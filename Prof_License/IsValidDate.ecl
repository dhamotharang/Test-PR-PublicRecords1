import Prof_License,STD,ut;
EXPORT IsValidDate := function

//Expiration_Date

dInValid_Expdate := Prof_License.File_prolic_in ( STD.DATE.IsValidDate((INTEGER) trim(expiration_date)) = FALSE AND expiration_date <> ''   and trim(expiration_date)[5..8] not in  ['0000'] and trim(expiration_date)[5..8] <> '' );

exprec := record
 dInValid_Expdate.vendor;
 dInValid_Expdate.date_last_seen;
integer count_ := count(group);
end;

t_Expdates := table(dInValid_Expdate,exprec,date_last_seen,vendor,few);

out_exp := output(t_Expdates,named('Invalid_Expiration_Dates'));


srt_exp := sort(t_Expdates ,-count_,-date_last_seen); 

expfinalrec := record
exprec;
string alert_flag := 'N';
end;

expfinalrec  texpdt ( srt_exp l ) := transform
self.alert_flag := if (  l.count_ > 1000 and ut.DaysApart ( (STRING8)STD.Date.Today() , l.date_last_seen ) < 30 ,'Y','N');
self := l;
end;

srt_exp_final := project( srt_exp, texpdt(left));




validate_exp := if ( count(srt_exp_final(alert_flag = 'Y')) > 0  ,Sequential( Output(topn(srt_exp_final(alert_flag = 'Y'), 100, -date_last_seen) , named ( 'New_Invalid_Expiration_Dates')),
                                                                                                      fail ('Count greater than 1000')
																		    ),
															Output('LOOKS GOOD')
  ); 




//Issue_Date

dInValid_Issue_Date := Prof_License.File_prolic_in ( STD.DATE.IsValidDate((INTEGER) trim(Issue_Date)) = FALSE AND Issue_Date <> ''   and trim(Issue_Date)[5..8] not in  ['0000'] and trim(Issue_Date)[5..8] <> '' );

issuerec := record
 dInValid_Issue_Date.vendor;
  dInValid_Issue_Date.date_last_seen;
integer count_ := count(group);
end;

t_Issuedates := sort(table(dInValid_Issue_Date,issuerec,date_last_seen,vendor,few),-count_);

srt_issue := sort(t_Issuedates ,-count_,-date_last_seen); 

issuefinalrec := record
issuerec;
string alert_flag := 'N';
end;

issuefinalrec  tissuedt ( srt_exp l ) := transform
self.alert_flag := if (  l.count_ > 1000 and ut.DaysApart ( (STRING8)STD.Date.Today() , l.date_last_seen ) < 30 ,'Y','N');
self := l;
end;

srt_issue_final := project( srt_issue, tissuedt(left));




validate_issue := if ( count(srt_issue_final(alert_flag = 'Y')) > 0  ,Sequential( Output(topn(srt_issue_final(alert_flag = 'Y'), 100, -date_last_seen) , named ( 'New_Invalid_Issue_Dates')),
                                                                                                      fail ('Count greater than 1000')
																		    ),
															Output('LOOKS GOOD')
  ); 



out_issue := output(t_Issuedates,named('Invalid_Issue_Dates'));



return sequential( out_exp,out_issue, validate_exp, validate_issue);
end;