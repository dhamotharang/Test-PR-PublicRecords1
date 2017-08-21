import header_services, DriversV2;

export fn_dlam (dataset(recordof(DriversV2.Layout_Drivers)) dl_in) := FUNCTION

Drop_Header_Layout := 
		Record 
				string15			   	   dl_seq := '';
				string15             did:= '0' ;
				string15             Preglb_did:= '0' ;
				string8              dt_first_seen;
				string8              dt_last_seen;
				string8              dt_vendor_first_reported;
				string8              dt_vendor_last_reported;
				string14	           dlcp_key := '';
				string2              orig_state;
				string2						   source_code	:=	'AD';
				string1              history :='';
				string52             name;
				string1	             addr_type := '';
				string40             addr1; 
				string20             city;
				string2              state;
				string5              zip;
				string2 		         province := '';
				string3 	           country := '';
				string10 	           postal_code := '';
				string10             dob;
				string1              race := '';
				string1              sex_flag := '';
				string6 	           license_class := '';
				string4              license_type;
				string4			         moxie_license_type;
				string14             attention_flag := '';
				string8              dod := '';
				string42             restrictions := '';
				string42					   restrictions_delimited := '';
				string10             orig_expiration_date := '0';
				string10             orig_issue_date := '0';
				string10             lic_issue_date := '0';
				string10             expiration_date := '0';
				string8              active_date := '0';
				string8              inactive_date := '0';
				string10             lic_endorsement := '';
				string4              motorcycle_code := '';
				string24             dl_number; 
				string9              ssn := '';
				string9              ssn_safe := '';
				string3              age := '';
				string1						   privacy_flag := '';
				string1					     driver_edu_code := '';
				string1              dup_lic_count:= '';
				string1              rcd_stat_flag:= '';
				string3              height := '';
				string3					     hair_color:= '';
				string3					     eye_color:= '';
				string3					     weight := '';
				string25             oos_previous_dl_number := '';
				string2              oos_previous_st := '';
				string5              title := '';
				string20             fname := '';
				string20             mname := '';
				string20             lname := '';
				string5              name_suffix := '';
				string3              cleaning_score := '';
				string1              addr_fix_flag := '';
				string10             prim_range := '';
				string2              predir := '';
				string28             prim_name := '';
				string4              suffix := '';
				string2              postdir := '';
				string10             unit_desig := '';
				string8              sec_range := '';
				string25             p_city_name := '';
				string25             v_city_name := '';
				string2              st := '';
				string5              zip5 := '';
				string4              zip4 := '';
				string4              cart := '';
				string1              cr_sort_sz := '';
				string4              lot := '';
				string1              lot_order := '';
				string2              dpbc := '';
				string1              chk_digit := '';
				string2              rec_type := '';
				string2              ace_fips_st := '';
				string3              county := '';
				string10             geo_lat := '';
				string11             geo_long := '';
				string4              msa := '';
				string7              geo_blk;
				string1              geo_match := '';
				string4              err_stat := '';
				string3              status := '';
				string2              issuance := '';
				string8              address_change := '';
				string1              name_change := '';
				string1              dob_change := '';
				string1              sex_change := '';
				string24             old_dl_number := ''; 
				string9					     dl_key_number:= '';
				string3 	           cdl_status := '';
				string1 	           record_type := '';
				string2              eor := '\r\n';
			end;



rec := RECORD
	DriversV2.Layout_Drivers;	
END;

// begin _sup
	Suppression_Layout := header_services.Supplemental_Data.layout_in; 
	header_services.Supplemental_Data.mac_verify(	'driverslicense_sup.txt',Suppression_Layout, dl_supp_ds_func	);
	DL_Suppression_In := dl_supp_ds_func();
	DLSuppressedIn 	:= PROJECT(	DL_Suppression_In,header_services.Supplemental_Data.in_to_out(left));
	
	dlHashDIDDlseqFormat := header_services.Supplemental_Data.layout_out;

	DlOut_HashBDID := RECORD
		rec;
		dlHashDIDDlseqFormat;
	end;

	DlOut_HashBDID Hash_DID_and_dlSeq(rec l) := transform                            
		self.hval := HASHMD5(intformat((unsigned6)l.did,15,1),TRIM((string14)l.dl_number, left, right));
		self 			:= l;
	end;

	DLOnly_withMD5 := PROJECT(dl_in,Hash_DID_and_dlSeq(left));

	DlOut_HashBDID dlONLYSuppress( DLOnly_withMD5 l ) := transform
	 self := l; 
	end;

	DL_Suppress			:= JOIN(DLOnly_withMD5,DLSuppressedIn,left.hval = right.hval,dlONLYSuppress(left),left only,lookup);
//end _sup

//begin _sup_all	
	dlFixed := PROJECT(DL_Suppress,rec);
	
	dlFixedAllSupp := dlFixed ;
//end _sup_all	

// begin_inj
	header_services.Supplemental_Data.mac_verify('file_dl_inj.txt', drop_header_layout, attr);

	Base_File_Append_In := attr();

	UNSIGNED endMax := MAX(dlFixedAllSupp, dl_seq);

	rec reformat_header(Base_File_Append_In L, INTEGER c) :=
		transform
			self.dl_seq := endMax + c;
			self.did := (unsigned6) L.did;
			self.Preglb_did := (unsigned6) L.Preglb_did;
			self.dt_first_seen := (unsigned3) L.dt_first_seen;
			self.dt_last_seen := (unsigned3) L.dt_last_seen;
			self.dt_vendor_first_reported := (unsigned3) L.dt_vendor_first_reported;
			self.dt_vendor_last_reported := (unsigned3) L.dt_vendor_last_reported;
			self.dob := (unsigned4) L.dob;
			self.orig_expiration_date := (unsigned4) L.orig_expiration_date;
			self.orig_issue_date := (unsigned4) L.orig_issue_date;
			self.lic_issue_date := (unsigned4) L.lic_issue_date;
			self.expiration_date := (unsigned4) L.expiration_date;
			self.active_date := (unsigned3) L.active_date;
			self.inactive_date := (unsigned3) L.inactive_date;
			self.geo_blk := '';
			self.record_type := '';
			self := L;
		end;
 
	Base_File_Append := project(Base_File_Append_In, reformat_header(left, Counter));

	return dlFixedAllSupp + Base_File_Append;				  

end ;