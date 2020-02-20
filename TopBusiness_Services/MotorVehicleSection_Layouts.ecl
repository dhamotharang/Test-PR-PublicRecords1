import BIPV2, Census_Data, iesp, Standard, VehicleV2;

export MotorVehicleSection_Layouts := module;

	export rec_ids_with_linkidsdata_slimmed := record
		BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;
	  TopBusiness_Services.Layouts.rec_common.source_docid;
	  //TopBusiness_Services.Layouts.rec_common.source_rec_id; //???

		// v--- other linkids key file fields needed to link to existing mvr key(s) or for sorting
	  VehicleV2.Layout_Base.Party_Base_BIP.Vehicle_key; // needed for linking to the mvr main & party keys
	  VehicleV2.Layout_Base.Party_Base_BIP.Iteration_key; // needed for linking to the mvr main & party keys
	  VehicleV2.Layout_Base.Party_Base_BIP.Sequence_key;  // needed or not for linking to the mvr party key
	  VehicleV2.Layout_Base.Party_Base_BIP.Date_Last_Seen;

		// v--- internal fields derived from certain linkids key fields
		string1 current_prior; // derived from History field into more descriptive field name.

		// v--- needed to pass total counts on to the next higher level records
	  unsigned4 total_current := 0; //default to zero
		unsigned4 total_prior   := 0; //default to zero
	end;		

  export rec_child_party := record
		BIPV2.IDlayouts.l_header_ids;
		// v--- new linkids key file fields needed to link to existing party key
		rec_ids_with_linkidsdata_slimmed.vehicle_key;   // needed for linking to the mvr linkids&main key
		rec_ids_with_linkidsdata_slimmed.iteration_key; // needed for linking to the mvr linkids&main key
		rec_ids_with_linkidsdata_slimmed.sequence_key;  // needed for linking to the mvr linkids key

    // v--- Party key fields used for report output; 
		// NOTE: vehicle party key also has title, registration & plate data.
    VehicleV2.Layout_Base_Party.State_Origin;

		// Name info fields
	  VehicleV2.Layout_Base_Party.Orig_Name_Type; // 1=Owner, 2=Lessor, 4=Registrant, 5=Lessee, 7=LienHolder
    //VehicleV2.Layout_Base_Party.orig_conjunction; //bip2, may be needed???
		string10 name_type_description;  // derived from orig_name_type
	  Standard.Name	Append_Clean_Name;
    VehicleV2.Layout_Base_Party.Append_Clean_CName;
    unsigned6 entity_id;	// store did or seleid(???) here to sort on common unique id field???

    // Address info fields
	  Standard.Addr	Append_Clean_Address;
    Census_Data.File_Fips2County.county_name;

    // Title info fields
	  VehicleV2.Layout_Base_Party.Ttl_Number;
	  //VehicleV2.Layout_Base_Party.Ttl_Earliest_Issue_Date; //???
	  VehicleV2.Layout_Base_Party.Ttl_Latest_Issue_Date;
	  //VehicleV2.Layout_Base_Party.Ttl_Previous_Issue_Date; //???

    // Registration/license plate info fields
	  VehicleV2.Layout_Base_Party.Reg_First_Date;
	  VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date;
	  VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;
	  VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;
	  //VehicleV2.Layout_Base_Party.Reg_Decal_Number; //???
	  //VehicleV2.Layout_Base_Party.Reg_Decal_Year; //???
	  //VehicleV2.Layout_Base_Party.Reg_Status_Desc; //???
	  //VehicleV2.Layout_Base_Party.Reg_True_License_Plate; //???
	  VehicleV2.Layout_Base_Party.Reg_License_Plate;
	  VehicleV2.Layout_Base_Party.Reg_License_State;
	  VehicleV2.Layout_Base_Party.Reg_License_Plate_Type_Desc;
	  //VehicleV2.Layout_Base_Party.Reg_Previous_License_State; //???
	  VehicleV2.Layout_Base_Party.Reg_Previous_License_Plate;

		// v--- Fields added for bug 150816, for the Accurint version of the new BIP Bus Comp Rpt
    VehicleV2.Layout_Base_Party.Reg_Decal_Year;
    VehicleV2.Layout_Base_Party.Ttl_Status_Desc;
    VehicleV2.Layout_Base_Party.Ttl_Odometer_Mileage;
		//VehicleV2.Layout_Base_Party.Ttl_Odometer_Status_Desc; //???
	  //VehicleV2.Layout_Base_Party.Ttl_Odometer_Date; //???
    // end of fields added for Bug 150816
		
		//source date added for infutor data	
		VehicleV2.Layout_Base_Party.SRC_FIRST_DATE;
		VehicleV2.Layout_Base_Party.SRC_LAST_DATE;

    string30 ReportedName;  // VehicleV2.Layout_Base_Party.raw_name 		
	end;

  export rec_parent_mvrdetail := record
	  BIPV2.IDlayouts.l_header_ids;
	  TopBusiness_Services.Layouts.rec_common.source;  // needed here???
	  TopBusiness_Services.Layouts.rec_common.source_docid;  //needed here???
	  //TopBusiness_Services.Layouts.rec_common.source_rec_id;  //needed here???
		// v--- new linkids key file fields needed to link to existing main key
		rec_ids_with_linkidsdata_slimmed.vehicle_key; //needed for linking to the mvr linkids & party keys
		rec_ids_with_linkidsdata_slimmed.iteration_key; //needed for linking to the mvr linkids & party keys
		rec_ids_with_linkidsdata_slimmed.sequence_key; //needed for linking to the mvr linkids & party keys

    // v--- main key vehicle info fields used for report output
    // Store either VINA (VIN decoded) fields and/or orig_* fields (used if vina fields empty) 
		// into common field names here.
	  string25 vin;  //car vins are only 17, but some original/trailer(etc.) vins could be more
	  //string30 vehicle_type; //vers1???
    VehicleV2.Layout_Base_Main.Orig_Vehicle_type_Desc; //vers2???
	  string4	 model_year;
 	  string36 make;
		string25 model_series; // may need to be longer if orig_model_desc(30) &orig_series_desc(25) are combined???
  	string25 style;
	  //string6  base_price; //vers1???
		VehicleV2.Layout_Base_Main.VINA_Price; //vers2???

    // v--- Fields added for bug 150816, for the Accurint version of the new BIP Bus Comp Rpt
		// Use main base layout names (---v) or use common names like done above???
		VehicleV2.Layout_Base_Main.State_Origin;
    VehicleV2.Layout_Base_Main.Orig_Major_Color_Desc; //??? not mentioned in bug, but might be needed for gui "Description:"???
		//??? or  VehicleV2.Layout_Base_Main.Best_Major_Color_Code; //???
    //VehicleV2.Layout_Base_Main.Orig_Minor_Color_Desc; //??? not mentioned in bug, but might be needed for gui "Description:"???
		//??? or  VehicleV2.Layout_Base_Main.Best_Minor_Color_Code; //???
    VehicleV2.Layout_Base_Main.Orig_Vehicle_Use_Desc;
    VehicleV2.Layout_Base_Main.VINA_VP_Restraint;
    VehicleV2.Layout_Base_Main.VINA_VP_Air_Conditioning;
    VehicleV2.Layout_Base_Main.VINA_VP_Power_Steering;
		VehicleV2.Layout_Base_Main.VINA_VP_Power_Brakes;
		VehicleV2.Layout_Base_Main.VINA_VP_Power_Windows;
		VehicleV2.Layout_Base_Main.VINA_VP_Tilt_Wheel;
		VehicleV2.Layout_Base_Main.VINA_VP_Roof;
		//VehicleV2.Layout_Base_Main.VINA_VP_Optional_Roof1_Desc;
	  //VehicleV2.Layout_Base_Main.VINA_VP_Optional_Roof2_Desc;
		VehicleV2.Layout_Base_Main.VINA_VP_Radio;
		//VehicleV2.Layout_Base_Main.VINA_VP_Optional_Radio1_Desc;
	  //VehicleV2.Layout_Base_Main.VINA_VP_Optional_Radio2_Desc;
	  //VehicleV2.Layout_Base_Main.VINA_VP_Transmission;
	  //VehicleV2.Layout_Base_Main.VINA_VP_Optional_Transmission1;
	  //VehicleV2.Layout_Base_Main.VINA_VP_Optional_Transmission2;
    VehicleV2.Layout_Base_Main.VINA_VP_Anti_Lock_Brakes;
		VehicleV2.Layout_Base_Main.VINA_VP_Front_Wheel_Drive;
		VehicleV2.Layout_Base_Main.VINA_VP_Four_Wheel_Drive;
		VehicleV2.Layout_Base_Main.VINA_VP_Security_System;
		VehicleV2.Layout_Base_Main.VINA_VP_Daytime_Running_Lights;
		// The following 3 fields make up the "Engine:" info in the gui???
		VehicleV2.Layout_Base_Main.VINA_Number_Of_Cylinders;
    VehicleV2.Layout_Base_Main.VINA_Engine_Size;
    VehicleV2.Layout_Base_Main.VINA_Fuel_Code; // explode  G=Gas, etc. into iesp output field
		boolean NonDMVSource := false;
		// Other fields that might be needed since they are output in current bcr mvrv2 section??? 
		// v--- here and some listed above, but commented out
		// See VehicleV2_Services.Functions.Layout_Report_out_veh, which uses
		//    VehicleV2_Services.Layout_Report_Vehicle ---v
	  //VehicleV2.Layout_Base_Main.Orig_Net_Weight;
	  //VehicleV2.Layout_Base_Main.Orig_Gross_Weight;
	  //VehicleV2.Layout_Base_Main.Orig_Number_Of_Axles;
    // end of fields added for Bug 150816

    // v--- needed to simulate revised iesp t_TopBusinessMotorVehicleDetail layout
		dataset(rec_child_party) Parties
       {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_MVR_PARTY_RECORDS)};	

		// v--- internal derived field(s)
		// v--- needed to pass info on to the next higher level records
	  unsigned4 total_current := 0; //default to zero
		unsigned4 total_prior   := 0; //default to zero
		string1 current_prior; //C=Current & P=Prior, built from linkids key History field
 end;

	export rec_ids_plus_MotorVehicleDetail := record
		 BIPV2.IDlayouts.l_header_ids;
	   TopBusiness_Services.Layouts.rec_common.source; 
	   TopBusiness_Services.Layouts.rec_common.source_docid;
		 rec_parent_mvrdetail.current_prior;
	   rec_parent_mvrdetail.total_current;
		 rec_parent_mvrdetail.total_prior;
     string8 display_order_date; 
		 iesp.topbusinessReport.t_TopbusinessMotorVehicleDetail;
	end;

	export rec_ids_plus_MotorVehicleSummary := record
	  TopBusiness_Services.Layouts.rec_input_ids.acctno;
		BIPV2.IDlayouts.l_header_ids;
	  rec_parent_mvrdetail.total_current;
		rec_parent_mvrdetail.total_prior;
		iesp.topbusinessReport.t_TopbusinessMotorvehicleSummary;
	end;		

	export rec_final := record
		TopBusiness_Services.Layouts.rec_input_ids.acctno;
		iesp.TopBusinessReport.t_TopBusinessMotorVehicleSection;
	end;		

end;
