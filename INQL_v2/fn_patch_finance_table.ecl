EXPORT fn_Patch_Finance_Table(dataset(recordof(INQL_v2.Layouts.MBS_Finance_common)) infile) := function
import ut, Data_Services;

company_info := dataset(Data_Services.foreign_logs + 'thor100_21::in::company_info',
													{string product_id, string gc_id, string company_id, string billing_id, string mbs_company_name, string company_status, string mbs_primary_market_code, string mbs_secondary_market_code, string mbs_industry_code_1, string mbs_industry_code_2},
													csv(separator('~~'), quote(','), heading(1)));
temp_rec := record

recordof(infile);
string appended_company_id := '';
string appended_billing_id := '';
end;

file_append_MBS_j := join(infile(gc_id <> ''), company_info, left.gc_id = right.gc_id and left.product_id = right.product_id and
left.company_id_finance = right.billing_id,
transform(temp_rec, self.appended_company_id := right.company_id,
self.appended_billing_id := right.billing_id,
self.acct_name := StringLib.StringToUpperCase(left.acct_name),
self := left), left outer);

file_append_MBS := file_append_MBS_j + project(infile(gc_id = ''), transform(temp_rec,  
self.appended_company_id := left.company_id_finance, 
self.appended_billing_id := left.billing_id_finance, 
self.acct_name := StringLib.StringToUpperCase(left.acct_name), 
self := left));

file_has_appended_id_grp := group(sort(file_append_MBS(appended_company_id <> ''),hhid, acct_name, appended_company_id, product_id), hhid, acct_name,appended_company_id, product_id);

file_has_no_appended_id := file_append_MBS(appended_company_id = '');

file_has_appended_id_grp tIteration(file_has_appended_id_grp le, file_has_appended_id_grp ri) := transform
self.gc_id   := if(le.gc_id = '' and ri.gc_id != '', ri.gc_id, le.gc_id);
self.vertical   := if(le.vertical = '' and ri.vertical != '', ri.vertical, le.vertical);
self.market     := if(le.market = '' and ri.market != '', ri.market, le.market);
self.sub_market := if(le.sub_market = '' and ri.sub_market != '', ri.sub_market, le.sub_market);
self := ri;
end;

file_has_appended_id_iter := group(iterate(file_has_appended_id_grp,tIteration(left,right)));

finance_comb := project(file_has_appended_id_iter + file_has_no_appended_id, transform(recordof(infile), self := left));

return finance_comb;

end;