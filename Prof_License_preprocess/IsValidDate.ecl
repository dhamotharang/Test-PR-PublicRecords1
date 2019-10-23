import Prof_License,STD;
EXPORT IsValidDate := module

//Expiration_Date

dValid_Expdate := Prof_License.File_prolic_in ( STD.DATE.IsValidDate((INTEGER) trim(expiration_date)) = FALSE AND expiration_date <> ''   and trim(expiration_date)[5..8] not in  ['0000'] and trim(expiration_date)[7..8] <> '' and regexfind('/',expiration_date) = true);

//output(ds(trim(vendor) = 'GEORGIA COMPOSITE STATE BOARD OF MEDICAL EXAMINERS' ));
exprec := record
//ds.expiration_date;
 dValid_Expdate.vendor;
integer count_ := count(group);
end;

t_Expdates := table(dValid_Expdate,exprec,/*expiration_date,*/vendor,few);

out_exp := output(sort(t_Expdates ,-count_),named('Invalid_Expiration_Dates'));

//Issue_Date

dValid_Issue_Date := Prof_License.File_prolic_in ( STD.DATE.IsValidDate((INTEGER) trim(Issue_Date)) = FALSE AND Issue_Date <> ''   and trim(Issue_Date)[5..8] not in  ['0000'] and trim(Issue_Date)[7..8] <> '' and regexfind('/',Issue_Date) = true);

//output(ds(trim(vendor) = 'GEORGIA COMPOSITE STATE BOARD OF MEDICAL EXAMINERS' ));
issuerec := record
//ds.expiration_date;
 dValid_Issue_Date.vendor;
integer count_ := count(group);
end;

t_Issuedates := table(dValid_Issue_Date,issuerec,/*expiration_date,*/vendor,few);

out_issue := output(sort(t_Issuedates ,-count_),named('Invalid_Issue_Dates'));

export alldate := sequential( out_exp,out_issue);
end;