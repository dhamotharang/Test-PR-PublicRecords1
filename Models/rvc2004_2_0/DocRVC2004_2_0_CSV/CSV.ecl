

Shellpoint Custom Model (previous_nonHE segment)(RVC2004_2_0)

Whole Model Information

This is a single scorecard model.
This model uses reason method AscendingNonZeroWithInquiry.
LUCI made the following notes while compiling the .CSV: 
Line: 46, Severity: WARNING, Message: RC [C12] used with multiple Inds
Line: 46, Severity: WARNING, Message: RC [Z01] used with multiple Inds


Exceptions
"There are also exception conditions in which the scorecards are bypassed, defined as follows":


RV5_Attr_200 - If (real) ssndeceased = 1 or (real) subjectdeceased = 1 is true then the score is set to 200 and a reason code of  is set.
RV5_Attr_222 - If (real) confirmationsubjectfound = -998 or (real) confirmationsubjectfound < 1 is true then the score is set to 222 and a reason code of  is set.




ScoreCard - SCORECARD_model12
This scorecard is a linear model.
The weights for each variable are computed as defined below
Combined_score is then calculated by adding the individual weights together
Raw_point is then calculated by adding the Combined_score to the Constant -1.80641556868857
The score is then processed according to the formula (700 + 20 * ((Raw_point - 0 - LN(0.049227)) / LN(2))).
The value is then rounded to the nearest integer.
If the value is less than 501 it is set to 501.
If the value is greater than 900 it is set to 900.


Independant Variables
ChargeOffAmount is defined in 8 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.307355877385115,Z01
-1,-1,0.0,0.0,NUMBER,0.0,0.307355877385115,
-999999999,4432.92,-0.368397706825698,0.0,NUMBER,0.0,0.307355877385115,Z04
4432.92,11517.91,-0.124064717201017,0.0,NUMBER,0.0,0.307355877385115,Z04
11517.91,16063.795,-0.0427750798132533,0.0,NUMBER,0.0,0.307355877385115,Z04
16063.795,24316.115,0.0735522392490668,0.0,NUMBER,0.0,0.307355877385115,Z04
24316.115,47222.515,0.196296354816782,0.0,NUMBER,0.0,0.307355877385115,Z04
47222.515,HIGH,0.307355877385115,0.0,NUMBER,0.0,0.307355877385115,

OutOfStatuteIndicator is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.522622593458921,Z01
N,N,0.522622593458921,0.0,NUMBER,0.0,0.522622593458921,
Y,Y,-0.52216878252275,0.0,NUMBER,0.0,0.522622593458921,Z03
,HIGH,0.0,0.0,NUMBER,0.0,0.522622593458921,Z03

addrinputownershipindex is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.123004769601752,
-1,-1,0.0,0.0,NUMBER,0.0,0.123004769601752,C12
-999999999,3.5,-0.0530990948270477,0.0,NUMBER,0.0,0.123004769601752,A44
3.5,HIGH,0.123004769601752,0.0,NUMBER,0.0,0.123004769601752,

confirmationinputaddress is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.0923792591262736,
-1,-1,-0.337887501368304,0.0,NUMBER,0.0,0.0923792591262736,C12
-999999999,0.5,-3.92028713838522E-4,0.0,NUMBER,0.0,0.0923792591262736,F01
0.5,HIGH,0.0923792591262736,0.0,NUMBER,0.0,0.0923792591262736,

dayssince_LastPaymentDate is defined in 7 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,2.90868702779944,Z01
-1,-1,0.0,0.0,NUMBER,0.0,2.90868702779944,
-999999999,13.5,2.90868702779944,0.0,NUMBER,0.0,2.90868702779944,
13.5,25.5,2.79160099181279,0.0,NUMBER,0.0,2.90868702779944,Z06
25.5,63.5,1.8704884685878,0.0,NUMBER,0.0,2.90868702779944,Z06
63.5,227.5,0.148985327141811,0.0,NUMBER,0.0,2.90868702779944,Z06
227.5,HIGH,-2.28956824523366,0.0,NUMBER,0.0,2.90868702779944,Z06

derogcount is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.206897909402591,
-1,-1,0.0,0.0,NUMBER,0.0,0.206897909402591,C12
-999999999,1.5,0.206897909402591,0.0,NUMBER,0.0,0.206897909402591,
1.5,HIGH,-0.206841677937945,0.0,NUMBER,0.0,0.206897909402591,D30

inputprovidedphone is defined in 4 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.11595697711271,
-1,-1,0.0,0.0,NUMBER,0.0,0.11595697711271,C12
-999999999,0.5,-0.115997439845944,0.0,NUMBER,0.0,0.11595697711271,F05
0.5,HIGH,0.11595697711271,0.0,NUMBER,0.0,0.11595697711271,

sourcecredheadertimeoldest is defined in 5 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.0,0.188800668917611,
-1,-1,0.0,0.0,NUMBER,0.0,0.188800668917611,C12
-999999999,293.5,-0.135530518722703,0.0,NUMBER,0.0,0.188800668917611,C20
293.5,421.5,-0.0694870572956636,0.0,NUMBER,0.0,0.188800668917611,C20
421.5,HIGH,0.188800668917611,0.0,NUMBER,0.0,0.188800668917611,



