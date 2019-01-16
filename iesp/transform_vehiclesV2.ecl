IMPORT VehicleV2_Services;
export transform_vehiclesV2 (dataset (VehicleV2_Services.Layout_Report) vehi) := function

Mac_set_PersonOrBusiness(name_source,reported_name) :=	macro
			Self.UniqueId := L.Append_DID,
			Self.Name := row(L,transform(iesp.share.t_name,self.full := '',
														self.First := left.fname,
														self.Middle := left.mname,
														self.Last := left.lname,
														self.suffix := left.name_suffix,
														self.prefix := '')),
			Self.Address := row(L, transform(iesp.share.t_Address,
											self.StreetName := left.prim_name,
											self.StreetNumber := left.prim_range,
											self.StreetPreDirection := left.predir,
											self.StreetPostDirection := left.postdir,
											self.StreetSuffix := left.addr_suffix,
											self.UnitDesignation := left.unit_desig,
											self.UnitNumber := left.sec_range,
											self.StreetAddress1 :=  '',
											self.StreetAddress2 :=  '',
											self.State := left.st,
											self.City := left.v_city_name,
											self.Zip5 := left.zip5,
											self.Zip4 := left.zip4,
											self.County := left.county_name,
											self.postalCode := '',
											self. StateCityZip :='')),

			Self.SSN := Left.Orig_SSN,
			Self.AppendSSN := Left.Append_SSN,
			Self.Fein := Left.Orig_Fein,
			Self.AppendedFein := Left.Append_Fein,
			Self.DriverLicenseNumber := Left.Orig_DL_Number,
			Self.DOB := iesp.ECL2ESP.toDate ((integer4) Left.Orig_DOB),
			Self.Age := (integer) Left.age,
			Self.Gender := Left.orig_sex_desc,
			Self.BusinessName := Left.Append_Clean_CName,
			Self.BusinessId :=Left.append_bdid,
			self.BusinessIDs.proxid := l.proxid;
			self.businessIDs.ultid := l.ultid;
			self.businessIDs.orgid := l.orgid;
			self.businessIDs.seleid := l.seleid;
			self.businessIDs.dotid := l.dotid;
			self.BusinessIDs.empid := l.empid;
			self.BusinessIDs.powid := l.powid;
			self.IdValue := '';
			self.NameSource := name_source;
			self.ReportedName := reported_name;
endmacro;


iesp.motorvehicle.t_MotorVehicleReportLessee SetLesseesV2 (VehicleV2_Services.assorted_layouts.Layout_Lessee L) := TRANSFORM
		Self.HistoryDescription := L.history_desc,
		Self.LesseeInfo := row(L, transform (iesp.motorvehicle.t_MotorVehicleReportPersonOrBusiness,
			Mac_set_PersonOrBusiness('','')
		));
END;		

iesp.motorvehicle.t_MotorVehicleReportLessor SetLessorsV2 (VehicleV2_Services.assorted_layouts.layout_lessee_or_lessor L) := TRANSFORM
		Self.HistoryDescription := L.history_desc,
		Self.LessorInfo := row(L, transform (iesp.motorvehicle.t_MotorVehicleReportPersonOrBusiness,
			Mac_set_PersonOrBusiness(L.name_source,'')
		));
END;		

iesp.motorvehicle.t_MotorVehicleSearchBrand SetBrandsV2 (VehicleV2_Services.assorted_layouts.layout_brand L) := TRANSFORM
		Self.Date := iesp.ECL2ESP.toDatestring8(L.brand_date);			
		Self.State := L.brand_state;		
		Self.Code := L.brand_code;
		Self._Type := L.brand_type;		
END;	
		
iesp.motorvehicle.t_MotorVehicleReportLienHolder SetLienHoldersV2 (VehicleV2_Services.assorted_layouts.Layout_lienholder L) := TRANSFORM
	Self.HistoryDescription := L.history_desc,
	Self.LienHolderInfo := row(L, transform (iesp.motorvehicle.t_MotorVehicleReportPersonOrBusiness,
			Mac_set_PersonOrBusiness(L.name_source,'')
	));
  Self.LienDate := iesp.ECL2ESP.toDate ((integer4) L.Orig_Lien_Date);
	Self.StandardizedName := L.std_lienholder_name;
