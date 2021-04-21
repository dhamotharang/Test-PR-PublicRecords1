

Shellpoint Custom Model (previous_HE segment)(RVC2004_3_0)

Whole Model Information

This is a single scorecard model.
This model uses reason method AscendingNonZeroWithInquiry.
LUCI made the following notes while compiling the .CSV: 
Line: 52, Severity: WARNING, Message: RC [C12] used with multiple Inds
Line: 52, Severity: WARNING, Message: RC [C13] used with multiple Inds
Line: 52, Severity: WARNING, Message: RC [Z01] used with multiple Inds
Line: 52, Severity: WARNING, Message: RC [Z03] used with multiple Inds


Exceptions
"There are also exception conditions in which the scorecards are bypassed, defined as follows":


RV5_Attr_200 - If (real) ssndeceased = 1 or (real) subjectdeceased = 1 is true then the score is set to 200 and a reason code of  is set.
RV5_Attr_222 - If (real) confirmationsubjectfound = -998 or (real) confirmationsubjectfound < 1 is true then the score is set to 222 and a reason code of  is set.




ScoreCard - SCORECARD_model13
This scorecard is a linear model.
The weights for each variable are computed as defined below
Combined_score is then calculated by adding the individual weights together
Raw_point is then calculated by adding the Combined_score to the Constant -1.78172567586037
The score is then processed according to the formula (700 + 20 * ((Raw_point - 0 - LN(0.049227)) / LN(2))).
The value is then rounded to the nearest integer.
If the value is less than 501 it is set to 501.
If the value is greater than 900 it is set to 900.


Independant Variables
CollateralStatus is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.175881297202286,Z01
Secured,Secured,0.175881297202286,0.0,NUMBER,0.0,0.175881297202286,
Unsecured,Unsecured,-0.175769990917404,0.0,NUMBER,0.0,0.175881297202286,Z03
,HIGH,0.0,0.0,NUMBER,0.0,0.175881297202286,Z03

OutOfStatuteIndicator is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.517999357387536,Z01
N,N,0.517999357387536,0.0,NUMBER,0.0,0.517999357387536,
Y,Y,-0.517699218854416,0.0,NUMBER,0.0,0.517999357387536,Z03
,HIGH,0.0,0.0,NUMBER,0.0,0.517999357387536,Z03

addrinputlengthofres is defined in 7 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.380188696628816,
-1,-1,0.0,0.0,NUMBER,0.0,0.380188696628816,C12
-999999999,85.5,-0.162252436093801,0.0,NUMBER,0.0,0.380188696628816,C13
85.5,175.5,-0.0744986191707646,0.0,NUMBER,0.0,0.380188696628816,C13
175.5,228.5,0.0134295817085936,0.0,NUMBER,0.0,0.380188696628816,C13
228.5,401.5,0.106913758369424,0.0,NUMBER,0.0,0.380188696628816,C13
401.5,HIGH,0.380188696628816,0.0,NUMBER,0.0,0.380188696628816,

addrprevioustimeoldest is defined in 5 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.0766876845593337,
-1,-1,0.0,0.0,NUMBER,0.0,0.0766876845593337,C12
-999999999,63.5,-0.243533121323617,0.0,NUMBER,0.0,0.0766876845593337,C13
63.5,293.5,0.0163999320923906,0.0,NUMBER,0.0,0.0766876845593337,C13
293.5,HIGH,0.0766876845593337,0.0,NUMBER,0.0,0.0766876845593337,

bankruptcycount is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.22054154165021,
-1,-1,0.0,0.0,NUMBER,0.0,0.22054154165021,C12
-999999999,0.5,0.22054154165021,0.0,NUMBER,0.0,0.22054154165021,
0.5,HIGH,-0.220487704235926,0.0,NUMBER,0.0,0.22054154165021,D31

dayssince_LastPaymentDate is defined in 10 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,2.78502174482666,Z01
-1,-1,0.0,0.0,NUMBER,0.0,2.78502174482666,
-999999999,20.5,2.78502174482666,0.0,NUMBER,0.0,2.78502174482666,
20.5,22.5,2.47927717616396,0.0,NUMBER,0.0,2.78502174482666,Z06
22.5,31.5,2.289394242031,0.0,NUMBER,0.0,2.78502174482666,Z06
31.5,40.5,2.16059645912678,0.0,NUMBER,0.0,2.78502174482666,Z06
40.5,97.5,1.28419126267805,0.0,NUMBER,0.0,2.78502174482666,Z06
97.5,473,-0.801117736469187,0.0,NUMBER,0.0,2.78502174482666,Z06
473,1298,-1.56111814895788,0.0,NUMBER,0.0,2.78502174482666,Z06
1298,HIGH,-1.88830934823268,0.0,NUMBER,0.0,2.78502174482666,Z06

derogcount is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.09127972345498,
-1,-1,0.0,0.0,NUMBER,0.0,0.09127972345498,C12
-999999999,0.5,0.09127972345498,0.0,NUMBER,0.0,0.09127972345498,
0.5,HIGH,-0.0912002663257225,0.0,NUMBER,0.0,0.09127972345498,D30

inputprovidedphone is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.126065595425946,
-1,-1,0.0,0.0,NUMBER,0.0,0.126065595425946,C12
-999999999,0.5,-0.126184162516679,0.0,NUMBER,0.0,0.126065595425946,F05
0.5,HIGH,0.126065595425946,0.0,NUMBER,0.0,0.126065595425946,

inquirycollections12month is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.230273226976335,
-1,-1,0.0,0.0,NUMBER,0.0,0.230273226976335,C12
-999999999,0.5,0.230273226976335,0.0,NUMBER,0.0,0.230273226976335,
0.5,HIGH,-0.230087456778504,0.0,NUMBER,0.0,0.230273226976335,I61



