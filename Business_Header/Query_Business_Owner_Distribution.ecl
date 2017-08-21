import ut;

#workunit ('name', 'Business Owner Distribution Stats ' + Business_Header.version);

bc := Business_Header.File_Business_Contacts;

layout_bc_slim := record
bc.did;
bc.company_title;
end;

bc_slim := table(bc(company_title <> ''), layout_bc_slim);

output(count(bc_slim(ut.TitleRank(company_title) = 1)), named('Total_Business_Owners'));
output(count(bc_slim(ut.TitleRank(company_title) = 1, did <> 0)), named('Total_Business_Owners_With_DID'));
output(count(dedup(bc_slim(ut.TitleRank(company_title) = 1, did <> 0),did,all)), named('Total_Business_Owners_Unique_DID'));


