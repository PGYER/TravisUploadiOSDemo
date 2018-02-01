//
//  ViewController.m
//  PgySDKDemo
//
//  Created by Scott Lei on 15/2/27.
//  Copyright (c) 2015年 蒲公英. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"蒲公英SDK Demo";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if ([[PgyManager sharedPgyManager] isFeedbackEnabled]) {
        NSString *activeType = [[PgyManager sharedPgyManager] feedbackActiveType] == kPGYFeedbackActiveTypeShake ? @"摇一摇" : @"三指上下拖动";
        return [NSString stringWithFormat:@"请%@以激活用户反馈界面", activeType];
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];

    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"触发崩溃";
            break;
        }

        case 1: {
            cell.textLabel.text = @"上报异常";
            break;
        }
            
        case 2: {
            cell.textLabel.text = @"检查更新";
            break;
        }

        case 3: {
            cell.textLabel.text = @"显示用户反馈";
            break;
        }

        case 4: {
            NSString *feedbackText = [[PgyManager sharedPgyManager] isFeedbackEnabled] ? @"关闭手势用户反馈" : @"开启手势用户反馈";

            cell.textLabel.text = feedbackText;
            break;
        }

        default:
            break;
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
            [self triggeCrash];
            break;
        case 1:
            [self reportException];
            break;
        case 2:
            [self checkUpdate];
            break;
        case 3: {
            [self showFeedbackView];
        } break;
        case 4: {
            [self setFeedback];
        } break;
            
        default:
            break;
    }
}

/**
 *  触发崩溃，崩溃信息会再程序下一次正常运行的时候上报服务器
 */
- (void)triggeCrash
{
    NSArray *array = [NSArray arrayWithObjects:@"", nil];
    NSString *value = [array objectAtIndex:10];
    
    NSLog(@"The value at index 10 is: %@", value);
}

/**
 *  上报异常信息，包含name,reason,callStackSymbols.
 */
- (void)reportException
{
    @try {
        [self triggeCrash];
    }
    @catch (NSException *exception) {
        [[PgyManager sharedPgyManager] reportException:exception];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"异常信息已上报"
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil,
                                  nil];
        
        [alertView show];
    }
}

- (void)checkUpdate
{
//    [[PgyUpdateManager sharedPgyManager] checkUpdate];
    
    [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
}

/**
 *  检查更新回调
 *
 *  @param response 检查更新的返回结果
 */
- (void)updateMethod:(NSDictionary *)response
{
    if (response[@"downloadURL"]) {
        
        NSString *message = response[@"releaseNote"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发现新版本"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil,
                                  nil];
        
        [alertView show];
    }
    
    //    调用checkUpdateWithDelegete后可用此方法来更新本地的版本号，如果有更新的话，在调用了此方法后再次调用将不提示更新信息。
    //    [[PgyUpdateManager sharedPgyManager] updateLocalBuildNumber];
}

/**
 *  通过代码调用来显示用户反馈界面
 */
- (void)showFeedbackView
{
    [[PgyManager sharedPgyManager] showFeedbackView];
}

/**
 *  关闭或者打开用户反馈
 */
- (void)setFeedback
{
    [[PgyManager sharedPgyManager] setEnableFeedback:![[PgyManager sharedPgyManager] isFeedbackEnabled]];

    NSString *message = [[PgyManager sharedPgyManager] isFeedbackEnabled] ? @"手势用户反馈已开启" : @"手势用户反馈已关闭";

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil,
                              nil];

    [alertView show];

    [self.tableView reloadData];
}
@end
