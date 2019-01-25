IMPORT VehicleV2_Services;

MAC_SetPerson () := MACRO
  Self.PersonInfo.Name := ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, '');
  Self.PersonInfo.Address := ECL2ESP.SetAddress (
    L.prim_name, L.prim_range, L.predir, L.postdir, L.addr_suffix, L.unit_desig, L.sec_range,
    L.v_city_name, L.st, L.zip5, L.zip4, L.county_name);
  Self.PersonInfo.UniqudId := L.Append_DID;
  Self.PersonInfo.UniqueId := L.append_bdid;
  Self.PersonInfo.DriverLicenseNumber := L.Orig_DL_Number;
  Self.PersonInfo.DealerLicenseNumber := '';
  Self.PersonInfo.DOB := iesp.ECL2ESP.toDate ((integer4) L.Orig_DOB);
  Self.PersonInfo.Age := (integer) L.age;
  Self.PersonInfo.Sex := L.Orig_Sex;
  Self.PersonInfo.SSN := L.Append_SSN;
ENDMACRO;

export transform_vehicles (dataset (VehicleV2_Services.Layout_Report) vehi) := function

iesp.motorvehicle.t_MVReportOwner SetOwners (VehicleV2_Services.assorted_layouts.Layout_owner L) := TRANSFORM
  Self.OwnerType := '';
  MAC_SetPerson ();
	Self.SourceDateFirstSeen := iesp.ECL2ESP.toDatestring8(L.SRC_FIRST_DATE);
	Self.SourceDateLastSeen := iesp.ECL2ESP.toDatestring8(L.SRC_LAST_DATE);
END;

iesp.motorvehicle.t_MVReportBrand SetBrands (VehicleV2_Services.assorted_layouts.layout_brand L) := TRANSFORM
		Self.Date  := iesp.ECL2ESP.toDatestring8(L.brand_date);			
		Self.State := L.brand_state;		
		Self.Code  := L.brand_code;
		Self._Type := L.brand_type;		
END;	

iesp.motorvehicle.t_MVReportRegistrant SetRegistrants (VehicleV2_Services.assorted_layouts.Layout_registrant L) := TRANSFORM
  Self.RegistrantType := '';
  MAC_SetPerson ();
END;

iesp.motorvehicle.t_MVReportLienHolder SetLienHolders (VehicleV2_Services.assorted_layouts.Layout_lienholder L) := TRANSFORM
  Self.LienHolderType := L.Orig_Party_Type;
  MAC_SetPerson ();
  Self.FEID_SSN := '';
  Self.LienDate := iesp.ECL2ESP.toDate ((integer4) L.Orig_Lien_Date);
  Self.BusinessName := L.Append_Clean_CName; //or L.orig_name
END;

