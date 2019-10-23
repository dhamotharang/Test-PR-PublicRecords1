import address;

export File_Keybuild(

	 dataset(layouts.base.companies			)	pCompaniesBase	= files().base.companies.built
	,dataset(layouts.base.contacts			)	pContactsBase		= files().base.contacts.built
	,dataset(layouts.temporary.hierarchy)	pHierarchy			= File_Hierarchy()
	,string																pPersistname		= persistnames().FileKeybuild
) :=
function

	lOldlayout 					:= Layouts.base.keybuildEntNum				;
	lkeybuildprep 			:= layouts.temporary.keybuildprep			;
	lcontactsprep 			:= layouts.temporary.contactsprep			;

	//first rollup the contacts file
	//can't be more than 10 contacts per record
	//so, need to rollup on contacts with same enterprise #, and same date last seen(means they came from the same update)
	//much easier to rollup using child datasets for the executives
	//then, after the rollup, join to the companies file on enterprise # and overlap of date first/last seen to get the big keybuild prep layout
	dcontactsprep := project(pContactsBase(record_type in [Utilities.RecordType.Updated,Utilities.RecordType.New])	,transform(lcontactsprep,
		self.rawfields.executives	:= row(left.rawfields.executive	,layouts.input.lexecutives);
		self.clean_names					:= row(left.clean_name					,Address.Layout_Clean_Name);
		self											:= left;
	));
	
	dcontacts_sort := sort(distribute(dcontactsprep, 
	                            HASH64(rawfields.enterprise_num, date_last_seen)), rawfields.enterprise_num, -date_last_seen);

	dcompanies_prep := sort(distribute(project(pCompaniesBase(record_type in [Utilities.RecordType.Updated,Utilities.RecordType.New])	,transform(lkeybuildprep	,self := left; self := [];)),HASH64(rawfields.enterprise_num, date_last_seen)), rawfields.enterprise_num, -date_last_seen);

	djoin2companies := join(dcompanies_prep,dcontacts_sort,
				left.rawfields.enterprise_num  = right.rawfields.enterprise_num
		,transform(
			lkeybuildprep,
				self.rawfields.executives	:= right.rawfields.executives	;
				self.clean_names					:= right.clean_names					;
				self											:= left												;
				self											:= right											;
		)	
		,local
		,left outer
	);
	
	dcontactsrollup := rollup(sort(djoin2companies,	rawfields.enterprise_num, -date_vendor_last_reported)
		,		left.rawfields.enterprise_num = right.rawfields.enterprise_num
		    and count(left.rawfields.executives) >= 1
		,transform(lkeybuildprep,
			self.rawfields.executives	:= if(count(left.rawfields.executives	) < 10	,left.rawfields.executives	+ right.rawfields.executives, left.rawfields.executives);
			self.clean_names					:= if(count(left.clean_names					) < 10	,left.clean_names						+ right.clean_names					,	left.clean_names);		
			self											:= left;
		)
		,local
	);	

	dedupContactsRollup := dedup(dcontactsrollup, (UNSIGNED)rawfields.enterprise_num);	
	
	ldashindex(string pstring) := stringlib.stringfind(pstring,'-',1);

	dproj := project(dedupContactsRollup	,transform(
		{lOldlayout,string6 file_type},

		//fix jv1_ and jv2_ with intformat so they can be joined later on.
		jv1_dindex 	:= ldashindex(left.rawfields.JV1_num);
		jv1_root		:= if(jv1_dindex != 0	,intformat((unsigned)left.rawfields.JV1_num[1..(jv1_dindex - 1)]	,9,1)	,'');
		jv1_sub			:= if(jv1_dindex != 0	,intformat((unsigned)left.rawfields.JV1_num[(jv1_dindex + 1)..]		,4,1)	,'');
		jv2_dindex 	:= ldashindex(left.rawfields.JV2_num);
		jv2_root		:= if(jv2_dindex != 0	,intformat((unsigned)left.rawfields.JV2_num[1..(jv2_dindex - 1)]	,9,1)	,'');
		jv2_sub			:= if(jv2_dindex != 0	,intformat((unsigned)left.rawfields.JV2_num[(jv2_dindex + 1)..]		,4,1)	,'');

		self.bdid               				:= left.bdid											;	
		self.root												:= intformat(left.lncaGID	,9,1);
		self.sub												:= intformat(left.lncaIID	,4,1);							
		self.Enterprise_num							:= left.rawfields.Enterprise_num	;	
		self.Parent_Enterprise_number		:= left.rawfields.Parent_Enterprise_number	;	
		self.Ultimate_Enterprise_number	:= left.rawfields.Ultimate_Enterprise_number	;	
		self.Parent_Number							:= left.rawfields.Parent_Number		;
		self.JV1_												:= if(left.rawfields.JV1_num	!= ''
																					,jv1_root + '-' + jv1_sub
																					,''
																		);
		self.JV2_												:= if(left.rawfields.JV2_num	!= ''
																			,jv2_root + '-' + jv2_sub
																			,''
																		);
		self.process_date       				:= intformat(left.date_vendor_last_reported	,8,1);
		self.Type_orig          				:= left.rawfields.company_type;
		self.Net_Worth_         				:= left.rawfields.Net_Worth;
		self.Import_orig        				:= left.rawfields.DoesImport;
		self.Export_orig        				:= left.rawfields.DoesExport;
		self.PO_Box_Bldg        				:= left.rawfields.address1.PO_Box_Bldg  ;
		self.street             				:= left.rawfields.address1.Street       ;
		self.Foreign_PO         				:= left.rawfields.address1.Foreign_PO   ;
		self.Misc__adr          				:= left.rawfields.address1.Misc__adr    ;
		self.Postal_Code_1      				:= left.rawfields.address1.Postal_Code_1;
		self.city               				:= left.rawfields.address1.City         ;
		self.state              				:= left.rawfields.address1.State        ;
		self.zip                				:= left.rawfields.address1.Zip          ;
		self.Province           				:= left.rawfields.address1.Province     ;
		self.Postal_Code_2      				:= left.rawfields.address1.Postal_Code_2;
		self.country            				:= left.rawfields.address1.Country      ;
		self.Postal_Code_3      				:= left.rawfields.address1.Postal_Code_3;
		self.PO_Box_Bldg_A      				:= left.rawfields.address2.PO_Box_Bldg  ;
		self.StreetA            				:= left.rawfields.address2.Street       ;
		self.Foreign_PO_BoxA    				:= left.rawfields.address2.Foreign_PO   ;
		self.Misc__adr_A        				:= left.rawfields.address2.Misc__adr    ;
		self.Postal_Code_1A     				:= left.rawfields.address2.Postal_Code_1;
		self.City_A             				:= left.rawfields.address2.City         ;
		self.State_A            				:= left.rawfields.address2.State        ;
		self.Zip_A              				:= left.rawfields.address2.Zip          ;
		self.Province_A         				:= left.rawfields.address2.Province     ;
		self.Postal_Code_2A     				:= left.rawfields.address2.Postal_Code_2;
		self.CountryA           				:= left.rawfields.address2.Country      ;
		self.Postal_Code_3A     				:= left.rawfields.address2.Postal_Code_3;
		self.Name_1             				:= left.rawfields.executives[1].name	;
		self.Title_1            				:= left.rawfields.executives[1].Title	;
		self.code_1             				:= left.rawfields.executives[1].code 	;
		self.Name_2             				:= left.rawfields.executives[2].name	;
		self.Title_2            				:= left.rawfields.executives[2].Title	;
		self.code_2             				:= left.rawfields.executives[2].code 	;
		self.Name_3             				:= left.rawfields.executives[3].name	;
		self.Title_3            				:= left.rawfields.executives[3].Title	;
		self.code_3             				:= left.rawfields.executives[3].code 	;
		self.Name_4             				:= left.rawfields.executives[4].name	;
		self.Title_4            				:= left.rawfields.executives[4].Title	;
		self.code_4             				:= left.rawfields.executives[4].code 	;
		self.Name_5             				:= left.rawfields.executives[5].name	;
		self.Title_5            				:= left.rawfields.executives[5].Title	;
		self.code_5             				:= left.rawfields.executives[5].code 	;
		self.Name_6             				:= left.rawfields.executives[6].name	;
		self.Title_6            				:= left.rawfields.executives[6].Title	;
		self.code_6             				:= left.rawfields.executives[6].code 	;
		self.Name_7             				:= left.rawfields.executives[7].name	;
		self.Title_7            				:= left.rawfields.executives[7].Title	;
		self.code_7             				:= left.rawfields.executives[7].code 	;
		self.Name_8             				:= left.rawfields.executives[8].name	;
		self.Title_8            				:= left.rawfields.executives[8].Title	;
		self.code_8             				:= left.rawfields.executives[8].code 	;
		self.Name_9             				:= left.rawfields.executives[9].name	;
		self.Title_9            				:= left.rawfields.executives[9].Title	;
		self.code_9             				:= left.rawfields.executives[9].code 	;
		self.Name_10            				:= left.rawfields.executives[10].name	;
		self.Title_10           				:= left.rawfields.executives[10].Title	;
		self.code_10            				:= left.rawfields.executives[10].code 	;
    self.Phone                      := left.clean_phones.Phone              ;
    self.Fax                        := left.clean_phones.Fax                ;
    self.Telex                      := left.clean_phones.Telex              ;
    self.update_date                := trim(left.rawfields.update_date)[5..8] + trim(left.rawfields.update_date)[1..4];
		self														:= left.rawfields;
		self.exec1_title        				:= left.clean_names[1].title			;
		self.exec1_fname        				:= left.clean_names[1].fname			;
		self.exec1_mname        				:= left.clean_names[1].mname			;
		self.exec1_lname        				:= left.clean_names[1].lname			;
		self.exec1_name_suffix  				:= left.clean_names[1].name_suffix;
		self.exec1_score        				:= left.clean_names[1].name_score	;
		self.exec2_title        				:= left.clean_names[2].title			;
		self.exec2_fname        				:= left.clean_names[2].fname			;
		self.exec2_mname        				:= left.clean_names[2].mname			;
		self.exec2_lname        				:= left.clean_names[2].lname			;
		self.exec2_name_suffix  				:= left.clean_names[2].name_suffix;
		self.exec2_score        				:= left.clean_names[2].name_score	;
		self.exec3_title        				:= left.clean_names[3].title			;
		self.exec3_fname        				:= left.clean_names[3].fname			;
		self.exec3_mname        				:= left.clean_names[3].mname			;
		self.exec3_lname        				:= left.clean_names[3].lname			;
		self.exec3_name_suffix  				:= left.clean_names[3].name_suffix;
		self.exec3_score        				:= left.clean_names[3].name_score	;
		self.exec4_title        				:= left.clean_names[4].title			;
		self.exec4_fname        				:= left.clean_names[4].fname			;
		self.exec4_mname        				:= left.clean_names[4].mname			;
		self.exec4_lname        				:= left.clean_names[4].lname			;
		self.exec4_name_suffix  				:= left.clean_names[4].name_suffix;
		self.exec4_score        				:= left.clean_names[4].name_score	;
		self.exec5_title        				:= left.clean_names[5].title			;
		self.exec5_fname        				:= left.clean_names[5].fname			;
		self.exec5_mname        				:= left.clean_names[5].mname			;
		self.exec5_lname        				:= left.clean_names[5].lname			;
		self.exec5_name_suffix  				:= left.clean_names[5].name_suffix;
		self.exec5_score        				:= left.clean_names[5].name_score	;
		self.exec6_title        				:= left.clean_names[6].title			;
		self.exec6_fname        				:= left.clean_names[6].fname			;
		self.exec6_mname        				:= left.clean_names[6].mname			;
		self.exec6_lname        				:= left.clean_names[6].lname			;
		self.exec6_name_suffix  				:= left.clean_names[6].name_suffix;
		self.exec6_score        				:= left.clean_names[6].name_score	;
		self.exec7_title        				:= left.clean_names[7].title			;
		self.exec7_fname        				:= left.clean_names[7].fname			;
		self.exec7_mname        				:= left.clean_names[7].mname			;
		self.exec7_lname        				:= left.clean_names[7].lname			;
		self.exec7_name_suffix  				:= left.clean_names[7].name_suffix;
		self.exec7_score        				:= left.clean_names[7].name_score	;
		self.exec8_title        				:= left.clean_names[8].title			;
		self.exec8_fname        				:= left.clean_names[8].fname			;
		self.exec8_mname        				:= left.clean_names[8].mname			;
		self.exec8_lname        				:= left.clean_names[8].lname			;
		self.exec8_name_suffix  				:= left.clean_names[8].name_suffix;
		self.exec8_score        				:= left.clean_names[8].name_score	;
		self.exec9_title        				:= left.clean_names[9].title			;
		self.exec9_fname        				:= left.clean_names[9].fname			;
		self.exec9_mname        				:= left.clean_names[9].mname			;
		self.exec9_lname        				:= left.clean_names[9].lname			;
		self.exec9_name_suffix  				:= left.clean_names[9].name_suffix;
		self.exec9_score        				:= left.clean_names[9].name_score	;
		self.exec10_title       				:= left.clean_names[10].title			;
		self.exec10_fname       				:= left.clean_names[10].fname			;
		self.exec10_mname       				:= left.clean_names[10].mname			;
		self.exec10_lname       				:= left.clean_names[10].lname			;
		self.exec10_name_suffix 				:= left.clean_names[10].name_suffix;
		self.exec10_score       				:= left.clean_names[10].name_score	;
		self.prim_range         				:= left.physical_address.prim_range		;
		self.predir             				:= left.physical_address.predir				;
		self.prim_name          				:= left.physical_address.prim_name			;
		self.addr_suffix        				:= left.physical_address.addr_suffix		;
		self.postdir            				:= left.physical_address.postdir				;
		self.unit_desig         				:= left.physical_address.unit_desig		;
		self.sec_range          				:= left.physical_address.sec_range			;
		self.p_city_name        				:= left.physical_address.p_city_name		;
		self.v_city_name        				:= left.physical_address.v_city_name		;
		self.st                 				:= left.physical_address.st						;
		self.z5                 				:= left.physical_address.zip						;
		self.zip4               				:= left.physical_address.zip4					;
		self.cart               				:= left.physical_address.cart					;
		self.cr_sort_sz         				:= left.physical_address.cr_sort_sz		;
		self.lot                				:= left.physical_address.lot						;
		self.lot_order          				:= left.physical_address.lot_order			;
		self.dpbc               				:= left.physical_address.dbpc					;
		self.chk_digit          				:= left.physical_address.chk_digit			;
		self.rec_type           				:= left.physical_address.rec_type			;
		self.county             				:= left.physical_address.fips_state + left.physical_address.fips_county;
		self.geo_lat            				:= left.physical_address.geo_lat		;
		self.geo_long           				:= left.physical_address.geo_long	;
		self.msa                				:= left.physical_address.msa				;
		self.geo_blk            				:= left.physical_address.geo_blk		;
		self.geo_match          				:= left.physical_address.geo_match	;
		self.err_stat           				:= left.physical_address.err_stat																					;
		self.prim_rangeA        				:= left.mailing_address.prim_range		;
		self.predirA            				:= left.mailing_address.predir				;
		self.prim_nameA         				:= left.mailing_address.prim_name			;
		self.addr_suffixA       				:= left.mailing_address.addr_suffix		;
		self.postdirA           				:= left.mailing_address.postdir				;
		self.unit_desigA        				:= left.mailing_address.unit_desig		;
		self.sec_rangeA         				:= left.mailing_address.sec_range			;
		self.p_city_nameA       				:= left.mailing_address.p_city_name		;
		self.v_city_nameA       				:= left.mailing_address.v_city_name		;
		self.stA                				:= left.mailing_address.st						;
		self.zipA               				:= left.mailing_address.zip						;
		self.zip4A              				:= left.mailing_address.zip4					;
		self.cartA              				:= left.mailing_address.cart					;
		self.cr_sort_szA        				:= left.mailing_address.cr_sort_sz		;
		self.lotA               				:= left.mailing_address.lot						;
		self.lot_orderA         				:= left.mailing_address.lot_order			;
		self.dpbcA              				:= left.mailing_address.dbpc					;
		self.chk_digitA         				:= left.mailing_address.chk_digit			;
		self.rec_typeA          				:= left.mailing_address.rec_type			;
		self.countyA            				:= left.mailing_address.fips_state + left.mailing_address.fips_county;
		self.geo_latA           				:= left.mailing_address.geo_lat		;
		self.geo_longA          				:= left.mailing_address.geo_long	;
		self.msaA               				:= left.mailing_address.msa				;
		self.geo_blkA           				:= left.mailing_address.geo_blk		;
		self.geo_matchA         				:= left.mailing_address.geo_match	;
		self.err_statA          				:= left.mailing_address.err_stat																				;
		self.lf                 				:= '';
		self.file_type									:= left.file_type;
		self.global_sid									:= left.global_sid;
	
	));

	ltrim(string pstring) := trim(stringlib.stringtouppercase(pstring));
	
	//replace parent num and jv nums with calculated lncagid since those ids aren't reliable anymore
	dgetParentNumber := join(
		 dproj(Parent_Enterprise_number != '')
		,pHierarchy
		,			left.Parent_Enterprise_number 		= right.enterprise_num
			and	left.file_type										= right.file_type
		,transform({lOldlayout,string6 file_type}
			,self.parent_number := if(right.lncaGID != 0	,intformat(right.lncaGID		,9,1) + '-' + intformat(right.lncaIID	,4,1)
																										,''
														 )
			,self								:= left
		)
		,left outer
		,keep(1)
	);
	
	dconcat1 := dgetParentNumber + dproj(Parent_Enterprise_number = '');

	dgetJV1 := join(
		 dconcat1(JV1_ != '')
		,pHierarchy
		,			left.JV1_[1..9] 				= right.root 
			and left.JV1_[11..14] 			= right.sub
			and ltrim(left.jv_parent1) 	= ltrim(right.name)
		,transform({lOldlayout,string6 file_type}
			,self.JV1_ 	:= if(right.lncaGID != 0	,intformat(right.lncaGID		,9,1) + '-' + intformat(right.lncaIID	,4,1)
																						,''
										 )
			,self				:= left
		)
		,left outer
		,keep(1)
	);
	
	dconcat2 := dgetJV1 + dconcat1(JV1_ = '');
	
	dgetJV2 := join(
		 dconcat2(JV2_ != '')
		,pHierarchy
		,			left.JV2_[1..9] 				= right.root 
			and left.JV2_[11..14] 			= right.sub
			and ltrim(left.jv_parent2) 	= ltrim(right.name)
		,transform({lOldlayout,string6 file_type}
			,self.JV2_	:= if(right.lncaGID != 0	,intformat(right.lncaGID		,9,1) + '-' + intformat(right.lncaIID	,4,1)
																						,''
										 )
			,self				:= left
		)
		,left outer
		,keep(1)
	);

	dreturn := project(dgetJV2 + dconcat2(JV2_ = ''),lOldlayout)
		: persist(pPersistname,SINGLE)
		;

	return dreturn;

end;