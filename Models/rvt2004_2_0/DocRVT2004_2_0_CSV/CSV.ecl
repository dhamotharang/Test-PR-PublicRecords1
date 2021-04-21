

T-Mobile Thick Custom RiskView 5.0 Score -- Project 9386(RVT2004_2_0)

Whole Model Information

This is a single scorecard model.
This model uses reason method DescendingPositiveWithInquiry.

Exceptions
"There are also exception conditions in which the scorecards are bypassed, defined as follows":


Alert - If ((real) alertregulatorycondition = 3) is true then the score is set to 100 and a reason code of  is set.
No_Hit - If ((real) confirmationsubjectfound = -998) or ((real) confirmationsubjectfound < 1) is true then the score is set to 222 and a reason code of  is set.
Deceased - If ((real) ssndeceased = 1) or ((real) subjectdeceased = 1) is true then the score is set to 200 and a reason code of  is set.


Local Variables
This model makes use of local variables which are defined thus:
"L_ca_creditseeking_orig of type REAL defined as map((real) inquiryshortterm12month = 1 and (real) inquiryauto12month = 1 => 6,(real) inquiryshortterm12month = 1 and (real) inquirybanking12month = 1 => 5,(real) inquiryshortterm12month = 1 => 4,(real) inquiryauto12month = 1 or (real) shorttermloanrequest > 0 => 3,(real) inquirybanking12month = 1 or (real) inquirycollections12month = 1 => 2,1)L_ca_creditseeking of type REAL defined as map(L_ca_creditseeking_orig = 2 and (real) inquirybanking12month = 0 and (real) inquirycollections12month = 1 => 8,L_ca_creditseeking_orig = 3 and (real) inquiryauto12month = 0 and (real) shorttermloanrequest = 1 => 7,L_ca_creditseeking_orig)L_ca_derogseverityindex_orig of type REAL defined as map((real) evictioncount > 1 or ((real) evictioncount = 1 and ((real) bankruptcystatus = 2 or (real) lienjudgmentsmallclaimscount > 0)) => 5,(real) evictioncount > 0 => 4,(real) lienjudgmentsmallclaimscount > 0 or (real) bankruptcystatus = 2 => 3,(real) lienjudgmentcount > 0 => 2,1)L_ca_derogseverityindex of type REAL defined as map(L_ca_derogseverityindex_orig = 3 and (real) lienjudgmentsmallclaimscount = 0 and (real) bankruptcystatus = 2 => 8,L_ca_derogseverityindex_orig = 3 and (real) lienjudgmentsmallclaimscount > 0 and (real) bankruptcystatus <> 2 => 7,L_ca_derogseverityindex_orig = 5 and (real) evictioncount > 1 and (real) bankruptcystatus <> 2 and (real) lienjudgmentsmallclaimscount = 0 => 6,L_ca_derogseverityindex_orig)L_ca_nonderogindex of type REAL defined as map((real) sourcenonderogcount06month > 2 => 7,(real) sourcenonderogcount > 4 and (real) sourcenonderogcount06month > 1 => 6,(real) sourcenonderogcount > 4 or ((real) sourcenonderogcount > 3 and (real) sourcenonderogcount06month = 2) => 5,(real) sourcenonderogcount > 3 or (real) sourcenonderogcount06month > 1 => 4,(real) sourcenonderogcount > 2 => 3,(real) sourcenonderogcount = 2 and (real) sourcenonderogcount06month = 1 => 2,1)L_ca_addrchangeindex of type REAL defined as map((real) subjectrecordtimeoldest >= 0 and (real) subjectrecordtimeoldest <= 84 and (real) addronfilecount > 5 => 6,(real) subjectrecordtimeoldest >= 0 and (real) subjectrecordtimeoldest <= 84 and (real) addronfilecount > 4 => 5,(real) subjectrecordtimeoldest >= 0 and (real) subjectrecordtimeoldest <= 84 and (real) addronfilecount > 2 => 4,(real) subjectrecordtimeoldest >= 0 and (real) subjectrecordtimeoldest <= 84 and (real) addronfilecount > 1 => 3,(real) subjectrecordtimeoldest >= 0 and (real) subjectrecordtimeoldest <= 84 => 2,(real) addrchangecount60month > 4 => 6,(real) addrchangecount60month > 2 => 5,(real) addrchangecount60month > 1 => 4,(real) addrchangecount60month > 0 => 3,1)"


ScoreCard - SCORECARD_model47
This scorecard is a linear model.
The weights for each variable are computed as defined below
Combined_score is then calculated by adding the individual weights together
Raw_point is then calculated by adding the Combined_score to the Constant -1.58477952594377
The score is then processed according to the formula (700 + -40 * ((Raw_point - 0 - LN(0.35685210312076)) / LN(2))).
The value is then rounded to the nearest integer.
If the value is less than 501 it is set to 501.
If the value is greater than 900 it is set to 900.


Independant Variables
L_ca_addrchangeindex is defined in 6 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,-0.005703807,-0.005703807,
-1,-1,0.0,0.0,NUMBER,-0.005703807,-0.005703807,C14
-999999999,2.5,-0.052677852519793,0.0,NUMBER,-0.005703807,-0.005703807,C14
2.5,4.5,0.0093886967604785,0.0,NUMBER,-0.005703807,-0.005703807,C14
4.5,5.5,0.0857939935789934,0.0,NUMBER,-0.005703807,-0.005703807,C14
5.5,HIGH,0.187917227284159,0.0,NUMBER,-0.005703807,-0.005703807,C14

