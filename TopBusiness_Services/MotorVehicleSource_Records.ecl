//=================================================================================
// ====== RETURNS MOTORVEHICLE DATA FOR A GIVEN VEHICLE_KEY & ITERATION_KEY  ======
// ====== IN ESP-COMPLIANT WAY.                                              ======
// ================================================================================
//
// This attribute was created by copying PersonReports.vehicle_records and 
// modifying it for use by TopBusiness_Services.SourceService_Records.
import iesp, VehicleV2, VehicleV2_Services, BIPV2, ut;

EXPORT MotorVehicleSource_Records(
	dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
	boolean IsFCRA = false,
	boolean keepAll = false) 
 := MODULE
	
	SHARED mvr_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		VehicleV2_Services.Layout_Report;
	END;

	SHARED mvr_sourceview_layout := RECORD
		Layouts.rec_input_ids_wSrc;
		VehicleV2_Services.Layout_Vehicle_Key;
	END;
	
	SHARED mvr_personBus_layout := RECORD
		VehicleV2_Services.layout_vehicle_party_out.layout_standard_name;
		VehicleV2_Services.layout_vehicle_party_out.layout_standard_address;
		string18  county_name;
		VehicleV2.Layout_Base_Party.Orig_SSN;
		VehicleV2.Layout_Base_Party.Append_SSN;
		VehicleV2.Layout_Base_Party.Orig_Fein;
		VehicleV2.Layout_Base_Party.Append_Fein;
		VehicleV2.Layout_Base_Party.Orig_DL_Number;
		VehicleV2.Layout_Base_Party.Orig_DOB;
		VehicleV2.Layout_Base_Party.Orig_Sex;
		VehicleV2.Layout_Base_Party.Append_Clean_CName;
		string12 append_did;
		string12 append_bdid;
		string3 age;
	END;
	
	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get vehicle_keys from linkids
	ds_LinkIDkeys := VehicleV2.Key_Vehicle_linkids.kFetch(in_docs_linkonly,inoptions.fetch_level,,,
	                                                    TopBusiness_Services.Constants.SlimKeepLimit);
	
	// For records matched on linkids only, only keep Owner(type=1), Registrant(type=4) or Lessee(type=5) records of the vehicle, unless stated to keep all.
  ds_LinkMvrkeys := PROJECT(ds_LinkIDkeys(orig_name_type = Constants.VEH_OWNER OR orig_name_type = Constants.VEH_REGISTRANT
																					 OR orig_name_type = Constants.VEH_LESSEE OR KeepAll),
																		TRANSFORM(mvr_sourceview_layout,
																					SELF.Vehicle_Key := LEFT.Vehicle_Key,
																					SELF.Iteration_Key := LEFT.iteration_key,
																					SELF.Sequence_Key := LEFT.Sequence_key,
																					SELF := LEFT,
																					SELF := []));
																					
	// For records with an id value assigned and an Id type of vehiclesrcrec, then get key parts via sourcerec key
	in_docs_SourceRec := in_docids(IdValue != '' and Idtype = constants.vehiclesrcrec);
	ds_SrcRecMvrkeys := JOIN(in_docs_SourceRec, VehicleV2.Key_Vehicle_Source_Rec_ID,
													KEYED((INTEGER) LEFT.IdValue = RIGHT.source_rec_id), 
													TRANSFORM(mvr_sourceview_layout,
																		SELF.Vehicle_Key := RIGHT.Vehicle_Key,
																		SELF.Iteration_Key := RIGHT.iteration_key,
																		SELF.Sequence_Key := RIGHT.Sequence_key,
																		SELF := LEFT,
																		SELF := []), LIMIT(TopBusiness_Services.Constants.SlimKeepLimit, SKIP));
	
	// For records with an id value assigned and an Id type of vehiclekeys, then parse the idvalue to get the key parts
	in_docs_Parse := in_docids(IdValue != '' and Idtype = constants.vehiclekeys);
	ds_ParseMvr_keys := PROJECT(in_docs_Parse,TRANSFORM(mvr_sourceview_layout,
																	delim1 := StringLib.StringFind(LEFT.IdValue,'//',1);
																	delim2 := StringLib.StringFind(LEFT.IdValue,'//',2);
																	SELF.Vehicle_Key := LEFT.IdValue[1..delim1-1],
																	SELF.Iteration_Key := LEFT.IdValue[delim1+2..delim2-1],
																	SELF.Sequence_Key := LEFT.IdValue[delim2+2..],
																	SELF := LEFT,
																	SELF := []));
	
	mvr_keys_comb := ds_LinkMvrkeys+ds_ParseMvr_keys+ds_SrcRecMvrkeys;
	
	// Get the raw data from the appropriate view.
	mvr_keys := PROJECT(mvr_keys_comb,TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key,SELF := LEFT,SELF:=[]));
	
	mvr_keys_dedup := DEDUP(mvr_keys,ALL);
	

	mod_vehicle_report := VehicleV2_Services.IParam.getReportModule();
	mvr_sourceview := VehicleV2_Services.raw.get_vehicle_crs_report_by_Veh_key(mod_vehicle_report, mvr_keys_dedup, inoptions.ssn_mask);

	SHARED mvr_sourceview_wLinkIds := JOIN(mvr_sourceview,mvr_keys_comb,
																					LEFT.Vehicle_Key = RIGHT.Vehicle_Key AND
																					LEFT.iteration_key = RIGHT.iteration_key AND
																					LEFT.sequence_key = RIGHT.Sequence_Key,
																					TRANSFORM(mvr_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
	
	iesp.motorvehicle.t_MotorVehicleReportPersonOrBusiness SetPersonOrBusinessInfo(mvr_personBus_layout l) := TRANSFORM
			SELF.UniqueID := (STRING)L.append_did;
			SELF.Name := iesp.ECL2ESP.setName(L.fname,L.mname,L.lname,L.name_suffix,'');
			SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip5,L.zip4,l.county_name);
			SELF.SSN := L.Orig_SSN;
			SELF.AppendSSN := L.Append_SSN;
			SELF.Fein := L.Orig_Fein;
			SELF.AppendedFEIN := L.append_fein;
			SELF.DriverLicenseNumber := L.Orig_DL_Number;
			SELF.DOB := iesp.ECL2ESP.toDate((Integer)L.Orig_DOB);
			SELF.Age := (Integer)L.age;
			SELF.Gender := L.Orig_Sex;
			SELF.BusinessName := L.Append_Clean_CName;
			SELF.BusinessId := (String)L.Append_BDID;
			SELF := [];
	END;

	iesp.motorvehicle.t_MotorVehicleReportLessor SetLessors(VehicleV2_Services.assorted_layouts.Layout_lessee_or_lessor L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
	
		//Project into a shared layout to use generic transform
		perBusRec := PROJECT(L,TRANSFORM(mvr_personBus_layout,SELF := LEFT, SELF := []));
		SELF.LessorInfo := PROJECT(perBusRec,setPersonOrBusinessInfo(LEFT));
		SELF := [];
  END; 
			
	iesp.motorvehicle.t_MotorVehicleReportLessee SetLessees(VehicleV2_Services.assorted_layouts.Layout_lessee L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
	
		//Project into a shared layout to use generic transform
		perBusRec := PROJECT(L,TRANSFORM(mvr_personBus_layout,SELF := LEFT, SELF := []));
		SELF.LesseeInfo := PROJECT(perBusRec,setPersonOrBusinessInfo(LEFT));
		SELF := [];
  END; 
		
	iesp.motorvehicle.t_MotorVehicleReportLienHolder SetLienholders(VehicleV2_Services.assorted_layouts.Layout_lienholder L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
	
		//Project into a shared layout to use generic transform
		perBusRec := PROJECT(L,TRANSFORM(mvr_personBus_layout,SELF := LEFT, SELF := []));
		SELF.LienHolderInfo := PROJECT(perBusRec,setPersonOrBusinessInfo(LEFT));
		SELF.LienDate := iesp.ECL2ESP.toDate((INTEGER)L.Orig_Lien_Date);
		SELF.StandardizedName := L.std_lienholder_name;
		SELF := [];
  END; 
		
	iesp.motorvehicle.t_MotorVehicleReportOwner SetOwners(VehicleV2_Services.assorted_layouts.Layout_owner L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
	
		//Project into a shared layout to use generic transform
		perBusRec := PROJECT(L,TRANSFORM(mvr_personBus_layout,SELF := LEFT, SELF := []));
		SELF.OwnerInfo := PROJECT(perBusRec,setPersonOrBusinessInfo(LEFT));
		SELF.TitleInfo.Number := L.Ttl_Number;
		SELF.TitleInfo.EarliestIssueDate := iesp.ECL2ESP.toDate((INTEGER)L.Ttl_Earliest_Issue_Date);
		SELF.TitleInfo.LatestIssueDate := iesp.ECL2ESP.toDate((INTEGER)L.Ttl_Latest_Issue_Date);
		SELF.TitleInfo.PreviousIssueDate := iesp.ECL2ESP.toDate((INTEGER)L.Ttl_Previous_Issue_Date);
		SELF.TitleInfo.StatusCode := L.Ttl_Status_Code;
		SELF.TitleInfo.StatusDesc := L.Ttl_Status_Desc;
		SELF.TitleInfo.OdometerMileage := (Integer)L.Ttl_Odometer_Mileage;
		SELF := [];
  END; 
	
	iesp.motorvehicle.t_MotorVehicleReportRegistrant SetRegistrants(VehicleV2_Services.assorted_layouts.Layout_registrant L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
	
		//Project into a shared layout to use generic transform
		perBusRec := PROJECT(L,TRANSFORM(mvr_personBus_layout,SELF := LEFT, SELF := []));
		SELF.RegistrantInfo := PROJECT(perBusRec,setPersonOrBusinessInfo(LEFT));
		SELF.RegistrationInfo.TrueLicensePlate := L.Reg_True_License_Plate;
		SELF.RegistrationInfo.LicenseState := L.Reg_License_State;
		SELF.RegistrationInfo.FirstDate := iesp.ECL2ESP.toDate((INTEGER)L.Reg_First_Date);
		SELF.RegistrationInfo.EarliestEffectiveDate := iesp.ECL2ESP.toDate((INTEGER)L.Reg_Earliest_Effective_Date);
		SELF.RegistrationInfo.LatestEffectiveDate := iesp.ECL2ESP.toDate((INTEGER)L.Reg_Latest_Effective_Date);
		SELF.RegistrationInfo.LatestExpirationDate := iesp.ECL2ESP.toDate((INTEGER)L.Reg_Latest_Expiration_Date);
		SELF.RegistrationInfo.DecalNumber := L.Reg_Decal_Number;
		SELF.RegistrationInfo.DecalYear := L.Reg_Decal_Year;
		SELF.RegistrationInfo.StatusDesc := L.Reg_Status_Desc;
		SELF.RegistrationInfo.LicensePlate := L.Reg_License_Plate;
		SELF.RegistrationInfo.LicensePlateTypeCode := L.Reg_License_Plate_Type_Code;
		SELF.RegistrationInfo.LicensePlateTypeDesc := L.Reg_License_Plate_Type_Desc;
		SELF.RegistrationInfo.PreviousLicensePlate := L.Reg_Previous_License_Plate;
		SELF.RegistrationInfo.PreviousLicenseState := L.Reg_Previous_License_State;
		SELF := [];
  END; 

	SHARED iesp.motorvehicle.t_MotorVehicleReport2Record toOut (mvr_layout_wLinkIds L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids()
		SELF.IsCurrent := l.is_current;
		SELF.VehicleInfo.IterationKey := l.Iteration_Key;
		SELF.VehicleInfo.SequenceKey := l.Sequence_Key;
		SELF.VehicleInfo.VehicleRecordId := l.Vehicle_Key;
		SELF.VehicleInfo.VIN := l.vin;
		SELF.VehicleInfo.YearMake := (Integer)l.model_year;
		SELF.VehicleInfo.Series := l.series_desc;
		SELF.VehicleInfo.Make := l.make_desc;
		SELF.VehicleInfo.Model := l.model_desc;
		SELF.VehicleInfo.MajorColor := l.major_color_desc;
		SELF.VehicleInfo.MinorColor := l.minor_color_desc;
		SELF.VehicleInfo._Type := l.vehicle_type_desc;
		SELF.VehicleInfo.Style := l.body_style_desc;
		SELF.VehicleInfo.NetWeight := l.Orig_Net_Weight;
		SELF.VehicleInfo.NumberOfAxles := (Integer)l.Orig_Number_Of_Axles;
		SELF.VehicleInfo.VehicleUse := l.Orig_Vehicle_Use_Desc;
		SELF.VehicleInfo.StateOfOrigin := l.State_Origin;
		SELF.VinaData.Year := (Integer)l.VINA_VP_Year;
		SELF.VinaData.Series := l.VINA_VP_Series;
		SELF.VinaData.SeriesName := l.VINA_VP_Series_Name;
		SELF.VinaData.Model := l.VINA_VP_Model;
		SELF.VinaData.Restraint := l.VINA_VP_RESTRAINT_Desc;
		SELF.VinaData.AirConditioning := l.VINA_VP_AIR_CONDITIONING_Desc;
		SELF.VinaData.PowerSteering := l.VINA_VP_POWER_STEERING_Desc;
		SELF.VinaData.PowerBrakes := l.VINA_VP_POWER_BRAKES_Desc;
		SELF.VinaData.PowerWindows := l.VINA_VP_Power_Windows_Desc;
		SELF.VinaData.TiltWheel := l.VINA_VP_Tilt_Wheel_Desc;
		SELF.VinaData.Roof := l.VINA_VP_Roof_Desc;
		SELF.VinaData.OptionalRoof1 := l.VINA_VP_Optional_Roof1_Desc;
		SELF.VinaData.OptionalRoof2 := l.VINA_VP_Optional_Roof2_Desc;
		SELF.VinaData.Radio := l.VINA_VP_Radio_Desc;
		SELF.VinaData.OptionalRadio1 := l.VINA_VP_Optional_Radio1_Desc;
		SELF.VinaData.OptionalRadio2 := l.VINA_VP_Optional_Radio2_Desc;
		SELF.VinaData.Transmission := l.VINA_VP_Transmission;
		SELF.VinaData.TransmissionDesc := IF(l.VINA_VP_Optional_Transmission1_Desc != '',
																						l.VINA_VP_Optional_Transmission1_Desc,
																						l.VINA_VP_Transmission_Desc);
		SELF.VinaData.AntiLockBrakes := l.VINA_VP_Anti_Lock_Brakes_Desc;
		SELF.VinaData.FrontWheelDrive := l.VINA_VP_Front_Wheel_Drive_Desc;
		SELF.VinaData.FourWheelDrive := l.VINA_VP_Four_Wheel_Drive_Desc;
		SELF.VinaData.SecuritySystem := l.VINA_VP_Security_System_Desc;
		SELF.VinaData.DaytimeRunningLights := l.VINA_VP_Daytime_Running_Lights_Desc;
		SELF.VinaData.NumberOfCylinders := (Integer)l.VINA_Number_Of_Cylinders;
		SELF.VinaData.EngineSize := (Integer)l.VINA_Engine_Size;
		SELF.VinaData.FuelType := l.fuel_type_name;
		SELF.VinaData.Price := l.VINA_Price;
		SELF.DataSource := l.DataSource;
		
		SELF.registrants := choosen(project(L.registrants,SetRegistrants(LEFT)),iesp.Constants.MV.MaxCountRegistrants);
		SELF.owners := choosen(project(L.owners,SetOwners(LEFT)),iesp.Constants.MV.MaxCountOwners);
		SELF.LienHolders := choosen(project(L.lienholders,SetLienHolders(LEFT)),iesp.Constants.MV.MaxCountLienHolders);
		SELF.Lessees := choosen(project(L.lessees,SetLessees(LEFT)),iesp.Constants.MV.MaxCountLessees);
		SELF.Lessors := choosen(project(L.lessors,SetLessors(LEFT)),iesp.Constants.MV.MaxCountLessors);
		SELF := [];
		
	end;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(mvr_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'VEH_V2';
			self.src_desc := 'Motor Vehicle Registrations';
			self.hasName 	:= exists(L.registrants(orig_name<>''));
			self.hasSSN  	:= exists(L.registrants(orig_ssn<>'' or append_ssn<>''));
			self.hasDOB  	:= exists(L.registrants((unsigned)orig_dob[1..4] > 0));
		  self.hasFEIN 	:= exists(L.registrants(orig_fein<>'' or append_fein<>''));		
			self.hasAddr 	:= exists(L.registrants(st<>'' or zip5<>''));
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate(min(L.registrants(Reg_Earliest_Effective_Date<>''), (unsigned)Reg_Earliest_Effective_Date));
			self.dt_last_seen := ut.NormDate(min(L.registrants(Reg_Latest_Effective_Date<>''), (unsigned)Reg_Latest_Effective_Date));
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(mvr_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(mvr_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(mvr_sourceview_wLinkIds);

END;
