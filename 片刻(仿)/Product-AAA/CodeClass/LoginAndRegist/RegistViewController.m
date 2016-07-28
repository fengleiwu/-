//
//  RegistViewController.m
//  Product-AAA
//
//  Created by 吴峰磊 on 16/7/5.
//  Copyright © 2016年 吴峰磊. All rights reserved.
//

#import "RegistViewController.h"
#import "UserInfoManager.h"
#define kRegistUrl @"http://api2.pianke.me/user/reg"   //注册接口的地址

@interface RegistViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate , UITextFieldDelegate>
{
    NSInteger _gender;//性别
}


@property (strong, nonatomic) IBOutlet UITextField *nameLabel;

@property (strong, nonatomic) IBOutlet UITextField *youxiangLabel;
@property (strong, nonatomic) IBOutlet UITextField *mimaLabel;
@property (strong, nonatomic) IBOutlet UIButton *manBtn;

@property (strong, nonatomic) IBOutlet UIButton *womanBtn;
@property (strong, nonatomic) IBOutlet UIImageView *personImg;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *youxiang;
@property (strong, nonatomic) IBOutlet UILabel *mima;

@property (strong, nonatomic) IBOutlet UIButton *completBtn;


@end

@implementation RegistViewController


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger inter = textField.tag;
    if (inter != 3) {
        UITextField *nextTF = [self.view viewWithTag:inter + 1];
        [nextTF becomeFirstResponder];
    }else
    {
        [textField resignFirstResponder];
    }
    return YES;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    self.personImg.userInteractionEnabled = YES;
    [self.personImg.layer setMasksToBounds:YES];
    [self.personImg.layer setCornerRadius:50];
    [self.manBtn.layer setMasksToBounds:YES];
    [self.manBtn.layer setCornerRadius:15];
    [self.womanBtn.layer setMasksToBounds:YES];
    [self.womanBtn.layer setCornerRadius:15];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personAction)];
    [self.personImg addGestureRecognizer:tap];
    self.nameLabel.tag = 1;
    self.youxiangLabel.tag = 2;
    self.mimaLabel.tag = 3;
    self.nameLabel.delegate = self;
    self.youxiangLabel.delegate = self;
    self.mimaLabel.delegate = self;
    //键盘将要出来
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘将要消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    

    // Do any additional setup after loading the view from its nib.
}


-(void)keyBoardShow:(NSNotification *)note
{
    CGRect newRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    [UIView animateWithDuration:[note.userInfo [UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        self.personImg.transform = CGAffineTransformMakeTranslation(0, self.personImg.frame.size.height - newRect.size.height + 100);
        self.manBtn.transform = CGAffineTransformMakeTranslation(0, self.manBtn.frame.size.height - newRect.size.height + 130);
        self.womanBtn.transform = CGAffineTransformMakeTranslation(0, self.womanBtn.frame.size.height - newRect.size.height + 130);
        self.name.transform = CGAffineTransformMakeTranslation(0, self.name.frame.size.height - newRect.size.height + 90);
        self.nameLabel.transform = CGAffineTransformMakeTranslation(0, self.nameLabel.frame.size.height - newRect.size.height + 80);
        self.youxiang.transform = CGAffineTransformMakeTranslation(0, self.youxiang.frame.size.height - newRect.size.height + 85);
        self.youxiangLabel.transform = CGAffineTransformMakeTranslation(0, self.youxiangLabel.frame.size.height - newRect.size.height + 75);
        self.mima.transform = CGAffineTransformMakeTranslation(0, self.mima.frame.size.height - newRect.size.height + 80);
        self.mimaLabel.transform = CGAffineTransformMakeTranslation(0, self.mimaLabel.frame.size.height - newRect.size.height + 75);
        self.completBtn.transform = CGAffineTransformMakeTranslation(0, self.completBtn.frame.size.height - newRect.size.height + 45);
    }];
    NSLog(@"键盘出来了");
    NSLog(@"%@",note);
    
    
}


-(void)keyBoardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        self.personImg.transform = CGAffineTransformIdentity;
        self.manBtn.transform = CGAffineTransformIdentity;
        self.womanBtn.transform = CGAffineTransformIdentity;
        self.name.transform = CGAffineTransformIdentity;
        self.nameLabel.transform = CGAffineTransformIdentity;
        self.youxiang.transform = CGAffineTransformIdentity;
        self.youxiangLabel.transform = CGAffineTransformIdentity;
        self.mima.transform = CGAffineTransformIdentity;
        self.mimaLabel.transform = CGAffineTransformIdentity;
        self.completBtn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nameLabel resignFirstResponder];
    [self.youxiangLabel resignFirstResponder];
    [self.mimaLabel resignFirstResponder];
}


-(void)personAction
{
    // actionSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    // 相册按钮
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相册");
        // 判断有没有相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            // 创建相册对象
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            // 设置调用的是相机还是相册
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 是否可以编辑
            picker.allowsEditing = YES;
            // 设置代理 代理需要遵守两个协议
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    [alert addAction:photoAction];
    // 相机按钮
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相机");
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            // 创建相册对象
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            // 设置调用的是相机还是相册
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 是否可以编辑
            picker.allowsEditing = YES;
            // 设置代理 代理需要遵守两个协议
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }

    }];
    [alert addAction:cameraAction];
    // 取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = info[UIImagePickerControllerEditedImage];
    self.personImg.image = img;
    //NSLog(@"%@",info);
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}


- (IBAction)manAction:(id)sender {
    _gender = 0;
    [_manBtn setBackgroundColor:[UIColor redColor]];
    [_womanBtn setBackgroundColor:[UIColor whiteColor]];
     }
- (IBAction)womanAction:(id)sender {
    _gender = 1;
    [_womanBtn setBackgroundColor:[UIColor redColor]];
    [_manBtn setBackgroundColor:[UIColor whiteColor]];
     }

- (IBAction)completAction:(id)sender {
    //网络请求
    //注册参数//email , gender , passwd, uname iconfile
    
    
    
    
    //如果请求出现content-type相关错误 用一些两种方案解决
    //应该适用于一切出现connect-type相关错误的案例 但请求成功后的返回值被转化成了nsdata 可读性
    
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:<#(nonnull id)#>]
    
    
    
    //uploadImage
    
    //9876789@qq.com  123456
    //15251321291@qq.com  123456
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:kRegistUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(_personImg.image) name:@"iconfile" fileName:@"uploadheadimage.png" mimeType:@"image/png"];
        [formData appendPartWithFormData:[_youxiangLabel.text dataUsingEncoding:NSUTF8StringEncoding] name:@"email"];
        [formData appendPartWithFormData:[_mimaLabel.text dataUsingEncoding:NSUTF8StringEncoding] name:@"passwd"];
        [formData appendPartWithFormData:[_nameLabel.text dataUsingEncoding:NSUTF8StringEncoding] name:@"uname"];
        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)_gender] dataUsingEncoding:NSUTF8StringEncoding] name:@"gender"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%lf", 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //responserObject nsdata
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
