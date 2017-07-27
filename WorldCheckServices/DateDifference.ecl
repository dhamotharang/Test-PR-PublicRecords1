import ut;
string4 noMMDD := '0000';
string4 defaultMMDD := '0101';

// this must handle year only dates 19660000 correctly
// DaysApart does not handle 19660000 correctly
export DateDifference(string8 d1, string8 d2) := if( ((integer)d1[1..4]) = ((integer)d2[1..4]) OR
													( ((integer)d1[1..4]) > ((integer)d2[1..4]) AND d2[5..8]<>noMMDD ) OR 
													( ((integer)d2[1..4]) > ((integer)d1[1..4]) AND d1[5..8]<>noMMDD ),
															ut.DaysApart(if(d1[5..8]<>noMMDD,d1, d1[1..4] + defaultMMDD), if(d2[5..8]<>noMMDD,d2, d2[1..4] + defaultMMDD)), 
															ut.DaysApart(if(d1[5..8]<>noMMDD,d1, d1[1..4] + defaultMMDD), if(d2[5..8]<>noMMDD,d2, d2[1..4] + defaultMMDD)) - 365);
