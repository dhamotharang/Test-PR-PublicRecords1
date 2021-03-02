

T-Mobile Thin Custom RiskView 5.0 Score -- Project 9386(RVT2004_1_0)

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
"L_addrprevioustimeoldest_alt of type REAL defined as (real) addrprevioustimeoldestL_ca_creditseeking_orig of type REAL defined as map((real) inquiryshortterm12month = 1 and ((real) inquiryauto12month = 1 or (real) shorttermloanrequest = 1) => 5,(real) inquiryshortterm12month = 1 and ((real) inquirybanking12month <> 0 or (real) inquirycollections12month = 1) => 4,(real) inquiryshortterm12month = 1 => 3,((real) inquiryauto12month = 1 or (real) shorttermloanrequest = 1) => 2,((real) inquirybanking12month = 1 or (real) inquirycollections12month = 1) => 1,0)L_ca_creditseeking of type REAL defined as map(L_ca_creditseeking_orig = 1 and (real) inquirybanking12month = 0 and (real) inquirycollections12month = 1 => 7,L_ca_creditseeking_orig = 2 and (real) inquirybanking12month = 0 and (real) shorttermloanrequest = 1 => 6,L_ca_creditseeking_orig)L_ca_addrchangeindex of type REAL defined as map((real) subjectrecordtimeoldest <= 84 and (real) subjectrecordtimeoldest >= 0 => map((real) addronfilecount > 5 => 5,(real) addronfilecount > 3 => 4,(real) addronfilecount > 2 => 3,(real) addronfilecount > 1 => 2, 1),map((real) addrchangecount60month > 3 => 5,(real) addrchangecount60month > 1 => 4,(real) addrchangecount60month > 0 => 3, 2))L_ca_nonderogindex_alt of type REAL defined as map((real) sourcenonderogcount > 3 and (real) sourcenonderogcount06month > 1 => 3,(real) sourcenonderogcount > 3 or (real) sourcenonderogcount06month > 1 => 2, 1)L_ca_derogseverityindex_orig of type REAL defined as map((real) evictioncount > 3 or ((real) evictioncount > 1 and (real) lienjudgmentcount > 0) or ((real) evictioncount > 0 and (real) bankruptcystatus = 2) => 5,(real) evictioncount > 1 or ((real) evictioncount > 0 and (real) lienjudgmentcount > 0) => 4,(real) evictioncount > 0 => 3,(real) bankruptcystatus = 2 => 2,(real) lienjudgmentcount > 0 => 1,0)L_ca_derogseverityindex of type REAL defined as map((L_ca_derogseverityindex_orig = 2 or L_ca_derogseverityindex_orig = 3) and (real) evictioncount = 0 and (real) bankruptcystatus = 2 => 8,(L_ca_derogseverityindex_orig = 2 or L_ca_derogseverityindex_orig = 3) and (real) evictioncount = 1 and (real) bankruptcystatus <> 2 => 7,(L_ca_derogseverityindex_orig = 4 or L_ca_derogseverityindex_orig = 5) and (real) evictioncount > 0 and (real) bankruptcystatus <> 2 and (real) lienjudgmentcount = 0 => 6,L_ca_derogseverityindex_orig)"


ScoreCard - SCORECARD_model110
This scorecard is a linear model.
The weights for each variable are computed as defined below
Combined_score is then calculated by adding the individual weights together
Raw_point is then calculated by adding the Combined_score to the Constant -0.172921378314879
The score is then processed according to the formula (700 + -40 * ((Raw_point - 0 - LN(0.35685210312076)) / LN(2))).
The value is then rounded to the nearest integer.
If the value is less than 501 it is set to 501.
If the value is greater than 900 it is set to 900.


Independant Variables
L_addrprevioustimeoldest_alt is defined in 9 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.006917638,0.006917638,
-1,-1,-0.192125399167892,0.0,NUMBER,0.006917638,0.006917638,C13
-998,-998,0.0,0.0,NUMBER,0.006917638,0.006917638,
999,999,0.0,0.0,NUMBER,0.006917638,0.006917638,
-999999999,96,0.195602970040618,0.0,NUMBER,0.006917638,0.006917638,C13
96,132,0.129691677434657,0.0,NUMBER,0.006917638,0.006917638,C13
132,204,0.0169316915846859,0.0,NUMBER,0.006917638,0.006917638,C13
204,240,-0.0774303118296151,0.0,NUMBER,0.006917638,0.006917638,C13
240,HIGH,-0.377374107224287,0.0,NUMBER,0.006917638,0.006917638,C13

