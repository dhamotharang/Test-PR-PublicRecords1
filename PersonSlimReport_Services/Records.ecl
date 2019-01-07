IMPORT PersonSlimReport_Services, doxie, iesp, PersonReports, SmartRollup, ATF_Services, AutoStandardI, American_Student_Services;
EXPORT Records(DATASET(doxie.layout_references_hh) in_did, PersonSlimReport_Services.IParams.PersonSlimReportOptions in_mod) := FUNCTION	

//had to use this for firearms,accidents,education sections to avoid ABSTRACT Module error.....
globalMod := AutoStandardI.GlobalModule();
				 
/*1*/
		addresses := if(in_mod.IncludeAddresses,
										CHOOSEN(PersonSlimReport_Services.Functions.addressRecsByDid(in_did),iesp.Constants.PersonSlim.MaxAddresses));
														//DATASET([],iesp.personslimreport.t_PersonSlimReportAddress);
/*2*/
		phone_mod := module (project (in_mod, PersonReports.input.phonesplus, opt)) end;
		phones    := if(in_mod.IncludePhones,
										CHOOSEN(PersonReports.phonesplus_records(in_did,phone_mod).phonesplus,iesp.Constants.PersonSlim.MaxPhones));
														//DATASET([],iesp.dirassistwireless.t_PhonesPlusRecord);
/*3*/
		pl_mod    := module (project (in_mod, PersonReports.input.proflic, opt)) end;
		profLics  := if(in_mod.IncludeProfessionalLicenses,
										CHOOSEN(PersonReports.proflic_records(in_did,pl_mod).proflicenses_v2,iesp.Constants.PersonSlim.MaxProfLic));
														// DATASET([],iesp.proflicense.t_ProfessionalLicenseRecord);
/*4*/
		paw_mod   := module (project (in_mod, PersonReports.input.peopleatwork, opt)) end;
		paws      := if(in_mod.IncludePeopleAtWork,
										CHOOSEN(PersonReports.peopleatwork_records(in_did,paw_mod),iesp.Constants.PersonSlim.MaxPeopleAtWork));
														// DATASET([],iesp.peopleatwork.t_PeopleAtWorkRecord);
/*5*/
		ac_mod    := module (project (in_mod, PersonReports.input.aircrafts, opt)) end;
		aircrafts := if(in_mod.IncludeAircrafts,
										CHOOSEN(project(PersonReports.aircraft_records(in_did,ac_mod),iesp.faaaircraft.t_aircraftReportRecord),iesp.Constants.PersonSlim.MaxAircrafts));
														// DATASET([],iesp.faaaircraft.t_AircraftReportRecord);
/*6*/
		pil_mod   := module (project (in_mod, PersonReports.input.faacerts, opt)) end;
		pilotCerts:= if(in_mod.IncludePilotCerts,
										CHOOSEN(SmartRollup.fn_smart_rollup_faa_cert(project(PersonReports.faacert_records(in_did,pil_mod).bps_view,iesp.bpsreport.t_BpsFAACertification)),
														iesp.constants.PersonSlim.MaxFaaCerts));
														// DATASET([],iesp.bpsreport.t_BpsFAACertification);
/*7*/
		w_mod     := module (project (in_mod, PersonReports.input.watercrafts, opt)) end;
		watercfts := if(in_mod.IncludeWatercrafts,
										CHOOSEN(project(PersonReports.watercraft_records(in_did,w_mod).wtr_recs,iesp.watercraft.t_WaterCraftReportRecord),iesp.Constants.PersonSlim.MaxWatercrafts));
												    // DATASET([],iesp.watercraft.t_WaterCraftReportRecord);
/*8*/
		ucc_mod   := module (project (in_mod, PersonReports.input.ucc, opt)) end;
		uccs      := if(in_mod.IncludeUCCS,
										CHOOSEN(PersonReports.ucc_records(in_did,ucc_mod).ucc_v2,iesp.Constants.PersonSlim.MaxUCCs));
														// DATASET([],iesp.ucc.t_UCCReport2Record);
/*9*/
		so_mod    := module (project (in_mod, PersonReports.input.sexoffenses, opt)) end;								
	  sexOff    := if(in_mod.IncludeSexualOffences,
										CHOOSEN(PersonReports.sexoffenses_records(in_did,so_mod),iesp.Constants.PersonSlim.MaxSexOffenses));
										       // DATASET([],iesp.sexualoffender.t_SexOffReportRecord);
