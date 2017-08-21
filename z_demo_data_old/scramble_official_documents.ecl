import _control,official_records;

file_in := dataset('~thor::base::demo_data_file_official_documents_prodcopy',official_records.Layout_In_Document,flat);
//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;
mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self:=l;
END;
mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in,      		// data set to be scrambled
      scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dob,		// DOB field name
		  false,app_ssn, //SSN field name
		  false,did,  		// DID field name
		  false,bdid,		// BDID field name
		  false,fname,
		  false,mname,
		  false,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,v_city_name,
		  true,st,
		  true,zip,
		  true,zip4,
		  false,dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);
file_in reformat(scrambled_file l) := transform

clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
clean_cityname := if(l.v_city_name<>'HAPPYPARK',l.v_city_name,'');
clean_zip := if(l.zip='00000','',l.zip);
self.parcel_or_case_num := 'X'+stringlib.stringfindreplace(l.parcel_or_case_num[2..],'1','2');
self.formatted_parcel_num := 'X'+stringlib.stringfindreplace(l.formatted_parcel_num[2..],'1','2');
self.doc_instrument_or_clerk_filing_num := 'X'+stringlib.stringfindreplace(l.doc_instrument_or_clerk_filing_num[2..],'1','2');;
self.doc_filed_dt := fn_scramblepii('DOB',l.doc_filed_dt);
self.doc_record_dt := fn_scramblepii('DOB',l.doc_record_dt);
self.execution_dt := fn_scramblepii('DOB',l.execution_dt);
self.doc_other_desc := '';
self.prior_doc_file_num := '';
self.prior_book_num := '';
self.prior_page_num :='';
self.address_1:=trim(clean_addr[1..8]) +' '+ TRIM(clean_addr[10..38],LEFT,RIGHT);
self.address_2:='';
self.address_3:= trim(clean_cityname)+' '+l.st+' '+clean_zip;
self.address_4:= '';
self.v_city_name := clean_cityname;
self.p_city_name := clean_cityname;
self.zip := clean_zip;
self.legal_desc_1 := if(l.legal_desc_1<>'','Legal Description...','');
self.legal_desc_2 := if(l.legal_desc_1<>'' and l.legal_desc_2<>'','continued legal info','');
self.legal_desc_3 := '';
self.legal_desc_4 := '';
self.legal_desc_5 := '';
// self.consideration_amt := '';
// self.assumption_amt:= '';
// self.certified_mail_fee:= '';
// self.service_charge:= '';
// self.trust_amt:= '';
// self.transfer_:= '';
// self.mortgage := '';
// self.intangible_tax_amt:= '';
// self.intangible_tax_penalty:= '';
// self.excise_tax_amt:= '';
// self.recording_fee:= '';
// self.documentary_stamps_fee:= '';
// self.doc_stamps_mtg_fee:= '';
self.book_num := '11'+stringlib.stringfindreplace(l.book_num,'1','2');
self.page_num := '2'+stringlib.stringfindreplace(l.page_num,'1','2');
self := l;
end;


export scramble_official_documents :=  dedup(sort(project(scrambled_file,reformat(left)),record),all);

