IMPORT PersonSlimReport_Services, doxie, iesp, PersonReports, SmartRollup,
       ATF_Services, AutoStandardI, American_Student_Services, Suppress;

EXPORT Records(DATASET(doxie.layout_references_hh) in_did,
           PersonSlimReport_Services.IParams.PersonSlimReportOptions in_mod) := FUNCTION

  //had to use this for phones, accidents, atf sections to avoid ABSTRACT Module error...
  globalMod := AutoStandardI.GlobalModule();
  //a workaround for HPCC-23091 (or similar);
  m_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(globalMod);

  mod_access := PROJECT(in_mod, doxie.IDataAccess);
 //filter out minors and suppress DID(s) before attempting to fetch any data....
  did_minorSafe := doxie.compliance.MAC_FilterOutMinors(in_did, , , mod_access.show_minors);
  Suppress.MAC_Suppress(did_minorSafe,did_safe,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);

 //the layout for each dataset is included in each commented section

 //***ADDRESS RECS***\\ //DATASET([],iesp.personslimreport.t_PersonSlimReportAddress);
 addresses := if(in_mod.IncludeAddresses,
                 CHOOSEN(PersonSlimReport_Services.Functions(did_safe).addressRecsByDid(),
                        iesp.Constants.PersonSlim.MaxAddresses));

 //***PHONE RECS***\\ //DATASET([],iesp.personslimreport.t_PersonSlimReportPhone);
 phone_mod := MODULE(PROJECT(globalMod,doxie.phone_noreconn_param.searchParams,OPT))
  //if input in_mod or mod_access is used instead, this code fails when compiling the query
  // doxie.compliance.MAC_CopyModAccessValues(in_mod);
   doxie.compliance.MAC_CopyModAccessValues(m_access);
   EXPORT BOOLEAN IncludeFullPhonesPlus := in_mod.IncludeFullPhonesPlus;
  END;
 phones := if(in_mod.IncludePhones,
              CHOOSEN(PersonSlimReport_Services.Functions(did_safe).phoneRecsByDid(phone_mod),
                      iesp.Constants.PersonSlim.MaxPhones));

 //***DEATH RECS***\\ // DATASET([],iesp.personslimreport.t_PersonSlimReportDeath);
 deaths := if(in_mod.IncludeDeaths,
              CHOOSEN(PersonSlimReport_Services.Functions(did_safe).deathRecsByDid(in_mod.IncludeBlankDOD),
                      iesp.Constants.PersonSlim.MaxDeaths));

 //***SSN RECS***\\ // DATASET([],iesp.personslimreport.t_PersonSlimReportSSN);
 ssns := if(in_mod.IncludeSSNs,
            CHOOSEN(PersonSlimReport_Services.Functions(did_safe).ssnRecsByDid(),
                    iesp.Constants.PersonSlim.MaxDeaths));

 //***DOB RECS***\\ // DATASET([],iesp.personslimreport.t_PersonSlimReportDOB);
 dobs := if(in_mod.IncludeDOBs,
            CHOOSEN(PersonSlimReport_Services.Functions(did_safe).dobRecsByDid(),
                    iesp.Constants.PersonSlim.MaxDeaths));

 //***PROFESSIONAL LICENSE RECS***\\ // DATASET([],iesp.proflicense.t_ProfessionalLicenseRecord);
 profLics := if(in_mod.IncludeProfessionalLicenses,
        CHOOSEN(PersonSlimReport_Services.Functions(did_safe).profLicRecsByDid(in_mod),
                        iesp.Constants.PersonSlim.MaxProfLic));

 //***PEOPLE AT WORK RECS***\\ // DATASET([],iesp.peopleatwork.t_PeopleAtWorkRecord);
 paws := if(in_mod.IncludePeopleAtWork,
            CHOOSEN(PersonSlimReport_Services.Functions(did_safe).pawRecsByDid(in_mod),
                    iesp.Constants.PersonSlim.MaxPeopleAtWork));

 //***AIRCRAFT RECS***\\ // DATASET([],iesp.faaaircraft.t_AircraftReportRecord);
 aircrafts := if(in_mod.IncludeAircrafts,
                CHOOSEN(PersonSlimReport_Services.Functions(did_safe).acRecsByDid(in_mod),
                        iesp.Constants.PersonSlim.MaxAircrafts));

 //***PILOT CERTIFICATION RECS***\\ // DATASET([],iesp.bpsreport.t_BpsFAACertification);
 pilotCerts := if(in_mod.IncludePilotCerts,
                  CHOOSEN(PersonSlimReport_Services.Functions(did_safe).pilotCertRecsByDid(in_mod),
                          iesp.Constants.PersonSlim.MaxFaaCerts));

 //***WATERCRAFT RECS***\\ // DATASET([],iesp.watercraft.t_WaterCraftReportRecord);
 watercfts := if(in_mod.IncludeWatercrafts,
                 CHOOSEN(PersonSlimReport_Services.Functions(did_safe).wcRecsByDid(in_mod),
                        iesp.Constants.PersonSlim.MaxWatercrafts));

 //***UNIFORM COMMERCIAL CODE RECS***\\ // DATASET([],iesp.ucc.t_UCCReport2Record);
 uccs := if(in_mod.IncludeUCCS,
            CHOOSEN(PersonSlimReport_Services.Functions(did_safe).uccRecsByDid(in_mod),
                   iesp.Constants.PersonSlim.MaxUCCs));

 //***SEXUAL OFFENCE RECS***\\ // DATASET([],iesp.sexualoffender.t_SexOffReportRecord);
 sexOff := if(in_mod.IncludeSexualOffences,
             CHOOSEN(PersonSlimReport_Services.Functions(did_safe).sexOffRecsByDid(in_mod),
                    iesp.Constants.PersonSlim.MaxSexOffenses));

 //***CRIMINAL RECS***\\ // DATASET([],iesp.criminal.t_CrimReportRecord);
 crim := if(in_mod.IncludeCrimRecords,
            CHOOSEN(PersonSlimReport_Services.Functions(did_safe).crimRecsByDid(in_mod),
                   iesp.Constants.PersonSlim.MaxCrimRecords));

 //***CONCEALED WEAPONS RECS***\\ // DATASET([],iesp.concealedweapon.t_WeaponRecord);
 cWeapons := if(in_mod.IncludeConcealedWeapons,
               CHOOSEN(PersonSlimReport_Services.Functions(did_safe).cWeaponsRecsByDid(in_mod),
                      iesp.Constants.PersonSlim.MaxWeapons));

 //***HUNTING & FISHING RECS***\\ // DATASET([],iesp.huntingfishing.t_HuntFishRecord);
 huntFish := if(in_mod.IncludeHuntingFishingPermits,
                CHOOSEN(PersonSlimReport_Services.Functions(did_safe).huntFishRecsByDid(),
                       iesp.Constants.PersonSlim.MaxHuntFish));

 //***FEDERAL FIREARM RECS***\\ // DATASET([],iesp.firearm.t_FirearmRecord);
 fire_mod  := MODULE(PROJECT(globalMod, ATF_Services.IParam.search_params,opt))
                EXPORT STRING14 did := (STRING)did_safe[1].did;
              END;
 firearms := if(in_mod.IncludeFederalFirearms,
                 CHOOSEN(PersonSlimReport_Services.Functions(did_safe).firearmRecsByDid(fire_mod),
                        iesp.Constants.PersonSlim.MaxFirearms));

