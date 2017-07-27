import VehicleV2;

export layout_vehicle_party_out := module

	export layout_standard_name := record
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5  name_suffix;
	end;
	
	export layout_standard_address := record
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  addr_suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		string25 v_city_name;
		string2  st;
		string5  zip5;
		string4  zip4;
	end;
	
	export layout_vehicle_party_registrant := record
		unsigned2 party_penalty;                         
		VehicleV2.Layout_Base_Party.Sequence_Key;
		VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;  
		string30 history_desc;
	     layout_standard_name;
		layout_standard_address;
	     string18  county_name;                            
		VehicleV2.Layout_Base_Party.orig_name;
	     VehicleV2.Layout_Base_Party.Orig_DL_Number;       
	     VehicleV2.Layout_Base_Party.Orig_DOB;             
	     VehicleV2.Layout_Base_Party.Orig_Sex; 
		string10 orig_sex_desc;
		VehicleV2.Layout_Base_Party.Orig_SSN;
		VehicleV2.Layout_Base_Party.Orig_Fein;
	     VehicleV2.Layout_Base_Party.Append_Clean_CName;   
	     VehicleV2.Layout_Base_Party.Append_DID;
	     VehicleV2.Layout_Base_Party.Append_BDID;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Append_Fein;
	     VehicleV2.Layout_Base_Party.Reg_First_Date;            
	     VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date; 
	     VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;   
	     VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;  
	     VehicleV2.Layout_Base_Party.Reg_Decal_Number;            
	     VehicleV2.Layout_Base_Party.Reg_Decal_Year;              
	     VehicleV2.Layout_Base_Party.Reg_Status_Desc;             
	     vehiclev2_services.Layout_Report_Plate;
			 VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
			 VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
	end;

	export layout_vehicle_party_owner := record
		unsigned2 party_penalty;                    
		VehicleV2.Layout_Base_Party.Sequence_Key;
		VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag; 
		string30 history_desc;
	     layout_standard_name;
		layout_standard_address;
	     string18  county_name;                           
		VehicleV2.Layout_Base_Party.orig_name;
	     VehicleV2.Layout_Base_Party.Orig_DL_Number;      
	     VehicleV2.Layout_Base_Party.Orig_DOB;            
	     VehicleV2.Layout_Base_Party.Orig_Sex; 
		string10 orig_sex_desc;
		VehicleV2.Layout_Base_Party.Orig_SSN;
		VehicleV2.Layout_Base_Party.Orig_Fein;
	     VehicleV2.Layout_Base_Party.Append_Clean_CName;  
	     VehicleV2.Layout_Base_Party.Append_DID;
	     VehicleV2.Layout_Base_Party.Append_BDID;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Append_Fein;
		vehiclev2_services.Layout_Report_Title;
		VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
		VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
		VehicleV2.Layout_Base_Party.SRC_FIRST_DATE;
		VehicleV2.Layout_Base_Party.SRC_LAST_DATE;
	end;
	
	export layout_vehicle_party_lienholder := record
		unsigned2 party_penalty;                      
	     VehicleV2.Layout_Base_Party.Orig_Party_Type;
		VehicleV2.Layout_Base_Party.Sequence_Key;
		VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag;  
		string30 history_desc;
	     layout_standard_name;
		layout_standard_address;
	     string18  county_name;                            
		VehicleV2.Layout_Base_Party.orig_name;
	     VehicleV2.Layout_Base_Party.Orig_DL_Number;       
	     VehicleV2.Layout_Base_Party.Orig_DOB;             
	     VehicleV2.Layout_Base_Party.Orig_Sex; 
		string10 orig_sex_desc;
		VehicleV2.Layout_Base_Party.Orig_SSN;
		VehicleV2.Layout_Base_Party.Orig_Fein;
		VehicleV2.Layout_Base_Party.Orig_Lien_Date;
	     VehicleV2.Layout_Base_Party.Append_Clean_CName;  
	     VehicleV2.Layout_Base_Party.Append_DID;
	     VehicleV2.Layout_Base_Party.Append_BDID;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Append_Fein;
		VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
		VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
	end;

     export layout_vehicle_party_lessor := record
		unsigned2 party_penalty;                         
	     VehicleV2.Layout_Base_Party.Orig_Party_Type;
		VehicleV2.Layout_Base_Party.Sequence_Key;
		VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag; 
		string30 history_desc;
	     layout_standard_name;
		layout_standard_address;
	     string18  county_name;                           
		VehicleV2.Layout_Base_Party.orig_name;
	     VehicleV2.Layout_Base_Party.Orig_DL_Number;      
	     VehicleV2.Layout_Base_Party.Orig_DOB;            
	     VehicleV2.Layout_Base_Party.Orig_Sex; 
		string10 orig_sex_desc;
		VehicleV2.Layout_Base_Party.Orig_SSN;
		VehicleV2.Layout_Base_Party.Orig_Fein;
	     VehicleV2.Layout_Base_Party.Append_Clean_CName;  
	     VehicleV2.Layout_Base_Party.Append_DID;
	     VehicleV2.Layout_Base_Party.Append_BDID;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Append_Fein;
		VehicleV2.Layout_Base_Party.Date_Vendor_first_Reported;
		VehicleV2.Layout_Base_Party.Date_Vendor_Last_Reported;
	end;
	
	export layout_vehicle_party_lessee := record
		layout_vehicle_party_lessor;
			 VehicleV2.Layout_Base_Party.Reg_First_Date;            
	     VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date; 
	     VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;   
	     VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;  
	     VehicleV2.Layout_Base_Party.Reg_Decal_Number;            
	     VehicleV2.Layout_Base_Party.Reg_Decal_Year;              
	     VehicleV2.Layout_Base_Party.Reg_Status_Desc;             
	     vehiclev2_services.Layout_Report_Plate;	
		end;	 
end;