/*10*/
		crim_mod  := module (project (in_mod, PersonReports.input.criminal, opt)) end;
		crim      := if(in_mod.IncludeCrimRecords,
										CHOOSEN(PersonReports.criminal_records(in_did, crim_mod),iesp.constants.PersonSlim.MaxCrimRecords));  
												  // DATASET([],iesp.criminal.t_CrimReportRecord);
/*11*/
		ccw_mod   := module (project (in_mod, PersonReports.input.ccw, opt)) end;							 
		cWeapons  := if(in_mod.IncludeConcealedWeapons,
									  CHOOSEN(project(PersonReports.ccw_records(in_did, ccw_mod),iesp.concealedweapon.t_WeaponRecord),iesp.Constants.PersonSlim.MaxWeapons));
													// DATASET([],iesp.concealedweapon.t_WeaponRecord);
/*12*/
		huntFish  := if(in_mod.IncludeHuntingFishingPermits,
							      CHOOSEN(SmartRollup.fn_hunting_iesp(doxie.hunting_records(in_did)),iesp.Constants.PersonSlim.MaxHuntFish));
										    	// DATASET([],iesp.huntingfishing.t_HuntFishRecord);
/*13*/
		fire_mod  := MODULE (PROJECT(globalMod, ATF_Services.IParam.search_params,opt))
									EXPORT STRING14 did := in_mod.did;
								 END;
		firearms  := if(in_mod.IncludeFederalFirearms,
									  CHOOSEN(SmartRollup.fn_smart_rollup_atf(project(ATF_Services.SearchService_Records.report(fire_mod),iesp.firearm.t_FirearmRecord)),iesp.Constants.PersonSlim.MaxFirearms));
													// DATASET([],iesp.firearm.t_FirearmRecord);
/*14*/
		deaConSub := if(in_mod.IncludeControlledSubstances,
										CHOOSEN(SmartRollup.fn_smart_rollup_dea(PersonReports.dea_records(in_did)),iesp.Constants.PersonSlim.MaxDEA));
													// DATASET([],iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record);
/*15*/
		vote_mod  := module (project (in_mod, PersonReports.input.voters, opt)) end;	
		voters    := if(in_mod.IncludeVoters,
										CHOOSEN(SmartRollup.fn_smart_rollup_voter(PersonReports.voter_records(in_did,vote_mod).voters_v2),iesp.Constants.PersonSlim.MaxVoter));
													// DATASET([],iesp.voter.t_VoterReport2Record);
/*16*/
		dl        := if(in_mod.IncludeDriversLicenses,
										CHOOSEN(SmartRollup.fn_smart_rollup_dls(PersonReports.DL_records(in_did)), iesp.Constants.PersonSlim.MaxDLs));
													// DATASET([],iesp.driverlicense2.t_DLEmbeddedReport2Record);													
/*17*/
	acc_mod     := MODULE (project (globalMod, PersonReports.input.accidents, opt))
									EXPORT boolean mask_dl := in_mod.mask_dl;
								 END;
	v_accidents := if(in_mod.IncludeAccidents,
										CHOOSEN(PersonReports.accident_records(in_did, acc_mod),iesp.Constants.PersonSlim.MaxAccidents));
									        // DATASET([],iesp.accident.t_AccidentReportRecord);
/*18*/
	bk_mod      := module (project(in_mod, PersonReports.input.bankruptcy, opt)) end;
	bankruptcies:= if(in_mod.IncludeBankruptcies,
										CHOOSEN(SmartRollup.fn_smart_rollup_bankruptcy(PersonReports.bankruptcy_records(in_did, bk_mod).bankruptcy_v2),iesp.Constants.PersonSlim.MaxBankruptcies));
													// DATASET([],iesp.bankruptcy.t_BankruptcyReport2Record);									
/*19*/
	liens_mod   := MODULE (project(in_mod, PersonReports.input.liens, opt))
								  EXPORT string1 leins_party_type := 'D'; //debtor
							  END;
	liens       := if(in_mod.IncludeLiens,
									  CHOOSEN(SmartRollup.fn_smart_rollup_liens(project(PersonReports.lienjudgment_records(in_did, liens_mod).liensjudgment_v2,
														iesp.lienjudgement.t_LienJudgmentReportRecord)),iesp.Constants.PersonSlim.MaxLiens));
													// DATASET([],iesp.lienjudgement.t_LienJudgmentReportRecord);
