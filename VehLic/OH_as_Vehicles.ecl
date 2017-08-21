import ut,lib_stringlib;
o := File_OH_Full;
u := File_OH_Update;

string lFixNameCharacters(string pOrigName)
  := if(lib_stringlib.stringlib.stringfind(pOrigName,'*',1) <> 0,
        lib_stringlib.stringlib.stringfindreplace(
	      lib_stringlib.stringlib.stringfindreplace(
            lib_stringlib.stringlib.stringfindreplace(pOrigName,'%',' '),
            ',',' '),
           '*',', ')
		 ,pOrigName
		);

string10	fZipFix(string pZip) :=	  if(length(trim(pZip)) = 5 and pZip[5..9] <> '00000',
										 pZip,
										 if(length(trim(pZip)) > 5 and pZip[5..9] <> '00000',
										 pZip[5..9] +     	// reformatted
										 if(pZip[1..4] <> '999' and
											pZip[1..4] <> '0000' and regexfind(' ', pZip[1..4]) = FALSE,
											'-' + pZip[1..4],
											''),
											''
										   )
										);										
string10	fZipFixUpdate(string pZip) :=	  if(length(trim(pZip)) = 5 and pZip[1..5] <> '00000',
										 pZip,
										 if(length(trim(pZip)) > 5 and pZip[1..5] <> '00000', 
										 pZip[1..5] +     	// reformatted
										 if(pZip[6..8] <> '999' and
											pZip[6..9] <> '0000' and regexfind(' ', pZip[6..9]) = FALSE,
											'-' + pZip[6..9],
											''),
											''
										   )
										);			

layout_vehicles intof(o le) := transform
self.dt_first_seen:=(unsigned6)(le.process_date[1..6]);
self.dt_last_seen:=(unsigned6)(le.process_date[1..6]);
self.dt_vendor_first_reported:=(unsigned6)(le.process_date[1..6]);
self.dt_vendor_last_reported:=(unsigned6)(le.process_date[1..6]);
self.orig_state := 'OH';
self.VEHICLE_NUMBERxBG1 := if(length(trim(le.s_vin)) < 11 or 
						      length(trim(lib_stringlib.stringlib.stringfilterout(le.s_vin,'0'))) < 8 or
							  trim(le.s_vin,all) = 'NONE',
							  (string20)hash64(trim(lib_stringlib.stringlib.stringfilterout(le.s_vin,'0')),trim(le.s_plate),trim(le.s_owner)),
							  le.s_vin
						     );
/*
self.VEHICLE_NUMBERxBG1:= if(lib_stringlib.stringlib.stringfind(le.s_title,'NONE',1)<>0 or
							   lib_stringlib.stringlib.stringfind(le.s_title,'N O N E',1)<>0 or
							   lib_stringlib.stringlib.stringfilterout(le.s_title,' 0')='',
							 '',
							 le.s_title
							);
*/
self.ORIG_VIN:= le.s_vin;
self.vehicle_transaction_id := le.s_app;
self.YEAR_MAKE:= le.s_year ;
self.MAKE_CODE:= le.s_make ;
self.VEHICLE_TYPE:= le.s_cat;
self.BODY_CODE:= le.s_type ;
self.VEHICLE_USE:= le.s_owner;
self.GROSS_WEIGHT:= le.s_weight ;
self.own_1_feid_ssn := le.s_ssn;
self.OWN_1_CUSTOMER_NAME:= lFixNameCharacters(le.s_name);
self.OWN_1_STREET_ADDRESS:= le.s_address;
self.OWN_1_CITY:= le.s_city ;
self.OWN_1_STATE:= le.s_state;
self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL:= fZipFix(le.s_zip);
self.OWN_2_CUSTOMER_NAME:= if(le.s_name2[1..3]='***',
							  '',
							  lFixNameCharacters(le.s_name2)
							 );
self.LICENSE_PLATE_NUMBERxBG4:= le.s_plate ;
self.registration_effective_date := le.s_issue;
self.REGISTRATION_EXPIRATION_DATE:= le.s_exp[3..6]+le.s_exp[1..2];
self.DECAL_NUMBER:= le.s_sticker ;
self.ACTIVITY_COUNTY:= le.s_cnty ;
self.activity_agencyxeg6 := le.s_agency;
self.TITLE_NUMBERxBG9:= le.s_title ;
self.title_issue_date := le.s_purchase;
self.LH_1_CUSTOMER_NAME := 'Not On File';
self.LH_2_CUSTOMER_NAME := 'Not On File';
self.LH_3_CUSTOMER_NAME := 'Not On File';
self.own_1_title:= le.s_name_title ;
self.own_1_fname:= le.s_name_fname ;
self.own_1_mname:= le.s_name_mname ;
self.own_1_lname:= le.s_name_lname ;
self.own_1_name_suffix:= le.s_name_suffix;
self.own_1_company_name:= le.s_name_company ;
self.own_2_title:= le.s_name2_title ;
self.own_2_fname:= le.s_name2_fname ;
self.own_2_mname:= le.s_name2_mname ;
self.own_2_lname:= le.s_name2_lname ;
self.own_2_name_suffix:= le.s_name2_suffix;
self.own_2_company_name:= le.s_name2_company ;
self.own_1_prim_range:= le.owner_prim_range ;
self.own_1_predir:= le.owner_predir ;
self.own_1_prim_name:= le.owner_prim_name ;
self.own_1_suffix:= le.owner_addr_suffix ;
self.own_1_postdir:= le.owner_postdir ;
self.own_1_unit_desig:= le.owner_unit_desig ;
self.own_1_sec_range:= le.owner_sec_range ;
self.own_1_p_city_name:= le.owner_p_city_name ;
self.own_1_v_city_name:= le.owner_v_city_name ;
self.own_1_state_2:= le.owner_st ;
self.own_1_zip5:= le.owner_zip5;
self.own_1_zip4:= le.owner_zip4 ;
self.own_1_county:= le.owner_county ;
self.own_1_geo_lat:= le.owner_geo_lat ;
self.own_1_geo_long:= le.owner_geo_long ;
  end;

