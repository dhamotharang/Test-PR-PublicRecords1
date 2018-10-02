import doxie,ut,INQL_v2,Data_Services;

export Key_Inquiry_industry_use_vertical(boolean IsFCRA=false) := function

df := INQL_v2.File_MBS.File(~(INQL_v2.fnTranslations.is_Disable_Observation(allowflags) or 
                              INQL_v2.fnTranslations.is_opt_out(allowflags) or
															INQL_v2.fnTranslations.is_Exclude_Inquiry_Access(allowflags)));

//mapping to the MBS industry vertical layout
df_ := project(df, transform({INQL_v2.Layout_MBS_Industry_vertical}
							       ,self.sub_market := if (left.sub_market='CARD','CARDS',left.sub_market)
										 ,self := left
                     ,self := []));
						
df_dist  := distribute(df_, hash(company_id,gc_id));
df_dedup := dedup(sort(df_dist, gc_id, company_id, product_id, local), gc_id, company_id, product_id, local);

//the maximum length for company_id is 12, for product_id is 2 and for gc_id is 4 in the current version
//the length given below is longer than the maximum length in case the length will be expanded in the future

InDx_FN := Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table'+if(IsFCRA,'::fcra::','::') + 'industry_use_vertical_' + doxie.Version_SuperKey;

return INDEX(df_dedup, {string20 s_company_id := company_id, string4 s_product_id := product_id,string20 s_gc_id := gc_id }, {df_dedup}, InDx_FN);

end;