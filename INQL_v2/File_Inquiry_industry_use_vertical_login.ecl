import ut, did_add;


export File_Inquiry_industry_use_vertical_login := module

df := INQL_v2.File_MBS.File;

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

export MBS_slim := dedup(sort(df_dist, gc_id, company_id, product_id, local), 
												gc_id, company_id, product_id, local);


end; 
 