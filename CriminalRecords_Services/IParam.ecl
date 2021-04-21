IMPORT doxie, AutokeyI, AutoStandardI, SexOffender_Services, FCRA, Gateway, iesp, hygenics_crim;

EXPORT IParam := MODULE
  
  EXPORT ak_params := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := TRUE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT BOOLEAN isdeepDive := FALSE;
  END;
  
  EXPORT ids_params := INTERFACE
    EXPORT STRING14 did;
    EXPORT STRING25 doc_number := '';
    EXPORT STRING35 case_number := '';
    EXPORT STRING60 offender_key := '';
  END;
  
  EXPORT search := INTERFACE(
    doxie.IDataAccess,
    ak_params,
    ids_params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.noDeepDive.params,
    FCRA.iRules)
    EXPORT STRING DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default; //INTERFACES: different definitions in base modules
    EXPORT UNSIGNED2 MAX_DEEP_DIDS := 100;
    EXPORT STRING30 county_in := '';
    EXPORT STRING2 FilingJurisdictionState :='';
    EXPORT STRING8 CaseFilingStartDate := '';
    EXPORT STRING8 CaseFilingEndDate := '';
    EXPORT UNSIGNED OffenseCategories := 0; // bitmap
    EXPORT STRING OffenseType := '';
    EXPORT BOOLEAN ConvictionsOnly := FALSE;
  END;
    
  EXPORT report := INTERFACE(
    doxie.IDataAccess,
    ids_params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    SexOffender_Services.IParam.report, //includes IDataAccess
    FCRA.iRules)
    EXPORT STRING DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default; //INTERFACES: different definitions in base modules
    EXPORT BOOLEAN IncludeSexualOffenses := FALSE;
    EXPORT BOOLEAN IncludeAllCriminalRecords := FALSE;
    EXPORT DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
    EXPORT BOOLEAN SkipPersonContextCall := TRUE;
  END;

  EXPORT incarceration_report := INTERFACE(doxie.IDataAccess, FCRA.iRules)
    EXPORT UNSIGNED8 did := 0;
    EXPORT BOOLEAN ReturnDocName := FALSE;
    EXPORT BOOLEAN ReturnSSN := FALSE;
    EXPORT DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
  END;

  // INITALIZE offense categories bitmap - bitwise OR all selected option bit values
  EXPORT getOffenseCategories(iesp.criminal.t_CrimSearchOption option) := FUNCTION
    RETURN
      IF(option.GroupSelectCrimesAgainstPersons ,hygenics_crim.Constants.CRIMES_AGAINST_PERSONS ,0)|
      IF(option.GroupSelectCrimesAgainstProperty ,hygenics_crim.Constants.CRIMES_AGAINST_PROPERTY ,0)|
      IF(option.GroupSelectDrugAlcoholOffenses ,hygenics_crim.Constants.DRUG_ALCOHOL_OFFENSES ,0)|
      IF(option.GroupSelectFraudOffenses ,hygenics_crim.Constants.FRAUD_OFFENSES ,0)|
      IF(option.GroupSelectDomesticPersonalOffenses,hygenics_crim.Constants.DOMESTIC_PERSONAL_OFFENSES ,0)|
      IF(option.GroupSelectSexualOffenses ,hygenics_crim.Constants.SEXUAL_OFFENSES ,0)|
      IF(option.IncludeArson ,hygenics_crim.Constants.ARSON ,0)|
      IF(option.IncludeAssaultAggravated ,hygenics_crim.Constants.ASSAULT_AGGRAVATED ,0)|
      IF(option.IncludeAssaultOther ,hygenics_crim.Constants.ASSAULT_OTHER ,0)|
      IF(option.IncludeBribery ,hygenics_crim.Constants.BRIBERY ,0)|
      IF(option.IncludeBurglaryResidential ,hygenics_crim.Constants.BURGLARY_RESIDENTIAL ,0)|
      IF(option.IncludeBurglaryCommercial ,hygenics_crim.Constants.BURGLARY_COMMERCIAL ,0)|
      IF(option.IncludeBurglaryMotorVehicle ,hygenics_crim.Constants.BURGLARY_MOTOR_VEHICLE ,0)|
      IF(option.IncludeCounterfeitingForgery ,hygenics_crim.Constants.COUNTERFEITING_FORGERY ,0)|
      IF(option.IncludeDestructionDamageVandalism ,hygenics_crim.Constants.DESTRUCTION_DAMAGE_VANDALISM ,0)|
      IF(option.IncludeDrugNarcotic ,hygenics_crim.Constants.DRUG_NARCOTIC ,0)|
      IF(option.IncludeFraud ,hygenics_crim.Constants.FRAUD ,0)|
      IF(option.IncludeGambling ,hygenics_crim.Constants.GAMBLING ,0)|
      IF(option.IncludeHomicide ,hygenics_crim.Constants.HOMICIDE ,0)|
      IF(option.IncludeKidnappingAbduction ,hygenics_crim.Constants.KIDNAPPING_ABDUCTION ,0)|
      IF(option.IncludeTheft ,hygenics_crim.Constants.THEFT ,0)|
      IF(option.IncludeShoplifting ,hygenics_crim.Constants.SHOPLIFTING ,0)|
      IF(option.IncludeMotorVehicleTheft ,hygenics_crim.Constants.MOTOR_VEHICLE_THEFT ,0)|
      IF(option.IncludePornographyObsceneMaterial ,hygenics_crim.Constants.PORNOGRAPHY_OBSCENE_MATERIAL ,0)|
      IF(option.IncludeProstitution ,hygenics_crim.Constants.PROSTITUTION ,0)|
      IF(option.IncludeRobberyResidential ,hygenics_crim.Constants.ROBBERY_RESIDENTIAL ,0)|
      IF(option.IncludeRobberyCommercial ,hygenics_crim.Constants.ROBBERY_COMMERCIAL ,0)|
      IF(option.IncludeSexOffensesForcible ,hygenics_crim.Constants.SEXOFFENSES_FORCIBLE ,0)|
      IF(option.IncludeSexOffensesNonForcible ,hygenics_crim.Constants.SEXOFFENSES_NON_FORCIBLE ,0)|
      IF(option.IncludeStolenPropertyOffensesFence ,hygenics_crim.Constants.STOLEN_PROPERTY_OFFENSES_FENCE,0)|
      IF(option.IncludeWeaponLawViolations ,hygenics_crim.Constants.WEAPON_LAW_VIOLATIONS ,0)|
      IF(option.IncludeIdentityTheft ,hygenics_crim.Constants.IDENTITY_THEFT ,0)|
      IF(option.IncludeComputerCrimes ,hygenics_crim.Constants.COMPUTER_CRIMES ,0)|
      IF(option.IncludeHumanTrafficking ,hygenics_crim.Constants.HUMAN_TRAFFICKING ,0)|
      IF(option.IncludeTerroristThreats ,hygenics_crim.Constants.TERRORIST_THREATS ,0)|
      IF(option.IncludeRestrainingOrderViolations ,hygenics_crim.Constants.RESTRAINING_ORDER_VIOLATIONS ,0)|
      IF(option.IncludeTraffic ,hygenics_crim.Constants.TRAFFIC ,0)|
      IF(option.IncludeBadchecks ,hygenics_crim.Constants.BADCHECKS ,0)|
      IF(option.IncludeCurfewLoiteringVagrancy ,hygenics_crim.Constants.CURFEW_LOITERING_VAGRANCY ,0)|
      IF(option.IncludeDisorderlyConduct ,hygenics_crim.Constants.DISORDERLY_CONDUCT ,0)|
      IF(option.IncludeDrivingUnderTheInfluence ,hygenics_crim.Constants.DRIVING_UNDER_THE_INFLUENCE ,0)|
      IF(option.IncludeDrunkenness ,hygenics_crim.Constants.DRUNKENNESS ,0)|
      IF(option.IncludeFamilyOffenses ,hygenics_crim.Constants.FAMILY_OFFENSES ,0)|
      IF(option.IncludeLiquorLawViolations ,hygenics_crim.Constants.LIQUOR_LAW_VIOLATIONS ,0)|
      IF(option.IncludeTrespassOfRealProperty ,hygenics_crim.Constants.TRESPASS_OF_REALPROPERTY ,0)|
      IF(option.IncludePeepingTom ,hygenics_crim.Constants.PEEPING_TOM ,0)|
      IF(option.IncludeOther ,hygenics_crim.Constants.OTHER ,0)|
      IF(option.IncludeCannotClassify ,hygenics_crim.Constants.CANNOT_CLASSIFY ,0)|
      IF(option.IncludeWarrantFugitive ,hygenics_crim.Constants.WARRANT_FUGITIVE ,0)|
      IF(option.IncludeObstructResist ,hygenics_crim.Constants.OBSTRUCT_RESIST ,0);
  END;

END;
