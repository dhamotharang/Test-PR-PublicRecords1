import Prof_License,STD;
EXPORT IsValidDate := function

//Expiration_Date

dValid_Expdate := Prof_License.File_prolic_in ( STD.DATE.IsValidDate((INTEGER) trim(expiration_date)) = FALSE AND expiration_date <> ''   and trim(expiration_date)[5..8] not in  ['0000'] and trim(expiration_date)[7..8] <> '' and regexfind('/',expiration_date) = true);

exprec := record
 dValid_Expdate.vendor;
integer count_ := count(group);
end;

t_Expdates := table(dValid_Expdate,exprec,vendor,few);

out_exp := output(sort(t_Expdates ,-count_),named('Invalid_Expiration_Dates'));

//Issue_Date

dValid_Issue_Date := Prof_License.File_prolic_in ( STD.DATE.IsValidDate((INTEGER) trim(Issue_Date)) = FALSE AND Issue_Date <> ''   and trim(Issue_Date)[5..8] not in  ['0000'] and trim(Issue_Date)[7..8] <> '' and regexfind('/',Issue_Date) = true);

issuerec := record
 dValid_Issue_Date.vendor;
integer count_ := count(group);
end;

t_Issuedates := table(dValid_Issue_Date,issuerec,vendor,few);

out_issue := output(sort(t_Issuedates ,-count_),named('Invalid_Issue_Dates'));

return sequential( out_exp,out_issue);
end;