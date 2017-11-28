import VehicleV2_Services, MDR;

export Batch_Transforms := MODULE

	layout_out := VehicleV2_Services.Batch_Layout.layout_out;
	temp_out := VehicleV2_Services.Batch_Layout.temp_out;

	temp_out xfm_Veh_recs(VehicleV2_Services.Layout_Report_Batch L) := TRANSFORM
		Reg_recs := L.registrants(Sequence_Key <> '');
		Owner_recs := L.owners(Sequence_Key <> '');
		Is_Reg := EXISTS(Reg_recs);
		reg_lr_date := MAX(Reg_recs, Date_Vendor_Last_Reported);
		owner_lr_date := MAX(Owner_recs, Date_Vendor_Last_Reported);
		reg_fr_date := MIN(Reg_recs(Date_Vendor_First_Reported > 0), Date_Vendor_First_Reported);
		owner_fr_date := MIN(Owner_recs(Date_Vendor_First_Reported > 0), Date_Vendor_First_Reported);

		SELF.vendor_last_reported_date := IF(Is_Reg, reg_lr_date, owner_lr_date);
		SELF.vendor_first_reported_date := IF(Is_Reg, reg_fr_date, owner_fr_date);
		SELf.title_latest_issue_date :=	MAX(Owner_recs(Ttl_Latest_Issue_Date <> ''), Ttl_Latest_Issue_Date);
		SELF.sk_len := LENGTH(TRIM(L.Sequence_Key));
		SELF := L;
	END;
 
  format_addr1(L,addr1) := MACRO
		addr1 :=  TRIM(L.prim_range) +' ' +TRIM(L.predir) +' ' +TRIM(L.prim_name) 
		+' ' +TRIM(L.addr_suffix) +' ' +TRIM(L.postdir);		
	ENDMACRO;
	
  format_addr2(L, addr2 ) := MACRO
		addr2 :=  TRIM(L.unit_desig) +' ' +TRIM(L.sec_range) ;
	ENDMACRO;	
	
  format_zip(L,zip ) := MACRO
		zip := TRIM(L.zip5) +' ' +TRIM(L.zip4) ;
	ENDMACRO;	  
	
  layout_out xfm_out(temp_out L, DATASET(temp_out) R) := TRANSFORM
		Owner_info := PROJECT(R.Owners(sequence_key<>'') ,VehicleV2_Services.assorted_layouts.Layout_owner); 
		Reg_info   := PROJECT(R.Registrants(sequence_key<>''),VehicleV2_Services.assorted_layouts.Layout_registrant);
		LH_info    := PROJECT(R.LienHolders(sequence_key<>''),VehicleV2_Services.assorted_layouts.Layout_lienholder);
		LE_info    := PROJECT(R.Lessees(sequence_key<>''),VehicleV2_Services.assorted_layouts.layout_lessee);
		LO_info    := PROJECT(R.Lessors(sequence_key<>''),VehicleV2_Services.assorted_layouts.Layout_lessee_or_lessor);
		BR_info    := PROJECT(R.Brands, VehicleV2_Services.assorted_layouts.layout_brand);
    
		SELF.Own_sequence_key := Owner_info[1].sequence_key;
		SELF.Reg_sequence_key := Reg_info[1].sequence_key;
		SELF.LH_sequence_key := LH_info[1].sequence_key;
		SELF.LE_sequence_key := LE_info[1].sequence_key;
		SELF.LO_sequence_key := LO_info[1].sequence_key;
	
	  //Owner 1
    
		SELF.	own_1_Orig_name := owner_info[1].orig_name;
		// .fname+' '+owner_info[1].mname+' '+owner_info[1].lname+' '+owner_info[1].name_suffix;
	  SELF.	own_1_orig_sex := owner_info[1].orig_sex;
		SELF. own_1_did :=  owner_info[1].Append_DID;
		SELF.	own_1_driver_license_number :=  owner_info[1].orig_Dl_number;
		SELF.	own_1_dob :=  owner_info[1].orig_dob; 
		SELF.	own_1_ssn :=  owner_info[1].append_ssn;
		SELF. own_1_company_name :=  owner_info[1].Append_clean_cname;
	  SELF. own_1_bdid :=  owner_info[1].Append_BDID;
		SELF. own_1_fein := '';
		SELF.own_1_fname := owner_info[1].fname;
		SELF.own_1_mname := owner_info[1].mname;
		SELF.own_1_lname := owner_info[1].lname;
		SELF.own_1_name_suffix := owner_info[1].name_suffix;
		format_addr1(owner_info[1],O1addr1)
		format_addr2(owner_info[1],O1addr2)
		SELF.own_1_addr1 := O1addr1;
		SELF.own_1_addr2 := O1addr2;
		SELF.own_1_v_city_name := owner_info[1].v_city_name;
		SELF.own_1_city :=  owner_info[1].v_city_name;
		SELF.own_1_state :=  owner_info[1].st;
		format_zip(owner_info[1],O1zip)
		SELF.own_1_zip := O1zip;
		SELF.own_1_county :=  owner_info[1].county_name; 
		SELF.own_1_src_first_date :=  owner_info[1].src_first_date; 
		SELF.own_1_src_last_date :=  owner_info[1].src_last_date; 
		SELF.own_1_UltID := owner_info[1].UltID;
		SELF.own_1_OrgID := owner_info[1].OrgID;
		SELF.own_1_SeleID := owner_info[1].SeleID;
		SELF.own_1_ProxID := owner_info[1].ProxID;
		SELF.own_1_PowID := owner_info[1].PowID;
		SELF.own_1_EmpID := owner_info[1].EmpID;
		SELF.own_1_DotID := owner_info[1].DotID;
		
		//Owner 2
		
		SELF.	own_2_Orig_name :=  owner_info[2].orig_name;
		// .fname+' '+owner_info[2].mname+' '+owner_info[2].lname+' '+owner_info[2].name_suffix;
	  SELF.	own_2_orig_sex :=  owner_info[2].orig_sex;
		SELF. own_2_did :=  owner_info[2].Append_DID;
		SELF.	own_2_driver_license_number :=  owner_info[2].orig_Dl_number;
		SELF.	own_2_dob :=  owner_info[2].orig_dob; 
		SELF.	own_2_ssn :=  owner_info[2].append_ssn;
		SELF. own_2_company_name :=  owner_info[2].Append_clean_cname;
	  SELF. own_2_bdid :=  owner_info[2].Append_BDID;
		SELF. own_2_fein := '';
		SELF.own_2_fname :=  owner_info[2].fname;
		SELF.own_2_mname :=  owner_info[2].mname;
		SELF.own_2_lname :=  owner_info[2].lname;
		SELF.own_2_name_suffix :=  owner_info[2].name_suffix;
		format_addr1(owner_info[2],O2addr1)
		format_addr2(owner_info[2],O2addr2)
		SELF.own_2_addr1 := O2addr1;
		SELF.own_2_addr2 := O2addr2;
		SELF.own_2_v_city_name := owner_info[2].v_city_name;
		SELF.own_2_city :=  owner_info[2].v_city_name;
		SELF.own_2_state :=  owner_info[2].st;
		format_zip(owner_info[2],O2zip)
		SELF.own_2_zip := O2zip;
		SELF.	own_2_county :=  owner_info[2].county_name; 
		SELF.own_2_src_first_date :=  owner_info[2].src_first_date; 
		SELF.own_2_src_last_date :=  owner_info[2].src_last_date; 
		SELF.own_2_UltID := owner_info[2].UltID;
		SELF.own_2_OrgID := owner_info[2].OrgID;
		SELF.own_2_SeleID := owner_info[2].SeleID;
		SELF.own_2_ProxID := owner_info[2].ProxID;
		SELF.own_2_PowID := owner_info[2].PowID;
		SELF.own_2_EmpID := owner_info[2].EmpID;
		SELF.own_2_DotID := owner_info[2].DotID;
		
		//Owner 3
		
		SELF.	own_3_Orig_name :=  owner_info[3].orig_name;
		// .fname+' '+owner_info[3].mname+' '+owner_info[3].lname+' '+owner_info[3].name_suffix;
	  SELF.	own_3_orig_sex :=  owner_info[3].orig_sex;
		SELF. own_3_did :=  owner_info[3].Append_DID;
		SELF.	own_3_driver_license_number :=  owner_info[3].orig_Dl_number;
		SELF.	own_3_dob :=  owner_info[3].orig_dob; 
		SELF.	own_3_ssn :=  owner_info[3].append_ssn;
		SELF. own_3_company_name :=  owner_info[3].Append_clean_cname;
	  SELF. own_3_bdid :=  owner_info[3].Append_BDID;
		SELF. own_3_fein := '';
		SELF.own_3_fname :=  owner_info[3].fname;
		SELF.own_3_mname :=  owner_info[3].mname;
		SELF.own_3_lname :=  owner_info[3].lname;
		SELF.own_3_name_suffix :=  owner_info[3].name_suffix;
		format_addr1(owner_info[3],O3addr1)
		format_addr2(owner_info[3],O3addr2)
		SELF.own_3_addr1 := O3addr1;
		SELF.own_3_addr2 := O3addr2;
		SELF.own_3_v_city_name := owner_info[3].v_city_name;
		SELF.own_3_city :=  owner_info[3].v_city_name;
		SELF.own_3_state :=  owner_info[3].st;
		format_zip(owner_info[3],O3zip)
		SELF.own_3_zip := O3zip;
		SELF.	own_3_county :=  owner_info[3].county_name; 
		SELF.own_3_src_first_date :=  owner_info[3].src_first_date; 
		SELF.own_3_src_last_date :=  owner_info[3].src_last_date; 
		SELF.own_3_UltID := owner_info[3].UltID;
		SELF.own_3_OrgID := owner_info[3].OrgID;
		SELF.own_3_SeleID := owner_info[3].SeleID;
		SELF.own_3_ProxID := owner_info[3].ProxID;
		SELF.own_3_PowID := owner_info[3].PowID;
		SELF.own_3_EmpID := owner_info[3].EmpID;
		SELF.own_3_DotID := owner_info[3].DotID;
		
		
		//Registrant 1
    
		SELF.	reg_1_Orig_name :=  reg_info[1].orig_name;
		// .fname+' '+reg_info[1].mname+' '+reg_info[1].lname+' '+reg_info[1].name_suffix;
	  SELF.	reg_1_orig_sex :=  reg_info[1].orig_sex;
		SELF. reg_1_did :=  reg_info[1].Append_DID;
		SELF.	reg_1_driver_license_number :=  reg_info[1].orig_Dl_number;
		SELF.	reg_1_dob :=  reg_info[1].orig_dob; 
		SELF.	reg_1_ssn :=  reg_info[1].append_ssn;
		SELF. reg_1_company_name :=  reg_info[1].Append_clean_cname;
	  SELF. reg_1_bdid :=  reg_info[1].Append_BDID;
		SELF. reg_1_fein := '';
		SELF.reg_1_fname :=  reg_info[1].fname;
		SELF.reg_1_mname :=  reg_info[1].mname;
		SELF.reg_1_lname :=  reg_info[1].lname;
		SELF.reg_1_name_suffix :=  reg_info[1].name_suffix;
		format_addr1(reg_info[1],R1addr1)
		format_addr2(reg_info[1],R1addr2)
		SELF.reg_1_addr1 := R1addr1;
		SELF.reg_1_addr2 := R1addr2;
		SELF.reg_1_v_city_name :=reg_info[1].v_city_name;
		SELF.	reg_1_city :=  reg_info[1].v_city_name;
		SELF.	reg_1_state :=  reg_info[1].st;
		format_zip(reg_info[1],R1zip)
		SELF.	reg_1_zip := R1zip;
		SELF.	reg_1_county :=  reg_info[1].county_name;
		SELF.reg_1_UltID := reg_info[1].UltID;
		SELF.reg_1_OrgID := reg_info[1].OrgID;
		SELF.reg_1_SeleID := reg_info[1].SeleID;
		SELF.reg_1_ProxID := reg_info[1].ProxID;
		SELF.reg_1_PowID := reg_info[1].PowID;
		SELF.reg_1_EmpID := reg_info[1].EmpID;
		SELF.reg_1_DotID := reg_info[1].DotID;
		
		//Registrant 2
		
		SELF.	reg_2_Orig_name :=  reg_info[2].orig_name;
		// .fname+' '+reg_info[2].mname+' '+reg_info[2].lname+' '+reg_info[2].name_suffix;
	  SELF.	reg_2_orig_sex :=  reg_info[2].orig_sex;
		SELF. reg_2_did :=  reg_info[2].Append_DID;
		SELF.	reg_2_driver_license_number :=  reg_info[2].orig_Dl_number;
		SELF.	reg_2_dob :=  reg_info[2].orig_dob; 
		SELF.	reg_2_ssn :=  reg_info[2].append_ssn;
		SELF. reg_2_company_name :=  reg_info[2].Append_clean_cname;
	  SELF. reg_2_bdid :=  reg_info[2].Append_BDID;
		SELF. reg_2_fein := '';
		SELF.reg_2_fname :=  reg_info[2].fname;
		SELF.reg_2_mname :=  reg_info[2].mname;
		SELF.reg_2_lname :=  reg_info[2].lname;
		SELF.reg_2_name_suffix :=  reg_info[2].name_suffix;
		format_addr1(reg_info[2],R2addr1)
		format_addr2(reg_info[2],R2addr2)
		SELF.reg_2_addr1 := R2addr1;
		SELF.reg_2_addr2 := R2addr2;
		SELF.reg_2_v_city_name :=reg_info[2].v_city_name;
		SELF.	reg_2_city :=  reg_info[2].v_city_name;
		SELF.	reg_2_state :=  reg_info[2].st;
		format_zip(reg_info[2],R2zip)
		SELF.	reg_2_zip := R2zip;
		SELF.	reg_2_county :=  reg_info[2].county_name; 
		SELF.reg_2_UltID := reg_info[2].UltID;
		SELF.reg_2_OrgID := reg_info[2].OrgID;
		SELF.reg_2_SeleID := reg_info[2].SeleID;
		SELF.reg_2_ProxID := reg_info[2].ProxID;
		SELF.reg_2_PowID := reg_info[2].PowID;
		SELF.reg_2_EmpID := reg_info[2].EmpID;
		SELF.reg_2_DotID := reg_info[2].DotID;
		
		//Registrant 3
		
		SELF.	reg_3_Orig_name :=  reg_info[3].orig_name;
		// .fname+' '+reg_info[3].mname+' '+reg_info[3].lname+' '+reg_info[3].name_suffix;
	  SELF.	reg_3_orig_sex :=  reg_info[3].orig_sex;
		SELF. reg_3_did :=  reg_info[3].Append_DID;
		SELF.	reg_3_driver_license_number :=  reg_info[3].orig_Dl_number;
		SELF.	reg_3_dob :=  reg_info[3].orig_dob; 
		SELF.	reg_3_ssn :=  reg_info[3].append_ssn;
		SELF. reg_3_company_name :=  reg_info[3].Append_clean_cname;
	  SELF. reg_3_bdid :=  reg_info[3].Append_BDID;
		SELF. reg_3_fein := '';
		SELF.reg_3_fname :=  reg_info[3].fname;
		SELF.reg_3_mname :=  reg_info[3].mname;
		SELF.reg_3_lname :=  reg_info[3].lname;
		SELF.reg_3_name_suffix :=  reg_info[3].name_suffix;
		format_addr1(reg_info[3],R3addr1)
		format_addr2(reg_info[3],R3addr2)
		SELF.reg_3_addr1 := R3addr1;
		SELF.reg_3_addr2 := R3addr2;
		SELF.reg_3_v_city_name :=reg_info[3].v_city_name;
		SELF.	reg_3_city :=  reg_info[3].v_city_name;
		SELF.	reg_3_state :=  reg_info[3].st;
		format_zip(reg_info[3],R3zip)
		SELF.	reg_3_zip := R3zip;
		SELF.	reg_3_county :=  reg_info[3].county_name; 
		SELF.reg_3_UltID := reg_info[3].UltID;
		SELF.reg_3_OrgID := reg_info[3].OrgID;
		SELF.reg_3_SeleID := reg_info[3].SeleID;
		SELF.reg_3_ProxID := reg_info[3].ProxID;
		SELF.reg_3_PowID := reg_info[3].PowID;
		SELF.reg_3_EmpID := reg_info[3].EmpID;
		SELF.reg_3_DotID := reg_info[3].DotID;		
		
		//lienHolder 1
    
		SELF.	lh_1_Orig_name :=  lh_info[1].orig_name;
		// .fname+' '+lh_info[1].mname+' '+lh_info[1].lname+' '+lh_info[1].name_suffix;
	  SELF.	lh_1_orig_sex :=  lh_info[1].orig_sex;
		SELF. lh_1_did :=  lh_info[1].Append_DID;
		SELF.	lh_1_driver_license_number :=  lh_info[1].orig_Dl_number;
		SELF.	lh_1_dob :=  lh_info[1].orig_dob; 
		SELF.	lh_1_ssn :=  lh_info[1].append_ssn;
		SELF. lh_1_company_name :=  lh_info[1].Append_clean_cname;
	  SELF. lh_1_bdid :=  lh_info[1].Append_BDID;
		SELF. lh_1_fein := '';
		SELF.lh_1_fname :=  lh_info[1].fname;
		SELF.lh_1_mname :=  lh_info[1].mname;
		SELF.lh_1_lname :=  lh_info[1].lname;
		SELF.lh_1_name_suffix :=  lh_info[1].name_suffix;
		format_addr1(lh_info[1],LH1addr1)
		format_addr2(lh_info[1],LH1addr2)
		SELF.lh_1_addr1 := LH1addr1;
		SELF.lh_1_addr2 := LH1addr2;
		SELF.lh_1_v_city_name := lh_info[1].v_city_name;
		SELF.	lh_1_city :=  lh_info[1].v_city_name;
		SELF.	lh_1_state :=  lh_info[1].st;
		format_zip(LH_info[1],LH1zip)
		SELF.	lh_1_zip := LH1zip;
		SELF.	lh_1_county :=  lh_info[1].county_name; 
		SELF.lh_1_UltID := lh_info[1].UltID;
		SELF.lh_1_OrgID := lh_info[1].OrgID;
		SELF.lh_1_SeleID := lh_info[1].SeleID;
		SELF.lh_1_ProxID := lh_info[1].ProxID;
		SELF.lh_1_PowID := lh_info[1].PowID;
		SELF.lh_1_EmpID := lh_info[1].EmpID;
		SELF.lh_1_DotID := lh_info[1].DotID;
		
		//LienHolder 2
		
		SELF.	lh_2_Orig_name :=  lh_info[2].orig_name;
		// .fname+' '+lh_info[2].mname+' '+lh_info[2].lname+' '+lh_info[2].name_suffix;
	  SELF.	lh_2_orig_sex :=  lh_info[2].orig_sex;
		SELF. lh_2_did :=  lh_info[2].Append_DID;
		SELF.	lh_2_driver_license_number :=  lh_info[2].orig_Dl_number;
		SELF.	lh_2_dob :=  lh_info[2].orig_dob; 
		SELF.	lh_2_ssn :=  lh_info[2].append_ssn;
		SELF. lh_2_company_name :=  lh_info[2].Append_clean_cname;
	  SELF. lh_2_bdid :=  lh_info[2].Append_BDID;
		SELF. lh_2_fein := '';
		SELF.lh_2_fname :=  lh_info[2].fname;
		SELF.lh_2_mname :=  lh_info[2].mname;
		SELF.lh_2_lname :=  lh_info[2].lname;
		SELF.lh_2_name_suffix :=  lh_info[2].name_suffix;
		format_addr1(lh_info[2],LH2addr1)
		format_addr2(lh_info[2],LH2addr2)
		SELF.lh_2_addr1 := LH2addr1;
		SELF.lh_2_addr2 := LH2addr2;
		SELF.lh_2_v_city_name := lh_info[2].v_city_name;
		SELF.	lh_2_city :=  lh_info[2].v_city_name;
		SELF.	lh_2_state :=  lh_info[2].st;
		format_zip(LH_info[2],LH2zip)
		SELF.	lh_2_zip := LH2zip;
		SELF.	lh_2_county :=  lh_info[2].county_name;
		SELF.lh_2_UltID := lh_info[2].UltID;
		SELF.lh_2_OrgID := lh_info[2].OrgID;
		SELF.lh_2_SeleID := lh_info[2].SeleID;
		SELF.lh_2_ProxID := lh_info[2].ProxID;
		SELF.lh_2_PowID := lh_info[2].PowID;
		SELF.lh_2_EmpID := lh_info[2].EmpID;
		SELF.lh_2_DotID := lh_info[2].DotID;
		
		//LienHolder 3
		
		SELF.	lh_3_Orig_name :=  lh_info[3].orig_name;
		// .fname+' '+lh_info[3].mname+' '+lh_info[3].lname+' '+lh_info[3].name_suffix;
	  SELF.	lh_3_orig_sex :=  lh_info[3].orig_sex;
		SELF. lh_3_did :=  lh_info[3].Append_DID;
		SELF.	lh_3_driver_license_number :=  lh_info[3].orig_Dl_number;
		SELF.	lh_3_dob :=  lh_info[3].orig_dob; 
		SELF.	lh_3_ssn :=  lh_info[3].append_ssn;
		SELF. lh_3_company_name :=  lh_info[3].Append_clean_cname;
	  SELF. lh_3_bdid :=  lh_info[3].Append_BDID;
		SELF. lh_3_fein := '';
		SELF.lh_3_fname :=  lh_info[3].fname;
		SELF.lh_3_mname :=  lh_info[3].mname;
		SELF.lh_3_lname :=  lh_info[3].lname;
		SELF.lh_3_name_suffix :=  lh_info[3].name_suffix;
		format_addr1(lh_info[3],LH3addr1)
		format_addr2(lh_info[3],LH3addr2)
		SELF.lh_3_addr1 := LH3addr1;
		SELF.lh_3_addr2 := LH3addr2;
		SELF.lh_3_v_city_name := lh_info[3].v_city_name;
		SELF.	lh_3_city :=  lh_info[3].v_city_name;
		SELF.	lh_3_state :=  lh_info[3].st;
		format_zip(LH_info[3],LH3zip)
		SELF.	lh_3_zip := LH3zip;
		SELF.	lh_3_county :=  lh_info[3].county_name;
		SELF.lh_3_UltID := lh_info[3].UltID;
		SELF.lh_3_OrgID := lh_info[3].OrgID;
		SELF.lh_3_SeleID := lh_info[3].SeleID;
		SELF.lh_3_ProxID := lh_info[3].ProxID;
		SELF.lh_3_PowID := lh_info[3].PowID;
		SELF.lh_3_EmpID := lh_info[3].EmpID;
		SELF.lh_3_DotID := lh_info[3].DotID;
		
		//lessee 1
    
		SELF.	le_1_Orig_name :=  le_info[1].orig_name;
		// .fname+' '+le_info[1].mname+' '+le_info[1].lname+' '+le_info[1].name_suffix;
	  SELF.	le_1_orig_sex :=  le_info[1].orig_sex;
		SELF. le_1_did :=  le_info[1].Append_DID;
		SELF.	le_1_driver_license_number :=  le_info[1].orig_Dl_number;
		SELF.	le_1_dob :=  le_info[1].orig_dob; 
		SELF.	le_1_ssn :=  le_info[1].append_ssn;
		SELF. le_1_company_name :=  le_info[1].Append_clean_cname;
	  SELF. le_1_bdid :=  le_info[1].Append_BDID;
		SELF. le_1_fein := '';
		SELF.le_1_fname :=  le_info[1].fname;
		SELF.le_1_mname :=  le_info[1].mname;
		SELF.le_1_lname :=  le_info[1].lname;
		SELF.le_1_name_suffix :=  le_info[1].name_suffix;
		format_addr1(le_info[1],LE1addr1)
		format_addr2(le_info[1],LE1addr2)
		SELF.le_1_addr1 := LE1addr1;
		SELF.le_1_addr2 := LE1addr2;
		SELF.le_1_v_city_name := le_info[1].v_city_name;
		SELF.	le_1_city :=  le_info[1].v_city_name;
		SELF.	le_1_state :=  le_info[1].st;
		format_zip(LE_info[1],LE1zip)
		SELF.	le_1_zip := LE1zip;
		SELF.	le_1_county :=  le_info[1].county_name; 
		SELF.le_1_UltID := le_info[1].UltID;
		SELF.le_1_OrgID := le_info[1].OrgID;
		SELF.le_1_SeleID := le_info[1].SeleID;
		SELF.le_1_ProxID := le_info[1].ProxID;
		SELF.le_1_PowID := le_info[1].PowID;
		SELF.le_1_EmpID := le_info[1].EmpID;
		SELF.le_1_DotID := le_info[1].DotID;
		
		//Lessee 2
		
		SELF.	le_2_Orig_name :=  le_info[2].orig_name;
		// .fname+' '+le_info[2].mname+' '+le_info[2].lname+' '+le_info[2].name_suffix;
	  SELF.	le_2_orig_sex :=  le_info[2].orig_sex;
		SELF. le_2_did :=  le_info[2].Append_DID;
		SELF.	le_2_driver_license_number :=  le_info[2].orig_Dl_number;
		SELF.	le_2_dob :=  le_info[2].orig_dob; 
		SELF.	le_2_ssn :=  le_info[2].append_ssn;
		SELF. le_2_company_name :=  le_info[2].Append_clean_cname;
	  SELF. le_2_bdid :=  le_info[2].Append_BDID;
		SELF. le_2_fein := '';
		SELF.le_2_fname :=  le_info[2].fname;
		SELF.le_2_mname :=  le_info[2].mname;
		SELF.le_2_lname :=  le_info[2].lname;
		SELF.le_2_name_suffix :=  le_info[2].name_suffix;
		format_addr1(le_info[2],LE2addr1)
		format_addr2(le_info[2],LE2addr2)
		SELF.le_2_addr1 := LE2addr1;
		SELF.le_2_addr2 := LE2addr2;
		SELF.le_2_v_city_name := le_info[2].v_city_name;
		SELF.	le_2_city :=  le_info[2].v_city_name;
		SELF.	le_2_state :=  le_info[2].st;
		format_zip(LE_info[2],LE2zip)
		SELF.	le_2_zip := LE2zip;
		SELF.	le_2_county :=  le_info[2].county_name;
		SELF.le_2_UltID := le_info[2].UltID;
		SELF.le_2_OrgID := le_info[2].OrgID;
		SELF.le_2_SeleID := le_info[2].SeleID;
		SELF.le_2_ProxID := le_info[2].ProxID;
		SELF.le_2_PowID := le_info[2].PowID;
		SELF.le_2_EmpID := le_info[2].EmpID;
		SELF.le_2_DotID := le_info[2].DotID;
		
		//Lessee 3
		
		SELF.	le_3_Orig_name :=  le_info[3].orig_name;
		// .fname+' '+le_info[3].mname+' '+le_info[3].lname+' '+le_info[3].name_suffix;
	  SELF.	le_3_orig_sex :=  le_info[3].orig_sex;
		SELF. le_3_did :=  le_info[3].Append_DID;
		SELF.	le_3_driver_license_number :=  le_info[3].orig_Dl_number;
		SELF.	le_3_dob :=  le_info[3].orig_dob; 
		SELF.	le_3_ssn :=  le_info[3].append_ssn;
		SELF. le_3_company_name :=  le_info[3].Append_clean_cname;
	  SELF. le_3_bdid :=  le_info[3].Append_BDID;
		SELF. le_3_fein := '';
		SELF.le_3_fname :=  le_info[3].fname;
		SELF.le_3_mname :=  le_info[3].mname;
		SELF.le_3_lname :=  le_info[3].lname;
		SELF.le_3_name_suffix :=  le_info[3].name_suffix;
		format_addr1(le_info[3],LE3addr1)
		format_addr2(le_info[3],LE3addr2)
		SELF.le_3_addr1 := LE3addr1;
		SELF.le_3_addr2 := LE3addr2;
		SELF.le_3_v_city_name := le_info[3].v_city_name;
		SELF.	le_3_city :=  le_info[3].v_city_name;
		SELF.	le_3_state :=  le_info[3].st;
		format_zip(LE_info[3],LE3zip)
		SELF.	le_3_zip := LE3zip;
		SELF.	le_3_county :=  le_info[3].county_name;
		SELF.le_3_UltID := le_info[3].UltID;
		SELF.le_3_OrgID := le_info[3].OrgID;
		SELF.le_3_SeleID := le_info[3].SeleID;
		SELF.le_3_ProxID := le_info[3].ProxID;
		SELF.le_3_PowID := le_info[3].PowID;
		SELF.le_3_EmpID := le_info[3].EmpID;
		SELF.le_3_DotID := le_info[3].DotID;
		
		//lessor 1
    
		SELF.	lo_1_Orig_name :=  lo_info[1].orig_name;
		// .fname+' '+lo_info[1].mname+' '+lo_info[1].lname+' '+lo_info[1].name_suffix;
	  SELF.	lo_1_orig_sex :=  lo_info[1].orig_sex;
		SELF. lo_1_did :=  lo_info[1].Append_DID;
		SELF.	lo_1_driver_license_number :=  lo_info[1].orig_Dl_number;
		SELF.	lo_1_dob :=  lo_info[1].orig_dob; 
		SELF.	lo_1_ssn :=  lo_info[1].append_ssn;
		SELF. lo_1_company_name :=  lo_info[1].Append_clean_cname;
	  SELF. lo_1_bdid :=  lo_info[1].Append_BDID;
		SELF. lo_1_fein := '';
		SELF.lo_1_fname :=  lo_info[1].fname;
		SELF.lo_1_mname :=  lo_info[1].mname;
		SELF.lo_1_lname :=  lo_info[1].lname;
		SELF.lo_1_name_suffix :=  lo_info[1].name_suffix;
		format_addr1(lo_info[1],LO1addr1)
		format_addr2(lo_info[1],LO1addr2)
		SELF.lo_1_addr1 := LO1addr1;
		SELF.lo_1_addr2 := LO1addr2;
		SELF.lo_1_v_city_name := lo_info[1].v_city_name;
		SELF.	lo_1_city :=  lo_info[1].v_city_name;
		SELF.	lo_1_state :=  lo_info[1].st;
		format_zip(LO_info[1],LO1zip)
		SELF.	lo_1_zip := LO1zip;
		SELF.	lo_1_county :=  lo_info[1].county_name; 
		SELF.lo_1_UltID := lo_info[1].UltID;
		SELF.lo_1_OrgID := lo_info[1].OrgID;
		SELF.lo_1_SeleID := lo_info[1].SeleID;
		SELF.lo_1_ProxID := lo_info[1].ProxID;
		SELF.lo_1_PowID := lo_info[1].PowID;
		SELF.lo_1_EmpID := lo_info[1].EmpID;
		SELF.lo_1_DotID := lo_info[1].DotID;
		
		//Lessor 2
		
		SELF.	lo_2_Orig_name :=  lo_info[2].orig_name;
		// .fname+' '+lo_info[2].mname+' '+lo_info[2].lname+' '+lo_info[2].name_suffix;
	  SELF.	lo_2_orig_sex :=  lo_info[2].orig_sex;
		SELF. lo_2_did :=  lo_info[2].Append_DID;
		SELF.	lo_2_driver_license_number :=  lo_info[2].orig_Dl_number;
		SELF.	lo_2_dob :=  lo_info[2].orig_dob; 
		SELF.	lo_2_ssn :=  lo_info[2].append_ssn;
		SELF. lo_2_company_name :=  lo_info[2].Append_clean_cname;
	  SELF. lo_2_bdid :=  lo_info[2].Append_BDID;
		SELF. lo_2_fein := '';
		SELF.lo_2_fname :=  lo_info[2].fname;
		SELF.lo_2_mname :=  lo_info[2].mname;
		SELF.lo_2_lname :=  lo_info[2].lname;
		SELF.lo_2_name_suffix :=  lo_info[2].name_suffix;
		format_addr1(lo_info[2],LO2addr1)
		format_addr2(lo_info[2],LO2addr2)
		SELF.lo_2_addr1 := LO2addr1;
		SELF.lo_2_addr2 := LO2addr2;
		SELF.lo_2_v_city_name := lo_info[2].v_city_name;
		SELF.	lo_2_city :=  lo_info[2].v_city_name;
		SELF.	lo_2_state :=  lo_info[2].st;
		format_zip(LO_info[2],LO2zip)
		SELF.	lo_2_zip := LO2zip;
		SELF.	lo_2_county :=  lo_info[2].county_name;
		SELF.lo_2_UltID := lo_info[2].UltID;
		SELF.lo_2_OrgID := lo_info[2].OrgID;
		SELF.lo_2_SeleID := lo_info[2].SeleID;
		SELF.lo_2_ProxID := lo_info[2].ProxID;
		SELF.lo_2_PowID := lo_info[2].PowID;
		SELF.lo_2_EmpID := lo_info[2].EmpID;
		SELF.lo_2_DotID := lo_info[2].DotID;
		
		//Lessor 3
		
		SELF.	lo_3_Orig_name :=  lo_info[3].orig_name;
		// .fname+' '+lo_info[3].mname+' '+lo_info[3].lname+' '+lo_info[3].name_suffix;
	  SELF.	lo_3_orig_sex :=  lo_info[3].orig_sex;
		SELF. lo_3_did :=  lo_info[3].Append_DID;
		SELF.	lo_3_driver_license_number :=  lo_info[3].orig_Dl_number;
		SELF.	lo_3_dob :=  lo_info[3].orig_dob; 
		SELF.	lo_3_ssn :=  lo_info[3].append_ssn;
		SELF. lo_3_company_name :=  lo_info[3].Append_clean_cname;
	  SELF. lo_3_bdid :=  lo_info[3].Append_BDID;
		SELF. lo_3_fein := '';
		SELF.lo_3_fname :=  lo_info[3].fname;
		SELF.lo_3_mname :=  lo_info[3].mname;
		SELF.lo_3_lname :=  lo_info[3].lname;
		SELF.lo_3_name_suffix :=  lo_info[3].name_suffix;
		format_addr1(lo_info[3],LO3addr1)
		format_addr2(lo_info[3],LO3addr2)
		SELF.lo_3_addr1 := LO3addr1;
		SELF.lo_3_addr2 := LO3addr2;
		SELF.lo_3_v_city_name := lo_info[3].v_city_name;
		SELF.	lo_3_city :=  lo_info[3].v_city_name;
		SELF.	lo_3_state :=  lo_info[3].st;
		format_zip(LO_info[3],LO3zip)
		SELF.	lo_3_zip := LO3zip;
		SELF.	lo_3_county :=  lo_info[3].county_name;		
    SELF.lo_3_UltID := lo_info[3].UltID;
		SELF.lo_3_OrgID := lo_info[3].OrgID;
		SELF.lo_3_SeleID := lo_info[3].SeleID;
		SELF.lo_3_ProxID := lo_info[3].ProxID;
		SELF.lo_3_PowID := lo_info[3].PowID;
		SELF.lo_3_EmpID := lo_info[3].EmpID;
		SELF.lo_3_DotID := lo_info[3].DotID;
																	 
		//Brand 1
		self.brand_date_1 := BR_info[1].brand_date;
		self.brand_state_1 := BR_info[1].brand_state;
		self.brand_code_1 := BR_info[1].brand_code;
		self.brand_type_1 := BR_info[1].brand_type;

		//Brand 2
		self.brand_date_2 := BR_info[2].brand_date;
		self.brand_state_2 := BR_info[2].brand_state;
		self.brand_code_2 := BR_info[2].brand_code;
		self.brand_type_2 := BR_info[2].brand_type;

		//Brand 3
		self.brand_date_3 := BR_info[3].brand_date;
		self.brand_state_3 := BR_info[3].brand_state;
		self.brand_code_3 := BR_info[3].brand_code;
		self.brand_type_3 := BR_info[3].brand_type;

		//Brand 4
		self.brand_date_4 := BR_info[4].brand_date;
		self.brand_state_4 := BR_info[4].brand_state;
		self.brand_code_4 := BR_info[4].brand_code;
		self.brand_type_4 := BR_info[4].brand_type;

		//Brand 5
		self.brand_date_5 := BR_info[5].brand_date;
		self.brand_state_5 := BR_info[5].brand_state;
		self.brand_code_5 := BR_info[5].brand_code;
		self.brand_type_5 := BR_info[5].brand_type;		
		
		SELF := if(exists(owner_info),owner_info[1]);
		SELF := if(exists(reg_info),reg_info[1]);
		SELF := if(exists(lh_info),lh_info[1]);
		SELF := if(exists(le_info),le_info[1]);
		SELF := if(exists(le_info),lo_info[1]);
		SELF.vendor_date := (STRING8) MAX(R(vendor_last_reported_date <> 0), vendor_last_reported_date);
		SELF.vendor_first_reported_date := (STRING8) MIN(R(vendor_first_reported_date <> 0), vendor_first_reported_date);
		SELF := IF(EXISTS(reg_info), PROJECT(reg_info,Layout_Report_Registration)[1],PROJECT(le_info,Layout_Report_Registration)[1]);
		SELF := IF(EXISTS(reg_info), PROJECT(reg_info,Layout_Report_Plate)[1],PROJECT(le_info,Layout_Report_Plate)[1]);
		SELF.penalt := MIN(R, min_party_penalty);
		SELF := L;
		// SELF := R;
		SELF := [];
	END;


	EXPORT get_flatLayout(DATASET(VehicleV2_Services.Layout_VKeysWithInput) in_veh_keys,
												BOOLEAN currentOnly = FALSE, BOOLEAN penalize_by_party = FALSE) := FUNCTION
		in_veh_keys_1 := GROUP(SORT(in_veh_keys, Vehicle_Key, Iteration_Key, Sequence_Key),
													 Vehicle_Key, Iteration_Key, Sequence_Key);
		in_mod := IParam.getSearchModule();
		veh_recsTmp := VehicleV2_Services.Functions.Get_VehicleSearch(in_mod, in_veh_keys_1, , penalize_by_party);
		veh_recs := IF(currentOnly, veh_recsTmp(is_current), veh_recsTmp);
		rpen := PROJECT(UNGROUP(veh_recs), xfm_Veh_recs(LEFT));
		rpen_s := SORT(rpen, acctno, Vehicle_Key, Iteration_Key, -is_current, Sequence_Key, -vendor_last_reported_date);
		rpen_d := DEDUP(rpen_s, acctno, Vehicle_Key, Iteration_Key, is_current, Sequence_Key, vendor_last_reported_date);
		rpen_g_AE := GROUP(rpen_d(source_code = 'AE' AND vendor_last_reported_date != vendor_first_reported_date), acctno, Vehicle_Key, Iteration_Key, is_current, vendor_last_reported_date);
		rpen_g_AE1 := GROUP(rpen_d(source_code = 'AE' AND vendor_last_reported_date = vendor_first_reported_date), acctno, Vehicle_Key, Iteration_Key, is_current, vendor_last_reported_date);
		rpen_g_DI := GROUP(rpen_d(source_code = 'DI'), acctno, Vehicle_Key, Iteration_Key, is_current, vendor_last_reported_date);	
		rpen_g_infutor := GROUP(rpen_d(source_code in MDR.sourceTools.set_infutor_all_veh), acctno, Vehicle_Key, Iteration_Key, is_current, vendor_last_reported_date);	
		//**** GET FLAT LAYOUT 
		out_noacctno := ROLLUP(rpen_g_AE, GROUP, xfm_out(LEFT, ROWS(LEFT)))
									  +
									  ROLLUP(rpen_g_AE1, GROUP, xfm_out(LEFT, ROWS(LEFT)))
									  +
									  ROLLUP(rpen_g_DI, GROUP, xfm_out(LEFT, ROWS(LEFT)))
										+
									  ROLLUP(rpen_g_infutor, GROUP, xfm_out(LEFT, ROWS(LEFT)));
		
		RETURN out_noacctno;
	END;



END;
