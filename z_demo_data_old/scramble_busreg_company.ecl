import demo_data;
import busreg;

file_in:= dataset('~thor::base::demo_data_file_busreg_company_prodcopy',busreg.Layout_BusReg_Company,flat);
//

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  false, x_phone_number,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  false, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, ofc1_name_first,
		  true, ofc1_name_middle,
		  true, ofc1_name_last,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, company_name, // businessName Field
		  //
		  true, street,
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
clean_addr := fn.cleanAddress(L.street, L.mail_v_city_name+' '+L.mail_zip+' '+L.mail_zip4);
self.mail_prim_range := clean_addr[1..8];
self.mail_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.mail_p_city_name  := l.mail_v_city_name;
self.CHAPTER := '';
self.PAGE	:= '';
self.VOLUME := '';
self.COMMENTS := '';
self.EMAIL_ADDR := if(l.email_addr<>'','my_email@my_company.com','');
self.company_phone10 := demo_data_scrambler.fn_scramblePII('phone',l.company_phone10);
self.ofc1_phone10 := demo_data_scrambler.fn_scramblePII('phone',l.ofc1_phone10);
self.ra_phone10 := demo_data_scrambler.fn_scramblePII('phone',l.ra_phone10);
self.USER_NAME := '';
self.BIZ_AC := '';
self.BIZ_PHONE:= '';
self.FAX_AC := '';
self.FAX_NUM := '';
self.FILING_NUM:= stringlib.stringfindreplace(demo_data_scrambler.fn_scramblePII('NUMBER',l.filing_num),'0','');
self.LICID :=  '';	//demo_data_scrambler.fn_scramblePII('NUMBER',l.licid);
self.ACCT_NUM := ''; 	//demo_data_scrambler.fn_scramblePII('NUMBER',l.acct_num);
self.CO_FEI := ''; // demo_data_scrambler.fn_scramblePII('NUMBER',l.co_fei);
self.CTRL_NUM:= stringlib.stringfindreplace(demo_data_scrambler.fn_scramblePII('NUMBER',l.ctrl_num),'0','');
self.RECORD_NO := '';
self.ACT := '';
self.OFC1_AC :='' ;
self.OFC1_PHONE := '';
self.OFC1_FEIN := ''; // demo_data_scrambler.fn_scramblePII('SSN',l.ofc1_fein);
self.OFC1_SSN := demo_data_scrambler.fn_scramblePII('SSN',l.ofc1_ssn);
self.MAIL_ADD:= '';
self.MAIL_SUITE:= '';
self.MAIL_CITY:= '';
self.MAIL_STATE:= '';
self.MAIL_ZIP_ORIG:= '';
self.MAIL_ZIP4_ORIG:= '';
self.LOC_ADD:= '';
self.LOC_SUITE:= '';
self.LOC_CITY:= '';
self.LOC_STATE:= '';
self.LOC_ZIP_ORIG:= '';
self.LOC_IDX:= '';
self.OFC1_ADD:= '';
self.OFC1_SUITE:= '';
self.OFC1_CITY:= '';
self.OFC1_STATE:= '';
self.OFC1_ZIP_ORIG:= '';
self.RA_ADD:= '';
self.RA_SUITE:= '';
self.RA_CITY:= '';
self.RA_STATE:= '';
self.RA_ZIP_ORIG:= '';
self.RA_AC:= '';
self.RA_PHONE:= '';
self.RA_FILE:= '';
self.FILE_DATE := '';
self.START_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.START_DATE  );
self.CCYYMMDD:= demo_data_scrambler.fn_scramblepii('DOB',l.CCYYMMDD  );
self.FORM_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.FORM_DATE  );
self.EXP_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.EXP_DATE  );
self.DISOL_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.DISOL_DATE  );
self.RPT_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.RPT_DATE  );
self.RENEW_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.RENEW_DATE  );
self.CHANG_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.CHANG_DATE  );
self.APPT_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.APPT_DATE  );
self.FISC_DATE_:= demo_data_scrambler.fn_scramblepii('DOB',l.FISC_DATE_  );
self.PROC_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.PROC_DATE  );
self.RA_DATE:= demo_data_scrambler.fn_scramblepii('DOB',l.RA_DATE  );
self.OFC1_NAME := trim(l.ofc1_name_first)+' '+ trim(l.ofc1_name_middle)+' '+trim(l.ofc1_name_last);
self.RA_NAME := if(l.ra_name<>'','Corporate Registration Service','');
self.FIRST_NAME := l.ofc1_name_first;
self.MI := l.ofc1_name_middle;
self.LAST_NAME := l.ofc1_name_last;
self.ra_prim_range:= ''; 
self.ra_predir:= '';
self.ra_prim_name:= '';
self.ra_addr_suffix:= '';
self.ra_postdir:= '';
self.ra_unit_desig:= '';
self.ra_sec_range:= '';
self.ra_p_city_name:= '';
self.ra_v_city_name:= '';
self.ra_st:= '';
self.ra_zip:= '';
self.ra_zip4:= '';
self.ra_cart:= '';
self.ra_cr_sort_sz:= '';
self.ra_lot:= '';
self.ra_lot_order:= '';
self.ra_dpbc:= '';
self.ra_chk_digit:= '';
self.ra_record_type:= '';
self.ra_ace_fips_st:= '';
self.ra_fipscounty:= '';
self.ra_geo_lat:= '';
self.ra_geo_long:= '';
self.ra_msa:= '';
self.ra_geo_blk:= '';
self.ra_geo_match:= '';
self.ra_err_stat:= '';
self.loc_prim_range:= ''; 
self.loc_predir:= '';
self.loc_prim_name:= '';
self.loc_addr_suffix:= '';
self.loc_postdir:= '';
self.loc_unit_desig:= '';
self.loc_sec_range:= '';
self.loc_p_city_name:= '';
self.loc_v_city_name:= '';
self.loc_st:= '';
self.loc_zip:= '';
self.loc_zip4:= '';
self.loc_cart:= '';
self.loc_cr_sort_sz:= '';
self.loc_lot:= '';
self.loc_lot_order:= '';
self.loc_dpbc:= '';
self.loc_chk_digit:= '';
self.loc_record_type:= '';
self.loc_ace_fips_st:= '';
self.loc_fipscounty:= '';
self.loc_geo_lat:= '';
self.loc_geo_long:= '';
self.loc_msa:= '';
self.loc_geo_blk:= '';
self.loc_geo_match:= '';
self.loc_err_stat:= '';
self.ofc1_prim_range:= clean_addr[1..8]; 
self.ofc1_predir:= l.mail_predir;
self.ofc1_prim_name:= TRIM(clean_addr[10..38],LEFT,RIGHT);
self.ofc1_addr_suffix:= l.mail_addr_suffix;
self.ofc1_postdir:= l.mail_postdir;
self.ofc1_unit_desig:= l.mail_unit_desig;
self.ofc1_sec_range:=  l.mail_sec_range;
self.ofc1_p_city_name:= l.mail_v_city_name;
self.ofc1_v_city_name:= l.mail_v_city_name;
self.ofc1_st:= l.mail_st;
self.ofc1_zip:= l.mail_zip;
self.ofc1_zip4:= l.mail_zip4;
self.ofc1_cart:= '';
self.ofc1_cr_sort_sz:= '';
self.ofc1_lot:= '';
self.ofc1_lot_order:= '';
self.ofc1_dpbc:= '';
self.ofc1_chk_digit:= '';
self.ofc1_record_type:= '';
self.ofc1_ace_fips_st:= '';
self.ofc1_fipscounty:= '';
self.ofc1_geo_lat:= '';
self.ofc1_geo_long:= '';
self.ofc1_msa:= '';
self.ofc1_geo_blk:= '';
self.ofc1_geo_match:= '';
self.ofc1_err_stat:= '';
self := l;
end;

scrambled := project(scrambled_file, to_finish(left));

export scramble_busreg_company  := dedup(sort(scrambled,record),all); 

