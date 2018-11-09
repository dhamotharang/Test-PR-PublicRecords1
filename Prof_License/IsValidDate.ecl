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

srt_exp := sort(t_Expdates ,-count_); 


out_exp := output(srt_exp,named('Invalid_Expiration_Dates'));

validate_exp := if ( srt_exp[1].count_ > 1000 and ut.DaysApart ( (STRING8)STD.Date.Today() , srt_exp[1].date_last_seen ) < 30  ,fail ('Count greater than 1000'),Output('LOOKS GOOD')); 


//Issue_Date

dInValid_Issue_Date := Prof_License.File_prolic_in ( STD.DATE.IsValidDate((INTEGER) trim(Issue_Date)) = FALSE AND Issue_Date <> ''   and trim(Issue_Date)[5..8] not in  ['0000'] and trim(Issue_Date)[5..8] <> '' );

issuerec := record
 dInValid_Issue_Date.vendor;
  dInValid_Issue_Date.date_last_seen;
integer count_ := count(group);
end;

t_Issuedates := sort(table(dInValid_Issue_Date,issuerec,date_last_seen,vendor,few),-count_);

out_issue := output(t_Issuedates,named('Invalid_Issue_Dates'));

validate_issue := if ( t_Issuedates[1].count_ > 1000 and ut.DaysApart ( (STRING8)STD.Date.Today() , t_Issuedates[1].date_last_seen ) < 30  ,fail ('Count greater than 1000'),Output('LOOKS GOOD')); 


return sequential( out_exp,out_issue, validate_exp, validate_issue);
end;