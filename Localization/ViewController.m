//
//  ViewController.m
//  Localization
//
//  Created by Jenkins on 29/08/16.
//  Copyright © 2016 srinivas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (strong, nonatomic) IBOutlet UITableView *aTableview;

@property (strong, nonatomic) IBOutlet UILabel *lblLanguage;
@end

@implementation ViewController
{
    NSIndexPath*selectedIndex;
    NSMutableArray *mutArray;
    NSArray * languagesArray;
//    NSInteger KnoOfTaps;
//    NSInteger EnoOfTaps;
//    NSInteger HnoOfTaps;
//    NSString *str;
//    NSInteger i;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mutArray = [[NSMutableArray alloc]init];
    languagesArray = @[@"Kannada",@"English",@"Hindi"];
     selectedIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    
//    KnoOfTaps=0;
//    EnoOfTaps=0;
//    HnoOfTaps=0;
    
 // [self readDataFromFile:@"English"];
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mutArray.count==0)
    {
        return languagesArray.count;
    }
    else
    {
        return mutArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (mutArray.count==0)
    {
        UILabel * label = (UILabel *)[cell viewWithTag:50];
        label.text = [languagesArray objectAtIndex:indexPath.row];
    }
    else
    {
    UILabel * label = (UILabel *)[cell viewWithTag:50];
    label.text = [mutArray objectAtIndex:indexPath.row];
    }
    
    
      _tableHeight.constant = _aTableview.contentSize.height;
       return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (selectedIndex.row != indexPath.row)
        {
            [self readDataFromFile:languagesArray[indexPath.row]];
            selectedIndex=indexPath;
        }
}
    
//if (selectedIndex != nil && selectedIndex.row != indexPath.row)
//{
//    selectedIndex=indexPath;
//    [self readDataFromFile:languagesArray[indexPath.row]];
//}
//else {
//    selectedIndex = indexPath;
//}






//    NSLog(@"KndnoOftaps: %ld",(long)KnoOfTaps);
//    NSLog(@"EngnoOftaps: %ld",(long)EnoOfTaps);
//    NSLog(@"HinnoOftaps: %ld",(long)HnoOfTaps);
//
//   i = indexPath.row;
//    
//  str = languagesArray[indexPath.row];
//    
//    switch (i) {
//        case 0:
//            if ([str containsString:@"Kannada"]) {
//                KnoOfTaps++;
//                 NSLog(@"KndnoOftaps: %ld",(long)KnoOfTaps);
//                if (KnoOfTaps==1)
//                {
//                  //  KnoOfTaps=0;
//                    EnoOfTaps=0;
//                    HnoOfTaps=0;
//                     [self readDataFromFile:str];
//                }
//                else
//                {
//                    return;
//                }
//            }
//            break;
//            
//       case 1:
//            
//            
//            if ([str containsString:@"English"]) {
//                EnoOfTaps++;
//                NSLog(@"EngnoOftaps: %ld",(long)EnoOfTaps);
//                if (EnoOfTaps==1) {
//                    
//                    KnoOfTaps=0;
//                   // EnoOfTaps=0;
//                    HnoOfTaps=0;
//                    [self readDataFromFile:str];
//                }
//                else
//                {
//                    return;
//                }
//            }
//            break;
//            
//           
//            
//        default:
//            
//            if ([str containsString:@"Hindi"]) {
//                HnoOfTaps++;
//                NSLog(@"HinnoOftaps: %ld",(long)HnoOfTaps);
//                if (HnoOfTaps==1) {
//                    
//                    KnoOfTaps=0;
//                    EnoOfTaps=0;
//                  //  HnoOfTaps=0;
//                    [self readDataFromFile:str];
//                }
//                else
//                {
//                    return;
//                }
//            }
//            break;
//            
//        }
 // }





-(void)readDataFromFile:(NSString*)languageCode
{
    [mutArray removeAllObjects];
    NSMutableDictionary *jsonDictionary=[[NSMutableDictionary alloc]init];
    NSString *filepath=[[NSBundle mainBundle]pathForResource:languageCode ofType:@".json"];
    NSURL *fileUrl=[NSURL fileURLWithPath:filepath];
    [jsonDictionary setObject:fileUrl forKey:languageCode];
    
    [MCLocalization loadFromLanguageURLPairs:jsonDictionary defaultLanguage:@"English"];
    [MCLocalization sharedInstance].language=languageCode;
    [MCLocalization sharedInstance].noKeyPlaceholder=@"[no '{key}' in '{language}']";
    
    [mutArray addObject:[MCLocalization stringForKey:@"Kannada"]];
    [mutArray addObject:[MCLocalization stringForKey:@"English"]];
    [mutArray addObject:[MCLocalization stringForKey:@"Hindi"]];
    _lblLanguage.text=[MCLocalization stringForKey:@"Text"];
    [_aTableview reloadData];
    [self.view layoutIfNeeded];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