//***DEA CONTROLLED SUBSTANCE RECS***\\ // DATASET([],iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record);
 deaConSub := if(in_mod.IncludeControlledSubstances,
                 CHOOSEN(PersonSlimReport_Services.Functions(did_safe).deaConSubRecsByDid(in_mod),
                        iesp.Constants.PersonSlim.MaxDEA));

 //***VOTER RECS***\\ // DATASET([],iesp.voter.t_VoterReport2Record);
 voters := if(in_mod.IncludeVoters,
              CHOOSEN(PersonSlimReport_Services.Functions(did_safe).voterRecsByDid(in_mod),
                      iesp.Constants.PersonSlim.MaxVoter));

 //***DRIVERS LICENCE RECS***\\ // DATASET([],iesp.driverlicense2.t_DLEmbeddedReport2Record);
 dl := if(in_mod.IncludeDriversLicenses,
          CHOOSEN(PersonSlimReport_Services.Functions(did_safe).dlsRecsByDid(),
                 iesp.Constants.PersonSlim.MaxDLs));

 //***ACCIDENT RECS***\\ // DATASET([],iesp.accident.t_AccidentReportRecord);
 acc_mod := MODULE (project (globalMod, PersonReports.input.accidents, opt))
              EXPORT boolean mask_dl := in_mod.dl_mask > 0;
            END;
 accidents := if(in_mod.IncludeAccidents,
                 CHOOSEN(PersonSlimReport_Services.Functions(did_safe).accidentRecsByDid(acc_mod),
                        iesp.Constants.PersonSlim.MaxAccidents));

 //***BANKRUPTCY RECS***\\ // DATASET([],iesp.bankruptcy.t_BankruptcyReport2Record);
 bk_mod      := PROJECT(in_mod, PersonReports.IParam.bankruptcy, OPT);
 bankruptcies:= if(in_mod.IncludeBankruptcies,
                  CHOOSEN(SmartRollup.fn_smart_rollup_bankruptcy(PersonReports.bankruptcy_records(did_safe, mod_access, bk_mod).bankruptcy_v2),
                          iesp.Constants.PersonSlim.MaxBankruptcies));

 //***LIEN RECS***\\ // DATASET([],iesp.lienjudgement.t_LienJudgmentReportRecord);
 liens := if(in_mod.IncludeLiens,
            CHOOSEN(PersonSlimReport_Services.Functions(did_safe).liensRecsByDid(in_mod),
                    iesp.Constants.PersonSlim.MaxLiens));

 //***PROPERTY RECS***\\ // DATASET([],iesp.property.t_PropertyReport2Record);
 properties := if(in_mod.IncludeProperties,
                  CHOOSEN(PersonSlimReport_Services.Functions(did_safe).propertyRecsByDid(in_mod, mod_access),
                         iesp.Constants.PersonSlim.MaxProperties));

 //***MARRIAGE & DIVORCE RECS***\\ // DATASET([],iesp.marriagedivorce.t_MarriageSearch2Record);
 marrDivorces := if(in_mod.IncludeMarriageDivorces,
                    CHOOSEN(PersonSlimReport_Services.Functions(did_safe).marDivRecsByDid(in_mod),
                           iesp.Constants.PersonSlim.MaxMarriageDiv));

 //***STUDENT EDUCATION RECS***\\ // DATASET([],iesp.student.t_StudentRecord);
 student_mod := project(mod_access, American_Student_Services.IParam.reportParams);
 eduStudentV2 := if(in_mod.IncludeEducation,
                 CHOOSEN(PersonSlimReport_Services.Functions(did_safe).studentRecsByDid(student_mod),
                        iesp.Constants.PersonSlim.MaxStudent));

 // this get's generic person records by DID that will be used below
 pers_mod := module (project (in_mod, PersonReports.IParam.personal, opt)) end;
 pers     := PersonReports.Person_records (did_safe, mod_access, pers_mod);

 //***VEHICLE RECS***\\ // DATASET([],iesp.motorvehicle.t_MotorVehicleReport2Record);
 bestRecs := if(in_mod.IncludeRealTimeVehicles, pers.bestrecs, DATASET([],doxie.layout_best));
 vehicles := if(in_mod.IncludeMotorVehicles OR in_mod.IncludeRealTimeVehicles,
                CHOOSEN(PersonSlimReport_Services.Functions(did_safe).vehicleRecsByDid(in_mod,bestRecs),
                         iesp.Constants.PersonSlim.MaxVehicles));

 //***Names Associated with Subject 'AKA' - 'Also Known As' RECS***\\ // DATASET([],iesp.bps_share.t_BpsReportIdentity);
  akas_temp := if(in_mod.IncludeAKAs OR in_mod.IncludeNames,
                project(pers.Akas,iesp.bps_share.t_BpsReportIdentity), dataset([],iesp.bps_share.t_BpsReportIdentity));
  name_akas  := SmartRollup.fn_smart_rollup_names(akas_temp);

 akas:= if(in_mod.IncludeAKAs,
           CHOOSEN(PersonSlimReport_Services.Functions(did_safe).akaRecsByDid(name_akas),
                   iesp.Constants.PersonSlim.MaxAKA));

 //***NAME RECS***\\ // DATASET([],iesp.personslimreport.t_PersonSlimReportName);
 names := if(in_mod.IncludeNames,
              CHOOSEN(PersonSlimReport_Services.Functions(did_safe).nameRecsByDid(name_akas),
                      iesp.Constants.PersonSlim.MaxNames));

