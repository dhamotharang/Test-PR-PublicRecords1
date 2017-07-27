IMPORT iesp,VehicleV2_Services;

// set party info from standard esdl structure
MAC_SetPartyInfo (Src) := MACRO
  // Name
  SELF.fname := Src.Name.First;
  SELF.mname := Src.Name.Middle;
  SELF.lname := Src.Name.Last;
  SELF.name_suffix := Src.Name.suffix;
  // Address
  SELF.prim_range := Src.Address.StreetNumber;
  SELF.predir := Src.Address.StreetPreDirection;
  SELF.prim_name := Src.Address.StreetName;
  SELF.addr_suffix := Src.Address.StreetSuffix;
  SELF.postdir := Src.Address.StreetPostDirection;
  SELF.unit_desig := Src.Address.UnitDesignation;
  SELF.sec_range := Src.Address.UnitNumber;
  SELF.v_city_name := Src.Address.City;
  SELF.st := Src.Address.State;
  SELF.zip5 := Src.Address.Zip5;
  SELF.zip4 := Src.Address.Zip4;
  SELF.county_name := Src.Address.County;
  SELF.Orig_name := '';
  SELF.Orig_DL_Number := Src.DriverLicenseNumber;
  SELF.Orig_DOB := iesp.ECL2ESP.t_DateToString8(Src.DOB);
  SELF.Orig_Sex := ''; 
  SELF.Orig_sex_desc := Src.Gender;
  SELF.Orig_SSN := Src.SSN;   
  SELF.Append_Clean_CName := Src.BusinessName;
  SELF.Append_DID := Src.UniqueId;
  SELF.Append_BDID := Src.BusinessId;
	self.DotID := Src.BusinessIds.dotid;
	self.EmpID := Src.BusinessIds.empid;
	self.POWID := Src.BusinessIds.powid;
	self.ProxID := Src.BusinessIds.proxid;
	self.SELEID := Src.BusinessIds.seleid;  
	self.OrgID := Src.BusinessIds.orgid;
	self.UltID := Src.BusinessIds.ultid;
  SELF.Append_SSN := Src.AppendSSN;
  SELF.age := (STRING)Src.Age;
ENDMACRO;

