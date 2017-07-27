import TXBUS,doxie,census_data;

doxie.MAC_Header_Field_Declare()	

export get_Txbus(dataset(TxbusV2_services.layout_search_IDs) in_TaxPayer_Nums,
			string in_ssn_mask_type = '',boolean is_Search =TRUE) := Module

	
	shared Tax_key := TXBUS.Key_Txbus_Taxpayer_Nbr;

	
	shared base_layout := record
		boolean isDeepDive;
		unsigned2 penalt_addr;
		unsigned2 penalt_addrb;
		unsigned2 penalt_phone;
		unsigned2 penalt_phoneb;
		unsigned2 penalt_bdid;
		unsigned2 penalt_did;
		unsigned2 penalt_cname;
		unsigned2 penalt_name;
		unsigned2 penalt;
		Txbus.Layouts_Txbus.Layout_Base.Taxpayer_Number;
		Layout_Outlet;
		Layout_taxpayer;
		dataset(Layout_Outlet) Outlet {maxcount(25)};
	END;
	
	
	shared base_layout get_TXBUS_r(in_TaxPayer_Nums l,tax_Key r) := transform
		min2(unsigned2 a,unsigned2 b) :=if(a<b,a,b);		

		
		self.penalt_addrb := doxie.FN_Tra_Penalty_Addr(r.outlet_predir,r.outlet_prim_range,r.outlet_prim_name,
				r.outlet_addr_suffix,r.outlet_postdir,r.outlet_sec_range,r.outlet_v_city_name,r.outlet_state,r.outlet_zip5);
		self.penalt_addr := doxie.FN_Tra_Penalty_Addr(r.taxpayer_predir,r.taxpayer_prim_range,r.taxpayer_prim_name,
				r.taxpayer_addr_suffix,r.taxpayer_postdir,r.taxpayer_sec_range,r.taxpayer_v_city_name,r.taxpayer_state,r.taxpayer_zip5);
			self.penalt_bdid :=		doxie.FN_Tra_Penalty_bdid((string) r.bdid);
			self.penalt_did :=		doxie.FN_Tra_Penalty_did((string) r.did);
			self.penalt_cname := Doxie.FN_Tra_Penalty_CName(r.outlet_name);
			self.penalt_name := Doxie.FN_Tra_Penalty_Name(r.Taxpayer_fname,r.Taxpayer_mname,r.Taxpayer_lname);
			self.penalt_phoneb := Doxie.Fn_Tra_Penalty_Phone(r.Outlet_Phone);
			self.penalt_phone  := Doxie.Fn_Tra_Penalty_Phone(r.taxpayer_phone);

		self.Outlet := project(R,transform(Layout_Outlet,self:=left,self.Outlet_county_desc :=
		Census_Data.Key_Fips2County(state_code=left.outlet_st and county_fips=
		left.outlet_fips_county)[1].county_name
		));
		
		self.Taxpayer_county_desc := Census_Data.Key_Fips2County(state_code=r.Taxpayer_st and county_fips=
		r.Taxpayer_fips_county)[1].county_name;	
		self := R;
		self := [];
	END;
	
	

	shared with_payload_base := join(in_TaxPayer_Nums, tax_Key,keyed(left.taxpayer_number =right.taxpayer_number), 
																			get_TXBUS_r(left,right),keep(100));
	
	
	

	shared base_layout do_roll_outlet(base_layout l,dataset(base_layout) r) := transform
		ri := topn(r,25,penalt_bdid + penalt_cname+penalt_phoneb+penalt_addrb);
		self.outlet := ri.outlet;
		self.penalt_bdid := min(ri,penalt_bdid);
		self.penalt_phoneb := min(ri,penalt_phoneb);
		self.penalt_cname := min(ri,penalt_cname);
		self.penalt_addrb := min(ri,penalt_addrb);
		self := l;
	END;

	
	shared dup_taxpayers := dedup(sort(with_payload_base,penalt_did+penalt_name+penalt_phone+penalt_addr,
	Taxpayer_number,	-dt_last_seen,-dt_first_seen,-Taxpayer_Name,-Taxpayer_Address,-Taxpayer_City,-Taxpayer_State,-Taxpayer_ZipCode,-Taxpayer_County_Code,
	-Taxpayer_Phone,-Taxpayer_Org_Type, -Taxpayer_Org_Type_desc,-Taxpayer_title,-Taxpayer_fname,-Taxpayer_mname,
	-Taxpayer_lname),taxpayer_number);
	
	shared sorted_outlets :=sort(with_payload_base,penalt_bdid+penalt_cname+penalt_phoneb+penalt_addrb,
	taxpayer_number,-Outlet_Name,-Outlet_Address,-Outlet_City,-Outlet_State,-Outlet_ZipCode,-Outlet_County_Code,
	-Outlet_Phone,-dt_last_seen,-dt_first_seen, Outlet_NAICS_Code,Outlet_City_Limits_Indicator,Outlet_Permit_Issue_Date,Outlet_First_Sales_Date);
	
	
	shared pre_roll_outlets := group(
	sort(if(is_search,dedup(sorted_outlets,taxpayer_number,Outlet_Name,Outlet_Address,Outlet_City,
	Outlet_State,Outlet_ZipCode,Outlet_County_Code,Outlet_Phone),dedup(sorted_outlets,
	taxpayer_number,Outlet_Name,Outlet_Address,Outlet_City,Outlet_State,Outlet_ZipCode,Outlet_County_Code,
	Outlet_Phone,Outlet_NAICS_Code,Outlet_City_Limits_Indicator,Outlet_Permit_Issue_Date,Outlet_First_Sales_Date)),taxpayer_number),taxpayer_number);
														
	
	shared rolled_outlets := rollup(pre_roll_outlets,group,do_roll_outlet(LEFT,rows(left)));
	
	shared base_layout get_both(base_layout l,base_layout r) := transform
		self.outlet := r.outlet;
		mac_PickPenalty(l.penalt_phone,l.penalt_addr,l.penalt_name,l.penalt_did, r.penalt_phoneb,r.penalt_addrb,r.penalt_cname,r.penalt_bdid)
		self := l;
	END;
	

	
	
	shared outlet_w_taxpayers := join(dup_taxpayers, rolled_outlets,
		left.taxpayer_number = right.taxpayer_number, get_both(left,right),
		full outer,limit(1));
	
	shared res := project(outlet_w_taxpayers,TXBUSV2_Services.Layout_Search);
								
	export searchorReport := res;

END;