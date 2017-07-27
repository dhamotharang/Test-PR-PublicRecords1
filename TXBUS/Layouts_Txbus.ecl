import Standard, address, BIPV2;

export Layouts_Txbus := module

  // Record Length 301
  export Layout_raw := record
			string11   Taxpayer_Number;
			string5    Outlet_Number;
			string50   Taxpayer_Name;
			string40   Taxpayer_Address;
			string20   Taxpayer_City;
			string2    Taxpayer_State;
			string5    Taxpayer_ZipCode;
			string3    Taxpayer_County_Code;
			string10   Taxpayer_Phone;
			string2    Taxpayer_Org_Type;
			string50   Outlet_Name;
			string40   Outlet_Address;
			string20   Outlet_City;
			string2    Outlet_State;
			string5    Outlet_ZipCode;
			string3    Outlet_County_Code;
			string10   Outlet_Phone;
			string6    Outlet_NAICS_Code;
			string1    Outlet_City_Limits_Indicator;
			string8    Outlet_Permit_Issue_Date;
			string8    Outlet_First_Sales_Date;
  end;
  
  export Layout_raw_crlf := record
			Layout_raw;
			string2 crlf;
  end;
  
  export Layout_Common := record
			string8   Process_date;
			string8   dt_first_seen;
			string8   dt_last_seen;
			Layout_raw;
			string75  Taxpayer_Org_Type_desc;
			string5   Taxpayer_title;
			string20  Taxpayer_fname;
			string20  Taxpayer_mname;
			string20  Taxpayer_lname;
			string5   Taxpayer_name_suffix;
			string3   Taxpayer_name_score; 
			string10 	Taxpayer_prim_range;         //Taxpayer clean address
			string2   Taxpayer_predir;
			string28 	Taxpayer_prim_name;
			string4   Taxpayer_addr_suffix;
			string2   Taxpayer_postdir;
			string10 	Taxpayer_unit_desig;
			string8   Taxpayer_sec_range;
			string25 	Taxpayer_p_city_name;
			string25 	Taxpayer_v_city_name;
			string2   Taxpayer_st;
			string5   Taxpayer_zip5;
			string4   Taxpayer_zip4;
			string4   Taxpayer_cart;
			string1   Taxpayer_cr_sort_sz;
			string4   Taxpayer_lot;
			string1   Taxpayer_lot_order;
			string2   Taxpayer_dpbc;
			string1   Taxpayer_chk_digit;
			string2   Taxpayer_addr_rec_type;
			string2   Taxpayer_fips_state;
			string3   Taxpayer_fips_county;
			string10 	Taxpayer_geo_lat;
			string11 	Taxpayer_geo_long;
			string4   Taxpayer_cbsa;
			string7   Taxpayer_geo_blk;
			string1   Taxpayer_geo_match;
			string4   Taxpayer_err_stat;	  
			string10 	outlet_prim_range;           //Outlet clean address
			string2   outlet_predir;
			string28 	outlet_prim_name;
			string4   outlet_addr_suffix;
			string2   outlet_postdir;
			string10 	outlet_unit_desig;
			string8   outlet_sec_range;
			string25 	outlet_p_city_name;
			string25 	outlet_v_city_name;
			string2   outlet_st;
			string5   outlet_zip5;
			string4   outlet_zip4;
			string4   outlet_cart;
			string1   outlet_cr_sort_sz;
			string4   outlet_lot;
			string1   outlet_lot_order;
			string2   outlet_dpbc;
			string1   outlet_chk_digit;
			string2   outlet_addr_rec_type;
			string2   outlet_fips_state;
			string3   outlet_fips_county;
			string10 	outlet_geo_lat;
			string11 	outlet_geo_long;
			string4   outlet_cbsa;
			string7   outlet_geo_blk;
			string1   outlet_geo_match;
			string4   outlet_err_stat;	 
  end;
	
	//** New layout defined for AID 
	export Layout_AID_Common := record
			unsigned8	raw_aid							:= 0;
			unsigned8	ace_aid							:= 0;
			unsigned8	mail_raw_aid				:= 0;
			unsigned8	mail_ace_aid				:= 0;
			string100 prep_addr_line1			 		;
			string50	prep_addr_line_last			;
			string100 prep_mail_addr_line1		;
			string50	prep_mail_addr_line_last;
			Layout_Common; 
  end;
			
  export Layout_Bdid := record
			unsigned6 bdid := 0;	  
			Layout_AID_Common;
			unsigned8 source_rec_id :=0 ;
			BIPV2.IDlayouts.l_xlink_ids ; 
  end;
  
	export Layout_Base := record
			unsigned6 did 					:= 0;
			unsigned1 did_score 		:= 0;
			string9		ssn 					:= '';
			Layout_Bdid;
  end;
	
	//** Layout that excludes the new AID fields for keys. 
	export Layout_Keys := record
			Layout_Base.did				;
			Layout_Base.did_score ;
			Layout_Base.ssn 			;
			Layout_Bdid.bdid			;
			Layout_Common					;
	end;
	
	export Layout_Autokeys := record
			Layout_Base.bdid;
			Layout_Base.did;
			Layout_Base.Taxpayer_Number;
			Layout_Base.Outlet_Number;
			string50  Name;
			Standard.L_Address.base addr;
			standard.Name taxpayerCleanName;
			string10  Phone;
			unsigned6 zero  := 0;
			string1   blank := '';
  end;
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Layout_AID_Temp :=record
			unsigned8	unique_id;
			Layout_AID_Common	 ;			
	end;
		
	export Layout_AID_Clean_Temp :=record
			string1 		addr_type 		:= ''	;
			unsigned8		unique_id						;
			string100 	prep_addr_line1			;
			string50		prep_addr_line_last	;
			unsigned8		raw_aid				:= 0	;
			unsigned8		ace_aid				:= 0	;
			address.Layout_Clean182_fips Clean_Addr;			
  end;
end;