/*20*/
	props_mod   := module (project(in_mod, PersonReports.input.property, opt)) end;
	properties  := if(in_mod.IncludeProperties,
										CHOOSEN(PersonReports.Property_Records(in_did,props_mod).property_v2,iesp.Constants.PersonSlim.MaxProperties));
													// DATASET([],iesp.property.t_PropertyReport2Record);											
/*21*/
	marrDivorces:= if(in_mod.IncludeMarriageDivorces,
										CHOOSEN(PersonReports.marriagedivorce_records(in_did),iesp.Constants.PersonSlim.MaxMarriageDiv));
													// DATASET([],iesp.marriagedivorce.t_MarriageSearch2Record);
/*22*/
	student_mod := module(project(globalMod, American_Student_Services.IParam.reportParams,opt)) end;
	onlyCurrent := true;  //request only current student records									
	eduStudentV2:= if(in_mod.IncludeEducation,
										CHOOSEN(American_Student_Services.Functions.get_report_recs(in_did,student_mod,onlyCurrent),iesp.Constants.PersonSlim.MaxStudent));
									       // DATASET([],iesp.student.t_StudentRecord);
												 
	pers_mod    := module (project (in_mod, PersonReports.input.personal, opt)) end;
	pers        := PersonReports.Person_records (in_did, pers_mod);

/*23*/
	vehicles_mod:= module (project (in_mod, PersonReports.input.vehicles, opt)) end;
	vehicles_v2 := PersonReports.vehicle_records (in_did,vehicles_mod).vehicles_v2;
										// CHOOSEN(SmartRollup.fn_smart_rollup_veh(PersonReports.vehicle_records (in_did,vehicles_mod).vehicles_v2,(unsigned6)in_mod.did),iesp.Constants.PersonSlim.MaxVehicles));
													// DATASET([],iesp.motorvehicle.t_MotorVehicleReport2Record); V_ID - VehicleInfo.vin,VehicleInfo.make,VehicleInfo.model 	

	w_best_addr := project(pers.bestrecs,TRANSFORM(doxie.Layout_Comp_Addresses,SELF:=LEFT,SELF:=[]));
	w_best_name := project(w_best_addr,doxie.layout_NameDID);
	rtv := if(in_mod.IncludeRealTimeVehicles,doxie.Comp_RealTime_Vehicles(in_did,w_best_addr,w_best_name).do);

	vehicles := vehicles_v2 + rtv;
	vehicles_final := if(in_mod.IncludeMotorVehicles,
											CHOOSEN(SmartRollup.fn_smart_rollup_veh(vehicles,(unsigned6)in_mod.did),iesp.Constants.PersonSlim.MaxVehicles));

/*24*/
// •	Names Associated with Subject 'AKA' - 'Also Known As'
	akas        := if(in_mod.IncludeAKAs,
										CHOOSEN (SmartRollup.fn_smart_rollup_names(project(pers.Akas,iesp.bps_share.t_BpsReportIdentity)),iesp.Constants.PersonSlim.MaxAKA));
												// DATASET([],iesp.bps_share.t_BpsReportIdentity);
/*25*/
// •	Others Associated with Subjects SSN
	imposters   := if(in_mod.IncludeImposters,
										CHOOSEN (SmartRollup.fn_smart_rollup_imposters(pers.imposters),iesp.Constants.PersonSlim.MaxImposters));
											// DATASET([],iesp.bps_share.t_BpsReportImposter);									
/*26*/
// •	Death records
	deaths      := if(in_mod.IncludeDeaths, //restrictions applied via global mod onsode inner function
										CHOOSEN (PersonReports.Death_records(in_did),iesp.Constants.PersonSlim.MaxDeaths));
											// DATASET([],iesp.death.t_DeathReportRecord);
