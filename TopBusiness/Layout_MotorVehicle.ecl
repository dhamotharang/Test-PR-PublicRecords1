import Standard;

export Layout_MotorVehicle := module

 export main := module
	
  export Unlinked := record
		string2  source;       // 'MV'
		string50 source_docid; // Vehicle_Key OR orig_VIN from vehiclev2 main file ???
		string2  vendor; // only on party recs; vehicle data supplier source code - AE=Experian, DI=Direct from state; not needed ???
		string25 vehicle_id;
		// v--- fields from the base vehiclev2 main file
		string30 VIN; // orig_VIN from vehiclev2 main file
		//string?? Vehicle_Class; // Per the specs output Vehicle_Class, but no such field
		                          // exists.  Mentioned to Tim B on 04/11/11.  
															// I suspect he really wants Vehicle_Type, so used it below.
															// But he might want Vehicle_Use instead ???
	  string30 Vehicle_Type; // Orig_Vehicle_Type_Desc;
		//string30 Vehicle_Use;  // Orig_Vehicle_Use_Desc;		
	  string4	 Model_Year;   // VINA_Model_Year;
	  string36 Make;         // VINA_Make_Desc;
	  string25 Series;       // VINA_VP_Series_Name; // contains model & series info combined, i..e Civic LX
	  string25 Style;        // VINA_Body_Style_Desc;
	  string6  Base_Price;   // VINA_Price;
  end;

	export Linked := record
		unsigned6 bid;
		string1 current_prior;
		unsigned4 key_date_9999;
		string1   party_type;
		Unlinked;
	end;

 end; // end of main module
 
 export Registration := record
		string2 vendor;
		string25 vehicle_id;
		string30 event_id;
	  string2  State_Jurisdiction; // State_Origin 
	  string8  Original_Registration_Date;   // Reg_First_Date if not blnak, otherwise use Reg_Earliest_Effective_Date ???
	  string8  Registration_Date;            // Reg_Latest_Effective_Date
	  string8  Registration_Expiration_Date; // Reg_Latest_Expiration_Date
	  string10 License_Plate;          // Reg_License_Plate
	  string65 License_Plate_Type;     // Reg_License_Plate_Type_Desc
	  string10 Previous_License_Plate; // Reg_Previous_License_Plate
	end;

 export Title := record
		string2 vendor;
		string25 vehicle_id;
		string30 event_id;
	  string2  State_Jurisdiction; // State_Origin 
	  string20 Title_Number; // Ttl_Number
	  string8  Title_Date;   // Ttl_Latest_Issue_Date
 end;
 
 export party := record
	
		string30  event_id;
		string2  vendor; // AE=Experian; DI=Direct, needed since reg/title info exists for both sources ???
		// v--- fields from the base vehiclev2 party file
		string1	 party_type;  // from orig_name_type: 1=Owner, 2=Lessor, 4=Registrant, 5=Lessee, 7=LienHolder
		string10 party_type_description; // not on base party file, but will be mapped at extract time
		string70 company_name;
		string5  title;  // ???
		string20 fname;
		string20 mname;
		string20 lname;
		string5  name_suffix;
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  addr_suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		string25 city_name;
		string2  st;
		string5  zip5;
		string4  zip4;
		unsigned6 did;
		unsigned4 ssn;
		string1 history;
	end;
	
/*   // temp combined layout to assist in extracting data in MotorVehicle_AsMasters
     export party_main_slimmed := record
       // v--- fields from both the main & party file
    	  string30 Vehicle_Key; 
   	  //string15 Iteration_Key;
   		string2  Source_code;
   	  string2	 State_Origin;
       // v--- fields from party file
   	  //string15 Sequence_Key;
   		string1  History;
   	  string1	 orig_name_type;
   	  Standard.Name	Append_Clean_Name;
   	  string70 Append_Clean_CName;
   	  Standard.Addr	Append_Clean_Address;
   	  string8  Reg_First_Date;
   		string8  Reg_Earliest_Effective_Date;
   	  string8  Reg_Latest_Effective_Date;
   	  string8  Reg_Latest_Expiration_Date;
   	  string10 Reg_License_Plate;
   	  string2  Reg_License_State;
   	  string10 Reg_Previous_License_Plate;
   	  string20 Ttl_Number;
   	  string8  Ttl_Latest_Issue_Date;
   		// v--- fields from the main file
   	  string25 Orig_VIN;
   	  string30 Orig_Vehicle_Type_Desc;
   		string25 VINA_VP_Series_Name;
   	  string4	 VINA_Model_Year;
   	  string36 VINA_Make_Desc;
   	  string25 VINA_Body_Style_Desc;
   	  string6  VINA_Price;
     end;
*/
	