L_ca_creditseeking is defined in 10 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,-0.188809907,-0.188809907,
-1,-1,0.0,0.0,NUMBER,-0.188809907,-0.188809907,I60
-999999999,1,-0.537997066263463,0.0,NUMBER,-0.188809907,-0.188809907,I60
2,2,0.0548804249144252,0.0,NUMBER,-0.188809907,-0.188809907,I60
3,3,0.190031718225198,0.0,NUMBER,-0.188809907,-0.188809907,I60
4,4,0.650769565235421,0.0,NUMBER,-0.188809907,-0.188809907,I60
5,5,1.00836443079308,0.0,NUMBER,-0.188809907,-0.188809907,I60
6,6,1.18265340641186,0.0,NUMBER,-0.188809907,-0.188809907,I60
7,7,0.190031718225198,0.0,NUMBER,-0.188809907,-0.188809907,C21
7,HIGH,0.0548804249144252,0.0,NUMBER,-0.188809907,-0.188809907,I61

L_ca_derogseverityindex is defined in 10 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,-0.316279327,-0.316279327,
-1,-1,0.0,0.0,NUMBER,-0.316279327,-0.316279327,
-999999999,1,-0.413793157156462,0.0,NUMBER,-0.316279327,-0.316279327,
2,2,-0.0314225344056521,0.0,NUMBER,-0.316279327,-0.316279327,D34
3,3,0.400599180681259,0.0,NUMBER,-0.316279327,-0.316279327,D30
4,4,0.683351662414589,0.0,NUMBER,-0.316279327,-0.316279327,D33
5,5,0.958117552563772,0.0,NUMBER,-0.316279327,-0.316279327,D30
6,6,0.958117552563772,0.0,NUMBER,-0.316279327,-0.316279327,D33
7,7,0.400599180681259,0.0,NUMBER,-0.316279327,-0.316279327,D34
7,HIGH,0.400599180681259,0.0,NUMBER,-0.316279327,-0.316279327,D31

L_ca_nonderogindex is defined in 6 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.073420476,0.073420476,
-1,-1,0.0,0.0,NUMBER,0.073420476,0.073420476,C12
-999999999,2.5,0.224638954157977,0.0,NUMBER,0.073420476,0.073420476,C12
2.5,3.5,0.0534093514829876,0.0,NUMBER,0.073420476,0.073420476,C12
3.5,4.5,-0.248370773172574,0.0,NUMBER,0.073420476,0.073420476,C12
4.5,HIGH,-0.453675193810595,0.0,NUMBER,0.073420476,0.073420476,C12

addrcurrentownershipindex is defined in 6 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.032557624,0.032557624,
-1,-1,0.0,0.0,NUMBER,0.032557624,0.032557624,A44
-999999999,0.5,0.369840206147756,0.0,NUMBER,0.032557624,0.032557624,A44
0.5,2.5,0.153617815307213,0.0,NUMBER,0.032557624,0.032557624,A44
2.5,3.5,-0.11136892139623,0.0,NUMBER,0.032557624,0.032557624,A44
3.5,HIGH,-0.482905249758621,0.0,NUMBER,0.032557624,0.032557624,A44

addrprevioustimeoldest is defined in 11 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.016988448,0.016988448,
-1,-1,-0.28084870461577,0.0,NUMBER,0.016988448,0.016988448,C13
-999999999,6,0.491375089074481,0.0,NUMBER,0.016988448,0.016988448,C13
6,12,0.321048883673525,0.0,NUMBER,0.016988448,0.016988448,C13
12,24,0.180121585542426,0.0,NUMBER,0.016988448,0.016988448,C13
24,72,0.151031197731993,0.0,NUMBER,0.016988448,0.016988448,C13
72,96,0.114801189635962,0.0,NUMBER,0.016988448,0.016988448,C13
96,156,-0.0288430799118979,0.0,NUMBER,0.016988448,0.016988448,C13
156,228,-0.0640308901228473,0.0,NUMBER,0.016988448,0.016988448,C13
228,288,-0.255266542810333,0.0,NUMBER,0.016988448,0.016988448,C13
288,HIGH,-0.45962051977284,0.0,NUMBER,0.016988448,0.016988448,C13

assetpropcurrentcount is defined in 5 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.149654754,0.149654754,
-1,-1,0.0,0.0,NUMBER,0.149654754,0.149654754,
-999999999,0.5,0.343155403853238,0.0,NUMBER,0.149654754,0.149654754,A42
0.5,1.5,-0.260918946043492,0.0,NUMBER,0.149654754,0.149654754,A42
1.5,HIGH,-0.33457231340859,0.0,NUMBER,0.149654754,0.149654754,A42

assetpropeversoldcount is defined in 5 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.256330125,0.256330125,
-1,-1,0.0,0.0,NUMBER,0.256330125,0.256330125,
-999999999,0.5,0.338302614099309,0.0,NUMBER,0.256330125,0.256330125,A45
0.5,1.5,-0.210498982583842,0.0,NUMBER,0.256330125,0.256330125,
1.5,HIGH,-0.538333965350616,0.0,NUMBER,0.256330125,0.256330125,



