
//
// base_layout copied from DriverV2.File_DL_KeyBuilding
// work done 10-14-19
// 

Export Regulatory := module

		// LZ layout
		Export Base_Layout := Record
				string15	dl_seq := '';
				string15	did:= '0' ;
				string15	Preglb_did:= '0' ;
				string8		dt_first_seen;
				string8		dt_last_seen;
				string8		dt_vendor_first_reported;
				string8		dt_vendor_last_reported;
				string14	dlcp_key := '';
				string2		orig_state;
				string2		source_code	:=	'AD';
				string1		history :='';
				string52	name;
				string1		addr_type := '';
				string40	addr1; 
				string20	city;
				string2		state;
				string5		zip;
				string2		province := '';
				string3		country := '';
				string10	postal_code := '';
				string10	dob;
				string1		race := '';
				string1		sex_flag := '';
				string6		license_class := '';
				string4		license_type;
				string4		moxie_license_type;
				string14	attention_flag := '';
				string8		dod := '';
				string42	restrictions := '';
				string42	restrictions_delimited := '';
				string10	orig_expiration_date := '0';
				string10	orig_issue_date := '0';
				string10	lic_issue_date := '0';
				string10	expiration_date := '0';
				string8		active_date := '0';
				string8		inactive_date := '0';
				string10	lic_endorsement := '';
				string4		motorcycle_code := '';
				string24	dl_number; 
				string9		ssn := '';
				string9		ssn_safe := '';
				string3		age := '';
				string1		privacy_flag := '';
				string1		driver_edu_code := '';
				string1		dup_lic_count:= '';
				string1		rcd_stat_flag:= '';
				string3		height := '';
				string3		hair_color:= '';
				string3		eye_color:= '';
				string3		weight := '';
				string25	oos_previous_dl_number := '';
				string2		oos_previous_st := '';
				string5		title := '';
				string20	fname := '';
				string20	mname := '';
				string20	lname := '';
				string5		name_suffix := '';
				string3		cleaning_score := '';
				string1		addr_fix_flag := '';
				string10	prim_range := '';
				string2		predir := '';
				string28	prim_name := '';
				string4		suffix := '';
				string2		postdir := '';
				string10	unit_desig := '';
				string8		sec_range := '';
				string25	p_city_name := '';
				string25	v_city_name := '';
				string2		st := '';
				string5		zip5 := '';
				string4		zip4 := '';
				string4		cart := '';
				string1		cr_sort_sz := '';
				string4		lot := '';
				string1		lot_order := '';
				string2		dpbc := '';
				string1		chk_digit := '';
				string2		rec_type := '';
				string2		ace_fips_st := '';
				string3		county := '';
				string10	geo_lat := '';
				string11	geo_long := '';
				string4		msa := '';
				string7		geo_blk;
				string1		geo_match := '';
				string4		err_stat := '';
				string3		status := '';
				string2		issuance := '';
				string8		address_change := '';
				string1		name_change := '';
				string1		dob_change := '';
				string1		sex_change := '';
				string24	old_dl_number := ''; 
				string9		dl_key_number:= '';
				string3		cdl_status := '';
				string1 	record_type := '';
				string2   eor := '\r\n';
		end;				

		//
		// this performs suppression, injection, and transformation to production layout before appending results and returning the modified base file
		//
		export applyDriversLicense(ds) := 
				functionmacro

						import DriversV2;

						//suppress
						DL_Suppress := driversV2.regulatory.applyDriversLicenseSup_DIDDl(ds);
			
						//append					
						base_file_inj_in := driversV2.regulatory.getDriversLicenseInj();				
		
						rec := recordof(ds);
						
						unsigned6 endMax := MAX(DL_Suppress, dl_seq);

						rec reformat_header(Base_File_inj_In L, INTEGER c) := transform
								self.dl_seq := endMax + c;;
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
								// self.record_type := '';
								self := L;
								self := [];
						end;
				 
						trans_to_prod := project(Base_File_inj_In, reformat_header(left, COUNTER));						

						return DL_Suppress + trans_to_prod;
						
				endmacro; 

//
// perform suppression function using applyRegulatory 
//
		export applyDriversLicenseSup_DIDDl(ds) := 
				functionmacro
						import suppress;
						
						DL_DID_DLNUM_hash(recordof(ds) L) := HASHMD5(intformat((unsigned6)l.did,15,1),TRIM((string14)l.dl_number, left, right));
						DL_Suppress := suppress.applyregulatory.simple_sup(ds,'driverslicense_sup.txt', DL_DID_DLNUM_hash);

						return DL_Suppress;
				endmacro;

		export applyDriversLicenseSup_DIDVend(ds) := 
				functionmacro
						import suppress;
				
						DL_DID_Vendor_hash(recordof(ds) L) := hashmd5(	intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right));
						DL_Suppress := suppress.applyregulatory.simple_sup(ds,'driverslicense_sup.txt', DL_DID_Vendor_hash);
						
						return DL_Suppress;
				endmacro;

		export applyDriversLicenseAllSup_DIDVendDOBSSN(ds) := 
				functionmacro
						import suppress;
						
						DL_DID_DOB_SSN_hash(recordof(ds) L) := HASHMD5(intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right),intformat((unsigned4)l.dob,8,1),Trim((string9)l.ssn));
						DL_Suppress := suppress.applyregulatory.simple_sup(ds,'driverslicenseall_sup.txt', DL_DID_DOB_SSN_hash);

						return DL_Suppress;
				endmacro;		
				
//
// perform append functions using applyRegulatory
//
		export applyDriversLicenseInj(ds) := 
				functionmacro
						import suppress;

						return := Suppress.applyRegulatory.simple_append(ds, 'file_dl_inj.txt', driversV2.regulatory.base_layout);
				endmacro;			

//
// perform get functions using applyRegulatory
//
		export getDriversLicenseSup() := 
				functionmacro						
						import suppress;

						return suppress.applyregulatory.getFile('driverslicense_sup.txt', suppress.applyregulatory.layout_in);
				endmacro; 

		export getDriversLicenseAllSup() := 
				functionmacro						
						import suppress;

						return suppress.applyregulatory.getFile('driverslicenseall_sup.txt', suppress.applyregulatory.layout_in);
				endmacro; 
				
		export getDriversLicenseInj() := 
				functionmacro										
						import suppress;

						return	suppress.applyregulatory.getFile('file_dl_inj.txt', driversV2.regulatory.base_layout);
				endmacro; 

				
end;