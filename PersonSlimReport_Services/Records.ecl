IMPORT PersonSlimReport_Services, doxie, iesp, PersonReports, SmartRollup,
       ATF_Services, AutoStandardI, American_Student_Services, Suppress;
EXPORT Records(DATASET(doxie.layout_references_hh) in_did,
           PersonSlimReport_Services.IParams.PersonSlimReportOptions in_mod) := FUNCTION	

 //had to use this for firearms,accidents,education sections to avoid ABSTRACT Module error...
 globalMod := AutoStandardI.GlobalModule();
 
 //filter out minors and suppress DID(s) before attempting to fetch any data....
  mod_access    := PersonSlimReport_Services.IParams.convertToDataAccess(in_mod);
  did_minorSafe := doxie.compliance.MAC_FilterOutMinors(in_did, , , mod_access.show_minors);
  Suppress.MAC_Suppress(did_minorSafe,did_safe,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);
 
 //the layout for each dataset is included in each commented section 
 
 //***ADDRESS RECS***\\ //DATASET([],iesp.personslimreport.t_PersonSlimReportAddress); 
 addresses := if(in_mod.IncludeAddresses,
                 CHOOSEN(PersonSlimReport_Services.Functions.addressRecsByDid(did_safe),
                        iesp.Constants.PersonSlim.MaxAddresses));
 
 //***PHONE RECS***\\ //DATASET([],iesp.dirassistwireless.t_PhonesPlusRecord);
 phone_mod := module (project (in_mod, PersonReports.input.phonesplus, opt)) end;
 phones    := if(in_mod.IncludePhones,
                 CHOOSEN(PersonReports.phonesplus_records(did_safe,phone_mod).phonesplus,
                         iesp.Constants.PersonSlim.MaxPhones));
 
 //***PROFESSIONAL LICENSE RECS***\\ // DATASET([],iesp.proflicense.t_ProfessionalLicenseRecord);
 pl_mod    := module (project (in_mod, PersonReports.input.proflic, opt)) end;
 profLics  := if(in_mod.IncludeProfessionalLicenses,
                 CHOOSEN(PersonReports.proflic_records(did_safe,pl_mod).proflicenses_v2,
                         iesp.Constants.PersonSlim.MaxProfLic));
 
 //***PEOPLE AT WORK RECS***\\ // DATASET([],iesp.peopleatwork.t_PeopleAtWorkRecord);
 paws := if(in_mod.IncludePeopleAtWork, PersonSlimReport_Services.Functions.pawRecsByDid(did_safe,in_mod));
 
 //***AIRCRAFT RECS***\\ // DATASET([],iesp.faaaircraft.t_AircraftReportRecord);
 ac_mod    := module (project (in_mod, PersonReports.input.aircrafts, opt)) end;
 aircrafts := if(in_mod.IncludeAircrafts,
                 CHOOSEN(project(PersonReports.aircraft_records(did_safe,ac_mod),iesp.faaaircraft.t_aircraftReportRecord),
                        iesp.Constants.PersonSlim.MaxAircrafts));
 
 //***PILOT CERTIFICATION RECS***\\ // DATASET([],iesp.bpsreport.t_BpsFAACertification);
 pil_mod   := module (project (in_mod, PersonReports.input.faacerts, opt)) end;
 pilotCerts:= if(in_mod.IncludePilotCerts,
                 CHOOSEN(SmartRollup.fn_smart_rollup_faa_cert(
                         project(PersonReports.faacert_records(did_safe,pil_mod).bps_view,iesp.bpsreport.t_BpsFAACertification)),
                         iesp.constants.PersonSlim.MaxFaaCerts));
 
 //***WATERCRAFT RECS***\\ // DATASET([],iesp.watercraft.t_WaterCraftReportRecord);
 w_mod     := module (project (in_mod, PersonReports.input.watercrafts, opt)) end;
 watercfts := if(in_mod.IncludeWatercrafts,
                 CHOOSEN(project(PersonReports.watercraft_records(did_safe,w_mod).wtr_recs,iesp.watercraft.t_WaterCraftReportRecord),
                         iesp.Constants.PersonSlim.MaxWatercrafts));
 
 //***UNIFORM COMMERCIAL CODE RECS***\\ // DATASET([],iesp.ucc.t_UCCReport2Record);
 ucc_mod   := module (project (in_mod, PersonReports.input.ucc, opt)) end;
 uccs      := if(in_mod.IncludeUCCS,
                 CHOOSEN(PersonReports.ucc_records(did_safe,ucc_mod).ucc_v2,
                         iesp.Constants.PersonSlim.MaxUCCs));
 
 //***SEXUAL OFFENCE RECS***\\ // DATASET([],iesp.sexualoffender.t_SexOffReportRecord);
 so_mod    := module (project (in_mod, PersonReports.input.sexoffenses, opt)) end;								
 sexOff    := if(in_mod.IncludeSexualOffences,
                 CHOOSEN(PersonReports.sexoffenses_records(did_safe,so_mod),
                         iesp.Constants.PersonSlim.MaxSexOffenses));
 
 //***CRIMINAL RECS***\\ // DATASET([],iesp.criminal.t_CrimReportRecord);
 crim_mod  := module (project (in_mod, PersonReports.input.criminal, opt)) end;
 crim      := if(in_mod.IncludeCrimRecords,
                 CHOOSEN(PersonReports.criminal_records(did_safe, crim_mod),
                         iesp.constants.PersonSlim.MaxCrimRecords));
 
 //***PHONE RECS***\\ // DATASET([],iesp.concealedweapon.t_WeaponRecord);
 ccw_mod   := module (project (in_mod, PersonReports.input.ccw, opt)) end;							 
 cWeapons  := if(in_mod.IncludeConcealedWeapons,
                 CHOOSEN(project(PersonReports.ccw_records(did_safe, ccw_mod),iesp.concealedweapon.t_WeaponRecord),
                         iesp.Constants.PersonSlim.MaxWeapons));
 
 //***HUNTING & FISHING RECS***\\ // DATASET([],iesp.huntingfishing.t_HuntFishRecord);
 huntFish  := if(in_mod.IncludeHuntingFishingPermits,
                 CHOOSEN(SmartRollup.fn_hunting_iesp(doxie.hunting_records(did_safe)),iesp.Constants.PersonSlim.MaxHuntFish));
 
 //***FEDERAL FIREARM RECS***\\ // DATASET([],iesp.firearm.t_FirearmRecord);
 fire_mod  := MODULE(PROJECT(globalMod, ATF_Services.IParam.search_params,opt))
                EXPORT STRING14 did := (STRING)did_safe[1].did;
              END;
 firearms  := if(in_mod.IncludeFederalFirearms,
                 CHOOSEN(SmartRollup.fn_smart_rollup_atf(project(ATF_Services.SearchService_Records.report(fire_mod),
                         iesp.firearm.t_FirearmRecord)),
                         iesp.Constants.PersonSlim.MaxFirearms));
 
 //***DEA CONTROLLED SUBSTANCE RECS***\\ // DATASET([],iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record);
 dea_mod   := module (project (in_mod, PersonReports.input.dea, opt)) end;	
 deaConSub := if(in_mod.IncludeControlledSubstances,
                 CHOOSEN(SmartRollup.fn_smart_rollup_dea(PersonReports.dea_records(did_safe,dea_mod)),
                         iesp.Constants.PersonSlim.MaxDEA));
 
 //***VOTER RECS***\\ // DATASET([],iesp.voter.t_VoterReport2Record);
 vote_mod  := module (project (in_mod, PersonReports.input.voters, opt)) end;	
 voters    := if(in_mod.IncludeVoters,
                 CHOOSEN(SmartRollup.fn_smart_rollup_voter(PersonReports.voter_records(did_safe,vote_mod).voters_v2),
                         iesp.Constants.PersonSlim.MaxVoter));
 
 //***DRIVERS LICENCE RECS***\\ // DATASET([],iesp.driverlicense2.t_DLEmbeddedReport2Record);
 dl := if(in_mod.IncludeDriversLicenses, PersonSlimReport_Services.Functions.dlsRecsByDid(did_safe));
 													
 //***ACCIDENT RECS***\\ // DATASET([],iesp.accident.t_AccidentReportRecord);
 acc_mod := MODULE (project (globalMod, PersonReports.input.accidents, opt))
              EXPORT boolean mask_dl := in_mod.mask_dl;
            END;
 accidents := if(in_mod.IncludeAccidents,
                   CHOOSEN(PersonReports.accident_records(did_safe, acc_mod),
                           iesp.Constants.PersonSlim.MaxAccidents));
 
 //***BANKRUPTCY RECS***\\ // DATASET([],iesp.bankruptcy.t_BankruptcyReport2Record);
 bk_mod      := module (project(in_mod, PersonReports.input.bankruptcy, opt)) end;
 bankruptcies:= if(in_mod.IncludeBankruptcies,
                  CHOOSEN(SmartRollup.fn_smart_rollup_bankruptcy(PersonReports.bankruptcy_records(did_safe, bk_mod).bankruptcy_v2),
                          iesp.Constants.PersonSlim.MaxBankruptcies));
 	
 //***LIEN RECS***\\ // DATASET([],iesp.lienjudgement.t_LienJudgmentReportRecord);
 liens_mod := MODULE (project(in_mod, PersonReports.input.liens, opt))
                EXPORT string1 leins_party_type := PersonSlimReport_Services.Constants.DEBTOR;
              END;
 liens := if(in_mod.IncludeLiens,
            CHOOSEN(SmartRollup.fn_smart_rollup_liens(project(PersonReports.lienjudgment_records(did_safe, liens_mod).liensjudgment_v2,
                    iesp.lienjudgement.t_LienJudgmentReportRecord)),iesp.Constants.PersonSlim.MaxLiens));
 
 //***PROPERTY RECS***\\ // DATASET([],iesp.property.t_PropertyReport2Record);
 props_mod  := module (project(in_mod, PersonReports.input.property, opt)) end;
 properties := if(in_mod.IncludeProperties,
                 CHOOSEN(PersonReports.Property_Records(did_safe,props_mod).property_v2,
                         iesp.Constants.PersonSlim.MaxProperties));
 								
 //***MARRIAGE & DIVORCE RECS***\\ // DATASET([],iesp.marriagedivorce.t_MarriageSearch2Record);
 marrDivorces:= if(in_mod.IncludeMarriageDivorces,
                  CHOOSEN(PersonReports.marriagedivorce_records(did_safe),
                         iesp.Constants.PersonSlim.MaxMarriageDiv));
 													
 //***STUDENT EDUCATION RECS***\\ // DATASET([],iesp.student.t_StudentRecord);
 student_mod := module(project(globalMod, American_Student_Services.IParam.reportParams,opt)) end;							
 eduStudentV2:= if(in_mod.IncludeEducation,
                   CHOOSEN(American_Student_Services.Functions.get_report_recs(did_safe,
									         student_mod,PersonSlimReport_Services.Constants.onlyCurrentStudentRecs),
                           iesp.Constants.PersonSlim.MaxStudent));
 
 // this get's generic person records by DID that will be used below 
 pers_mod := module (project (in_mod, PersonReports.input.personal, opt)) end;
 pers     := PersonReports.Person_records (did_safe, pers_mod);
 
 //***VEHICLE RECS***\\ including real time vehicles based on their input params
 vehicles_mod:= module (project (in_mod, PersonReports.input.vehicles, opt)) end;
 vehicles_v2 := PersonReports.vehicle_records (did_safe,vehicles_mod).vehicles_v2;
 
 //get best info
 w_best_addr := project(pers.bestrecs,TRANSFORM(doxie.Layout_Comp_Addresses,SELF:=LEFT,SELF:=[]));
 w_best_name := project(w_best_addr,doxie.layout_NameDID);
 
 //hit RTV GW
 rtv := if(in_mod.IncludeRealTimeVehicles,
          doxie.Comp_RealTime_Vehicles(did_safe,w_best_addr,w_best_name).do);
 
 //combine all vehicle recs
 vehicles := vehicles_v2 + rtv;
 vehicles_final := if(in_mod.IncludeMotorVehicles OR in_mod.IncludeRealTimeVehicles,
                     CHOOSEN(SmartRollup.fn_smart_rollup_veh(vehicles,did_safe[1].did),
                             iesp.Constants.PersonSlim.MaxVehicles));
 
 //***Names Associated with Subject 'AKA' - 'Also Known As' RECS***\\ // DATASET([],iesp.bps_share.t_BpsReportIdentity);
 akas := if(in_mod.IncludeAKAs,
           CHOOSEN(SmartRollup.fn_smart_rollup_names(project(pers.Akas,iesp.bps_share.t_BpsReportIdentity)),
                   iesp.Constants.PersonSlim.MaxAKA));
 
 //***IMPOSTER RECS - Others Associated with Subjects SSN***\\ // DATASET([],iesp.bps_share.t_BpsReportImposter);
 imposters := if(in_mod.IncludeImposters,
                 CHOOSEN(SmartRollup.fn_smart_rollup_imposters(pers.imposters),
                         iesp.Constants.PersonSlim.MaxImposters));
 						
 //***DEATH RECS***\\ // DATASET([],iesp.death.t_DeathReportRecord);
 deaths := if(in_mod.IncludeDeaths,
              CHOOSEN(PersonReports.Death_records(did_safe, in_mod),
                      iesp.Constants.PersonSlim.MaxDeaths));
 											
 //***UTILITY RECS***\\ // DATASET([],iesp.personslimreport.t_PersonSlimReportUtility);
 util := if(in_mod.IncludeUtility,
            CHOOSEN(PersonSlimReport_Services.Functions.utilityRecsByDid(did_safe,in_mod),
                   iesp.Constants.PersonSlim.MaxUtilities));

iesp.personslimreport.t_PersonSlimReportResponse xformOut() := TRANSFORM
	header_row 	 := iesp.ECL2ESP.GetHeaderRow();
	SELF._Header := project(header_row,TRANSFORM(iesp.share.t_ResponseHeader,
	                        SELF.Exceptions := DATASET([], iesp.share.t_WsException);
	                        SELF := left));
	SELF.UniqueID               := (STRING)did_safe[1].did;
	SELF.Addresses              := addresses;
	// SELF.Addresses              := DATASET([],iesp.personslimreport.t_PersonSlimReportAddress);
	SELF.Phones                 := phones;
	// SELF.Phones                 := DATASET([],iesp.dirassistwireless.t_PhonesPlusRecord);
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
	SELF.Accidents              := accidents;
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