file_in := scramble_foreclosure1;



//Add Fields to conform to Macro Interface Files
mod_file_rec2:=RECORD
recordof(file_in);
String100 street2;
END;
mod_file_rec2 addCleanName2(file_in L):= transform
self.street2 := (string8)L.situs2_prim_range+' '+(string30)L.situs2_prim_name+' '+(string3)L.situs2_addr_suffix;
self:=l;
END;
mod_file_in2:=PROJECT(file_in,addCleanName2(Left));
mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in2,      		// data set to be scrambled
      scrambled_file2, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dob,		// DOB field name
		  true,name2_ssn, 		//SSN field name
		  true,name2_did,  		// DID field name
		  false,bdid,		// BDID field name
		  true,name2_first,
		  true,name2_middle,
		  true,name2_last,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street2,
		  true,situs2_v_city_name,
		  true,situs2_st,
		  true,situs2_zip,
		  true,situs2_zip4,
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
recordof(file_in) reformat2(scrambled_file2 L):= TRANSFORM
clean_addr := fn.cleanAddress(L.street2, L.situs2_v_city_name+' '+L.situs2_zip+' '+L.situs2_zip4);
self.situs2_prim_range := clean_addr[1..8];
self.situs2_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.situs2_p_city_name  := l.situs2_v_city_name;
self.name3_prefix:='';
self.name3_first:='';
self.name3_middle:='';
self.name3_last:='';
self.name3_suffix:='';
self.name3_score:='';
self.name3_company:='';
self.name3_ssn := '';
self.name3_did_score := '';
self.name3_did := '';
self.name4_prefix:='';
self.name4_first:='';
self.name4_middle:='';
self.name4_last:='';
self.name4_suffix:='';
self.name4_score:='';
self.name4_company:='';
self.name4_ssn := '';
self.name4_did_score := '';
self.name4_did := '';
/*-------------------------  Jayant Changes ------------------------------------ */
self.foreclosure_id:= fn_scramblePII('SCR_FIRST',L.foreclosure_id);	
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
//self.parcel_number_parcel_id:= IF(L.parcel_number_parcel_id <> '','X'+fn_scramblePII('SCR_SECOND',L.parcel_number_parcel_id),'');
self.parcel_number_parcel_id := 'X'+stringlib.stringfindreplace(l.parcel_number_parcel_id[2..],'1','2');
self.parcel_number_unmatched_id:= '';
self.last_full_sale_transfer_date:= '';
self.map_book:= '';
self.map_page:= '';
// orig name and address aren't remapped or blanked yet
self:=l;
END;
scrambled2 := project(scrambled_file2,reformat2(LEFT));

export scramble_foreclosure2 := dedup(sort(scrambled2,record),all);


