//
//  ViewController.m
//  textpic
//
//  Created by mac on 2018/10/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

}
@property (nonatomic,strong) NSTextContainer *textContainer;
@property (strong, nonatomic)UITextView *textView;

@property (strong, nonatomic)UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建一个矩形区域
    CGRect textViewRect=CGRectInset(self.view.bounds, 10.0, 20.0);
    //创建NSTextStorage对象,它需要一个字符串作为构造方法的参数,这里我们是从TextView 控件取出来付值给它的
    NSTextStorage *textStorage=[[NSTextStorage alloc] initWithString:@"现货黄金周一（10月15日）止跌上涨，美市盘中最高触及1233.26美元/盎司，创10周以来的新高，金价摆脱了日内的窄幅盘整，但触及日高后回落，不过金价仍收涨在接近百日均线附近。美元周一转跌，美元指数盘中最低触及94.96，向下逼近95关口。日内公布的美国9月零售销售月率为0.1%，与前值一致，但低于预期0.6%，因美国汽车销售的反弹被餐厅饮食领域支出录得近两年来最大的跌幅所抵消；美国10月纽约联储制造业指数为21.1，高于前值和预期19。周一黄金的上涨主要是由于避险买盘的推动，美国和沙特阿拉伯之间爆发紧张关系，与一名在沙特失踪的沙特籍记者被杀有关。美国总统特朗普表示，如果明确了该名记者被杀，美国将对沙特实施“严厉的惩罚”。 现货黄金周二（10月16日）小幅收跌，美市盘中最低下探1223.73美元/盎司，金价在触及日内高位后回落，有转入盘整的迹象。美元周二续跌，美股大幅反弹，市场风险情绪回升制约了黄金的涨势。日内公布的美国9月工业产出月率，上涨0.3%，低于前值0.4%但高于预期0.2%，连续四个月录得增长，主要受到制造业与矿业产出增长的助推，但三季度工业产出动能料出现大幅放缓。黄金经过了近日的强势上涨，技术图表上已经得到极大改善，继续吸引技术性买盘跟进。同时，最近的股市震荡和地缘政治的紧张关系继续支撑了黄金的避险需求。因沙特记者失踪案导致的美国和沙特的紧张关系仍在继续，美国国务卿正在沙特处理此事。 现货黄金周三（10月17日）在美联储纪要发布后保持温和下跌，美市盘中最低下探至1219.92美元/盎司，收于日内低位。美元则扩大涨幅，美元指数盘中最高触及95.56，运行在95关口上方，对黄金构成不利因素。美联储会议纪要称所有委员都认为9月的会议上加息25基点是合适的。委员们一致预计未来将渐进式加息，经济将持续扩张，就业市场强劲，通胀接近达到目标水平。几乎所有委员认为政策声明中“货币政策立场是宽松的（accommodative）”这一表述是合适的。几乎所有委员都一致认为经济前景不变。"];
    NSLayoutManager *layoutManager=[[NSLayoutManager alloc] init];
    //将刚创建的nstextStorage和NSLayoutManager对象关联起来
    [textStorage addLayoutManager:layoutManager];
    self.textContainer =[[NSTextContainer alloc] initWithSize:textViewRect.size];
    //将NSLayoutManager和NSTextContainer关联起来
    [layoutManager addTextContainer:self.textContainer];
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.imageView.image=[UIImage imageNamed:@"1.png"];
    [self.view addSubview:self.imageView];
    
    self.textView=[[UITextView alloc] initWithFrame:textViewRect textContainer:_textContainer];
      // [self.view addSubview:self.textView];
    [self.textView setFont:[UIFont systemFontOfSize:20.0f]];
    //添加的textView在ImageView之下
    [self.view insertSubview:self.textView belowSubview:self.imageView];
    //设置凸版印刷效果
    [textStorage beginEditing];
    /**
     *声明一个字典对象,其中包括@{NSTextEffectAttribute-*Name:NSTextEffectLetterpressStyle},NSTextEffectAttributeName是文本效果建,而*NSTextEffect- LetterpressStyle是文本效果值,这里面它们都是常量
     */
    NSDictionary *attrsDic = @{NSTextEffectAttributeName: NSTextEffectLetterpressStyle};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_textView.text attributes:attrsDic];
    [textStorage setAttributedString:attrStr];
    [self markWord:@"黄金" inTextStorage:textStorage];
    [self markWord:@"金价" inTextStorage:textStorage];
    [textStorage endEditing];
    
    self.textView.textContainer.exclusionPaths=@[[self translatedBezierPath]];//设置translatedBezierPath方法

    
    // Do any additional setup after loading the view, typically from a nib.
}
//改变textview和imageView的坐标
- (UIBezierPath *)translatedBezierPath
{
    CGRect imageRect = [self.textView convertRect:_imageView.frame fromView:self.view];
    CGRect imageRectnew = CGRectOffset(imageRect, 2, -10);
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:imageRectnew];
    return newPath;
}
//根据指定的文本设置样式风格
-(void)markWord:(NSString *)word inTextStorage:(NSTextStorage *)textStorage{
    //
    NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:word options:0 error:nil];
    //通过正则表达式NSRegularExpression对象对TextView中的文本内 容进行扫描,结果放到数组中
    NSArray *matches=[regex matchesInString:self.textView.text  options:0 range:NSMakeRange(0, [self.textView.text length])];
    //为找到的文本设置颜色
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange=[match range];
        [textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:matchRange];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