END;


iesp.motorvehicle.t_MotorVehicleReportTitleInfo TitleInfo_trans (VehicleV2_Services.assorted_layouts.Layout_owner L) := transform
			self.Number := l.Ttl_Number;
			self.EarliestIssueDate := iesp.ECL2ESP.toDate ((unsigned4) L.Ttl_Earliest_Issue_Date);
			self.LatestIssueDate := iesp.ECL2ESP.toDate ((unsigned4) L.Ttl_Latest_Issue_Date);
			self.PreviousIssueDate := iesp.ECL2ESP.toDate ((unsigned4) L.Ttl_Previous_Issue_Date);
			self.StatusCode := L.Ttl_Status_Code;
			self.StatusDesc := L.Ttl_Status_Desc;
			self.OdometerMileage := (integer)L.Ttl_Odometer_Mileage;
end;

iesp.motorvehicle.t_MotorVehicleReportOwner SetOwnersV2 (VehicleV2_Services.assorted_layouts.Layout_owner L) := TRANSFORM
		Self.HistoryDescription := L.history_desc,
		Self.OwnerInfo := row(L, transform (iesp.motorvehicle.t_MotorVehicleReportPersonOrBusiness,
			Mac_set_PersonOrBusiness('','')
		));
		Self.TitleInfo := row(TitleInfo_trans(L));
		Self.SourceDateFirstSeen := iesp.ECL2ESP.toDatestring8(L.SRC_FIRST_DATE);
		Self.SourceDateLastSeen := iesp.ECL2ESP.toDatestring8(L.SRC_LAST_DATE);
END;

iesp.motorvehicle.t_MotorVehicleReportRegistrationInfo RegistrationInfo_trans(VehicleV2_Services.assorted_layouts.Layout_registrant L) := transform
			Self.TrueLicensePlate := L.Reg_True_License_Plate;
			Self.LicenseState := l.Reg_License_State;
			Self.FirstDate := iesp.ECL2ESP.toDate ((unsigned4) L.Reg_First_Date);
			Self.EarliestEffectiveDate := iesp.ECL2ESP.toDate ((unsigned4) L.Reg_Earliest_Effective_Date);
			Self.LatestEffectiveDate := iesp.ECL2ESP.toDate ((unsigned4) l.Reg_Latest_Effective_Date);
			Self.LatestExpirationDate := iesp.ECL2ESP.toDate ((unsigned4) L.Reg_Latest_Expiration_Date);
			Self.DecalNumber :=l.Reg_Decal_Number;
			Self.DecalYear := L.Reg_Decal_Year;
			Self.StatusDesc := l.Reg_Status_Desc;
			Self.LicensePlate := L.Reg_License_Plate;
			Self.LicensePlateTypeCode := L.Reg_License_Plate_Type_Code;
			Self.LicensePlateTypeDesc := L.Reg_License_Plate_Type_Desc;
			Self.PreviousLicensePlate := l.Reg_Previous_License_Plate;
			Self.PreviousLicenseState := l.Reg_Previous_License_State;
end;

iesp.motorvehicle.t_MotorVehicleReportRegistrant SetRegistrantsV2 (VehicleV2_Services.assorted_layouts.Layout_registrant L) := TRANSFORM
		Self.HistoryDescription := L.history_desc,
		Self.RegistrantInfo := row(L, transform (iesp.motorvehicle.t_MotorVehicleReportPersonOrBusiness,
			Mac_set_PersonOrBusiness(L.name_source,l.reported_name)
		));
	
		Self.RegistrationInfo := row(RegistrationInfo_trans(L));
		Self.TitleIssueDate := iesp.ECL2ESP.toDatestring8(L.title_issue_date);
		Self.TitleNumber := L.title_number;		
END;

