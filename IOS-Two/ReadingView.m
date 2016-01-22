//
//  ReadingView.m
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/20.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import "ReadingView.h"
#import "ReadingEntity.h"

@interface ReadingView () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView* webview;
@property (strong, nonatomic) UIButton *Zan;
@property UIColor *backgroundColor;

@end

@implementation ReadingView

-(IBAction)DianZan:(id)sender
{
    [self.Zan setSelected:![self.Zan isSelected]];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
   // CGRect mainrect = [[UIScreen mainScreen] bounds];
    
    if (self) {
        self.webview = [[UIWebView alloc] initWithFrame:frame];


        [self addSubview:self.webview];
        
        self.webview.delegate = self;
    }

    return self;
}

-(void)ConfigureReadingContent:(ReadingEntity*)reading BackC:(NSString*)backgroundColor CharC:(NSString*)
    charactersColor {
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    NSString *content = [reading ReadingContent];
    NSString* title = [reading ReadingTitle];
    [HTMLContent appendString:[NSString stringWithFormat:@"<body bgcolor=\"%@\">", backgroundColor]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><body><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 0px; margin-left: 15px;\">%@</p>", charactersColor, title]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div></body>", charactersColor, content]];
    [self.webview loadHTMLString:HTMLContent baseURL:nil];
    if ([backgroundColor isEqualToString:@"3C3C3C"]) {
        self.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.webview.scrollView.backgroundColor = self.backgroundColor;
        self.webview.backgroundColor = self.backgroundColor;
        self.backgroundColor = self.backgroundColor;
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        self.webview.backgroundColor = [UIColor whiteColor];
        self.webview.scrollView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSArray *sv = [NSArray arrayWithArray:[self.webview subviews]];
    UIScrollView *webScroller = (UIScrollView *)[sv objectAtIndex:0];
    CGSize webSize = [webView sizeThatFits:CGSizeZero];
    self.webview.scrollView.contentSize =CGSizeMake([[UIScreen mainScreen] bounds].size.width,
                                                    webSize.height + 150);
    self.webview.scrollView.backgroundColor = [UIColor whiteColor];
    self.Zan = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 70, webSize.height, 70, 20)];
    self.Zan.imageEdgeInsets = UIEdgeInsetsMake(2, -22, 0, 0);
    
    UIImage *btnImage = [[UIImage imageNamed:@"LikeBG"] stretchableImageWithLeftCapWidth:70
                                                                            topCapHeight:2];
    [self.Zan setBackgroundImage:btnImage forState:UIControlStateNormal];
    [self.Zan setTitle:@"12" forState:UIControlStateNormal];
    [self.Zan.titleLabel setFrame:CGRectMake(280, webSize.height + 63, 40, 17)];
    self.Zan.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.Zan.titleLabel setHidden:NO];
    [self.Zan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.Zan setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    [self.Zan setImage:[UIImage imageNamed:@"Image-1"] forState:UIControlStateSelected];
    [self.Zan addTarget:self action:@selector(DianZan:) forControlEvents:UIControlEventTouchUpInside];
  
    webScroller.backgroundColor = self.backgroundColor;
    [self.webview.scrollView addSubview:self.Zan];
    

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/

@end