old_dump := project(o,intof(left));

layout_vehicles intof1(u le) := transform
self.dt_first_seen:=(unsigned6)(le.process_date[1..6]);
self.dt_last_seen:=(unsigned6)(le.process_date[1..6]);
self.dt_vendor_first_reported:=(unsigned6)(le.process_date[1..6]);
self.dt_vendor_last_reported:=(unsigned6)(le.process_date[1..6]);
self.orig_state := 'OH';
// Replaces next line //
self.VEHICLE_NUMBERxBG1 := if(length(trim(le.vr_vin)) < 11 or 
						      length(trim(lib_stringlib.stringlib.stringfilterout(le.vr_vin,'0'))) < 8 or
							  trim(le.vr_vin,all) = 'NONE',
							  (string20)hash64(trim(lib_stringlib.stringlib.stringfilterout(le.vr_vin,'0')),trim(le.vr_lic),trim(le.vr_owner)),
							  le.vr_vin
						     );
/* Following replaced by previous line
self.VEHICLE_NUMBERxBG1:= if(lib_stringlib.stringlib.stringfind(le.vr_title,'NONE',1)<>0 or
							   lib_stringlib.stringlib.stringfind(le.vr_title,'N O N E',1)<>0 or
							   lib_stringlib.stringlib.stringfilterout(le.vr_title,' 0')='',
							 '',
							 le.vr_title
							);
*/
self.ORIG_VIN:= le.vr_vin;
self.vehicle_transaction_id := le.vr_app_nbr;
self.YEAR_MAKE:= le.vr_yy ;
self.MAKE_CODE:= le.vr_make ;
self.VEHICLE_TYPE:= le.vr_cat;
self.BODY_CODE:= le.vr_type ;
self.VEHICLE_USE:= le.vr_owner;
//self.net_weight := le.vr_unl_weight; Remove from mapping because of vendor changes.
self.GROSS_WEIGHT:= le.vr_gvw_weight ;
self.own_1_feid_ssn := le.vr_ssn;
self.OWN_1_CUSTOMER_NAME:= lFixNameCharacters(le.vr_name);
self.OWN_1_STREET_ADDRESS:= le.vr_addr;
self.OWN_1_CITY:= le.vr_city1 ;
self.OWN_1_STATE:= le.vr_state1;
self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL:= fZipFixUpdate(le.vr_zip9);
self.OWN_2_CUSTOMER_NAME:= lFixNameCharacters(le.vr_name2);
self.LICENSE_PLATE_NUMBERxBG4:= le.vr_lic ;
self.registration_effective_date := le.vr_iss_date;
self.REGISTRATION_EXPIRATION_DATE:= le.vr_exp_date;
self.DECAL_NUMBER:= le.vr_val ;
self.license_plate_code := le.vr_coll_code;
self.true_license_plste_number := le.vr_lic;
self.activity_datexbg6 := le.vr_sys_date;
self.activity_agencyxeg6 := le.vr_agency;
self.TITLE_NUMBERxBG9:= le.vr_title ;
self.title_issue_date := le.vr_pur_date;
self.LH_1_CUSTOMER_NAME := 'Not On File';
self.LH_2_CUSTOMER_NAME := 'Not On File';
self.LH_3_CUSTOMER_NAME := 'Not On File';
self.own_1_title:= le.own_name_title ;
self.own_1_fname:= le.own_name_fname ;
self.own_1_mname:= le.own_name_mname ;
self.own_1_lname:= le.own_name_lname ;
self.own_1_name_suffix:= le.own_name_suffix;
self.own_1_company_name:= le.own_name_company ;
self.own_2_title:= le.own2_name_title ;
self.own_2_fname:= le.own2_name_fname ;
self.own_2_mname:= le.own2_name_mname ;
self.own_2_lname:= le.own2_name_lname ;
self.own_2_name_suffix:= le.own2_name_suffix;
self.own_2_company_name:= le.own2_name_company ;
self.own_1_prim_range:= le.owner_prim_range ;
self.own_1_predir:= le.owner_predir ;
self.own_1_prim_name:= le.owner_prim_name ;
self.own_1_suffix:= le.owner_addr_suffix ;
self.own_1_postdir:= le.owner_postdir ;
self.own_1_unit_desig:= le.owner_unit_desig ;
self.own_1_sec_range:= le.owner_sec_range ;
self.own_1_p_city_name:= le.owner_p_city_name ;
self.own_1_v_city_name:= le.owner_v_city_name ;
self.own_1_state_2:= le.owner_st ;
self.own_1_zip5:= le.owner_zip5;
self.own_1_zip4:= le.owner_zip4 ;
self.own_1_county:= le.owner_county ;
self.own_1_geo_lat:= le.owner_geo_lat ;
self.own_1_geo_long:= le.owner_geo_long ;
  end;

upd := project(u,intof1(left));

export OH_as_Vehicles
 :=	old_dump
 +	upd
 ;