L_ca_addrchangeindex is defined in 9 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,-0.050522645,-0.050522645,
-1,-1,0.0,0.0,NUMBER,-0.050522645,-0.050522645,C14
-998,-998,0.0,0.0,NUMBER,-0.050522645,-0.050522645,
999,999,0.0,0.0,NUMBER,-0.050522645,-0.050522645,
-999999999,1.5,-0.361445513556842,0.0,NUMBER,-0.050522645,-0.050522645,C14
1.5,2.5,-0.0326651072762166,0.0,NUMBER,-0.050522645,-0.050522645,C14
2.5,3.5,0.228542788688605,0.0,NUMBER,-0.050522645,-0.050522645,C14
3.5,4.5,0.345993801395147,0.0,NUMBER,-0.050522645,-0.050522645,C14
4.5,HIGH,0.650067423161005,0.0,NUMBER,-0.050522645,-0.050522645,C14

L_ca_creditseeking is defined in 12 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,-0.145916024,-0.145916024,
-1,-1,0.0,0.0,NUMBER,-0.145916024,-0.145916024,I60
-998,-998,0.0,0.0,NUMBER,-0.145916024,-0.145916024,
999,999,0.0,0.0,NUMBER,-0.145916024,-0.145916024,
-999999999,0,-0.362569357925149,0.0,NUMBER,-0.145916024,-0.145916024,I60
1,1,0.0367915769388987,0.0,NUMBER,-0.145916024,-0.145916024,I60
2,2,0.222011816622779,0.0,NUMBER,-0.145916024,-0.145916024,I60
3,3,0.467339660305824,0.0,NUMBER,-0.145916024,-0.145916024,I60
4,4,0.943890182033126,0.0,NUMBER,-0.145916024,-0.145916024,I60
5,5,0.979326295061764,0.0,NUMBER,-0.145916024,-0.145916024,I60
6,6,0.222011816622779,0.0,NUMBER,-0.145916024,-0.145916024,C21
6,HIGH,0.0367915769388987,0.0,NUMBER,-0.145916024,-0.145916024,I61

L_ca_derogseverityindex is defined in 13 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,-0.17793609,-0.17793609,
-1,-1,0.0,0.0,NUMBER,-0.17793609,-0.17793609,
-998,-998,0.0,0.0,NUMBER,-0.17793609,-0.17793609,
999,999,0.0,0.0,NUMBER,-0.17793609,-0.17793609,
-999999999,0,-0.204450773503088,0.0,NUMBER,-0.17793609,-0.17793609,
1,1,-0.129339415823904,0.0,NUMBER,-0.17793609,-0.17793609,D34
2,2,0.331183108776348,0.0,NUMBER,-0.17793609,-0.17793609,D30
3,3,0.331183108776348,0.0,NUMBER,-0.17793609,-0.17793609,D30
4,4,0.475902823827432,0.0,NUMBER,-0.17793609,-0.17793609,D30
5,5,0.475902823827432,0.0,NUMBER,-0.17793609,-0.17793609,D30
6,6,0.475902823827432,0.0,NUMBER,-0.17793609,-0.17793609,D33
7,7,0.331183108776348,0.0,NUMBER,-0.17793609,-0.17793609,D33
7,HIGH,0.331183108776348,0.0,NUMBER,-0.17793609,-0.17793609,D31

L_ca_nonderogindex_alt is defined in 6 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.251102104,0.251102104,
-1,-1,0.0,0.0,NUMBER,0.251102104,0.251102104,C12
-998,-998,0.0,0.0,NUMBER,0.251102104,0.251102104,
999,999,0.0,0.0,NUMBER,0.251102104,0.251102104,
-999999999,1.5,0.269980986524245,0.0,NUMBER,0.251102104,0.251102104,C12
1.5,HIGH,-0.254808888546115,0.0,NUMBER,0.251102104,0.251102104,C12

addrcurrentownershipindex is defined in 8 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.044169642,0.044169642,
-1,-1,0.0,0.0,NUMBER,0.044169642,0.044169642,A44
-998,-998,0.0,0.0,NUMBER,0.044169642,0.044169642,
999,999,0.0,0.0,NUMBER,0.044169642,0.044169642,
-999999999,0.5,0.241278264062402,0.0,NUMBER,0.044169642,0.044169642,A44
0.5,2.5,0.00593506382761733,0.0,NUMBER,0.044169642,0.044169642,A44
2.5,3.5,-0.422097965223441,0.0,NUMBER,0.044169642,0.044169642,A44
3.5,HIGH,-0.426452499208887,0.0,NUMBER,0.044169642,0.044169642,A44

assetpropevercount is defined in 7 ranges.
Low Bound,High Bound,Points,Multiplier,Method,Expected,Best,Reason Code
-998,-998,0.0,0.0,NUMBER,0.233084749,0.233084749,
-1,-1,0.0,0.0,NUMBER,0.233084749,0.233084749,A41
-998,-998,0.0,0.0,NUMBER,0.233084749,0.233084749,
999,999,0.0,0.0,NUMBER,0.233084749,0.233084749,
-999999999,0.5,0.258573459164827,0.0,NUMBER,0.233084749,0.233084749,A41
0.5,1.5,-0.146309609694865,0.0,NUMBER,0.233084749,0.233084749,A41
1.5,HIGH,-0.597848433083429,0.0,NUMBER,0.233084749,0.233084749,A41