iesp.motorvehicle.t_MVReportRecord toOut (VehicleV2_Services.Layout_Report L) := TRANSFORM
  // Due to the vehicle report data model we need to pick exactly one owner and registrant,
  // although both owners and both registrants have exactly same title, etc. info.
  this_reg := choosen (L.registrants, 1)[1];
  this_own := choosen (L.owners, 1)[1];

  Self.StateOfOrigin := L.State_Origin;
  Self.VID := l.vin;
  Self.VehicleNumber := l.Vehicle_Key;
  Self.HistoryFlag := IF (L.is_current, 'CURRENT', 'HISTORICAL');
  Self.RecordType := '';
  Self.StateName := L.state_origin_decoded;
  Self.YearMake := (integer4) L.model_year;
  Self.MakeCode := '';//L.Orig_Make_Code;
  Self.Make := L.make_desc;
  Self.Model := L.model_desc;
  Self.VehicleType := L.vehicle_type_desc;
  Self.VehicleTypeCode := '';
	Self.NonDMVSource := L.NonDMVSource;
  Self.VehicleSpecification := PROJECT (L, transform (iesp.motorvehicle.t_MVReportVehicle,
    Self.VIN := Left.vin;
    Self.MajorColorCode := '';
    Self.MajorColor := Left.major_color_desc;
    Self.MinorColorCode := '';
    Self.MinorColor := Left.minor_color_desc;
    Self.BodyCode := '';
    Self.BodyStyle := Left.body_style_desc;
    Self.Series := L.vina_vp_series;
    Self.NumberOfCylinders := Left.VINA_Number_Of_Cylinders;
    Self.EngineSize := Left.VINA_Engine_Size;
    Self.FuelTypeCode := Left.Vina_fuel_code;
    Self.FuelType := Left.fuel_type_name;
    Self.VehicleUseCode := Left.Orig_Vehicle_Use_code;
    Self.VehicleUse := Left.Orig_Vehicle_Use_Desc;
    Self.OdometerMileage := this_own.Ttl_Odometer_Mileage;
  ));

  Self.Vessel := PROJECT (L, transform (iesp.motorvehicle.t_MVReportVessel, 
    Self.HullId := '';
    Self.VesselPropulsionTypeCode := '';
    Self.VesselPropulsionType := '';
    Self.BoatDescription := '';
    Self.HullMaterialTypeCode := '';
    Self.HullMaterialType := '';
    Self.LengthFeet := 0;
    Self.VesselType := '';
    Self.VesselTypeCode := '';
  )); // {xpath('Vessel')};

   Self.LicensePlate := PROJECT (L, transform (iesp.motorvehicle.t_MVReportLicensePlate, 
     Self.PlateCode := this_reg.Reg_License_Plate_Type_Code;
     Self.PlateType := this_reg.Reg_License_Plate_Type_Desc;
     Self.PlateNumber := this_reg.Reg_License_Plate;
     Self.TruePlateNumber := this_reg.Reg_True_License_Plate;
  )); // {xpath('LicensePlate')};

  Self.Title := PROJECT (L, transform (iesp.motorvehicle.t_MVReportTitle, 
    Self.TitleNumber := this_own.Ttl_Number;
    Self.TitleIssueDate := iesp.ECL2ESP.toDate ((unsigned4) this_own.Ttl_Latest_Issue_Date);
    Self.TitleStatusCode := this_own.Ttl_Status_Code;
    Self.TitleStatus := this_own.Ttl_Status_Desc;
  )); // {xpath('Title')};

  // TODO: check all dates -- what are they?
  Self.RegistrationExpirationDate := iesp.ECL2ESP.toDate ((unsigned4) this_reg.Reg_Latest_Expiration_Date);
  Self.OriginalRegistrationDate   := iesp.ECL2ESP.toDate ((unsigned4) this_reg.Reg_First_Date);
  Self.RegistrationDate           := iesp.ECL2ESP.toDate ((unsigned4) this_reg.Reg_Earliest_Effective_Date);
  Self.FirstRegistrationDate      := iesp.ECL2ESP.toDate ((unsigned4) this_reg.Reg_First_Date);
  Self.RegistrationEffectiveDate  := iesp.ECL2ESP.toDate ((unsigned4) this_reg.Reg_Latest_Effective_Date);

  Self.DecalYear := (integer) this_reg.Reg_Decal_Year;
  Self.RegistrationStatusCode := '';

  Self.VINAData := PROJECT (L, transform (iesp.motorvehicle.t_VINAData,
    Self.Restraint := L.VINA_VP_RESTRAINT_Desc;
    Self.AirConditioning := L.VINA_VP_AIR_CONDITIONING_Desc;
    Self.PowerSteering := L.VINA_VP_POWER_STEERING_Desc;
    Self.PowerBrakes := L.VINA_VP_POWER_BRAKES_Desc;
    Self.PowerWindows := L.VINA_VP_Power_Windows_Desc;
    Self.SecuritySystem := L.VINA_VP_Security_System_Desc;
    Self.Roof := L.VINA_VP_Roof_Desc;
    Self.Radio := L.VINA_VP_Radio_Desc;
    Self.TiltWheel := L.VINA_VP_Tilt_Wheel_Desc;
    Self.AntiLockBrakes := L.VINA_VP_Anti_Lock_Brakes_Desc;
    Self.DaytimeRunningLights := L.VINA_VP_Daytime_Running_Lights_Desc;
    Self.FrontWheelDrive := L.VINA_VP_Front_Wheel_Drive_Desc;
    Self.FourWheelDrive := L.VINA_VP_Four_Wheel_Drive_Desc;
    Self.BasePrice := L.VINA_Price;
  )); // {xpath('VINAData')}

  Self.SeriesName := L.VINA_VP_Series_Name;

  self.owners      := project (choosen (L.owners,      iesp.Constants.MV.MaxCountOwners),      SetOwners (Left));
  self.registrants := project (choosen (L.registrants, iesp.Constants.MV.MaxCountRegistrants), SetRegistrants (Left));
  self.LienHolders := project (choosen (L.lienholders, iesp.Constants.MV.MaxCountLienHolders), SetLienHolders (Left));
	self.Brands      := project (choosen (L.Brands, iesp.Constants.MV.MaxCountBrands), SetBrands (Left));
	self.ExternalKey := '';
  self.isAccurintData := false;
end;

RETURN PROJECT (vehi, toOut (Left));

END;
