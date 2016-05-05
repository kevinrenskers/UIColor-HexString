//
//  UIColor+HexString.m
//
//  Created by Micah Hainline
//  http://stackoverflow.com/users/590840/micah-hainline
//

#import "UIColor+HexString.h"


@implementation UIColor (HexString)

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];          
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];                      
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];                      
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (NSDictionary *)colorComponentsAsFloats
{
    CGFloat red, green, blue, alpha;
    if ( ![self getRed:&red green:&green blue:&blue alpha:&alpha] )
    {
        [self getWhite:&red alpha:&alpha];
        green = blue = red;
    }
    
    return @{
             @"red": @(red),
             @"green": @(green),
             @"blue": @(blue),
             @"alpha": @(alpha),
             };
}

+ (NSNumber *)colorComponentFloatToInteger:(NSNumber *)floatValue
{
    return @( (unsigned int)(roundf( [floatValue floatValue] * 255 ) ) );
}

- (NSDictionary *)colorComponentsAsIntegers
{
    NSDictionary *colorComponentsAsFloats = [self colorComponentsAsFloats];
    return @{
             @"red": [UIColor colorComponentFloatToInteger:[colorComponentsAsFloats objectForKey:@"red"] ],
             @"green": [UIColor colorComponentFloatToInteger:[colorComponentsAsFloats objectForKey:@"green"] ],
             @"blue": [UIColor colorComponentFloatToInteger:[colorComponentsAsFloats objectForKey:@"blue"] ],
             @"alpha": [UIColor colorComponentFloatToInteger:[colorComponentsAsFloats objectForKey:@"alpha"] ]
             };
}

- (NSString *) hexString
{
    NSDictionary *colorComponentsAsIntegers = [self colorComponentsAsIntegers];
    
    return [NSString stringWithFormat:@"#%02x%02x%02x",
            [ [colorComponentsAsIntegers objectForKey:@"red"] intValue],
            [ [colorComponentsAsIntegers objectForKey:@"green"] intValue],
            [ [colorComponentsAsIntegers objectForKey:@"blue"] intValue] ];
}

- (NSString *) hexStringWithAlpha
{
    NSDictionary *colorComponentsAsIntegers = [self colorComponentsAsIntegers];
    
    return [NSString stringWithFormat:@"#%02x%02x%02x%02x",
            [ [colorComponentsAsIntegers objectForKey:@"alpha"] intValue],
            [ [colorComponentsAsIntegers objectForKey:@"red"] intValue],
            [ [colorComponentsAsIntegers objectForKey:@"green"] intValue],
            [ [colorComponentsAsIntegers objectForKey:@"blue"] intValue] ];

}

@end
