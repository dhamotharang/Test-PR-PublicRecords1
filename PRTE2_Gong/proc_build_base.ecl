IMPORT  PRTE2_Gong,PromoteSupers, prte2, ut, std,Address, aid,didville;

EXPORT PROC_BUILD_BASE := FUNCTION

prte2.CleanFields(Files.DS_Gong_Santander_IN, gong_sant_in_clean);
prte2.CleanFields(Files.DS_Gong_History_IN, gong_hist_in_clean);
prte2.CleanFields(Files.DS_Gong_Weekly_IN, gong_week_in_clean);

gong_week_clean_filt := PROJECT(gong_week_in_clean, TRANSFORM(recordof(gong_week_in_clean), 
											self.bell_id := if (left.bell_id ='', 
															'NEU', 
															left.bell_id), 
											self.current_record_flag := 'Y',
											self := left))(filedate!= 'FILEDATE' and phone10 != '');

gong_hist_old := (gong_hist_in_clean(cust_name = '') + gong_sant_in_clean(cust_name = ''))(STD.Str.ToUpperCase(filedate)!= 'FILEDATE' and filedate != '');
gong_hist_new := (gong_hist_in_clean(cust_name != '') + gong_sant_in_clean(cust_name != ''))(STD.Str.ToUpperCase(filedate)!= 'FILEDATE' and filedate != '');

gong_hist_addr_rdy := project(gong_hist_new, transform(recordof(gong_hist_new) or {string typ := 'hist'}, self := left));
gong_week_addr_rdy := project(gong_week_clean_filt(cust_name != ''), transform(recordof(gong_hist_new) or {string typ := 'week'}, self := left));
gong_combined_addr_rdy := gong_hist_addr_rdy + gong_week_addr_rdy;
gong_combined_new_clean_address := PRTE2.AddressCleaner(		gong_combined_addr_rdy, 					// Record set with addresses to be cleaned
																													['address1'],  			// Set of fields containing address line 1
																													['street_address_2'],  			// Set of fields containing address line 2
																													['city'],										 			// Set of fields containing city
																													['state'],										 			// Set of fields containing state
																													['zip'],										 			// Set of fields containing zip
																													['clean_address'],		 			// Target fields for Address.Layout_Clean182_fips	
																													['admin_rawaid']) ;	   			// Target fields for rawaids
layouts.layout_base  or {string typ} xform_clean(gong_combined_new_clean_address l) := transform
			clean_name := if (	l.listing_type_res != '',
													Address.CleanPersonFML73(STD.Str.CleanSpaces(trim(l.listed_name))),
													'');
			self.name_first := if (	l.listing_type_res != '',
													Address.CleanNameFields(clean_name).fname,
													'');
			self.name_middle := if (	l.listing_type_res != '',
													Address.CleanNameFields(clean_name).mname,
													'');
			self.name_last := if (	l.listing_type_res != '',
												Address.CleanNameFields(clean_name).lname,
												'');
			self.name_suffix := if (	l.listing_type_res != '',
													Address.CleanNameFields(clean_name).name_suffix,
													'');

			self.county_code 		:= l.clean_address.fips_county;
			self.z5							:= l.clean_address.zip;
			self.z4							:= l.clean_address.zip4;
			self.did := if (	l.listing_type_res != '',
												prte2.fn_AppendFakeID.did(self.name_first, self.name_last, l.link_ssn, l.link_dob, l.cust_name),
												0);			
			self 	:= l.clean_address;
			self.bdid := if (	l.listing_type_bus != '',
												prte2.fn_AppendFakeID.bdid(l.listed_name,	self.prim_range,	self.prim_name, self.v_city_name, self.st, self.z5, l.cust_name),
												0);
			vLinkingIds := prte2.fn_AppendFakeID.LinkIds(l.listed_name, l.link_fein, l.link_inc_date,  l.prim_range,  l.prim_name
																							,  l.sec_range,  l.v_city_name,  l.st,  l.zip,  l.cust_name);
			self.powid	:=  if (	l.listing_type_bus != '',vLinkingIds.powid, 0) ;
			self.proxid	:=  if (	l.listing_type_bus != '',vLinkingIds.proxid, 0) ;
			self.seleid	:=  if (	l.listing_type_bus != '',vLinkingIds.seleid, 0) ;
			self.orgid	:=  if (	l.listing_type_bus != '',vLinkingIds.orgid, 0) ;
			self.ultid	:=  if (	l.listing_type_bus != '',vLinkingIds.ultid, 0) ;
			self.bell_id := if (l.bell_id ='', 
															'NEU', 
															l.bell_id),
			self.global_sid := 0;
			self.record_sid	:= 0;
			self.rawaid			:= l.admin_rawaid;
			self	:= l;
			self 	:= [];
end;
//merge in hhid

gong_hist_new_clean := Project(gong_combined_new_clean_address,xform_clean(left));


didville.MAC_HHID_Append(gong_hist_new_clean, 
									'BEST_HHID', 
									gong_hist_new_clean_hhid);
df_gong_hist_old := PROJECT(gong_hist_old, TRANSFORM(layouts.Layout_base, 
											self.bell_id := if (left.bell_id ='', 
															'NEU', 
															left.bell_id), 
											self.global_sid := 0;
											self.record_sid	:= 0;				
											self := left;
											self := []));

gong_hist_new_rdy :=  project(gong_hist_new_clean_hhid(typ = 'hist'), layouts.Layout_base);
gong_week_new_rdy :=  project(gong_hist_new_clean_hhid(typ = 'week'), layouts.Layout_base);
gong_weekly_old 		:= 	project(gong_week_clean_filt(cust_name = ''), transform(layouts.Layout_base, self := left, self := []));
gong_week_dedup := dedup(gong_weekly_old + gong_week_new_rdy , record, all);
gong_hist_dedup := dedup(df_gong_hist_old + gong_hist_new_rdy + gong_week_dedup, record, all);
PromoteSupers.MAC_SF_BuildProcess(gong_hist_dedup,'~PRTE::BASE::Gong_History', writefile_gong1);
PromoteSupers.MAC_SF_BuildProcess(gong_week_dedup,'~PRTE::BASE::Gong_Weekly', writefile_gong2);

Return sequential(writefile_gong1,writefile_gong2);
END;