//***IMPOSTER RECS - Others Associated with Subjects SSN***\\ // DATASET([],iesp.bps_share.t_BpsReportIdentity);
 imposters:= if(in_mod.IncludeImposters,
                CHOOSEN(PersonSlimReport_Services.Functions(did_safe).imposterRecsByDid(pers.imposters),
                        iesp.Constants.PersonSlim.MaxImposters));

 //***UTILITY RECS***\\ // DATASET([],iesp.personslimreport.t_PersonSlimReportUtility);
 util := if(in_mod.IncludeUtility,
            CHOOSEN(PersonSlimReport_Services.Functions(did_safe).utilityRecsByDid(in_mod),
                   iesp.Constants.PersonSlim.MaxUtilities));

iesp.personslimreport.t_PersonSlimReportResponse xformOut() := TRANSFORM
  header_row    := iesp.ECL2ESP.GetHeaderRow();
  SELF._Header := project(header_row,TRANSFORM(iesp.share.t_ResponseHeader,
                          SELF.Exceptions := DATASET([], iesp.share.t_WsException);
                          SELF := left));
  SELF.UniqueID               := (STRING)did_safe[1].did;
  SELF.Addresses              := addresses;
  // SELF.Addresses              := DATASET([],iesp.personslimreport.t_PersonSlimReportAddress);
  SELF.Phones                 := phones;
  // SELF.Phones                 := DATASET([],iesp.personslimreport.t_PersonSlimReportPhone);
  SELF.Names                  := names;
  // SELF.Names                  := DATASET([],iesp.personslimreport.t_PersonSlimReportName);
  SELF.Deaths                 := deaths;
  // SELF.Deaths                 := DATASET([],iesp.personslimreport.t_PersonSlimReportDeath);
  SELF.SSNs                   := ssns;
  // SELF.SSNs                   := DATASET([],iesp.personslimreport.t_PersonSlimReportSSN);
  SELF.DOBs                   := dobs;
  // SELF.DOBs                   := DATASET([],iesp.personslimreport.t_PersonSlimReportDOB);
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
  SELF.Vehicles               := vehicles;
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
  // SELF.Imposters              := DATASET([],iesp.bps_share.t_BpsReportIdentity);
  SELF.Utilities              := util;
  // SELF.Utilities              := DATASET([],iesp.personslimreport.t_PersonSlimReportUtility);
END;

final_recs := DATASET([xformOut()]);
RETURN final_recs;
END;
