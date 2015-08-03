#import <Foundation/Foundation.h>

#import "ContactInfoView.h"

@interface ContactInfoView ()
@property(nonatomic, retain) NSMutableDictionary* textFields;
@end

@implementation ContactInfoView

- (id) initWithFrame:(CGRect) frame{
    self = [super initWithFrame:frame];
    
    [self buildContactTextFields:@[@"Type", @"Phone", @"Email", @"Address", @"City", @"State", @"Zip", @"Country"] y:0];
    
    // resize
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    
    CGRect oldFrame = self.frame;
    oldFrame.size.height = contentRect.size.height;
    self.frame = oldFrame;
    
    return self;
}

- (void) PutFieldIn:(NSString*)value key:(NSString*)key {
    if([value length] > 0){
        ((UITextField*)[self.textFields objectForKey:key]).text = value;
    }
    else{
        ((UITextField*)[self.textFields objectForKey:key]).text = @"";
    }
}


- (void) updateFields {
    [self PutFieldIn:self.record.Phone key:@"Phone" ];
    [self PutFieldIn:self.record.Email key:@"Email" ];
    [self PutFieldIn:self.record.Address key:@"Address" ];
    [self PutFieldIn:self.record.City key:@"City" ];
    [self PutFieldIn:self.record.State key:@"State" ];
    [self PutFieldIn:self.record.Zipcode key:@"Zip" ];
    [self PutFieldIn:self.record.Country key:@"Country" ];
    [self PutFieldIn:self.record.Type key:@"Type"];
    
    [self reloadInputViews];
    [self setNeedsDisplay];
}

- (NSString*) getTextValue:(NSString*) key {
    return ((UITextField*)[self.textFields objectForKey:key]).text;
}

- (void) updateRecord {
    self.record.Address = [self getTextValue:@"Address" ];
    self.record.City = [self getTextValue:@"City" ];
    self.record.Country = [self getTextValue:@"Country" ];
    self.record.Email = [self getTextValue:@"Email" ];
    self.record.Phone = [self getTextValue:@"Phone" ];
    self.record.State = [self getTextValue:@"State" ];
    self.record.Zipcode = [self getTextValue:@"Zip" ];
    self.record.Type = [self getTextValue:@"Type" ];
}

- (NSDictionary*) buildToDictionary{
    NSDictionary* dict = @{@"infoId":self.record.Id,
                           @"address":self.record.Address,
                           @"contactId":self.record.ContactId ,
                           @"city":self.record.City,
                           @"email":self.record.Email,
                           @"phone":self.record.Phone,
                           @"state":self.record.State,
                           @"zip":self.record.Zipcode,
                           @"country":self.record.Country,
                           @"infoType":self.record.Type
                           };
    return dict;
}

- (void) buildContactTextFields:(NSArray*)names y:(int)y {
    y += 30;

    self.textFields = [[NSMutableDictionary alloc] init];
    
    for(NSString* field in names){
        UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.05, y, self.frame.size.width * .9, 35)];
        [textfield setPlaceholder:field];
        [textfield setFont:[UIFont fontWithName:@"Helvetica Neue" size: 20.0]];
        textfield.backgroundColor = [UIColor whiteColor];
        
        textfield.layer.cornerRadius = 5;
   
        [self addSubview:textfield];
        
        [self.textFields setObject:textfield forKey:field];
        
        y += 40;
    }
}

@end