/*27*/
// •	Utility records
	util        := if(in_mod.IncludeUtility,
									  CHOOSEN (PersonSlimReport_Services.Functions.utilityRecsByDid(in_did,in_mod),iesp.Constants.PersonSlim.MaxUtilities));
											// DATASET([],iesp.personslimreport.t_PersonSlimReportUtility);
		 
		iesp.personslimreport.t_PersonSlimReportResponse xformOut() := TRANSFORM
			header_row 	 := iesp.ECL2ESP.GetHeaderRow();
			SELF._Header := project(header_row,TRANSFORM(iesp.share.t_ResponseHeader,
																									SELF.Exceptions := DATASET([], iesp.share.t_WsException);
																									SELF := left));
			SELF.UniqueID 					    := in_mod.did;
			SELF.Addresses 						  := addresses;
			// SELF.Addresses 						  := DATASET([],iesp.personslimreport.t_PersonSlimReportAddress);
			SELF.Phones 						    := phones;
			// SELF.Phones 						    := DATASET([],iesp.dirassistwireless.t_PhonesPlusRecord);
			SELF.ProfessionalLicenses   := profLics;
			// SELF.ProfessionalLicenses   := DATASET([],iesp.proflicense.t_ProfessionalLicenseRecord);
			SELF.PeopleAtWorks          := paws;
			// SELF.PeopleAtWorks          := DATASET([],iesp.peopleatwork.t_PeopleAtWorkRecord);
			SELF.Aircrafts              := aircrafts;
			// SELF.Aircrafts              := DATASET([],iesp.faaaircraft.t_AircraftReportRecord);
			SELF.FAACertifications      := pilotCerts;
			// SELF.FAACertifications      := DATASET([],iesp.bpsreport.t_BpsFAACertification);
			SELF.Watercrafts            := watercfts;
			// SELF.Watercrafts            := DATASET([],iesp.watercraft.t_WaterCraftReportRecord);
			SELF.UCCFilings             := uccs;
			// SELF.UCCFilings             := DATASET([],iesp.ucc.t_UCCReport2Record);
			SELF.SexualOffenses         := sexoff;
			// SELF.SexualOffenses         := DATASET([],iesp.sexualoffender.t_SexOffReportRecord);
			SELF.Criminals              := crim;
			// SELF.Criminals              := DATASET([],iesp.criminal.t_CrimReportRecord);
			SELF.WeaponPermits          := cWeapons;
			// SELF.WeaponPermits          := DATASET([],iesp.concealedweapon.t_WeaponRecord);
			SELF.HuntingFishingLicenses := huntFish;
			// SELF.HuntingFishingLicenses := DATASET([],iesp.huntingfishing.t_HuntFishRecord);
		  SELF.FirearmExplosives      := firearms;
		  // SELF.FirearmExplosives      := DATASET([],iesp.firearm.t_FirearmRecord);
			SELF.ControlledSubstances   := deaConSub;
			// SELF.ControlledSubstances   := DATASET([],iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record);
			SELF.VoterRegistrations     := voters;
			// SELF.VoterRegistrations     := DATASET([],iesp.voter.t_VoterReport2Record);
			SELF.Drivers                := dl;
			// SELF.Drivers                := DATASET([],iesp.driverlicense2.t_DLEmbeddedReport2Record);
			SELF.Vehicles               := vehicles_final;
			// SELF.Vehicles               := DATASET([],iesp.motorvehicle.t_MotorVehicleReport2Record);
			SELF.Accidents              := v_accidents;
			// SELF.Accidents              := DATASET([],iesp.accident.t_AccidentReportRecord);
			SELF.Bankruptcies           := bankruptcies;
			// SELF.Bankruptcies           := DATASET([],iesp.bankruptcy.t_BankruptcyReport2Record);
			SELF.LiensJudgments         := liens;
			// SELF.LiensJudgments         := DATASET([],iesp.lienjudgement.t_LienJudgmentReportRecord);
			SELF.Properties             := properties;
			// SELF.Properties             := DATASET([],iesp.property.t_PropertyReport2Record);
			SELF.MarriageDivorces       := marrDivorces;
			// SELF.MarriageDivorces       := DATASET([],iesp.marriagedivorce.t_MarriageSearch2Record);
			SELF.Educations             := eduStudentV2;
			// SELF.Educations             := DATASET([],iesp.student.t_StudentRecord);
			SELF.AKAs                   := akas;
			// SELF.AKAs                   := DATASET([],iesp.bps_share.t_BpsReportIdentity);
			SELF.Imposters              := imposters;
			// SELF.Imposters              := DATASET([],iesp.bps_share.t_BpsReportImposter);
			SELF.Deaths                 := deaths;
			// SELF.Deaths                 := DATASET([],iesp.death.t_DeathReportRecord);
			SELF.Utilities              := util;
			// SELF.Utilities              := DATASET([],iesp.personslimreport.t_PersonSlimReportUtility);
		END;

		final_recs := DATASET([xformOut()]);
		RETURN final_recs;
END;