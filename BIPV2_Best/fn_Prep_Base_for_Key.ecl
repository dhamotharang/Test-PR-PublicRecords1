import BIPV2;
EXPORT fn_Prep_Base_for_Key 
			(string pversion
			 ,dataset(BIPV2_Best.Layouts.Base) pBestBase         = BIPV2_Best.Files(pversion).base.built
			 ,MaxSize = 4080)
			:= function

key_size := 48;
id_size := sizeof(BIPV2.IDlayouts.l_xlink_ids) + 6 ;
name_size := sizeof(BIPV2_Best.Layouts.company_name_case_layout and not [score, Sources]);
address_size := sizeof(BIPV2_Best.Layouts.company_address_case_layout and not [score, state_fips, county_fips]);
phone_size := sizeof(BIPV2_Best.Layouts.company_phone);
fein_size := sizeof(BIPV2_Best.Layouts.company_fein and not [company_fein_cnt,company_fein_owns]);
url_size := sizeof(BIPV2_Best.Layouts.company_url);
incorp_date_size := sizeof(BIPV2_Best.Layouts.company_incorporation_date);
source_size := sizeof(BIPV2_Best.Layouts.Source);	
duns_size := sizeof(BIPV2_Best.Layouts.duns_number);
	
Size_layout := record
BIPV2_Best.Layouts.Base;
unsigned fixed_size;
unsigned total_size;
end;

Size_layout t_sizeit(pBestBase le) := transform
		
    name_children := count(le.company_name);
		name_grandchildren:= sum(loop(project(le.company_name, {recordof(le.company_name), unsigned childcnt := 0}),
													    count(le.company_name), 
															PROJECT(ROWS(LEFT),
																			TRANSFORM({recordof(le.company_name), unsigned childcnt := 0},
																			SELF.childcnt := count(le.company_name[counter].sources);
																			SELF := LEFT))), childcnt);
		address_children:=  count(le.company_address);
		phone_children:= count(le.company_phone);
		fein_children:= count(le.company_fein);
		fein_grandchildren:= sum(loop(project(le.company_fein, {recordof(le.company_fein), unsigned childcnt := 0}),
													    count(le.company_fein), 
															PROJECT(ROWS(LEFT),
																			TRANSFORM({recordof(le.company_fein), unsigned childcnt := 0},
																			SELF.childcnt := count(le.company_fein[counter].sources);
																			SELF := LEFT))), childcnt);
		url_children:= count(le.company_url);
		incorp_date_children:= count(le.company_incorporation_date);
		incorp_date_grandchildren:= sum(loop(project(le.company_incorporation_date, {recordof(le.company_incorporation_date), unsigned childcnt := 0}),
													    count(le.company_incorporation_date), 
															PROJECT(ROWS(LEFT),
																			TRANSFORM({recordof(le.company_incorporation_date), unsigned childcnt := 0},
																			SELF.childcnt := count(le.company_incorporation_date[counter].sources);
																			SELF := LEFT))), childcnt);
		duns_children:= count(le.duns_number);
		self.fixed_size := key_size + 
																	id_size +  
																	(name_size         * if(name_children = 0, 1, name_children)) +
																	(address_size      * if(address_children = 0, 1, address_children)) +
																	(phone_size        * if(phone_children = 0, 1, phone_children)) +
																	(fein_size         * if(fein_children = 0, 1, fein_children)) +
																	(url_size          * if(url_children = 0, 1, url_children )) +
																	(incorp_date_size  * if(incorp_date_children = 0, 1, incorp_date_children)) +
																	(duns_size          * if(duns_children = 0, 1, duns_children )) ;
		self.total_size :=self.fixed_size +  
																	(source_size       * if(name_grandchildren = 0, 1, name_grandchildren)) +
																	(source_size       * if(fein_grandchildren = 0, 1, fein_grandchildren)) +
																	(source_size       * if(incorp_date_grandchildren=  0, 1, incorp_date_grandchildren));
		 self := le;
end;

row_count := project(pBestBase,t_sizeit(left));

large_records := 	row_count(total_size > MaxSize);
good_size := row_count(total_size <= MaxSize);



BIPV2_Best.Layouts.base t_reduce_size(large_records le) := transform
  fixed_size := le.fixed_size;
	name_fein_num := count(le.company_name) + count(le.company_fein) + count(le.company_incorporation_date);
	self.company_name := project(le.company_name,
				transform(BIPV2_Best.Layouts.company_name_case_layout,
							self.sources := choosen(left.sources, (((MaxSize-fixed_size)/ source_size) / name_fein_num)),
							self := left)),
	self.company_fein := project(le.company_fein,
				transform(BIPV2_Best.Layouts.company_fein_case_layout,
							self.sources := choosen(left.sources,(((MaxSize-fixed_size)/ source_size) / name_fein_num)),
							self := left));			
	self.company_incorporation_date := project(le.company_incorporation_date,
				transform(BIPV2_Best.Layouts.company_incorporation_date_layout,
							self.sources := choosen(left.sources,(((MaxSize-fixed_size)/ source_size) / name_fein_num)),
							self := left));	

	self := le;
end;


reduce_large_recs := project(large_records, t_reduce_size(left));
re_count := project(reduce_large_recs,t_sizeit(left)); 
good_size_resized := re_count(total_size <= MaxSize);

for_index := project(good_size + good_size_resized, BIPV2_Best.Layouts.base);

return for_index;
end;
