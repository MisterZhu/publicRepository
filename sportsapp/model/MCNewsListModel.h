//
//Created by ESJsonFormatForMac on 19/04/23.
//

#import <Foundation/Foundation.h>

@class NewsResult,NewsRows;
@interface MCNewsListModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) NewsResult *Result;

@end
@interface NewsResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray *rows;

@end

@interface NewsRows : NSObject

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *images_url;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *news_cate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *title_pic;

@property (nonatomic, assign) NSInteger news_type;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *url;

@end

