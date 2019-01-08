IMPORT Address,Business_Header,Business_HeaderV2,MDR,lib_stringlib, UT;

EXPORT fEBR_As_Business_Linking(
			 dataset(Layout_0010_Header_Base_AID) 			pInput0010HeaderBase	= EBR.File_0010_Header_Base_AID, 				//business data
			 dataset(Layout_5610_Demographic_Data_Base) pInput5610DemoBase 		= EBR.File_5610_Demographic_Data_Base,	//contact data
			 dataset(Layout_5600_Demographic_Data_Base) pInput5600DemoBase		= EBR.File_5600_Demographic_Data_Base		//business data
			) := function

		//The following is a function that takes a string and converts it to uppercase and then trims off leading.
		//and trailing blanks.
		fTrimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;				

		//////////////////////////////////////////////////////////////////////////////////////////////
		// --Company Mapping
		//////////////////////////////////////////////////////////////////////////////////////////////
		HeaderBase0010_filt := pInput0010HeaderBase(ftrimUpper(company_name)<>'');
		HeaderBase0010_dist := distribute(HeaderBase0010_filt, hash(FILE_NUMBER));	
		DemoBase5600_dist 	:= distribute(pInput5600DemoBase, hash(FILE_NUMBER));
		DemoBase5600_filter := DemoBase5600_dist(sic_1_code<>'' OR sic_2_code<>'' OR sic_3_code <> '' OR sic_4_code <> '' or bus_type_desc <> '');		

		//This sort makes sure that the current record (indicated by record_type "C" is first before all the historical
		//records indicated by a record_type "H".  This ensures that the current record information is maintained
		//in the rollup named "SIC_Code_Rollup".
		DemoBase5600_dedup	:= dedup(sort(DemoBase5600_filter,file_number,record_type,sic_1_code,sic_2_code,sic_3_code,sic_4_code,bus_type_desc,-date_last_seen, local),file_number, sic_1_code,sic_2_code,sic_3_code,sic_4_code,bus_type_desc, local);	
		
		DemoBase5610_dist		:= distribute(pInput5610DemoBase, hash(FILE_NUMBER));

		Layout_5600_Slim := record
				STRING10  file_number;	
				STRING4 	sic_1_code;
				STRING4 	sic_2_code;		
				STRING4 	sic_3_code;		
				STRING4 	sic_4_code;								
				STRING20	bus_type_desc;
		end;

		//Propagate slim layout
		ds_5600_proj	 := project(DemoBase5600_dedup, transform(Layout_5600_Slim, SELF := LEFT));
		
		ds_5600_proj_srt := sort(distribute(ds_5600_proj,hash(file_number)),file_number, local);

		//This rollup maintains the sic codes in the current 5600 record. However for those sic code fields that 
		//contain blanks, the historical records with data in the associated fields will rollup their data.
		Layout_5600_Slim SIC_Code_Rollup(ds_5600_proj_srt L, ds_5600_proj_srt R) := transform
			self.sic_1_code 		:= if(l.sic_1_code <> '',l.sic_1_code,r.sic_1_code);
			self.sic_2_code 		:= if(l.sic_2_code <> '',l.sic_2_code,r.sic_2_code);
			self.sic_3_code 		:= if(l.sic_3_code <> '',l.sic_3_code,r.sic_3_code);
			self.sic_4_code 		:= if(l.sic_4_code <> '',l.sic_4_code,r.sic_4_code);
			self.bus_type_desc 	:= if(l.bus_type_desc <> '',l.bus_type_desc,r.bus_type_desc);	
			self := l;
		end;

		ds_5600_rollup := rollup(ds_5600_proj_srt, SIC_Code_Rollup(left,right), left.file_number = right.file_number, local);

		Layout_EBR_Local := record
				EBR.layout_0010_header_base_aid;
				STRING4 	sic_1_code;
				STRING4 	sic_2_code;		
				STRING4 	sic_3_code;		
				STRING4 	sic_4_code;								
				STRING20	bus_type_desc;				
		end;
	
		//////////////////////////////////////////////////////////////////////////////////////////////
		//Adding the 4 sic codes and business type code from the 5600 Demographic file to the 0010 
		//Header/Main Business file.
		//////////////////////////////////////////////////////////////////////////////////////////////		
		Layout_EBR_Local tJoin_0010_5600(HeaderBase0010_dist L, ds_5600_rollup R) := transform
				self.sic_1_code			:= R.sic_1_code;
				self.sic_2_code			:= R.sic_2_code;
				self.sic_3_code			:= R.sic_3_code;
				self.sic_4_code			:= R.sic_4_code;	
				self.bus_type_desc	:= trim(stringlib.StringToUppercase(R.bus_type_desc),left,right);				
				self								:= L;
		end;	
	
		joined_0010_and_5600 := join(HeaderBase0010_dist,ds_5600_rollup, 
																	 left.FILE_NUMBER = right.FILE_NUMBER, 
																	 tJoin_0010_5600(left,right),
																	 left outer,
																	 local);		

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to BH-Company format
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout_company := business_header.Layout_Business_Linking.Company_;

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Load Layout_Business_Linking.Company_
		//////////////////////////////////////////////////////////////////////////////////////////////	
		bh_layout_company Translate_EBR_To_BHL(joined_0010_and_5600 L) := transform
				self.tmp_join_id_company         		:= fTrimUpper(L.file_number);
				self.source 												:= MDR.sourceTools.src_EBR;
				self.dt_first_seen 									:= (unsigned4)L.date_first_seen;
				self.dt_last_seen 									:= (unsigned4)L.date_last_seen;
				self.dt_vendor_first_reported				:= (unsigned4)L.process_date_first_seen;
				self.dt_vendor_last_reported				:= (unsigned4)L.process_date_last_seen;		
				self.rcid														:= 0;
				self.company_bdid										:= l.bdid;
				self.company_name 									:= fTrimUpper(L.company_name);
				self.company_name_type_raw					:= '';  
				self.company_rawaid	 								:= L.Append_RawAID;
				self.company_aceaid	 								:= L.Append_AceAID;				
				self.company_address.prim_range 		:= L.clean_address.prim_range;
				self.company_address.predir 				:= L.clean_address.predir;
				self.company_address.prim_name 			:= L.clean_address.prim_name;
				self.company_address.addr_suffix		:= L.clean_address.addr_suffix;
				self.company_address.postdir 				:= L.clean_address.postdir;
				self.company_address.unit_desig 		:= L.clean_address.unit_desig;
				self.company_address.sec_range 			:= L.clean_address.sec_range;
				self.company_address.p_city_name 		:= L.clean_address.p_city_name;
				self.company_address.v_city_name 		:= L.clean_address.v_city_name;
				self.company_address.st 						:= L.clean_address.st;
				self.company_address.zip	 					:= L.clean_address.zip;
				self.company_address.zip4 					:= L.clean_address.zip4;
				self.company_address.cart 					:= L.clean_address.cart;	
				self.company_address.cr_sort_sz	 		:= L.clean_address.cr_sort_sz;	
				self.company_address.lot 						:= L.clean_address.lot;		
				self.company_address.lot_order 			:= L.clean_address.lot_order;	
				self.company_address.dbpc 					:= L.clean_address.dbpc;	
				self.company_address.chk_digit 			:= L.clean_address.chk_digit;
				self.company_address.rec_type 			:= L.clean_address.rec_type;			
				self.company_address.fips_state 		:= L.clean_address.county[1..2];	
				self.company_address.fips_county 		:= L.clean_address.county[3..5];				
				self.company_address.geo_lat 				:= L.clean_address.geo_lat;
				self.company_address.geo_long 			:= L.clean_address.geo_long;
				self.company_address.msa 						:= L.clean_address.msa;
				self.company_address.geo_blk 				:= L.clean_address.geo_blk;	
				self.company_address.geo_match 			:= L.clean_address.geo_match;
				self.company_address.err_stat 			:= L.clean_address.err_stat;
				self.company_address_type_raw				:= '';
				self.company_address_category				:= '';
				self.company_fein 									:= '';
				self.company_phone 									:= ut.CleanPhone(l.phone_number);
				self.phone_type	  									:= if (self.company_phone<>'','T','');
				self.company_org_structure_raw			:= fTrimUpper(L.bus_type_desc);
				self.company_incorporation_date			:= 0;
				//The following mappings eliminates duplicate sic codes from being propagated.
				self.company_sic_code1							:= MAP(l.sic_code<>''		=> l.sic_code,
																								   l.sic_1_code<>'' => l.sic_1_code,
																								   l.sic_2_code<>'' => l.sic_2_code,
																								   l.sic_3_code<>'' => l.sic_3_code,
																								   l.sic_4_code<>'' => l.sic_4_code,'');
				self.company_sic_code2							:= MAP(l.sic_1_code<>'' AND l.sic_1_code<>self.company_sic_code1 => l.sic_1_code,
																									 l.sic_2_code<>'' AND l.sic_2_code<>self.company_sic_code1 => l.sic_2_code,	
																									 l.sic_3_code<>'' AND l.sic_3_code<>self.company_sic_code1 => l.sic_3_code,					
																									 l.sic_4_code<>'' AND l.sic_4_code<>self.company_sic_code1 => l.sic_4_code,'');	
				self.company_sic_code3							:= MAP(l.sic_2_code<>'' AND l.sic_2_code<>self.company_sic_code1 AND l.sic_2_code <> self.company_sic_code2  => l.sic_2_code,
																									 l.sic_3_code<>'' AND l.sic_3_code<>self.company_sic_code1 AND l.sic_3_code <> self.company_sic_code2  => l.sic_3_code,	
																									 l.sic_4_code<>'' AND l.sic_4_code<>self.company_sic_code1 AND l.sic_4_code <> self.company_sic_code2  => l.sic_4_code,'');					
				self.company_sic_code4							:= MAP(l.sic_3_code<>'' AND l.sic_3_code<>self.company_sic_code1 AND l.sic_3_code <> self.company_sic_code2 AND l.sic_3_code <> self.company_sic_code3  => l.sic_3_code,	
																									 l.sic_4_code<>'' AND l.sic_4_code<>self.company_sic_code1 AND l.sic_4_code <> self.company_sic_code2 AND l.sic_4_code <> self.company_sic_code3  => l.sic_4_code,'');							
				self.company_sic_code5							:= MAP(l.sic_4_code<>'' AND l.sic_4_code<>self.company_sic_code1 AND l.sic_4_code <> self.company_sic_code2 AND l.sic_4_code <> self.company_sic_code3 AND l.sic_4_code <> self.company_sic_code4  => l.sic_4_code,'');
				self.company_naics_code1						:= '';
				self.company_naics_code2						:= '';
				self.company_naics_code3						:= '';
				self.company_naics_code4						:= '';
				self.company_naics_code5						:= '';
				self.company_foreign_domestic				:= '';
				self.company_url										:= '';
				self.company_inc_state							:= '';
				self.company_charter_number					:= '';
				self.company_filing_date						:= 0;
				self.company_status_date						:= 0;
				self.company_foreign_date						:= 0;
				self.event_filing_date							:= 0;
				self.company_name_status_raw				:= '';
				self.company_status_raw							:= '';
				self.dt_first_seen_company_name			:= 0;
				self.dt_last_seen_company_name			:= 0;
				self.dt_first_seen_company_address	:= 0;
				self.dt_last_seen_company_address		:= 0;				
				self.vl_id 				  								:= fTrimUpper(L.File_Number);			
				self.current												:= TRUE;
				self.source_record_id								:= L.source_rec_id;
				self.glb														:= FALSE;
				self.dppa														:= FALSE;
				self.phone_score 										:= IF((UNSIGNED8)self.company_phone  = 0, 0, 1);
				self.match_company_name							:= '';
				self.match_branch_city							:= '';
				self.match_geo_city									:= '';		
				self																:= l;
				self																:= [];
		end;			

		ds_company_proj 			:= project(joined_0010_and_5600, Translate_EBR_To_BHL(LEFT));
		
		ds_company_sort_dist 	:= sort(distribute(ds_company_proj,hash(tmp_join_id_company)),record, EXCEPT company_rawaid,local);
		
		//This rollup will collapse the records if all the fields are the same except for the company_rawaid	
		bh_layout_company RollupCompany(bh_layout_company l, bh_layout_company r) := transform
			self := l;
		end;		
		
		//This rollup ensures unique companies exist.				
		ds_company := rollup(ds_company_sort_dist,
												 RollupCompany(left, right),
												 record,
												 except 					
													 company_rawaid
													,LOCAL
												 );		
	
		//////////////////////////////////////////////////////////////////////////////////////////////
		// --Contact Mapping
		//////////////////////////////////////////////////////////////////////////////////////////////

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to BH-Contact format
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout_contact := record
			  string8	process_date;
				business_header.Layout_Business_Linking.Contact;
		end;		

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to business_header.Layout_Business_Linking.Contact
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout_contact MapToBHLayoutContact(demobase5610_dist L) := transform
				self.tmp_join_id_contact         :=  fTrimUpper(L.file_number);
				self.contact_rawaid							 := 0;
				self.contact_aceaid							 := 0;
				self.contact_address_type        := 'C'; //Contact
				self.is_contact									 := false;
				self.dt_first_seen_contact       := (unsigned4)l.date_first_seen;
				self.dt_last_seen_contact        := (unsigned4)l.date_last_seen;
				self.contact_did                 := l.did;
				self.contact_name.title          := l.clean_officer_name.title;
				self.contact_name.fname          := l.clean_officer_name.fname;
				self.contact_name.mname          := l.clean_officer_name.mname;
				self.contact_name.lname          := l.clean_officer_name.lname;
				self.contact_name.name_suffix		 :=	l.clean_officer_name.name_suffix;		
				self.contact_name.name_score     := Business_Header.CleanName(self.contact_name.fname,self.contact_name.mname,self.contact_name.lname,self.contact_name.name_suffix)[142];			
				self.contact_type_raw						 := '';
				self.contact_job_title_raw       := l.officer_title;
				self.contact_ssn			           := if(l.ssn<>0, (string9)l.ssn, '');
				self.contact_dob								 :=	0;
				self.contact_status_raw					 := '';
				self.contact_email							 :=	'';
				self.contact_email_username			 := '';
				self.contact_email_domain				 := '';
				self.contact_phone               := '';
				self.cid												 := 0;
				self.contact_score							 := 0;
				self.from_hdr										 := 'N';		
				self.company_department					 :='';
				self := l;
				self := [];
		end;

		ds_contact 				:= project(demobase5610_dist, MapToBHLayoutContact(LEFT));
		
		ds_contact_dist 	:= sort(distribute(ds_contact,hash(tmp_join_id_contact)),record, EXCEPT dt_first_seen_contact, dt_last_seen_contact,local);

		//This rollup ensures unique contacts exist and the earliest record first seen date and latest last seen date are kept.		
		bh_layout_contact RollupUpdate(bh_layout_contact l, bh_layout_contact r) := transform
			self.dt_first_seen_contact	:=	ut.EarliestDate(
																						ut.EarliestDate(l.dt_first_seen_contact, r.dt_first_seen_contact),
																						ut.EarliestDate(l.dt_last_seen_contact, r.dt_last_seen_contact)
																			  		);
			self.dt_last_seen_contact		:=	max(l.dt_last_seen_contact,r.dt_last_seen_contact);
			self                				:= l;
		end;		
		
		//This rollup ensures unique contacts exist.				
		ds_contact_rollup := rollup(ds_contact_dist,
																RollupUpdate(left, right),
																record,
																except 					
																  dt_first_seen_contact
																 ,dt_last_seen_contact
																 ,LOCAL
																);
		
		ds_company_dist := dedup(sort(distribute(ds_company,hash(tmp_join_id_company)),record,local),record,local);

		Business_Header.Layout_Business_Linking.Combined joinfiles(Business_Header.Layout_Business_Linking.Company_ L, bh_layout_contact R) := transform
				self.company_address_type_raw := r.contact_address_type;
				self 													:= l;
				self 													:= r;
		end;

		//The file_number that resides in tmp_join_id_company and tmp_join_id_contact represents the "headquarters"
		//of a company.  Therefore the same file_number can be associated with multiple locations.  Since the contact file
		//doesn't contain an address this causes the following join to link the same contacts to multiple locations (via the file number).
		//In order to improve the linking, the process_date has been added to ensure that we are processing the same
		//contact file with its associated company file.
		j1 := join(ds_company_dist,ds_contact_rollup,
							 left.tmp_join_id_company=right.tmp_join_id_contact and
   							(unsigned)left.dt_vendor_first_reported <= (unsigned)right.process_date	 and 
								(unsigned)left.dt_vendor_last_reported  >= (unsigned)right.process_date								
							 ,joinfiles(left,right)
							 ,left outer
							 ,local);

	 final_proj 	:= project(j1,Business_Header.Layout_Business_Linking.Linking_Interface);
 
	 concat_dupd 	:= dedup(sort(distribute(final_proj, hash(vl_id)),record,local),record,local);	 

	 return concat_dupd;
		
end;