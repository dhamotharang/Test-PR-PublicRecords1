file_in := scramble_foreclosure2b;


//Add Fields to conform to Macro Interface Files
mod_file_rec2:=RECORD
recordof(file_in);
String100 street2;
END;
mod_file_rec2 addCleanName2(file_in L):= transform
self.street2 := (string8)L.site_prim_range+' '+(string30)L.site_prim_name+' '+(string3)L.site_addr_suffix;
self:=l;
END;
mod_file_in2:=PROJECT(file_in,addCleanName2(Left));
mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in2,      		// data set to be scrambled
      scrambled_file2, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dob,		// DOB field name
		  false,name2_ssn, 		//SSN field name
		  false,name2_did,  		// DID field name
		  false,name2_bdid,		// BDID field name
		  false,name2_first,
		  false,name2_middle,
		  false,name2_last,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street2,
		  true,site_v_city_name,
		  true,site_st,
		  true,site_zip,
		  true,site_zip4,
		  false,dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);
//****     REFORMAT SOME FIELDS BACK INTO THE ORIGINAL FILE
//
recordof(file_in) reformat2(scrambled_file2 L):= TRANSFORM
clean_addr := fn.cleanAddress(L.street2, L.site_v_city_name+' '+L.site_zip+' '+L.site_zip4);
self.site_prim_range := clean_addr[1..8];
self.site_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.site_p_city_name  := l.site_v_city_name;
//
// do names,ssn,dids,bdids
//
scrambled_name_last		:= if(l.name_last <>'',demo_data_scrambler.fn_scrambleLastName(l.name_last),'');
scrambled_name1_last	:= if(l.name1_last<>'',demo_data_scrambler.fn_scrambleLastName(l.name1_last),'');
scrambled_name2_last	:= if(l.name2_last<>'',demo_data_scrambler.fn_scrambleLastName(l.name2_last),'');
scrambled_name3_last	:= if(l.name3_last<>'',demo_data_scrambler.fn_scrambleLastName(l.name3_last),'');
scrambled_name4_last	:= if(l.name4_last<>'',demo_data_scrambler.fn_scrambleLastName(l.name4_last),'');
//
scrambled_name_company 	:= if(l.name_company <>'',demo_data_scrambler.fn_scrambleBizName(l.name_company),'');
scrambled_name1_company := if(l.name1_company<>'',demo_data_scrambler.fn_scrambleBizName(l.name1_company),'');
scrambled_name2_company := if(l.name2_company<>'',demo_data_scrambler.fn_scrambleBizName(l.name2_company),'');
scrambled_name3_company := if(l.name3_company<>'',demo_data_scrambler.fn_scrambleBizName(l.name3_company),'');
scrambled_name4_company := if(l.name4_company<>'',demo_data_scrambler.fn_scrambleBizName(l.name4_company),'');
//
self.name_last	:= scrambled_name_last;
self.name1_last	:= scrambled_name1_last;
self.name2_last	:= scrambled_name2_last;
self.name3_last	:= scrambled_name3_last;
self.name4_last	:= scrambled_name4_last;
//
self.name_company := scrambled_name_company;
self.name1_company := scrambled_name1_company;
self.name2_company := scrambled_name2_company;
self.name3_company := scrambled_name3_company;
self.name4_company := scrambled_name4_company;
//
self.first_defendant_borrower_owner_last_name			:= scrambled_name1_last;
self.first_defendant_borrower_company_name				:= scrambled_name1_company;
self.second_defendant_borrower_owner_last_name 		:= scrambled_name2_last;
self.second_defendant_borrower_company_name 			:= scrambled_name2_company;
self.third_defendant_borrower_owner_last_name			:= scrambled_name3_last;
self.third_defendant_borrower_company_name 				:= scrambled_name3_company;
self.fourth_defendant_borrower_owner_last_name 		:= scrambled_name4_last;
self.fourth_defendant_borrower_company_name 			:= scrambled_name4_company;


self.did			 	:= IF(l.did <> 0,(integer)fn_scramblePII('DID',(string)l.did),0);
self.name1_did	:= IF((integer)l.name1_did <> 0,fn_scramblePII('DID',l.name1_did),'');
self.name2_did	:= IF((integer)l.name2_did <> 0,fn_scramblePII('DID',l.name2_did),'');
self.name3_did	:= IF((integer)l.name3_did <> 0,fn_scramblePII('DID',l.name3_did),'');
self.name4_did	:= IF((integer)l.name4_did <> 0,fn_scramblePII('DID',l.name4_did),'');

