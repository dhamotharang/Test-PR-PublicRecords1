	ds := dataset('~thor_data400::in::ln_propertyv2::irs.Deed', LN_PropertyV2.Layouts.PreProcess_Deed_Layout, flat);

	LN_PropertyV2.layout_deed_mortgage_common_model_base deedCmTran(LN_PropertyV2.Layouts.PreProcess_Deed_Layout l):= transform
		self.ln_ownership_rights := '';
		self.ln_relationship_type := '';
		self.ln_buyer_mailing_country_code := '';
		self.ln_seller_mailing_country_code := '';
		self := l;
	end;

export irs_dummy_recs_deed := project(ds, deedCmTran(left));
		
/*
Deed conversion
true_deed_records:= dataset(
[{'ODx014318179','20060517','OKCTY','D','26161','MI','WASHTENAW         ','T','x9-09-10-400-066                             ','    ','                                       ','          ','MARSUPIAL, MARK','HW','','','  ',' ','          ','                                                                                                                                                      ','                                        ','401 N LAZY LAKE ROAD                                             ','','ANN ARBOR, MI 48104  ','                                                                                ','  ','                                                                                ','  ','  ','                                                                      ','      ','                                                   ',' ','AARDVARK, JOHN','  ','','',' ','','123 MAIN STREET','      ','NEW YORK, NY','                                                                                                                                                      ','401 N LAZY LAKE ROAD','      ','ANN ARBOR, MI',' ','          ','  ','          ','       ','       ','       ','       ','x65','ANN ARBOR                     ','LAZY LAKES DEVELOPMENT','       ','          ','                              ','WASHTENAW COUNTY LAZIEST LAKE #305                                                                     ','LL3789     ','Y','20010114','20060105','5697758             ','WD ','                    ','4530    ','310       ','5697759            ','0000185000 ','D','0138750','0020350','0159100','000148000  ','000000000  ','B','     ','G    ','    ','    ','20360101','NONE AVAILABLE                                              ','   ','     ','     ','USAA FSB                                ','002411','                                        ','                                                            ','      ','78288                                    ','    ','RES',' ',' ','          ','                                                   ','      ','    ','                              ',' ',' ','    ','               ',' ',' ',' ',' ','',' ',' ',' ',' ',' ',' ',' ','IDM',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','            ','            ','                     ',' ','            ','                             ','                                                                       ','                                                                    ','                                             ',' ','   ','                                                            ','        ','      ','    ','     ','         ',' ',' ',' ','                                                            ','' }],
LN_mortgage.Layout_Deed_Mortgage_Common_Model_Base);

output(true_deed_records);
ln_propertyv2.layout_deed_mortgage_common_model_base t_deed_v1_in_to_v2_in(true_deed_records le) := transform

 self.vendor_source_flag := map( le.vendor_source_flag = 'FAR_F' => 'F', 
                                 le.vendor_source_flag = 'FAR_S' => 'S',
								 le.vendor_source_flag = 'OKCTY' => 'O', 
				                 le.vendor_source_flag = 'DAYTN' => 'D',
								 '');

 self.buyer_or_borrower_ind := 'O';
 self.name1                 := le.buyer1;
 self.name1_id_code         := le.buyer1_id_code;
 self.name2                 := le.buyer2;
 self.name2_id_code         := le.buyer2_id_code;
 self.vesting_code          := le.buyer_vesting_code;
 self.addendum_flag         := le.buyer_addendum_flag;
 //self.phone_number          := '';
 self.mailing_care_of       := le.buyer_mailing_address_care_of_name;
 self.mailing_street        := le.buyer_mailing_full_street_address;
 self.mailing_unit_number   := if(le.state!='HI',le.buyer_mailing_address_unit_number,le.hawaii_property_address_unit_number);
 self.mailing_csz           := le.buyer_mailing_address_citystatezip;
 self.mailing_address_cd    := ''; //looks like borrowers only
 
 self.legal_brief_description := trim(stringlib.stringcleanspaces(le.legal_brief_description+' '+le.hawaii_legal));
 
 self := le;
 self := [];

end;

convert_in_true_deed_records := project(true_deed_records,t_deed_v1_in_to_v2_in(left));
output(convert_in_true_deed_records,, '~thor_data400::in::ln_propertyv2::irs.Deed'); */ 