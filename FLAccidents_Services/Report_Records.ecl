import Census_Data,codes,FLAccidents,iesp, suppress;

export Report_Records := module
	export params := interface
		export string9 Accident_Number  := '';
    export boolean mask_dl := false;
	end;
	
	export val(params in_mod) := function

    // Common routine used to get the name of a county
    get_county_name(string2 st_in, string3 county_in) := 
		        Census_data.Key_Fips2County(keyed(st_in = state_code AND
                                              county_in = county_fips))[1].county_name;

	  // Assign accident number that was input to an unsigned6 integer attribute for
		// matching on in multiple places below.
    in_accnbr := (unsigned6)in_mod.Accident_Number;


   /*NOTE: According to an email from Tammy Avella on 11/04/08, we do not want to 
	         expose any new fields to customers in this moxie-to-roxie rewrite at this
					 point in time.
           Therefore certain fields on the output iesp.accident.t_AccidentReportRecord
					 related records will be blanked out even if they contain data in their
					 associated data file field.
					 These fields can be found below by searching on the word "moxie".
					 Coding to output these fields is left in for future enhancements, but is 
					 commented out for now.
	 */

    //******** File1 (Accident Time/Condition/Investigation/Stats Info) Transforms
		//********### File1 (Accident Time Info) Transform
	  iesp.accident.t_AccidentReportTime file1_xform1(
	                                     FLAccidents.Key_FLCrash1 l) := transform
			self.DayOfWeek         := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','DAY_WEEK','',l.day_week),
			self.HourOfAccident    := (integer1) l.hr_accident;
			self.MinuteOfAccident  := (integer1) l.min_accident;
			self.HourOffNotified   := (integer1) l.hr_off_notified;
			self.MinuteOffNotified := (integer1) l.min_off_notified;
			self.HourOffArrived    := (integer1) l.hr_off_arrived; 
			self.MinuteOffArrived  := (integer1) l.min_off_arrived;
    end;

 		//********### File1 (Accident Condition Info) Transform
	  iesp.accident.t_AccidentReportCondition file1_xform2(
	                                          FLAccidents.Key_FLCrash1 l) := transform
			self.LocationType       := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','LOCATION_TYPE','',l.location_type),
			self.Population         := l.pop_code,
			self.RuralUrban         := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RURAL_URBAN_CODE','',l.rural_urban_code),
			self.SiteLocation       := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SITE_LOC','',l.site_loc),
	    self.FirstHarmfulEvent  := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_HARMFUL_EVENT','',l.first_harmful_event),
	    self.SecondHarmfulEvent := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SUBS_HARMFUL_EVENT','',l.subs_harmful_event),
	    self.OnOffRoadway       := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ON_OFF_ROADWAY','',l.on_off_roadway),
			self.LightCondition     := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','LIGHT_CONDITION','',l.light_condition),
			self.Weather            := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','WEATHER','',l.weather),
			self.RoadSurfaceType    := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RD_SURFACE_TYPE','',l.rd_surface_type),
	    self.ShoulderType       := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','TYPE_SHOULDER','',l.type_shoulder),
			self.RoadSurfaceCondition := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RD_SURFACE_CONDITION','',l.rd_surface_condition),
			self.FirstContributingCause  := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_CONTRIB_CAUSE','',l.first_contrib_cause),
	    self.SecondContributingCause := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SECOND_CONTRIB_CAUSE','',l.second_contrib_cause);
	    self.FirstContributingEnvirionment  := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_CONTRIB_ENVIR','',l.first_contrib_envir),
	    self.SecondContributingEnvirionment := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SECOND_CONTRIB_ENVIR','',l.second_contrib_envir),
	    self.FirstTrafficControl  := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_TRAFFIC_CONTROL','',l.first_traffic_control),
	    self.SecondTrafficControl := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','SECOND_TRAFFIC_CONTROL','',l.second_traffic_control),
			self.TrafficwayChar       := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','TRAFFICWAY_CHAR','',l.trafficway_char),
			self.NumberOfLanes        := l.nbr_lanes,
	    self.DividedUndivided     := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','DIVIDED_UNDIVIDED','',l.divided_undivided),
			self.RoadSystemId         := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','RD_SYS_ID','',l.rd_sys_id);
			self.InvestigationAgent   := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_AGENCY','',l.invest_agency),
			self.InjurySeverity       := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ACCIDENT_INJURY_SEVERITY','',l.accident_injury_severity),
	    self.DamageSeverity       := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ACCIDENT_DAMAGE_SEVERITY','',l.accident_damage_severity),
			// Insurance field not in moxie results, so it is not included here.
	    //self.Insurance            := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ACCIDENT_INSUR_CODE','',l.accident_insur_code),
	    self.Insurance            := '',
			self.AccidentFault        := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ACCIDENT_FAULT_CODE','',l.accident_fault_code),
			self.AlcoholDrug          := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','ALCOHOL_DRUG','',l.alcohol_drug),
		end;

 		//********### File1 (Accident Investigation Info) Transform
	  iesp.accident.t_AccidentReportInvestigation file1_xform3(
	                                              FLAccidents.Key_FLCrash1 l) := transform
	    self.InvestigationAgent.AgentReportNumber   := l.invest_agy_rpt_nbr,
	    self.InvestigationAgent.AgentName           := l.invest_name,
	    self.InvestigationAgent.AgentRank           := l.invest_rank,
	    self.InvestigationAgent.AgentIdBadgeNumber  := l.invest_id_badge_nbr,
	    self.InvestigationAgent.AgentDepartmentName := l.dept_name,
	    self.InvestMaede         := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_MAEDE','',l.invest_maede),
			self.InvestComplete      := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INVEST_COMPLETE','',l.invest_complete),
			// Couldn't find any examples of l.report_Date, so don't know what format it is in.
			self.SearchDate          := iesp.ECL2ESP.toDate ((integer4) l.report_date),
	    self.PhotosTaken         := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN','',l.photos_taken),
			self.PhotosTakenWhom     := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','PHOTOS_TAKEN_WHOM','',l.photos_taken_whom),
	    self.FirstAidName        := l.first_aid_name,
	    self.FirstAidPersonType  := codes.keyCodes('FLCRASH1_ACCIDENT_CHAR','FIRST_AID_PERSON_TYPE','',l.first_aid_person_type),
			// For InjuredTakenTo:
			// check l.injured_taken_to field first and use it if it is not empty, 
			// otherwise explode the l.injured_taken_to_code field
			self.InjuredTakenTo      := if (l.injured_taken_to<>'',
			                                l.injured_taken_to,
			                                codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','INJURED_TAKEN_TO_CODE','',l.injured_taken_to_code)),
			self.InjuredTakenBy      := l.injured_taken_by,
	    self.TypeDriverAccident  := codes.KeyCodes('FLCRASH1_ACCIDENT_CHAR','TYPE_DRIVER_ACCIDENT','',l.type_driver_accident),
	    self.HourOfEMSNotified   := l.hr_ems_notified,
	    self.MinuteOfEMSNotified := l.min_ems_notified,
	    self.HourOfEMSArrived    := l.hr_ems_arrived,
	    self.MinuteOfEMSArrived  := l.min_ems_arrived,
    end;
		
 		//********### File1 (Accident Statistics Info) Transform
	  iesp.accident.t_AccidentReportStatistics file1_xform4(
	                                           FLAccidents.Key_FLCrash1 l) := transform
      self.TotalTarDamage               := l.total_tar_damage,
	    self.TotalvehicleDamage           := l.total_vehicle_damage,
	    self.TotalPropertyDamage          := l.total_prop_damage_amt,
	    self.TotalNumberOfPersons         := (integer) l.total_nbr_persons,
	    self.TotalNumberOfDrivers         := (integer) l.total_nbr_drivers,
	    self.TotalNumberOfVehicles        := (integer) l.total_nbr_vehicles,
	    self.TotalNumberOfFatalities      := (integer) l.total_nbr_fatalities,
	    self.TotalNumberOfNonTrafficFatal := (integer) l.total_nbr_non_traffic_fatal,
	    self.TotalNumberOfInjuries        := (integer) l.total_nbr_injuries,
	    self.TotalNumberOfPedestrians     := (integer) l.total_nbr_pedestrian,
	    self.TotalNumberOfPedalcyclists   := (integer) l.total_nbr_pedalcyclist,
    end;


    //******** File3v (Vehicle addl Info: (towed trailer) Transform
	  iesp.accident.t_AccidentReportTowedTrailer file3_xform(
	                                             FLAccidents.Key_FLCrash3v l) := transform
      self.Year            := (integer) l.towed_trlr_veh_yr, 
			// For future enhancement, map the 4 character l.towed_trlr_make like is done in 
			// file2v xform below.  However not sure where to find all possible 4 char codes
			// and their explosion values?  
			// They are not on the FLCRASH3_TOWED_TRAILER_VEH portion of the ...codes_v3 file.
	    self.Make            := l.towed_trlr_make, 
	    self._Type           := codes.KeyCodes('FLCRASH3_TOWED_TRAILER_VEH','TOWED_TRAILER_TYPE','',l.towed_trailer_type); 
	    self.TagNumber       := l.towed_trlr_veh_tag_nbr,
	    self.State           := l.towed_trlr_veh_state,
	    self.IDNumber        := l.towed_trlr_veh_id_nbr,
	    self.EstimatedDamage := l.towed_trlr_veh_est_damage,
	    self.OwnerName       := l.towed_trlr_veh_owner_name,
			// For OwnerNameSuffix, moxie outputs the 1 char suffix code from the file as is,
			// so decided to also output it here as is instead of mapping it.
			// However for future enhancement, mapping coding left in, but commented out.
			self.OwnerNameSuffix := l.towed_trlr_veh_owner_name_suffix,
	    /*
			self.OwnerNameSuffix := map(l.towed_trlr_veh_owner_name_suffix = 'C' => '', //C=Company indicator
			                            l.towed_trlr_veh_owner_name_suffix = 'J' => 'Jr',
																	l.towed_trlr_veh_owner_name_suffix = 'S' => 'Sr',
																	l.towed_trlr_veh_owner_name_suffix = '2' => 'II',
																	l.towed_trlr_veh_owner_name_suffix = '3' => 'III',
																	// others ???
																	l.towed_trlr_veh_owner_name_suffix),
			*/
			// For the OwnerCity, the l.towed_trlr_veh_owner_st_city field data actually has 
			// the street address and the city name in it, which also matches what moxie
			// outputs.
	    self.OwnerCity       := l.towed_trlr_veh_owner_st_city,
	    self.OwnerState      := l.towed_trlr_veh_owner_st,
	    self.OwnerZip5       := l.towed_trlr_veh_owner_zip[1..5],
	    self.FRCap           := l.towed_trlr_fr_cap_code,
		end;


    //******** File4 (Driver Info) Transform
	  iesp.accident.t_AccidentReportDriver file4_xform(
	                                       FLAccidents.Key_FLCrash4 l) := transform
	    self.ResidentState               := l.driver_resident_state,
	    self.FirstSafety                 := codes.KeyCodes('FLCRASH4_DRIVER','FIRST_DRIVER_SAFETY','',l.first_driver_safety),
	    self.SecondSafety                := codes.KeyCodes('FLCRASH4_DRIVER','SECOND_DRIVER_SAFETY','',l.second_driver_safety),
	    self.Eject                       := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_EJECT_CODE','',l.driver_eject_code),
	    self.RecommandReExam             := codes.KeyCodes('FLCRASH4_DRIVER','RECOMMAND_REEXAM','',l.recommand_reexam),
	    self.PhoneNumber                 := l.driver_phone_nbr,
	    self.DriverLicenseNumberGoodBad  := codes.KeyCodes('FLCRASH4_DRIVER','DL_NBR_GOOD_BAD','',l.dl_nbr_good_bad),
			self.ReqEndorsement              := codes.KeyCodes('FLCRASH4_DRIVER','REQ_ENDORSEMENT','',l.req_endorsement),
			self.OosDriverLicenseNumber      := l.oos_dl_nbr,
			self.DriverLicense.LicenseNumber := if (in_mod.mask_dl and l.driver_dl_nbr != '', suppress.dl_mask (l.driver_dl_nbr), l.driver_dl_nbr);
			self.DriverLicense.ForceAsterisk := l.driver_dl_force_asterisk,
			self.DriverLicense.LicenseState  := l.driver_lic_st,
			self.DriverLicense.LicenseType   := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_LIC_TYPE','',l.driver_lic_type),
      // Individual.UniqueId field not in moxie results, so it is not included here.	
      //self.Individual.UniqueId         := l.did,
      self.Individual.UniqueId         := '',
			self.Individual.Name.Full        := '',
		  self.Individual.Name.First       := l.fname,
		  self.Individual.Name.Middle      := l.mname,
		  self.Individual.Name.Last        := l.lname,
		  self.Individual.Name.Suffix      := l.suffix,
      // Individual.Name.Prefix field not in moxie results, so it is not included here.	
		  //self.Individual.Name.Prefix      := l.title,
			self.Individual.Name.Prefix      := '',
			// File4 driver_dob is in mmddyyyy format, but iesp.ECL2ESP.toDate is expecting 
			// yyyymmdd format, so reformat it.
			self.Individual.DOB := iesp.ECL2ESP.toDate ((integer4) (l.driver_dob[5..8]+
			                                                        l.driver_dob[1..4])),
		  self.Individual.Address.StreetNumber        := l.prim_range,
		  self.Individual.Address.StreetPreDirection  := l.predir,
		  self.Individual.Address.StreetName          := l.prim_name,
			self.Individual.Address.StreetSuffix        := l.addr_suffix,
		  self.Individual.Address.StreetPostDirection := l.postdir,
		  self.Individual.Address.UnitDesignation     := l.unit_desig,
		  self.Individual.Address.UnitNumber          := l.sec_range,
		  self.Individual.Address.StreetAddress1      := '',
			self.Individual.Address.StreetAddress2      := '',
			self.Individual.Address.State               := l.st,
		  self.Individual.Address.City                := l.v_city_name,
			self.Individual.Address.Zip5                := l.zip,
		  self.Individual.Address.Zip4                := l.zip4,
			self.Individual.Address.County              := if(l.st<>'' and l.county<>'',
			                                               get_county_name(l.st, l.county),''),
			self.Individual.Address.PostalCode          := '',
			self.Individual.Address.StateCityZip        := '',
	    self.Individual.Sex                   := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_SEX','',l.driver_sex),
	    self.Individual.Race                  := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_RACE','',l.driver_race),
	    self.Individual.FRInjuryCap           := l.driver_fr_injury_cap_code,
      self.Individual.BACTestType           := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_BAC_TEST_TYPE','',l.driver_bac_test_type),
	    self.Individual.BACForce              := l.driver_bac_force_code,
	    self.Individual.BACTestResults        := l.driver_bac_test_results,
	    self.Individual.AlcoholDrug           := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_ALCO_DRUG_CODE','',l.driver_alco_drug_code),
	    self.Individual.PhysicalDefect        := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_PHYSICAL_DEFECTS','',l.driver_physical_defects),
	    self.Individual.Residence             := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_RESIDENCE','',l.driver_residence),
			self.Individual.InjurySeverity        := codes.KeyCodes('FLCRASH4_DRIVER','DRIVER_INJURY_SEVERITY','',l.driver_injury_severity),
	    self.Individual.FirstContributeCause  := codes.KeyCodes('FLCRASH4_DRIVER','FIRST_CONTRIB_CAUSE','',l.first_contrib_cause),
	    self.Individual.SecondContributeCause := codes.KeyCodes('FLCRASH4_DRIVER','SECOND_CONTRIB_CAUSE','',l.second_contrib_cause),
	    self.Individual.ThirdContributeCause  := codes.KeyCodes('FLCRASH4_DRIVER','THIRD_CONTRIB_CAUSE','',l.third_contrib_cause),
			self.Individual.ChargedOffenses := dataset([{l.first_offense_charged},
                                                  {l.second_offense_charged},
																								  {l.third_offense_charged},
																									{l.fourth_offense_charged},
																									{l.fifth_offense_charged},
																									{l.sixth_offense_charged},
																									{l.seveth_offense_charged},
																									{l.eighth_offense_charged}
																								 ],iesp.share.t_StringArrayItem);
	    self.Individual.FRDLCharges     := dataset([{l.first_frdl_sys_charge_code},
                                                  {l.second_frdl_sys_charge_code},
																								  {l.third_frdl_sys_charge_code},
																									{l.fourth_frdl_sys_charge_code},
																									{l.fifth_frdl_sys_charge_code},
																									{l.sixth_frdl_sys_charge_code},
																									{l.seveth_frdl_sys_charge_code},
																									{l.eighth_frdl_sys_charge_code}
																								 ],iesp.share.t_StringArrayItem);
      self.Individual.Citations       := dataset([{l.first_citation_nbr},
                                                  {l.second_citation_nbr},
																								  {l.third_citation_nbr},
																									{l.fourth_citation_nbr},
																									{l.fifth_citation_nbr},
																									{l.sixth_citation_nbr},
																									{l.seventh_citation_nbr},
																									{l.eighth_citation_nbr}
																								 ],iesp.share.t_StringArrayItem);
			self.InsuranceCompany := '';
			self.InsurancePolicyNumber := '';									 
    end;


    //******** File5 (Passenger Info) Transform
	  iesp.accident.t_AccidentReportPassenger file5_xform(
	                                          FLAccidents.Key_FLCrash5 l) := transform
      self.Number                      := (integer) l.passenger_nbr,
			self.Name.Full                   := '',
		  self.Name.First                  := l.fname,
		  self.Name.Middle                 := l.mname,
		  self.Name.Last                   := l.lname,
		  self.Name.Suffix                 := l.suffix,
			// Name.Prefix field not in moxie results, so it is not included here.
			//self.Name.Prefix                 := l.title,
		  self.Name.Prefix                 := '',
			// Gender is not on the file5 rec layout, so not sure where to get it from.
			// Plus the Gender field not in moxie results, so it is not included here.
      self.Gender                      := '', 
		  self.Address.StreetNumber        := l.prim_range,
		  self.Address.StreetPreDirection  := l.predir,
		  self.Address.StreetName          := l.prim_name,
			self.Address.StreetSuffix        := l.addr_suffix,
		  self.Address.StreetPostDirection := l.postdir,
		  self.Address.UnitDesignation     := l.unit_desig,
		  self.Address.UnitNumber          := l.sec_range,
		  self.Address.StreetAddress1      := '',
			self.Address.StreetAddress2      := '',
			self.Address.State               := l.st,
		  self.Address.City                := l.v_city_name,
			self.Address.Zip5                := l.zip,
		  self.Address.Zip4                := l.zip4,
 			self.Address.County              := if(l.st<>'' and l.county<>'',
			                                       get_county_name(l.st, l.county),''),
			self.Address.PostalCode          := '',
			self.Address.StateCityZip        := '',
	    self.Age                 := (integer) l.passenger_age,
    	self.Location            := codes.KeyCodes('FLCRASH5_PASSENGER','PASSENGER_LOCATION','',l.passenger_location),
	    self.InjurySeverity      := codes.KeyCodes('FLCRASH5_PASSENGER','PASSENGER_INJURY_SEV','',l.passenger_injury_sev),
	    self.FirstPassengerSafe  := codes.KeyCodes('FLCRASH5_PASSENGER','FIRST_PASSENGER_SAFE','',l.first_passenger_safe),
	    self.SecondPassengerSafe := codes.KeyCodes('FLCRASH5_PASSENGER','SECOND_PASSENGER_SAFE','',l.second_passenger_safe),
	    self.Eject               := codes.KeyCodes('FLCRASH5_PASSENGER','PASSENGER_EJECT_CODE','',l.passenger_eject_code),
	    self.FRInjuryCap         := l.passenger_fr_cap_code,
		end;


    //******** File6 (Pedestrian Info) Transform
	  iesp.accident.t_AccidentReportPedestrian file6_xform(
	                                           FLAccidents.Key_FLCrash6 l) := transform
			self.Action                 := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_ACTION','',l.ped_action),
	    self.DriverlicenseNumber    := if (in_mod.mask_dl and l.ped_dl_nbr != '', suppress.dl_mask (l.ped_dl_nbr), l.ped_dl_nbr);
      // Individual.UniqueId field not in moxie results, so it is not included here.	
      //self.Individual.UniqueId    := l.did,
      self.Individual.UniqueId    := '',
			self.Individual.Name.Full   := '',
		  self.Individual.Name.First  := l.fname,
		  self.Individual.Name.Middle := l.mname,
		  self.Individual.Name.Last   := l.lname,
		  self.Individual.Name.Suffix := l.suffix,
			// Individual.Name.Prefix field not in moxie results, so it is not included here.	
		  //self.Individual.Name.Prefix := l.title,
			self.Individual.Name.Prefix := '',
			// File6 ded_dob is in mmddyyyy format, but iesp.ECL2ESP.toDate is expecting 
			// yyyymmdd format, so reformat it.
			self.Individual.DOB := iesp.ECL2ESP.toDate ((integer4) (l.ded_dob[5..8]+
			                                                        l.ded_dob[1..4])),
		  self.Individual.Address.StreetNumber        := l.prim_range,
		  self.Individual.Address.StreetPreDirection  := l.predir,
		  self.Individual.Address.StreetName          := l.prim_name,
			self.Individual.Address.StreetSuffix        := l.addr_suffix,
		  self.Individual.Address.StreetPostDirection := l.postdir,
		  self.Individual.Address.UnitDesignation     := l.unit_desig,
		  self.Individual.Address.UnitNumber          := l.sec_range,
		  self.Individual.Address.StreetAddress1      := '',
			self.Individual.Address.StreetAddress2      := '',
			self.Individual.Address.State               := l.st,
		  self.Individual.Address.City                := l.v_city_name,
			self.Individual.Address.Zip5                := l.zip,
		  self.Individual.Address.Zip4                := l.zip4,
 			self.Individual.Address.County        := if(l.st<>'' and l.county<>'',
			                                            get_county_name(l.st, l.county),''),
		  self.Individual.Address.PostalCode    := '',
			self.Individual.Address.StateCityZip  := '',
	    self.Individual.Sex                   := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_SEX','',l.ped_sex),
	    self.Individual.Race                  := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_RACE','',l.ped_race),
	    self.Individual.FRInjuryCap           := l.ped_fr_injury_cap,
			self.Individual.BACtestType           := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_BAC_TEST_TYPE','',l.ped_bac_test_type),
			self.Individual.BACForce              := l.ped_bac_force_code,
	    self.Individual.BACTestResults        := l.ped_bac_results,
	    self.Individual.AlcoholDrug           := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_ALCO_DRUGS','',l.ped_alco_drugs),
			self.Individual.PhysicalDefect        := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_PHYSICAL_DEFECT','',l.ped_physical_defect),
			self.Individual.Residence             := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PD_RESIDENCE','',l.ped_residence),
			self.Individual.InjurySeverity        := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_INJURY_SEV','',l.ped_injury_sev),
	    self.Individual.FirstContributeCause  := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_FIRST_CONTRIB_CAUSE','',l.ped_first_contrib_cause),
			self.Individual.SecondContributeCause := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_SECOND_CONTRIB_CAUSE','',l.ped_second_contrib_cause),
			self.Individual.ThirdContributeCause  := codes.KeyCodes('FLCRASH6_PEDESTRIAN','PED_THIRD_CONTRIB_CAUSE','',l.ped_third_contrib_cause),
			self.Individual.ChargedOffenses := dataset([{l.first_offense_charged},
                                                  {l.second_offense_charged},
																								  {l.third_offense_charged},
																									{l.fourth_offense_charged},
																									{l.fifth_offense_charged},
																									{l.sixth_offense_charged},
																									{l.seventh_offense_charged},
																									{l.eighth_offense_charged}
																								 ],iesp.share.t_StringArrayItem);
	    self.Individual.FRDLCharges     := dataset([{l.first_frdl_sys_charge_code},
                                                  {l.second_frdl_sys_charge_code},
																								  {l.third_frdl_sys_charge_code},
																									{l.fourth_frdl_sys_charge_code},
																									{l.fifth_frdl_sys_charge_code},
																									{l.sixth_sys_charge_code},
																									{l.seventh_sys_charge_code},
																									{l.eighth_sys_charge_code}
																								 ],iesp.share.t_StringArrayItem);
      self.Individual.Citations       := dataset([{l.first_citation_nbr},
                                                  {l.second_citation_nbr},
																								  {l.third_citation_nbr},
																									{l.fourth_citation_issued},
																									{l.fifth_citation_issued},
																									{l.sixth_citation_issued},
																									{l.seventh_citation_issued},
																									{l.eighth_citation_issued}
																								 ],iesp.share.t_StringArrayItem);
    end;


    //******** File7 (Property Damage Info) Transform
	  iesp.accident.t_AccidentReportPropertyDamage file7_xform(
	                                            FLAccidents.Key_FLCrash7 l) := transform
	    self.PropertyDamageNumber  := l.prop_damage_nbr,
	    self.PropertyDamaged       := l.prop_damaged,
    	self.PropertyDamageAmount  := l.prop_damage_amount,
	    self.FRFixedObjectCap      := l.fr_fixed_object_cap_code,
      self.Owner.Name.Full       := '',
		  self.Owner.Name.First      := l.fname,
		  self.Owner.Name.Middle     := l.mname,
		  self.Owner.Name.Last       := l.lname,
		  self.Owner.Name.Suffix     := l.suffix,
			// Owner.Name.Prefix field not in moxie results, so it is not included here.
		  //self.Owner.Name.Prefix     := l.title,
			self.Owner.Name.Prefix     := '',
			// Gender is not on the file7 rec layout, so not sure where to get it from.
			// Plus the Gender field not in moxie results, so it is not included here.
      self.Owner.Gender          := '',
	    self.Owner.CompanyName     := l.cname,
		  self.Owner.Address.StreetNumber        := l.prim_range,
		  self.Owner.Address.StreetPreDirection  := l.predir,
		  self.Owner.Address.StreetName          := l.prim_name,
			self.Owner.Address.StreetSuffix        := l.addr_suffix,
		  self.Owner.Address.StreetPostDirection := l.postdir,
		  self.Owner.Address.UnitDesignation     := l.unit_desig,
		  self.Owner.Address.UnitNumber          := l.sec_range,
		  self.Owner.Address.StreetAddress1      := '',
			self.Owner.Address.StreetAddress2      := '',
			self.Owner.Address.State               := l.st,
		  self.Owner.Address.City                := l.v_city_name,
			self.Owner.Address.Zip5                := l.zip,
		  self.Owner.Address.Zip4                := l.zip4,
			self.Owner.Address.County              := if(l.st<>'' and l.county<>'',
			                                            get_county_name(l.st, l.county),''),
		  self.Owner.Address.PostalCode          := '',
			self.Owner.Address.StateCityZip        := '',
    end;


    //******** File2v (Vehicle basic & owner Info) Transform
	  iesp.accident.t_AccidentReportVehicle file2_xform(
                                          FLAccidents.Key_FLCrash2v l) := transform
			// Vehicle field not in moxie results, but it is included here to help 
			// identify vehicle order.
			self.Vehicle                 := l.section_nbr,
			self.OwnerDriver             := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_OWNER_DRIVER_CODE','',l.vehicle_owner_driver_code),
	    self.DriverAction            := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_DRIVER_ACTION','',l.vehicle_driver_action),
	    self.Year                    := (integer) l.vehicle_year, 
			// Data bug 34427 was resolved on 02/10/09, so now the make_description field can 
			// be used when it is not blank and it is not = to the model.
			// Otherwise explode the 4 character vehicle_make field into a valid value.
			self.Make                    := if(l.make_description <> '' AND
						                             l.make_description <> l.model_description,
			                                   l.make_description,
			                                   map(l.vehicle_make = 'ACUR' => 'Acura',
																				  //l.vehicle_make = 'AMGC' => 'A???', type=03=pickup/lt trk
																				  //l.vehicle_make = 'AMGE' => 'A????', model=HUMMER HMCO
																					l.vehicle_make = 'AMRT' => 'Aston Martin', //???
																					//l.vehicle_make = 'AMTR' => 'A????', //??? bicycle
																					l.vehicle_make = 'AUDI' => 'Audi',
																					//l.vehicle_make = 'BICY' => 'B????', type=10=motorcycle
																					//l.vehicle_make = 'BIKE' => 'Bike?', type=10=motorcycle
																					//l.vehicle_make = 'B???' => 'Bentley',
																					l.vehicle_make = 'BLUB' or 
																					l.vehicle_make = 'BLUE' => 'Blue Bird', //bus
																					l.vehicle_make = 'BMW'  => 'BMW',
																					//l.vehicle_make = 'BU'   => 'B????', //bus??
																					l.vehicle_make = 'BUEL' => 'Buell',
																					//l.vehicle_make = 'B???' => 'Bugatti',
																					l.vehicle_make = 'BUIC' => 'Buick',
																					l.vehicle_make = 'CADI' => 'Cadillac',
																					//l.vehicle_make = 'CARA' => 'C???', type=02=pass van
																					l.vehicle_make = 'CHEV' => 'Chevrolet',
			                                    l.vehicle_make = 'CHRY' => 'Chrysler',
																					//l.vehicle_make = 'CLAR' => 'C???',
																					//l.vehicle_make = 'CRUI' => 'C???', type=10=motorcycle
																					l.vehicle_make = 'DAEW' => 'Daewoo',
																					l.vehicle_make = 'DAIM' => 'Daimler', //or
																					//l.vehicle_make = 'DAIM' => 'Daimler-Chrysler',
																					l.vehicle_make = 'DATS' => 'Datsun',
																					//l.vehicle_make = 'DEER' => 'D??????', type=15=???
																					//l.vehicle_make = 'DELF' => 'D??????', type=09=bicycle
																					l.vehicle_make = 'DODG' => 'Dodge',
																					l.vehicle_make = 'EAGL' => 'Eagle Bus',
																					//l.vehicle_make = 'EURO' => 'E???', type=08=bus
																					//l.vehicle_make = 'FEC' => 'F???', type=13=train
																					l.vehicle_make = 'FERR' => 'Ferrari',
																					//l.vehicle_make = 'FEDE' => 'F???', type=05=heavy truck
																					//l.vehicle_make = 'FLEX' => 'F????', type=08=bus 
																					//l.vehicle_make = 'FLIX' => 'F????', type=08=bus
																					//l.vehicle_make = 'FLYE' => 'F????', bus
																					l.vehicle_make = 'FIRD' or 
																					l.vehicle_make = 'FORD' => 'Ford',
																					l.vehicle_make = 'FHRT' or 
																					l.vehicle_make = 'FL'   or 
																					l.vehicle_make = 'FRA'  or 
																					l.vehicle_make = 'FREI' or 
																					l.vehicle_make = 'FRHT' or 
																					l.vehicle_make = 'FRIE' or
																					l.vehicle_make = 'FRLN' or
																					l.vehicle_make = 'FRTL' or
																					l.vehicle_make = 'FTRL' => 'Freightliner',
																					// or 'FIRE' ???
																					l.vehicle_make = 'GEO'  => 'Geo',
																					//l.vehicle_make = 'GILL' => 'G??????', type=09=bicycle
																					//l.vehicle_make = 'GLLG' => 'G???????', type=09=bicycle
																					l.vehicle_make = 'GMC'  => 'GMC',
																					l.vehicle_make = 'GRUM'  => 'Grumman',
																					//l.vehicle_make = 'GTMN'  => 'G????', Motor home
																					l.vehicle_make = 'HARL' or 
																					l.vehicle_make = 'HD'   or 
																					l.vehicle_make = 'HRLY' => 'Harley Davidson',
																					l.vehicle_make = 'HOND' => 'Honda',
																					//l.vehicle_make = 'HUFF' => 'Huffy', ???
																					//l.vehicle_make = 'HUMM' or          ??? 
																					l.vehicle_make = 'HUMB' => 'Hummer',
																					//l.vehicle_make = 'HYST' => 'H?????', type=02=van
																					l.vehicle_make = 'HYND' or
																					l.vehicle_make = 'HYUK' or
																					l.vehicle_make = 'HYUN' => 'Hyundai',
																					//l.vehicle_make = 'ICCO' => 'I??????',
																					l.vehicle_make = 'INFI' or 
																					l.vehicle_make = 'INFN' => 'Infiniti',
																					//l.vehicle_make = 'INGI' => 'I???', type=04=med truck
																					//l.vehicle_make = 'INTK' => 'I????????????',
																					l.vehicle_make = 'INT'  or
																					l.vehicle_make = 'INTE' or 
																					l.vehicle_make = 'INTL' or 
																					l.vehicle_make = 'INTR' => 'International',
																					l.vehicle_make = 'ISU'  or
																					l.vehicle_make = 'ISUZ' => 'Isuzu',
																					//l.vehicle_make = 'ITL0' => 'I????', typo???
																					//l.vehicle_make = 'IZU' => 'I????', typo???
																					l.vehicle_make = 'JAG'  or  
																					l.vehicle_make = 'JAGU' => 'Jaguar',
																					l.vehicle_make = 'JDDP' or
																					l.vehicle_make = 'JEP'  or
																					l.vehicle_make = 'JEEP' or
																					l.vehicle_make = 'JEPP' => 'Jeep',
																					//l.vehicle_make = 'JOHN' => 'Johnson????',
																					l.vehicle_make = 'KAW'  or
																					l.vehicle_make = 'KAWA' => 'Kawasaki',
																					l.vehicle_make = 'KENN' or 
																					l.vehicle_make = 'KENW' or 
																					l.vehicle_make = 'KW'   => 'Kenworth',
																					l.vehicle_make = 'KIA'  => 'Kia',
																					//l.vehicle_make = 'KME' => 'K???', type=05=heavy truck
																					//l.vehicle_make = 'KOMA' => 'K????',
																					//l.vehicle_make = 'KUBO' => 'K????', type=77=''
																					//l.vehicle_make = 'L???' => 'Lamborghini',
																					l.vehicle_make = 'LAND' or  
																					l.vehicle_make = 'LNDR' => 'Land Rover',
																					l.vehicle_make = 'LEX'  or
																					l.vehicle_make = 'LEXS' or
																					l.vehicle_make = 'LEXU' => 'Lexus',
																					l.vehicle_make = 'LICN' or  
																					l.vehicle_make = 'LINC' => 'Lincoln',
																					//l.vehicle_make = 'LODA' => 'L???', type=03=pickup
																					l.vehicle_make = 'MACK' or 
																					l.vehicle_make = 'MCK'  => 'Mack',
																					//l.vehicle_make = 'MAGN' => 'M?????', type=10=motorcycle
																					//l.vehicle_make = 'MAIL' => 'Mail Truck??????',
																					//l.vehicle_make = 'MASK' => 'M??????????????',
																					//l.vehicle_make = 'M???' => 'Maserati',
																					//l.vehicle_make = 'M???' => 'Maybach',
																					l.vehicle_make = 'MAZD' => 'Mazda',
																					//l.vehicle_make = 'MCI' => 'M?????',
																					l.vehicle_make = 'MEEZ' or 
																					l.vehicle_make = 'MERZ' => 'Mercedes Benz',
																					l.vehicle_make = 'MER'  or
																					l.vehicle_make = 'MERC' or
																					l.vehicle_make = 'MERQ' => 'Mercury',
																					//l.vehicle_make = 'M???' => 'MINI', 
																					l.vehicle_make = 'MITS' => 'Mitsubishi',
																					//l.vehicle_make = 'MOTB' => 'M?????', type=12=ATV
																					//l.vehicle_make = 'MOTI' => 'M?????', type=10=motorcycle
																					//l.vehicle_make = 'MRS'  => 'M?????????????', 
																					//l.vehicle_make = 'NABI' => 'N?????', type=08=bus & 09=bicycle
																					l.vehicle_make = 'NAVI' => 'Navistar',
																					//l.vehicle_make = 'NESU' => 'N?????????????',
																					l.vehicle_make = 'NISS' or
																					l.vehicle_make = 'NISN' => 'Nissan',
																					//l.vehicle_make = 'NW' => 'N??', type=01=car
																					l.vehicle_make = 'OLDS' => 'Oldsmobile',
																					l.vehicle_make = 'OSHK' => 'Oshkosh',
																					//l.vehicle_make = 'PACI' => 'P???', type=10=motorcycle
																					//l.vehicle_make = 'P???' => 'Panoz', ???
																					l.vehicle_make = 'PETE' or
																					l.vehicle_make = 'PB'   or
																					l.vehicle_make = 'PBTI' or   //???
																					l.vehicle_make = 'PTRB' => 'Peterbilt',
																					l.vehicle_make = 'PLY'  or  
																					l.vehicle_make = 'PLYM' => 'Plymouth',
																					l.vehicle_make = 'PONT' => 'Pontiac',
																					//l.vehicle_make = 'PORC???' => 'Porsche',
																					//l.vehicle_make = 'RALE' => 'R????', type=10=motorcycle
																					//l.vehicle_make = 'ROAD' => 'R????', type=10=motorcycle
																					l.vehicle_make = 'ROLS' => 'Rolls Royce',
																					l.vehicle_make = 'SAAB' => 'Saab',
																					//l.vehicle_make = 'SAAS' => 'Saab',   ???
																					//l.vehicle_make = 'SABE' => 'S?????', 05 heavy truck
																					l.vehicle_make = 'SATN' or 
																					l.vehicle_make = 'SATU' or 
																					l.vehicle_make = 'STRN' => 'Saturn',
																					//l.vehicle_make = 'SCWI' => 'S?????', type=12=ATV
																					//l.vehicle_make = 'S???' => 'Scion', 
																					//l.vehicle_make = 'SEMI' => 'S?????????',
																					//l.vehicle_make = 'S???' => 'smart',
																					//l.vehicle_make = 'SMID' => 'S?????????',
																					l.vehicle_make = 'SPAR' => 'Spartan',
																					l.vehicle_make = 'STER' or 
																					l.vehicle_make = 'STLG' => 'Sterling',
																					l.vehicle_make = 'SUBA' or 
																					l.vehicle_make = 'SUBR' => 'Subaru', 
																					l.vehicle_make = 'SUZ'  or 
																					l.vehicle_make = 'SUZI' => 'Suzuki',
																					//l.vehicle_make = 'TMC'  => 'T????????',
																					l.vehicle_make = 'THMS' => 'Thomas Freightliner',
																					l.vehicle_make = 'THO'  or 
																					l.vehicle_make = 'THOM' => 'Thomas',
																					l.vehicle_make = 'TORO' => 'Toro',
																					l.vehicle_make = 'TOY' or
																					l.vehicle_make = 'TOYO' or
																					l.vehicle_make = 'TOYT' => 'Toyota',
																					l.vehicle_make = 'TRI'  => 'Triumph',
																					l.vehicle_make = 'UD'   => 'UD Trucks',
																					//l.vehicle_make = 'UK'   => 'U??????', type=09=bicycle
																					l.vehicle_make = 'VOLK' or 
																					l.vehicle_make = 'VW'   => 'Volkswagen',
																					l.vehicle_make = 'VOLV' => 'Volvo',
																					l.vehicle_make = 'WGMC' or 
																					l.vehicle_make = 'WHGM' or 
																					l.vehicle_make = 'WHIT' => 'White GMC',
																					l.vehicle_make = 'WINN' => 'Winnebago',
																					l.vehicle_make = 'WS'   or
																					l.vehicle_make = 'WSTR' => 'Western Star',
																					l.vehicle_make = 'YAMA' => 'Yamaha',
																			    l.vehicle_make)),
	    self._Type                   := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_TYPE','',l.vehicle_type),
	    self.TagNumber               := l.vehicle_tag_nbr,
	    self.RegisterState           := l.vehicle_reg_state,
	    self.IDNumber                := l.vehicle_id_nbr,
	    self.TravelOn                := l.vehicle_travel_on,
	    self.TravelDirection         := codes.KeyCodes('FLCRASH2_VEHICLE','DIRECTION_TRAVEL','',l.direction_travel),
	    self.EstimatedSpeed          := l.est_vehicle_speed,
	    self.PostedSpeed             := l.posted_speed,
	    self.EstimatedDamage         := l.est_vehicle_damage,
	    self.DamageType              := codes.KeyCodes('FLCRASH2_VEHICLE','DAMAGE_TYPE','',l.damage_type),
	    self.InsuranceCompany        := l.ins_company_name,
	    self.InsurancePolicyNumber   := l.ins_policy_nbr,
	    self.RemovedBy               := l.vehicle_removed_by,
	    self.HowRemoved              := codes.KeyCodes('FLCRASH2_VEHICLE','HOW_REMOVED_CODE','',l.how_removed_code),
	    self.PointOfImpact           := codes.KeyCodes('FLCRASH2_VEHICLE','POINT_OF_IMPACT','',l.point_of_impact),
	    self.Movement                := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_MOVEMENT','',l.vehicle_movement),
	    self._Function               := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_FUNCTION','',l.vehicle_function),
	    self.VehicleFirstDefect      := codes.KeyCodes('FLCRASH2_VEHICLE','VEHS_FIRST_DEFECT','',l.vehs_first_defect),
	    self.VehicleSecondDefect     := codes.KeyCodes('FLCRASH2_VEHICLE','VEHS_SECOND_DEFECT','',l.vehs_second_defect),
	    self.Modified                := l.vehicle_modified,
	    self.RoadwayLocation         := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_ROADWAY_LOC','',l.vehicle_roadway_loc),
	    self.HazardMaterialTransport := codes.KeyCodes('FLCRASH2_VEHICLE','HAZARD_MATERIAL_TRANSPORT','',l.hazard_material_transport),
	    self.TotalOccupants          := l.total_occu_vehicle,
	    self.TotalSaftyEquipments    := l.total_occu_saf_equip,
	    self.MovingViolation         := codes.KeyCodes('FLCRASH2_VEHICLE','MOVING_VIOLATION','',l.moving_violation),
      // Insurance field not in moxie results, so it is not included here.
			// However for future enhancement, mapping coding left in, but commented out.
			// In the FLCRASH2_VEHICLE portion of the ...codes_v3 file, the VEHICLE_INSUR_CODE 
			// entries explode codes 1 & 2, but the data contains I & U, so a map was used.
			/*
      self.Insurance               := map(l.vehicle_insur_code = 'I' => 'Vehicle Insured',
			                                    l.vehicle_insur_code = 'U' => 'Vehicle Un-Insured',
	                          							 '');
		  */
			self.Insurance               := '',
			self.Fault                   := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_FAULT_CODE','',l.vehicle_fault_code),
	    self.Cap                     := l.vehicle_cap_code,
	    self.FR                      := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_FR_CODE','',l.vehicle_fr_code),
	    self.Use                     := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_USE','',l.vehicle_use),
	    self.Placarded               := codes.KeyCodes('FLCRASH2_VEHICLE','PLACARDED','',l.placarded),
	    self.DhsmvInd                := l.dhsmv_vehicle_ind,
	    self.Model                   := l.model_description,  
	    self.Series                  := l.series_description,
      // Owner.UniqueId field not in moxie results, so it is not included here.	
			//self.Owner.UniqueId            := l.did,
      self.Owner.UniqueId            := '',
			self.Owner.Name.Full           := '',
		  self.Owner.Name.First          := l.fname,
		  self.Owner.Name.Middle         := l.mname,
		  self.Owner.Name.Last           := l.lname,
		  self.Owner.Name.Suffix         := l.suffix,
      // Owner.Name.Prefix field not in moxie results, so it is not included here.	
		  //self.Owner.Name.Prefix         := l.title,
	    self.Owner.Name.Prefix         := '',
			self.Owner.CompanyName         := l.cname,
	    self.Owner.DriverLicenseNumber := if (in_mod.mask_dl and l.vehicle_owner_dl_nbr != '', suppress.dl_mask (l.vehicle_owner_dl_nbr), l.vehicle_owner_dl_nbr);

			// File2V vehicle_owner_dob is in mmddyyyy format, but iesp.ECL2ESP.toDate is 
			// expecting yyyymmdd format, so reformat it.
			self.Owner.DOB := iesp.ECL2ESP.toDate ((integer4) (l.vehicle_owner_dob[5..8]+
			                                                   l.vehicle_owner_dob[1..4])),
			self.Owner.Sex  := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_OWNER_SEX','',l.vehicle_owner_sex),
      self.Owner.Race := codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_OWNER_RACE','',l.vehicle_owner_race),
      self.Owner.ForgeAsterisk       := l.vehicle_owner_forge_asterisk,
		  self.Owner.Address.StreetNumber        := l.prim_range,
		  self.Owner.Address.StreetPreDirection  := l.predir,
		  self.Owner.Address.StreetName          := l.prim_name,
			self.Owner.Address.StreetSuffix        := l.addr_suffix,
		  self.Owner.Address.StreetPostDirection := l.postdir,
		  self.Owner.Address.UnitDesignation     := l.unit_desig,
		  self.Owner.Address.UnitNumber          := l.sec_range,
		  self.Owner.Address.StreetAddress1      := '',
			self.Owner.Address.StreetAddress2      := '',
			self.Owner.Address.State               := l.st,
		  self.Owner.Address.City                := l.v_city_name,
			self.Owner.Address.Zip5                := l.zip,
		  self.Owner.Address.Zip4                := l.zip4,
			self.Owner.Address.County              := if(l.st<>'' and l.county<>'',
			                                             get_county_name(l.st, l.county),''),
      self.Owner.Address.PostalCode          := '',
			self.Owner.Address.StateCityZip        := '',
			self.TowedTrailer := project(FLAccidents.Key_FLCrash3v(keyed(in_accnbr = l_acc_nbr) AND
			                                                            l.section_nbr = section_nbr),
			 				             file3_xform(left))[1],
			self.Driver       := project(FLAccidents.Key_FLCrash4(keyed(in_accnbr = l_acc_nbr) AND
			                                                            l.section_nbr = section_nbr),
			             				 file4_xform(left))[1],
      //After the project, sort passengers in passenger# order.
			self.Passengers   := sort(project(FLAccidents.Key_FLCrash5(
			                                                    keyed(in_accnbr = l_acc_nbr) AND
			                                                    l.section_nbr = section_nbr),
			 				                          file5_xform(left))
													      ,Number),
    end;


    // **************** MAIN TRANSFORM ****************
    //******** File0 (Accident Location/DOT Info)
		
		iesp.accident.t_AccidentReportRecord file0_xform(
                                                   FLAccidents.Key_FLCrash0 l) := transform
					
		   self.AccidentDate      := iesp.ECL2ESP.toDate ((integer4) l.accident_date),
		   self.DhsmvVehicleCrash := l.dhsmv_veh_crash_ind,
	     self.FormType          := l.form_type,
	     self.UpdateNumber      := l.update_nbr,
	     self.AccidentState     := '',
			 self.AccidentLocation.StateRoadAccident      := l.st_road_accident,
       self.AccidentLocation.County                 := codes.KeyCodes('FLCRASH0_TIME_LOCATION','COUNTY_NBR','',l.city_nbr[1..2]),
			 self.AccidentLocation.City                   := codes.keyCodes('FLCRASH0_TIME_LOCATION','CITY_NBR','',l.city_nbr),
			 self.AccidentLocation.FootCityTown           := (integer) l.ft_city_town,
			 self.AccidentLocation.MilesCityTown          := (integer) l.miles_city_town,
			 self.AccidentLocation.DirectionCityTown      := l.direction_city_town,
			 self.AccidentLocation.CityTownName           := l.city_town_name,
			 self.AccidentLocation.AtNodeNumber           := l.at_node_nbr,
			 self.AccidentLocation.FootMilesNode          := l.ft_miles_node,
			 // FootMiles1 field not in moxie results, so it is not included here.
			 //self.AccidentLocation.FootMiles1             := l.ft_miles_code1,
			 self.AccidentLocation.FootMiles1             := '',
			 self.AccidentLocation.FromNodeNumber         := l.from_node_nbr,
			 self.AccidentLocation.NextNodeRoadway        := l.next_node_rdwy,
			 self.AccidentLocation.StateRoadHighwayName   := l.st_road_hhwy_name,
			 self.AccidentLocation.AtIntersectOf          := l.at_intersect_of,
			 self.AccidentLocation.FootMilesFromIntersect := l.ft_miles_from_intersect,
			 // FootMiles2 field not in moxie results, so it is not included here.
			 //self.AccidentLocation.FootMiles2             := l.ft_miles_code2,
			 self.AccidentLocation.FootMiles2             := '',
			 self.AccidentLocation.IntersectDirectionOf   := l.intersect_dir_of,
			 self.AccidentLocation.OfIntersectOf          := l.of_intersect_of,
			 // IsCodeable field not in moxie results, but it is included here because
			 // the output field type is boolean so it can not be blanked out.
			 // In the thor_data400::key::codes::yyyymmdd::codes_v3 file, the entries for   
			 // file_name=FLCRASH0_TIME_LOCATION and field_name=CODEABLE_NONCODEABLE, show  
			 // the value of 0 = Codeable & 1 = Non-Codeable.
			 // So the output IsCodeable boolean field is set accordingly.
			 self.AccidentLocation.IsCodeable := if(l.codeable_noncodeable = '0',
			                                        true,false),
			 self.AccidentLocation.TypeFRCase := codes.KeyCodes('FLCRASH0_TIME_LOCATION','TYPE_FR_CASE','',l.type_fr_case);
			 self.AccidentLocation.Action     := codes.KeyCodes('FLCRASH0_TIME_LOCATION','ACTION_CODE','',l.action_code),
       self.AccidentTime := project(FLAccidents.Key_FLCrash1(keyed(in_accnbr = l_acc_nbr)),
			 				file1_xform1(left))[1],
			 self.DotInfo.TypeFacility        := l.dot_type_facility,
	     self.DotInfo.RoadType            := l.dot_road_type,
       self.DotInfo.NumberOfLanes       := (integer) l.dot_nbr_lanes,
       self.DotInfo.SiteLocation        := l.dot_site_loc,
       self.DotInfo.DistrictIndex       := l.dot_district_ind,
       self.DotInfo.County              := l.dot_county,
       self.DotInfo.SectionNumber       := (integer) l.dot_section_nbr,
       self.DotInfo.SkidResistance      := l.dot_skid_resistance,
       self.DotInfo.FrictionCoarse      := l.dot_friction_coarse,
       self.DotInfo.AverageDailyTraffic := l.dot_avg_daily_traffic,
       self.DotInfo.NodeNumber          := (integer) l.dot_node_nbr,
       self.DotInfo.DistanceFromNode    := l.dot_distance_node,
       self.DotInfo.DirectionFromNode   := l.dot_dir_from_node,
       self.DotInfo.StateRoadNumber     := (integer) l.dot_st_road_nbr,
       self.DotInfo.USRoadNumber        := (integer) l.dot_us_road_nbr,
       self.DotInfo.Milepost            := l.dot_milepost,
       self.DotInfo.HighwayLocation     := l.dot_hhwy_loc,
       self.DotInfo.Subsection          := l.dot_subsection,
       self.DotInfo.SystemType          := l.dot_system_type,
       self.DotInfo.Travelway           := l.dot_travelway,
       self.DotInfo.NodeType            := l.dot_node_type,
       self.DotInfo.FixtureType         := l.dot_fixture_type,
       self.DotInfo.SideOfRoad          := l.dot_side_of_road,
       self.DotInfo.AccidentSeverity    := l.dot_accident_severity,
       self.DotInfo.LaneId              := (integer) l.dot_lane_id,
       self.Conditions := project(FLAccidents.Key_FLCrash1(keyed(in_accnbr = l_acc_nbr)),
			 				file1_xform2(left))[1], 
       self.Investigation := project(FLAccidents.Key_FLCrash1(keyed(in_accnbr = l_acc_nbr)),
			 				file1_xform3(left))[1], 
       self.Statistics := project(FLAccidents.Key_FLCrash1(keyed(in_accnbr = l_acc_nbr)),
			 				file1_xform4(left))[1], 
			 //self.Vehicles := project(FLAccidents.Key_FLCrash2v(keyed(in_accnbr = l_acc_nbr)),
			 //				file2_xform(left)),
       //After the project, sort vehicles in vehicle# order.
			 self.Vehicles := sort(project(FLAccidents.Key_FLCrash2v(keyed(in_accnbr = l_acc_nbr)),
			 				               file2_xform(left)),Vehicle),
			 self.PropertyDamages := project(FLAccidents.Key_FLCrash7(keyed(in_accnbr = l_acc_nbr)),
			 				file7_xform(left)),
			 self.Pedestrians := project(FLAccidents.Key_FLCrash6(keyed(in_accnbr = l_acc_nbr)),
			 				file6_xform(left)),
    end;
	
	empty_ds := dataset([],iesp.accident.t_AccidentReportRecord); 

	rec_proj := if(in_accnbr<>0,project(FLAccidents.Key_FLCrash0(keyed(in_accnbr = l_acc_nbr)),
								file0_xform(left)),empty_ds);
	
  //Uncomment lines below as needed to assist in debugging
	//output(in_accnbr,named('rr_in_accnbr'));
  //output(recs_proj, named('rr_recs_proj'));

  return rec_proj;

  end;

end;