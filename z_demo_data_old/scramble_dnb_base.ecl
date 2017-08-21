import demo_data;
import dnb;

file_in:= dataset('~thor::base::demo_data_file_dnb_base_prodcopy',dnb.Layout_DNB_Base,flat);
//
//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 streetx;
END;

mod_file_rec addCleanName(file_in L):= transform
self.streetx := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  false, telephone_number,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  false, did,  		// DID field name
		  true, bdid,		// BDID field name
		  false, ofc1_name_first,
		  false, ofc1_name_middle,
		  false, ofc1_name_last,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, business_name, // businessName Field
		  //
		  true, streetx,
		  true, mail_v_city_name,
		  true, mail_st,
		  true, mail_zip,
		  true, mail_zip4,
		  false, dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);
//
file_in to_finish(scrambled_file l) := transform
clean_addr := fn.cleanAddress(L.streetx, L.mail_v_city_name+' '+L.mail_zip+' '+L.mail_zip4);
self.mail_prim_range := clean_addr[1..8];
self.mail_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.mail_p_city_name  := l.mail_v_city_name;
self.bank_duns_number := '';
self.bank_name := '';
self.accounting_firm_name := '';
self.street := '';
self.city:= '';
self.state:= '';
self.zip_code:= '';
self.mail_address := '';
self.mail_city:= '';
self.mail_state:= '';
self.mail_zip_code:= '';
self.date_of_incorporation := demo_data_scrambler.fn_scramblePII('DOB',l.date_of_incorporation);
self.annual_sales_revision_date := demo_data_scrambler.fn_scramblePII('DOB',l.annual_sales_revision_date);
//
self.prim_range:= clean_addr[1..8] ;
self.predir:= l.mail_predir ;
self.prim_name:= TRIM(clean_addr[10..38],LEFT,RIGHT) ;
self.addr_suffix:= l.mail_addr_suffix ;
self.postdir:= l.mail_postdir ;
self.unit_desig:= l.mail_unit_desig ;
self.sec_range:= l.mail_sec_range ;
self.p_city_name:= l.mail_v_city_name ;
self.v_city_name:= l.mail_v_city_name ;
self.st:= l.mail_st ;
self.zip:= l.mail_zip ;
self.zip4:= l.mail_zip4 ;
self.cart:= '' ;
self.cr_sort_sz:= '' ;
self.lot:= '' ;
self.lot_order:= '' ;
self.dpbc:= '' ;
self.chk_digit:= '' ;
self.rec_type:= '' ;
//
self.duns_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.duns_number);
self.parent_duns_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.parent_duns_number);
self.ultimate_duns_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.ultimate_duns_number);
self.headquarters_duns_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.headquarters_duns_number);
//
self.dias_code := '';
self.ultimate_company_name := l.business_name;
self.parent_company_name := l.business_name;
self := l;
end;

scrambled := project(scrambled_file, to_finish(left));

export scramble_dnb_base  := dedup(sort(scrambled,record),all); 
/*



*/