iesp.motorvehicle.t_MotorVehicleReportVehicleInfo VehicleInfo_trans(VehicleV2_Services.Layout_Report L) := transform
			Self.VehicleRecordId := l.Vehicle_Key;
			Self.IterationKey := l.Iteration_Key;
			Self.SequenceKey := l.Sequence_Key;
			Self.VIN := l.vin;
			Self.YearMake := (integer) L.model_year;
			Self.Series := l.series_desc;
			Self.Make := L.make_desc;
			Self.Model := L.model_desc;
			Self.MajorColor := L.major_color_desc;
			Self.MinorColor := L.minor_color_desc;
			Self._Type := l.vehicle_type_desc;
			Self.Style := l.body_style_desc;
			Self.NetWeight := l.Orig_Net_Weight;
			Self.NumberOfAxles := (integer)l.Orig_Number_Of_Axles;
			Self.VehicleUse := L.Orig_Vehicle_Use_Desc;
			Self.StateOfOrigin := L.State_Origin;
		  Self.TransferOnDeath := L.TOD_flag;
end;

iesp.motorvehicle.t_MVR2VinaData VinData_trans(VehicleV2_Services.Layout_Report L) :=transform
	  Self.Year := (integer)l.VINA_VP_Year;
		Self.Series := L.vina_vp_series;
		Self.SeriesName := L.VINA_VP_Series_Name;
		Self.Model := l.VINA_VP_Model;
    Self.Restraint := L.VINA_VP_RESTRAINT_Desc;
    Self.AirConditioning := L.VINA_VP_AIR_CONDITIONING_Desc;
    Self.PowerSteering := L.VINA_VP_POWER_STEERING_Desc;
    Self.PowerBrakes := L.VINA_VP_POWER_BRAKES_Desc;
    Self.PowerWindows := L.VINA_VP_Power_Windows_Desc;
    Self.TiltWheel := L.VINA_VP_Tilt_Wheel_Desc;
    Self.Roof := L.VINA_VP_Roof_Desc;
    Self.OptionalRoof1 :=l.VINA_VP_Optional_Roof1_Desc;
	  Self.OptionalRoof2 := l.VINA_VP_Optional_Roof2_Desc;
    Self.Radio := L.VINA_VP_Radio_Desc;
	  Self.OptionalRadio1 := l.VINA_VP_Optional_Radio1_Desc;
	  Self.OptionalRadio2 := l.VINA_VP_Optional_Radio2_Desc;
	  Self.Transmission := l.VINA_VP_Transmission;
		Self.TransmissionDesc := l.VINA_VP_Transmission_Desc;
    Self.AntiLockBrakes := L.VINA_VP_Anti_Lock_Brakes_Desc;
    Self.FrontWheelDrive := L.VINA_VP_Front_Wheel_Drive_Desc;
    Self.FourWheelDrive := L.VINA_VP_Four_Wheel_Drive_Desc;
    Self.SecuritySystem := L.VINA_VP_Security_System_Desc;
    Self.DaytimeRunningLights := L.VINA_VP_Daytime_Running_Lights_Desc;
		Self.NumberOfCylinders := (integer)L.VINA_Number_Of_Cylinders;
		Self.EngineSize :=  (integer)L.VINA_Engine_Size;
		Self.FuelType := l.fuel_type_name;
		Self.Price := l.base_Price;
end;

iesp.motorvehicle.t_MotorVehicleReport2Record toOut (VehicleV2_Services.Layout_Report Le) := TRANSFORM
  Self.IsCurrent := Le.is_current;
  Self.VehicleInfo := row (VehicleInfo_trans(Le));
	Self.VinaData := row(VinData_trans(Le));
  self.Registrants := project (choosen (Le.registrants, iesp.Constants.MV.MaxCountRegistrants), SetRegistrantsV2 (Left));
  self.owners      := project (choosen (Le.owners,      iesp.Constants.MV.MaxCountOwners),      SetOwnersV2 (Left));
  self.LienHolders := project (choosen (Le.lienholders, iesp.Constants.MV.MaxCountLienHolders), SetLienHoldersV2 (Left));
  self.Lessees := project (choosen (Le.Lessees, iesp.Constants.MV.MaxCountLessees), SetLesseesV2 (Left));
  self.Lessors := project (choosen (Le.Lessors, iesp.Constants.MV.MaxCountLessors), SetLessorsV2 (Left));
	self.Brands := project (choosen (Le.Brands, iesp.Constants.MV.MaxCountBrands), SetBrandsV2 (Left));
	self.DataSource := Le.dataSource; //values['All','Local','RealTime','REPORT','']
	self.NonDMVSource := Le.NonDMVSource;
	self := [];
end;

RETURN PROJECT (vehi, toOut (Left));

END;
