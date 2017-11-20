import doxie,ut,Inquiry_AccLogs,Data_Services;

EXPORT Key_Inquiry_industry_use_vertical_login (boolean IsFCRA=false) := function

df := Inquiry_AccLogs.File_MBS.File;

//mapping to the MBS industry vertical layout

r:= record
string company_id;
string product_id;
string gc_id;
string vertical;
string sub_market;
string industry;
end;

df_ := project(df, transform(r
															,self.sub_market := if (left.sub_market='CARD','CARDS',left.sub_market)
															,self := left
															, self := []));
						
df_dist := distribute(df_, hash(company_id,gc_id));
df_dedup := dedup(sort(df_dist, gc_id, company_id, product_id, local), 
									gc_id, company_id, product_id, local);

//the maximum length for company_id is 12, for product_id is 2 and for gc_id is 4 in the current version
//the length given below is longer than the maximum length in case the length will be expanded in the future

return INDEX(df_dedup, {string20 s_company_id := company_id,
string4 s_product_id := product_id,string20 s_gc_id := gc_id }, {df_dedup} - company_id - product_id - gc_id,

Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table'+if(IsFCRA,'::fcra::','::') + 'industry_use_vertical_login_' + doxie.Version_SuperKey);

end;