end;

/* existing VehicleV2 base main & base party file layouts:
VehicleV2.Layout_Base_Main
export Layout_Base_Main := record
	string30		Vehicle_Key;
	string15		Iteration_Key;
	string2			Source_Code;
	string2			State_Origin;
	unsigned8		State_Bitmap_Flag;
	string25		Orig_VIN;
	string4			Orig_Year;
	string5			Orig_Make_Code;
	string36		Orig_Make_Desc;
	string3			Orig_Series_Code;
	string25		Orig_Series_Desc;
	string3			Orig_Model_Code;
	string30		Orig_Model_Desc;
	string5			Orig_Body_Code;
	string20		Orig_Body_Desc;
	string6     Orig_Net_Weight;
	string6     Orig_Gross_Weight;
  string1     Orig_Number_Of_Axles;
	string1     Orig_Vehicle_Use_code;
	string30    Orig_Vehicle_Use_Desc;
	string5			Orig_Vehicle_Type_Code;
	string30		Orig_Vehicle_Type_Desc;
	string3			Orig_Major_Color_Code;
	string15		Orig_Major_Color_Desc;
	string3			Orig_Minor_Color_Code;
	string15		Orig_Minor_Color_Desc;
	string1 		VINA_Veh_Type;
	string5 		VINA_NCIC_Make;
	string2 		VINA_Model_Year_YY;
	string17		VINA_VIN;
	string1 		VINA_VIN_Pattern_Indicator;
	string1 		VINA_Bypass_Code;
	string1 		VINA_VP_Restraint;
	string4 		VINA_VP_Abbrev_Make_Name;
	string2 		VINA_VP_Year;
	string3 		VINA_VP_Series;
	string3 		VINA_VP_Model;
	string1 		VINA_VP_Air_Conditioning;
	string1 		VINA_VP_Power_Steering;
	string1 		VINA_VP_Power_Brakes;
	string1 		VINA_VP_Power_Windows;
	string1 		VINA_VP_Tilt_Wheel;
	string1 		VINA_VP_Roof;
	string1 		VINA_VP_Optional_Roof1;
	string1 		VINA_VP_Optional_Roof2;
	string1 		VINA_VP_Radio;
	string1 		VINA_VP_Optional_Radio1;
	string1 		VINA_VP_Optional_Radio2;
	string1 		VINA_VP_Transmission;
	string1 		VINA_VP_Optional_Transmission1;
	string1 		VINA_VP_Optional_Transmission2;
	string1 		VINA_VP_Anti_Lock_Brakes;
	string1 		VINA_VP_Front_Wheel_Drive;
	string1 		VINA_VP_Four_Wheel_Drive;
	string1 		VINA_VP_Security_System;
	string1 		VINA_VP_Daytime_Running_Lights;
	string25		VINA_VP_Series_Name;
	string4 		VINA_Model_Year;
	string3 		VINA_Series;
	string3 		VINA_Model;
	string2 		VINA_Body_Style;
	string36		VINA_Make_Desc;
	string36		VINA_Model_Desc;
	string25		VINA_Series_Desc;
	string25		VINA_Body_Style_Desc;
	string2 		VINA_Number_Of_Cylinders;
	string4 		VINA_Engine_Size;
	string1 		VINA_Fuel_Code;
	string6 		VINA_Price;
	string5			Best_Make_Code;
	string3			Best_Series_Code;
	string3			Best_Model_Code;
	string5			Best_Body_Code;
	string4			Best_Model_Year;
	string3			Best_Major_Color_Code;
	string3			Best_Minor_Color_Code;
 end;

VehicleV2.Layout_Base_Party
export Layout_Base_Party := record
	string30		Vehicle_Key;
	string15		Iteration_Key;
	string15		Sequence_Key;
	string2			Source_Code;
	string2			State_Origin;
	unsigned8		State_Bitmap_Flag;
	string1			Latest_Vehicle_Flag;
	string1			Latest_Vehicle_Iteration_Flag;
	string1			History;
	unsigned3		Date_First_Seen;
	unsigned3		Date_Last_Seen;
	unsigned3		Date_Vendor_First_Reported;
	unsigned3		Date_Vendor_Last_Reported;
	string1			Orig_Party_Type;
	string1			Orig_Name_Type;
	string10		Orig_Conjunction;
	string70		Orig_Name;
	string70		Orig_Address;
	string35		Orig_City;
	string2			Orig_State;
	String30    orig_province;
  String30    orig_country;
	string10		Orig_Zip;
	string9			Orig_SSN;
	string9			Orig_FEIN;
	string20		Orig_DL_Number;
	string8			Orig_DOB;
	string1			Orig_Sex;
	string8			Orig_Lien_Date;
	Standard.Name	Append_Clean_Name; ---v
    export Name := RECORD
	    STRING5  title;
	    STRING20 fname;
	    STRING20 mname;
	    STRING20 lname;
	    STRING5  name_suffix;
	    STRING3  name_score;
    END;
	string70		Append_Clean_CName;
	Standard.Addr	Append_Clean_Address; ---v
    export Addr := RECORD
	    string10 prim_range ;
	    string2  predir ;
	    string28 prim_name ;
	    string4  addr_suffix ;
	    string2  postdir ;
	    string10 unit_desig ;
	    string8  sec_range ;
	    string25 v_city_name ;
	    string2  st ;
	    string5  zip5 ;
	    string4  zip4 ;
	    string2  addr_rec_type := '';
	    string2  fips_state;
	    string3  fips_county;
	    string10 geo_lat ;
	    string11 geo_long ;
	    string4  cbsa ;
	    string7  geo_blk ;
	    string1  geo_match ;
	    string4  err_stat;
    END;
	unsigned6		Append_DID;						// overload BDID here and use Orig_Name_Type to determine which?
	unsigned1		Append_DID_Score;				// overload BDID_Score here and use Orig_Name_Type to determine which?
	unsigned6		Append_BDID;
	unsigned1		Append_BDID_Score;
  string20		Append_DL_Number;
	string9			Append_SSN;						// overload FEIN here and use Orig_Name_Type to determine which?
	string9			Append_FEIN;
	string8     Append_DOB;
	string8			Reg_First_Date;
	string8			Reg_Earliest_Effective_Date;
	string8			Reg_Latest_Effective_Date;
	string8			Reg_Latest_Expiration_Date;
	unsigned1		Reg_Rollup_Count;
	string10		Reg_Decal_Number;
	string4			Reg_Decal_Year;
	string1			Reg_Status_Code;
	string20		Reg_Status_Desc;
	string10		Reg_True_License_Plate;
	string10		Reg_License_Plate;
	string2			Reg_License_State;
	string4			Reg_License_Plate_Type_Code;
	string65		Reg_License_Plate_Type_Desc;
	string2			Reg_Previous_License_State;
	string10		Reg_Previous_License_Plate;
	string20		Ttl_Number;
	string8			Ttl_Earliest_Issue_Date;
	string8			Ttl_Latest_Issue_Date;
	string8			Ttl_Previous_Issue_Date;
	unsigned1		Ttl_Rollup_Count;
	string2			Ttl_Status_Code;
	string48		Ttl_Status_Desc;
	string7			Ttl_Odometer_Mileage;
	string1			Ttl_Odometer_Status_Code;
	string42		Ttl_Odometer_Status_Desc;
	string8			Ttl_Odometer_Date;
 end;
*/