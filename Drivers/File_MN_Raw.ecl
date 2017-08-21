layout_Pre20050314_MN_Raw 
:= 
record
    string8         process_date;
    string32        name;
    string32        address;
    string20        city;
    string10        zip;
    string2         code_co;
    string7         dob;
    string1         sex;
    string3         hieght;
    string3         wieght;
    string1         donor;
    string2         class;
    string1         _type;
    string1         corrective_lenses;
    string7         code_endors;
    string1         ctr_bcard;
    string1         code_status_lic;
    string1         code_status_com;
    string1         new_license_ind;
    string7         dl_date_issue;
    string7         dl_date_expire;
    string14        key_driver_license;
    string11        code_restrictions;
    string10        conviction_code_data_1;
    string10        conviction_code_data_2;
    string10        conviction_code_data_3;
    string10        conviction_code_data_4;
    string10        conviction_code_data_5;
    string10        conviction_code_data_6;
    string10        conviction_code_data_7;
    string10        conviction_code_data_8;
    string10        conviction_code_data_9;
    string10        conviction_code_data_10;
    string10        conviction_code_data_11;
    string10        conviction_code_data_12;
    string10        conviction_code_data_13;
    string10        conviction_code_data_14;
    string10        conviction_code_data_15;
    string10        conviction_code_data_16;
    string10        conviction_code_data_17;
    string10        conviction_code_data_18;
    string10        conviction_code_data_19;
    string10        conviction_code_data_20;
    string10        conviction_code_data_21;
    string10        conviction_code_data_22;
    string10        conviction_code_data_23;
    string10        conviction_code_data_24;
    string10        conviction_code_data_25;
    string10        conviction_code_data_26;
    string10        conviction_code_data_27;
    string10        conviction_code_data_28;
    string10        conviction_code_data_29;
    string10        conviction_code_data_30;
    string10        conviction_code_data_31;
    string10        conviction_code_data_32;
    string10        conviction_code_data_33;
    string10        conviction_code_data_34;
    string10        conviction_code_data_35;
    string10        conviction_code_data_36;
    string10        conviction_code_data_37;
    string10        conviction_code_data_38;
    string10        conviction_code_data_39;
    string10        conviction_code_data_40;
    string10        conviction_code_data_41;
    string10        conviction_code_data_42;
    string10        conviction_code_data_43;
    string10        conviction_code_data_44;
    string10        conviction_code_data_45;
    string10        conviction_code_data_46;
    string10        conviction_code_data_47;
    string10        conviction_code_data_48;
    string10        conviction_code_data_49;
    string10        conviction_code_data_50;
    string1         jacket_file_indc;
    string1         indc_restric;
    string6         filler;
    string5         name_title;
    string20        name_first;
    string20        name_middle;
    string20        name_last;
    string5         name_suffix;
    string3         name_score;
    string10        prim_range;
    string2         predir;
    string28        prim_name;
    string4         addr_suffix;
    string2         postdir;
    string10        unit_desig;
    string8         sec_range;
    string25        p_city_name;
    string25        v_city_name;
    string2         state;
    string5         zip5;
    string4         zip4;
    string4         cart;
    string1         cr_sort_sz;
    string4         lot;
    string1         lot_order;
    string2         dpbc;
    string1         chk_digit;
    string2         rec_type;
    string2         ace_fips_st;
    string3         county;
    string10        geo_lat;
    string11        geo_long;
    string4         msa;
    string7         geo_blk;
    string1         geo_match;
    string4         err_stat;
end;


dPre20050314_MN_Raw
 := dataset(Drivers.Cluster + 'in::drvlic_mn_old', layout_Pre20050314_MN_Raw,thor)
 ;
 

 /* To correct or fix the bug related to the bad date_first_seen 2007615 */
 
dMn_Raw_incorrect
  :=	dataset(Drivers.Cluster + 'in::drvlic_mn_full', drivers.Layout_MN_Raw,thor) 
  ;


	drivers.Layout_MN_Raw  transform_to_correct_baddatefirstseen(dMn_Raw_incorrect  L) := transform

	self.process_date     := If(L.process_date='2007615','20070615',L.process_date);
	self		      := L;
	end;


	dMn_Raw := project(dMn_Raw_incorrect, transform_to_correct_baddatefirstseen(left));
  /* corrected date as dMn_Raw */
 
 Drivers.Layout_MN_Raw tOldLayoutToCurrent(dPre20050314_MN_Raw pInput)
 := 
  transform
	self.soundex     := '';
	self.filler      := '';
	self						 :=	pInput;
  end;
	
dOldAsCurrent := project(dPre20050314_MN_Raw, tOldLayoutToCurrent(left)); 

export File_MN_Raw 
 := dOldAsCurrent
 + dMn_Raw
;


