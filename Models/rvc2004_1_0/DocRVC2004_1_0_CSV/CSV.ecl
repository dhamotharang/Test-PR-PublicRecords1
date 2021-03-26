

Shellpoint Custom Model (neverpaid segment)(RVC2004_1_0)

Whole Model Information

This is a single scorecard model.
This model uses reason method AscendingNonZeroWithInquiry.
LUCI made the following notes while compiling the .CSV: 
Line: 62, Severity: WARNING, Message: RC [C12] used with multiple Inds
Line: 62, Severity: WARNING, Message: RC [Z01] used with multiple Inds
Line: 62, Severity: WARNING, Message: RC [Z03] used with multiple Inds


Exceptions
"There are also exception conditions in which the scorecards are bypassed, defined as follows":


RV5_Attr_200 - If (real) ssndeceased = 1 or (real) subjectdeceased = 1 is true then the score is set to 200 and a reason code of  is set.
RV5_Attr_222 - If (real) confirmationsubjectfound = -998 or (real) confirmationsubjectfound < 1 is true then the score is set to 222 and a reason code of  is set.




ScoreCard - SCORECARD_model6
This scorecard is a linear model.
The weights for each variable are computed as defined below
Combined_score is then calculated by adding the individual weights together
Raw_point is then calculated by adding the Combined_score to the Constant -6.20383556354911
The score is then processed according to the formula (700 + 20 * ((Raw_point - 0 - LN(0.049227)) / LN(2))).
The value is then rounded to the nearest integer.
If the value is less than 501 it is set to 501.
If the value is greater than 900 it is set to 900.


Independant Variables
ChargeOffAmount is defined in 6 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.375117906627449,Z01
-1,-1,0.0,0.0,NUMBER,0.0,0.375117906627449,
-999999999,8546.265,0.375117906627449,0.0,NUMBER,0.0,0.375117906627449,
8546.265,18436.145,0.309244208292874,0.0,NUMBER,0.0,0.375117906627449,Z04
18436.145,34264.93,-0.0976038497040409,0.0,NUMBER,0.0,0.375117906627449,Z04
34264.93,HIGH,-0.285617568483362,0.0,NUMBER,0.0,0.375117906627449,Z04

CollateralStatus is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.506249019049611,Z01
Secured,Secured,0.506249019049611,0.0,NUMBER,0.0,0.506249019049611,
Unsecured,Unsecured,-0.505505156657995,0.0,NUMBER,0.0,0.506249019049611,Z03
,HIGH,0.0,0.0,NUMBER,0.0,0.506249019049611,Z03

LoanType is defined in 7 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.437226314256582,Z01
CFD,CFD,-0.783823199084631,0.0,NUMBER,0.0,0.437226314256582,Z03
HE,HE,0.437226314256582,0.0,NUMBER,0.0,0.437226314256582,
HI,HI,0.0808731487276667,0.0,NUMBER,0.0,0.437226314256582,Z03
MHCH,MHCH,-0.213208434163752,0.0,NUMBER,0.0,0.437226314256582,Z03
MHLH,MHLH,-0.48149235638988,0.0,NUMBER,0.0,0.437226314256582,Z03
,HIGH,0.0,0.0,NUMBER,0.0,0.437226314256582,Z03

OutOfStatuteIndicator is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.400744957361021,Z01
N,N,0.400744957361021,0.0,NUMBER,0.0,0.400744957361021,
Y,Y,-0.399632991058556,0.0,NUMBER,0.0,0.400744957361021,Z03
,HIGH,0.0,0.0,NUMBER,0.0,0.400744957361021,Z03

addrcurrentphoneservice is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.17581248093876,
-1,-1,0.0,0.0,NUMBER,0.0,0.17581248093876,C12
-999999999,0.5,-0.176496997665736,0.0,NUMBER,0.0,0.17581248093876,L78
0.5,HIGH,0.17581248093876,0.0,NUMBER,0.0,0.17581248093876,

addrinputmatchindex is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.109644071572997,
-1,-1,0.0,0.0,NUMBER,0.0,0.109644071572997,C12
-999999999,1.5,-0.348450615891214,0.0,NUMBER,0.0,0.109644071572997,F01
1.5,HIGH,0.109644071572997,0.0,NUMBER,0.0,0.109644071572997,

addrinputsubjectowned is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.25984141212094,
-1,-1,0.0,0.0,NUMBER,0.0,0.25984141212094,C12
-999999999,0.5,-0.126883825848919,0.0,NUMBER,0.0,0.25984141212094,A44
0.5,HIGH,0.25984141212094,0.0,NUMBER,0.0,0.25984141212094,

addrprevioussubjectowned is defined in 1 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-999999999,HIGH,0.0,0.0,NUMBER,0.0,0.393204356454376,C12

addrprevioustimeoldest is defined in 5 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.227389143242477,
-1,-1,0.0,0.0,NUMBER,0.0,0.227389143242477,C12
-999999999,205.5,-0.178058014191334,0.0,NUMBER,0.0,0.227389143242477,C13
205.5,353.5,0.180458239359927,0.0,NUMBER,0.0,0.227389143242477,C13
353.5,HIGH,0.227389143242477,0.0,NUMBER,0.0,0.227389143242477,

dayssince_OpenDate is defined in 5 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.518838613059721,Z01
-1,-1,0.0,0.0,NUMBER,0.0,0.518838613059721,
-999999999,4785.5,0.518838613059721,0.0,NUMBER,0.0,0.518838613059721,
4785.5,7697.5,-0.15284397845779,0.0,NUMBER,0.0,0.518838613059721,Z05
7697.5,HIGH,-0.27403651626685,0.0,NUMBER,0.0,0.518838613059721,Z05

dayssince_ReceivedDate is defined in 7 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,1.84983879208409,Z01
-1,-1,0.0,0.0,NUMBER,0.0,1.84983879208409,
-999999999,309,1.84983879208409,0.0,NUMBER,0.0,1.84983879208409,
309,1358.5,0.933891056825015,0.0,NUMBER,0.0,1.84983879208409,Z02
1358.5,2314,0.147011498338894,0.0,NUMBER,0.0,1.84983879208409,Z02
2314,3731,0.0658874265823452,0.0,NUMBER,0.0,1.84983879208409,Z02
3731,HIGH,-0.846610037669496,0.0,NUMBER,0.0,1.84983879208409,Z02

sourcecredheadertimeoldest is defined in 5 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.393416528917569,
-1,-1,0.0,0.0,NUMBER,0.0,0.393416528917569,C12
-999999999,345.5,-0.275087108555596,0.0,NUMBER,0.0,0.393416528917569,C20
345.5,423.5,0.0295111082163462,0.0,NUMBER,0.0,0.393416528917569,C20
423.5,HIGH,0.393416528917569,0.0,NUMBER,0.0,0.393416528917569,