self.bdid			 	:= IF(l.bdid <> 0,(integer)fn_scramblePII('DID',(string)l.bdid),0);
self.name1_bdid	:= IF((integer)l.name1_bdid <> 0,fn_scramblePII('DID',l.name1_bdid),'');
self.name2_bdid	:= IF((integer)l.name2_bdid <> 0,fn_scramblePII('DID',l.name2_bdid),'');
self.name3_bdid	:= IF((integer)l.name3_bdid <> 0,fn_scramblePII('DID',l.name3_bdid),'');
self.name4_bdid	:= IF((integer)l.name4_bdid <> 0,fn_scramblePII('DID',l.name4_bdid),'');

self.ssn				:= if((integer) l.ssn <> 0,fn_scramblePII('SSN',l.ssn),'');
self.name1_ssn	:= if((integer) l.name1_ssn <> 0,fn_scramblePII('SSN',l.name1_ssn),'');
self.name2_ssn	:= if((integer) l.name2_ssn <> 0,fn_scramblePII('SSN',l.name2_ssn),'');
self.name3_ssn	:= if((integer) l.name3_ssn <> 0,fn_scramblePII('SSN',l.name3_ssn),'');
self.name4_ssn	:= if((integer) l.name4_ssn <> 0,fn_scramblePII('SSN',l.name4_ssn),'');
//
// do trustee, atty infor with generic stuff
//
// do miscellaneous dates, etc.
//
self.recording_date:= fn_scramblepii('DOB',l.recording_date);
self.filing_date:= fn_scramblepii('DOB',l.filing_date);

self.date_of_default:= fn_scramblepii('DOB',l.date_of_default);
self.document_nbr:= fn_scramblePII('NUMBER',(string7)L.document_nbr);
self.document_book:= fn_scramblePII('NUMBER',(string6)L.document_book);
self.document_pages:= fn_scramblePII('NUMBER',(string6)L.document_pages);
self.attorney_phone_nbr:= '';
self.court_case_nbr:= fn_scramblePII('SCR_SECOND',L.court_case_nbr);
self.trustee_sale_number:= fn_scramblePII('NUMBER',(string7)L.trustee_sale_number);
self.original_loan_date:= fn_scramblepii('DOB',l.original_loan_date);
self.original_loan_recording_date:= fn_scramblepii('DOB',l.original_loan_recording_date);
self.original_document_number:= fn_scramblePII('NUMBER',(string7)L.original_document_number);
self.original_recording_book:= fn_scramblePII('NUMBER',(string6)L.original_recording_book);
self.original_recording_page:= fn_scramblePII('NUMBER',(string6)L.original_recording_page);
self.parcel_number_parcel_id := 'X'+stringlib.stringfindreplace(l.parcel_number_parcel_id[2..],'1','2');
self.parcel_number_unmatched_id := 'X'+stringlib.stringfindreplace(l.parcel_number_unmatched_id[2..],'1','2');
self.last_full_sale_transfer_date:= '';
self.auction_date:= '';
self.auction_time:= '';
self.map_book:= '';
self.map_page:= '';
self.legal_2 := '';
self.legal_3 := '';
self.legal_4 := '';
self.title_company_name := if(l.title_company_name<>'','ANONYMOUS TITLE COMPANY','');
self.street_address_of_auction_call := '';
self.city_of_auction_call := if(l.city_of_auction_call<>'','AUCTION CITY','');
self.attorney_name := if(l.attorney_name<>'','FORECLOSURE ATTORNEY SPECIALISTS','');
self.lender_beneficiary_first_name := '';
self.lender_beneficiary_last_name := '';
self.lender_beneficiary_company_name := '';
self.lender_beneficiary_mailing_address := '';
self.lender_beneficiary_city := '';
self.lender_beneficiary_state := '';
self.lender_beneficiary_zip := '';
self.lender_phone := '';
self.trustee_name := '';
self.trustee_mailing_address := '';
self.trustee_city := '';
self.trustee_state := '';
self.trustee_zip := '';
self.trustee_phone := '';
self.tract_subdivision_name := if(l.tract_subdivision_name<>'','HAPPY VALLEY SUBDIVISION','');
self.expanded_legal := '';
self.plaintiff_1 := if(l.plaintiff_1<>'','PLAINTIFF','');
self.plaintiff_2 := '';
self:=l;
END;
scrambled2 := project(scrambled_file2,reformat2(LEFT));

export scramble_foreclosure2c := dedup(sort(scrambled2,record),all);

