//
//  SPAFontConfig.h
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAFontConfig : NSObject

/*
 Font Family @Myriad Pro
 */


/*
Font Name @MyriadPro-Cond
*/
@property (nonatomic,retain) NSString *MyriadProCond;
/*
 Font Name @MyriadPro-CondIt
 */
@property (nonatomic,retain) NSString *MyriadProCondIt;
/*
 Font Name @MyriadPro-It
 */
@property (nonatomic,retain) NSString *MyriadProIt;
/*
 Font Name @MyriadPro-BoldCondIt
 */
@property (nonatomic,retain) NSString *MyriadProBoldCondIt;
/*
 Font Name @MyriadPro-Regular
 */
@property (nonatomic,retain) NSString *MyriadProRegular;
/*
 Font Name @MyriadPro-BoldCond
 */
@property (nonatomic,retain) NSString *MyriadProBoldCond;
/*
 Font Name @MyriadPro-Bold
 */
@property (nonatomic,retain) NSString *MyriadProBold;
/*
 Font Name @MyriadPro-Semibold
 */
@property (nonatomic,retain) NSString *MyriadProSemibold;
/*
 Font Name @MyriadPro-BoldIt
 */
@property (nonatomic,retain) NSString *MyriadProBoldIt;
/*
 Font Name @MyriadPro-SemiboldIt
 */
@property (nonatomic,retain) NSString *MyriadProSemiboldIt;


/*
 Font Family @Helvetica
 */


/*
 Font Name @Helvetica-Bold
 */
@property (nonatomic,retain) NSString *HelveticaBold;
/*
 Font Name @Helvetica
 */
@property (nonatomic,retain) NSString *Helvetica;
/*
 Font Name @Helvetica-LightOblique
 */
@property (nonatomic,retain) NSString *HelveticaLightOblique;
/*
 Font Name @Helvetica-Oblique
 */
@property (nonatomic,retain) NSString *HelveticaOblique;
/*
 Font Name @Helvetica-BoldOblique
 */
@property (nonatomic,retain) NSString *HelveticaBoldOblique;
/*
 Font Name @Helvetica-Light
 */
@property (nonatomic,retain) NSString *HelveticaLight;

/*
 Font Family @Roboto
 */


/*
 Font Name @Roboto-Bold
 */
@property (nonatomic,retain) NSString *RobotoBold;
/*
 Font Name @Roboto-Regula
 */
@property (nonatomic,retain) NSString *RobotoRegular;
/*
 Font Name @Roboto-Medium
 */
@property (nonatomic,retain) NSString *RobotoMedium;

+ (SPAFontConfig *)config;
@end
