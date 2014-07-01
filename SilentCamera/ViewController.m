//
//  ViewController.m
//  SilentCamera
//
//  Created by Eri Tange on 2014/05/05.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "CameraManager.h"

#define kHomePageURL @"http://www.quil-fait-bon.com/menulist.php?tsp=1"

@interface ViewController ()

@property(weak,nonatomic)IBOutlet UIWebView *webView;
@property(weak,nonatomic)IBOutlet UITextField *urlField;
@property(weak,nonatomic)IBOutlet UIBarButtonItem *backButton;
@property(weak,nonatomic)IBOutlet UIBarButtonItem *nextButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self navigate:kHomePageURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

//撮影ボタン
-(IBAction)performCameraButton:(id)sender{
    
    //撮影
    [[CameraManager sharedManager] takePhoto];
}

//開くボタン
-(IBAction)performNavigation:(id)sender{
    
    [self navigate:self.urlField.text];
}

//戻るボタン
-(IBAction)performBackButtonAction:(id)sender{
    
    [self.webView goBack];
}

//進むボタン
-(IBAction)performNextButtonAction:(id)sender{
    
    [self.webView goForward];
}

#pragma mark - User Interface

//戻る、進むができるときのみボタンを有効化
-(void)enableButtons{
    
    self.backButton.enabled = self.webView.canGoBack;
    self.nextButton.enabled = self.webView.canGoForward;
}

//キーボードのReturnが押されたとき
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //読み込みを開始
    [self navigate:self.urlField.text];
    
    return YES;
}

#pragma mark - Web View

//指定したURLをWebViewで開く
-(void)navigate:(NSString *)strUrl{
    
    //キーボードを閉じる
    [self.urlField resignFirstResponder];
    
    //URLの文字列からリクエストを生成
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //リクエスト開始
    [self.webView loadRequest:request];
}

//Web Viewが読み込みを開始したとき
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    //インジケーターを表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//Web Viewのエラー時
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    //インジケーターを表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //エラーを表示
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:error.localizedDescription delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    //ボタンの有効•無効を切り替え
    [self enableButtons];
}

//Web Viewの読み込みが完了したとき
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //インジケーターを隠す
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //現在のURLをテキストボックスに反映
    self.urlField.text = webView.request.URL.absoluteString;
    
    //ボタンの有効、無効を切り替え
    [self enableButtons];
}























@end