EXPORT vehicleV2_transform_records_crs (DATASET(iesp.motorvehicle.t_MotorVehicleReport2Record) iespMvrRpt2) := FUNCTION

	VehicleV2_Services.assorted_layouts.Layout_registrant setRegistrants(iesp.motorvehicle.t_MotorVehicleReportRegistrant L) := TRANSFORM
		SELF.party_penalty := 0;
		SELF.Sequence_Key := '';
		SELF.Latest_Vehicle_Flag := ''; 
		SELF.history_desc := L.HistoryDescription;

    MAC_SetPartyInfo (L.RegistrantInfo);

		// RegistrationInfo
		SELF.Reg_First_Date := iesp.ECL2ESP.t_DateToString8(L.RegistrationInfo.FirstDate);
		SELF.Reg_Earliest_Effective_Date := iesp.ECL2ESP.t_DateToString8(L.RegistrationInfo.EarliestEffectiveDate);
		SELF.Reg_Latest_Effective_Date := iesp.ECL2ESP.t_DateToString8(L.RegistrationInfo.LatestEffectiveDate);
		SELF.Reg_Latest_Expiration_Date := iesp.ECL2ESP.t_DateToString8(L.RegistrationInfo.LatestExpirationDate);
		SELF.Reg_Decal_Number := L.RegistrationInfo.DecalNumber; 
		SELF.Reg_Decal_Year := L.RegistrationInfo.DecalYear;
		SELF.Reg_Status_Desc := L.RegistrationInfo.StatusDesc;
		SELF.Reg_True_License_Plate := L.RegistrationInfo.TrueLicensePlate;
		SELF.Reg_License_Plate := L.RegistrationInfo.LicensePlate;
		SELF.Reg_License_Plate_Type_Code := L.RegistrationInfo.LicensePlateTypeCode;
		SELF.Reg_License_Plate_Type_Desc := L.RegistrationInfo.LicensePlateTypeDesc;
		SELF.Reg_License_State := L.RegistrationInfo.LicenseState;
		SELF.Reg_Previous_License_Plate := L.RegistrationInfo.PreviousLicensePlate;
		SELF.Reg_Previous_License_State := L.RegistrationInfo.PreviousLicenseState;

		SELF.Date_Vendor_first_Reported := 0;
		SELF.Date_Vendor_Last_Reported := 0;

		SELF.matchFlags.surnameFlag := '';  
		SELF.matchFlags.fullNameFlag := '';  
		SELF.matchFlags.addressMatchFlag := '';
		SELF := [];
	END;

	VehicleV2_Services.assorted_layouts.Layout_owner setOwners(iesp.motorvehicle.t_MotorVehicleReportOwner L) := TRANSFORM
		SELF.party_penalty := 0;
		SELF.Sequence_Key := '';
		SELF.Latest_Vehicle_Flag := '';
		SELF.history_desc := L.HistoryDescription;

    MAC_SetPartyInfo (L.OwnerInfo);

		// TitleInfo
		SELF.Ttl_Number := L.TitleInfo.Number;
		SELF.Ttl_Earliest_Issue_Date := iesp.ECL2ESP.t_DateToString8(L.TitleInfo.EarliestIssueDate);
		SELF.Ttl_Latest_Issue_Date := iesp.ECL2ESP.t_DateToString8(L.TitleInfo.LatestIssueDate);
		SELF.Ttl_Previous_Issue_Date := iesp.ECL2ESP.t_DateToString8(L.TitleInfo.PreviousIssueDate);
		SELF.Ttl_Status_Code := L.TitleInfo.StatusCode;
		SELF.Ttl_Status_Desc := L.TitleInfo.StatusDesc;
		SELF.Ttl_Odometer_Mileage := (STRING)L.TitleInfo.OdometerMileage;

		SELF.Date_Vendor_first_Reported := 0;
		SELF.Date_Vendor_Last_Reported := 0;

		SELF.matchFlags.surnameFlag := '';
		SELF.matchFlags.fullNameFlag := '';
		SELF.matchFlags.addressMatchFlag := '';
		SELF := [];
	END;

	VehicleV2_Services.assorted_layouts.Layout_lienholder setLienholders(iesp.motorvehicle.t_MotorVehicleReportLienHolder L) := TRANSFORM
		SELF.party_penalty := 0;
		SELF.Orig_Party_Type := '';
		SELF.Sequence_Key := '';
		SELF.Latest_Vehicle_Flag := '';
		SELF.history_desc := L.HistoryDescription;

    MAC_SetPartyInfo (L.LienHolderInfo);

		// LienHolderInfo
		SELF.Orig_lien_date := iesp.ECL2ESP.t_DateToString8(L.LienDate);

		SELF.Date_Vendor_first_Reported := 0;
		SELF.Date_Vendor_Last_Reported := 0;

		SELF.matchFlags.surnameFlag := '';
		SELF.matchFlags.fullNameFlag := '';
		SELF.matchFlags.addressMatchFlag := '';
		SELF.std_lienholder_name := L.StandardizedName;
		SELF := [];
	END;

	VehicleV2_Services.assorted_layouts.Layout_lessee setLessees(iesp.motorvehicle.t_MotorVehicleReportLessee L) := TRANSFORM
		SELF.party_penalty := 0;
		SELF.Orig_Party_Type := '';
		SELF.Sequence_Key := '';
		SELF.Latest_Vehicle_Flag := '';
		SELF.history_desc := L.HistoryDescription;

    MAC_SetPartyInfo (L.LesseeInfo);

		SELF.Reg_First_Date := '';
		SELF.Reg_Earliest_Effective_Date := '';
		SELF.Reg_Latest_Effective_Date := '';
		SELF.Reg_Latest_Expiration_Date := '';
		SELF.Reg_Decal_Number := '';
		SELF.Reg_Decal_Year := '';
		SELF.Reg_Status_Desc := '';
		SELF.Reg_True_License_Plate := '';
		SELF.Reg_License_Plate := '';
		SELF.Reg_License_Plate_Type_Code := '';
		SELF.Reg_License_Plate_Type_Desc := '';
		SELF.Reg_License_State := '';
		SELF.Reg_Previous_License_Plate := '';
		SELF.Reg_Previous_License_State := '';

		SELF.Date_Vendor_first_Reported := 0;
		SELF.Date_Vendor_Last_Reported := 0;

		SELF.matchFlags.surnameFlag := '';
		SELF.matchFlags.fullNameFlag := '';
		SELF.matchFlags.addressMatchFlag := '';
		SELF := [];
	END;

	VehicleV2_Services.assorted_layouts.layout_lessee_or_lessor setLessors(iesp.motorvehicle.t_MotorVehicleReportLessor L) := TRANSFORM
		SELF.party_penalty := 0;
		SELF.Orig_Party_Type := '';
		SELF.Sequence_Key := '';
		SELF.Latest_Vehicle_Flag := '';
		SELF.history_desc := L.HistoryDescription;

    MAC_SetPartyInfo (L.LessorInfo);

		SELF.Date_Vendor_first_Reported := 0;
		SELF.Date_Vendor_Last_Reported := 0;

		SELF.matchFlags.surnameFlag := '';
		SELF.matchFlags.fullNameFlag := '';
		SELF.matchFlags.addressMatchFlag := '';
		SELF := [];
	END;

	VehicleV2_Services.assorted_layouts.layout_brand setBrands(iesp.motorvehicle.t_MotorVehicleSearchBrand L) := TRANSFORM
		SELF.brand_date := iesp.ECL2ESP.t_DateToString8(L.Date),
		SELF.brand_state := L.State,
		SELF.brand_code := L.Code,
		SELF.brand_type := L._Type			
	END;

	VehicleV2_Services.Layout_Report toVehV2Rpt(iesp.motorvehicle.t_MotorVehicleReport2Record L) := TRANSFORM
		SELF.is_current := TRUE;
		SELF.min_party_penalty := 0;
		SELF.DataSource := L.DataSource;
		SELF.NonDMVSource := L.NonDMVSource;

		// VehicleInfo
		SELF.Vehicle_Key := L.VehicleInfo.VehicleRecordId;
		SELF.Iteration_Key := L.VehicleInfo.IterationKey;
		SELF.Sequence_Key := L.VehicleInfo.SequenceKey;

		SELF.is_deep_dive := FALSE;
		SELF.MatchCode := '';
		SELF.Source_Code := '';
		SELF.state_origin_decoded := '';

		SELF.State_Origin := L.VehicleInfo.StateOfOrigin;
		SELF.VIN := L.VehicleInfo.VIN;
		SELF.Model_Year := (STRING)L.VehicleInfo.YearMake;
		SELF.Series_Desc := L.VehicleInfo.Series;
		SELF.Make_Desc := L.VehicleInfo.Make;
		SELF.Model_Desc := L.VehicleInfo.Model;
		SELF.Major_Color_Desc := L.VehicleInfo.MajorColor;
		SELF.Minor_Color_Desc := L.VehicleInfo.MinorColor;
		SELF.Vehicle_Type_Desc := L.VehicleInfo._Type;
		SELF.Body_Style_Desc := L.VehicleInfo.Style;
		SELF.Orig_Net_Weight := L.VehicleInfo.NetWeight;
		SELF.Orig_Number_Of_Axles := (STRING)L.VehicleInfo.NumberOfAxles;
		SELF.Orig_Vehicle_Use_Desc := L.VehicleInfo.VehicleUse;

		// VinaData
		SELF.VINA_VP_Year := (STRING)L.VinaData.Year;
		SELF.VINA_VP_Series := L.VinaData.Series;
		SELF.VINA_VP_Series_Name := L.VinaData.SeriesName;
		SELF.VINA_VP_Model := L.VinaData.Model;
		SELF.VINA_VP_Restraint_Desc := L.VinaData.Restraint;
		SELF.VINA_VP_Air_Conditioning_Desc := L.VinaData.AirConditioning;
		SELF.VINA_VP_Power_Steering_Desc := L.VinaData.PowerSteering;
		SELF.VINA_VP_Power_Brakes_Desc := L.VinaData.PowerBrakes;
		SELF.VINA_VP_Power_Windows_Desc := L.VinaData.PowerWindows;
		SELF.VINA_VP_Tilt_Wheel_Desc := L.VinaData.TiltWheel;
		SELF.VINA_VP_Roof_Desc := L.VinaData.Roof;
		SELF.VINA_VP_Optional_Roof1_Desc := L.VinaData.OptionalRoof1;
		SELF.VINA_VP_Optional_Roof2_Desc := L.VinaData.OptionalRoof2;
		SELF.VINA_VP_Radio_Desc := L.VinaData.Radio;
		SELF.VINA_VP_Optional_Radio1_Desc := L.VinaData.OptionalRadio1;
		SELF.VINA_VP_Optional_Radio2_Desc := L.VinaData.OptionalRadio2;
		SELF.VINA_VP_Transmission := L.VinaData.Transmission;

		SELF.VINA_VP_Transmission_Desc := '';
		SELF.VINA_VP_Optional_Transmission1_Desc := '';
		SELF.VINA_VP_Optional_Transmission2_Desc := '';

		SELF.VINA_VP_Anti_Lock_Brakes_Desc := L.VinaData.AntiLockBrakes;
		SELF.VINA_VP_Front_Wheel_Drive_Desc := L.VinaData.FrontWheelDrive;
		SELF.VINA_VP_Four_Wheel_Drive_Desc := L.VinaData.FourWheelDrive;
		SELF.VINA_VP_Security_System_Desc := L.VinaData.SecuritySystem;
		SELF.VINA_VP_Daytime_Running_Lights_Desc := L.VinaData.DaytimeRunningLights;
		SELF.VINA_Number_Of_Cylinders := (STRING)L.VinaData.NumberOfCylinders;
		SELF.VINA_Engine_Size := (STRING)L.VinaData.EngineSize;
		SELF.Fuel_Type_Name := L.VinaData.FuelType;
		SELF.Base_Price := L.VinaData.Price;

		SELF.VINA_Fuel_Code := '';
		SELF.VINA_Price := '';
		SELF.Orig_Gross_Weight := '';
		SELF.Orig_Vehicle_Use_Code := '';

		// Datasets
		SELF.Target_Sequence_Keys := [];
		SELF.Matched_Party := [];
		SELF.Registrants := PROJECT(L.Registrants,setRegistrants(LEFT));
		SELF.Owners := PROJECT(L.Owners,setOwners(LEFT));
		SELF.Lienholders := PROJECT(L.Lienholders,setLienholders(LEFT));
		SELF.Lessees := PROJECT(L.Lessees,setLessees(LEFT));
		SELF.Lessors := PROJECT(L.Lessors,setLessors(LEFT));
		SELF.Brands := PROJECT(L.Brands,setBrands(LEFT));
		SELF.Tod_flag := L.VehicleInfo.TransferOnDeath;
		self := [];
	END;

	RETURN PROJECT(iespMvrRpt2,toVehV2Rpt(LEFT));

END;