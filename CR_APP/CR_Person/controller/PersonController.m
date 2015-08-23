//
//  PersonController.m
//  CR_APP
//
//  Created by Itachi on 15/7/10.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "PersonController.h"
#import "PersonCell.h"
#import "LoginViewController.h"
#import "UserInfoController.h"
#import "LoginViewController.h"
#import "PersonOperationCell.h"


#define userIcon @"userIcon" //此处应该是userIcon加上用户的ID组成的字符串
#define cellNumber 4
#define userViewHeight 180.0

@interface PersonController ()
{
    UIBarButtonItem *logOffButton;
}
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSOperationQueue *myQueue;
@end

@implementation PersonController
@synthesize backgroundView,myQueue;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = ThemeRed;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.translucent = NO;
    
    myQueue = [[NSOperationQueue alloc] init];
    myQueue.maxConcurrentOperationCount = 2;
    
    [self refreshUserInfo];
    [self fillUserInfo];
    
    
    
    
}//这里在个人中心界面每次出现的时候都重新加载一次

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView.rowHeight = 70;
    
    logOffButton= [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOff)];
    
  
    self.userButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userButton.layer.borderWidth = 1.0;
    self.userButton.clipsToBounds = YES;
    self.userButton.layer.cornerRadius =  self.userButton.frame.size.width/2;
    

}

#pragma mark - Method

//登录
- (IBAction)logIn:(UIBarButtonItem *)sender {
    LoginViewController *logInVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:logInVC animated:YES];
}

//注销之后执行的方法
- (void)logOff{
    
    ATSHOW_ALERT_2(@"是否退出当前账户?");
}


- (IBAction)showUserInfo:(UIBarButtonItem *)sender {
    UserInfoController *userInfoController = [[UserInfoController alloc] init];
    [self presentPopUpViewController:userInfoController];
}



//从远程服务器获得用户的信息
- (void)refreshUserInfo{
    
}

//用来完善主界面用户信息,并根据是否登录决定导航栏右边按钮的属性
- (void)fillUserInfo{
    if (CheckLogIn) {
        NSDictionary *user = [NSKeyedUnarchiver unarchiveObjectWithData:[APPDefualts objectForKey:USER]];
        self.userButton.userInteractionEnabled = YES;
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem = logOffButton;
        
        self.nickname.text = [user valueForKey:@"userName"];
        //此处用来填写主界面上用户的信息
        //若使用第三方接口查询用户账户，也在此处调用
    }else{
        [self.userButton setBackgroundImage:[UIImage imageNamed:@"userImage.png"] forState:UIControlStateNormal];
        self.nickname.text = @"";
        self.lastTime.text = @"";
        self.userButton.userInteractionEnabled = NO;
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem = self.logInButton;
        
    }
}



//更改用户头像
- (IBAction)touchIconButton:(UIButton *)sender {
    
    UIActionSheet *sheet;
    // 判断是否支持相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}







#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"operationCell";
    PersonOperationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PersonOperationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    return cell;
}





#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (CheckLogIn) {
        //此处填写已登录点击单元格时的行为
    }else{
        //此处填写未登录点击单元格时的行为
    }
 
}


#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:{
            
            LogOff
            [self fillUserInfo];

        }
            break;
        default:
            break;
    }
}


#pragma mark - UIActionSheet Delegate

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }
}



#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
    //此处可以编写一个视图用来选择返回图片的类型
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 此处代码可以保存图片至本地，方法见下文,可以在AppDelegate中创建一个用于保存图片的文件夹，imageName可以使用代码进行实时更改
    NSString *imageName = userIcon;
    [self saveImage:image withName:imageName]; // 将图片保存到沙盒中

    
}

//此处为在UIImagePickerController中点击Cancel后执行的代码
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

//NSData * UIImageJPEGRepresentation ( UIImage *image, CGFloat compressionQuality);


#pragma mark - 保存及获得头像至沙盒 OR 上传头像

- (UIImage *)getUserIcon:(NSString *)imageName{

    UIImage *image = [UIImage imageWithContentsOfFile:imageName];
    return image;
}

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    //对图片进行优化
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    NSData *imageData = UIImagePNGRepresentation(currentImage);
    
    // 获取沙盒目录
    
    NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:imageName];
    // 将图片写入tmp文件夹
    
    [imageData writeToFile:fullPath atomically:YES];
    [self uploadImage:fullPath];//图片文件必须写入到沙盒之后才可以上传到远程服务器
}

- (void)uploadImage:(NSString *)imagePath{
    //other_url是上传头像的地址
    MKNetworkEngine *engine = enginer;
    MKNetworkOperation *op = [engine operationWithPath:other_url params:nil httpMethod:@"POST"];
    [MBProgressHUD showMessage:@"正在上传头像"];
    
    [op addFile:imagePath forKey:userIcon mimeType:@"image/jpg"];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HideProcessView
        //完成网络请求后的代码
        

        [self.userButton setBackgroundImage:[self getUserIcon:imagePath] forState:UIControlStateNormal];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HideProcessView
        ERROR_InterNet
        //未完成网络请求后执行的代码
    }];
    [engine enqueueOperation:op];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


@end
