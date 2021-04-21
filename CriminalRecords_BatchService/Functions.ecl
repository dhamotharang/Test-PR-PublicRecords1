IMPORT AutokeyB2_batch, hygenics_crim, CriminalRecords_BatchService;
EXPORT Functions := MODULE
 
  // get acctno by auto keys which don't have any results or too many result back
  EXPORT get_ak_nr(DATASET(AutokeyB2_batch.Layouts.rec_output_IDs_batch) ak_nr) := FUNCTION
        
    CriminalRecords_BatchService.Layouts.batch_out xfm_ak_recs(RECORDOF(ak_nr) L , DATASET(RECORDOF(ak_nr)) R) :=TRANSFORM
      cur := IF (COUNT(R)>1,R(search_status=AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES)
                            ,R(search_status =AutokeyB2_batch.Constants.FAILED_NO_MATCHES));
                            
      SELF.too_many_flag:= 
        IF(cur[1].search_Status = AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES,
          'Y', IF(cur[1].search_Status = AutokeyB2_batch.Constants.FAILED_NO_MATCHES,
                'N',''));
      SELF := cur[1];
      SELF.too_many_code:= (STRING3) cur[1].search_status;
      SELF := [];
    END;
    ak_r := ak_nr(search_status=0);
    ak_nr1 := JOIN(ak_nr(Search_Status>0), ak_r, 
                LEFT.acctno = RIGHT.acctno, 
                LEFT ONLY);
                
    ak_nr_out := ROLLUP(GROUP(SORT(ak_nr1,acctno),acctno),GROUP,xfm_ak_recs(LEFT,ROWS(LEFT)));
    RETURN ak_nr_out;
  END;
 
  EXPORT Bitmap_all_includes (CriminalRecords_BatchService.IParam.batch_params configData) := FUNCTION
    RETURN
      IF(configData.IncludeArson ,hygenics_crim.Constants.ARSON ,0)|
      IF(configData.IncludeAssaultAgg ,hygenics_crim.Constants.ASSAULT_AGGRAVATED ,0)|
      IF(configData.IncludeAssaultOther ,hygenics_crim.Constants.ASSAULT_OTHER ,0)|
      IF(configData.IncludeBadChecks ,hygenics_crim.Constants.BADCHECKS ,0)|
      IF(configData.IncludeBribery ,hygenics_crim.Constants.BRIBERY ,0)|
      IF(configData.IncludeBurglaryComm ,hygenics_crim.Constants.BURGLARY_COMMERCIAL ,0)|
      IF(configData.IncludeBurglaryRes ,hygenics_crim.Constants.BURGLARY_RESIDENTIAL ,0)|
      IF(configData.IncludeBurglaryVeh ,hygenics_crim.Constants.BURGLARY_MOTOR_VEHICLE ,0)|
      IF(configData.IncludeComputer ,hygenics_crim.Constants.COMPUTER_CRIMES ,0)|
      IF(configData.IncludeCounterfeit ,hygenics_crim.Constants.COUNTERFEITING_FORGERY ,0)|
      IF(configData.IncludeCurLoiVag ,hygenics_crim.Constants.CURFEW_LOITERING_VAGRANCY ,0)|
      IF(configData.IncludeVandalism ,hygenics_crim.Constants.DESTRUCTION_DAMAGE_VANDALISM ,0)|
      IF(configData.IncludeDisorderly ,hygenics_crim.Constants.DISORDERLY_CONDUCT ,0)|
      IF(configData.IncludeDUI ,hygenics_crim.Constants.DRIVING_UNDER_THE_INFLUENCE ,0)|
      IF(configData.IncludeDrug ,hygenics_crim.Constants.DRUG_NARCOTIC ,0)|
      IF(configData.IncludeDrunk ,hygenics_crim.Constants.DRUNKENNESS ,0)|
      IF(configData.IncludeFamilyOff ,hygenics_crim.Constants.FAMILY_OFFENSES ,0)|
      IF(configData.IncludeFraud ,hygenics_crim.Constants.FRAUD ,0)|
      IF(configData.IncludeGambling ,hygenics_crim.Constants.GAMBLING ,0)|
      IF(configData.IncludeHomicide ,hygenics_crim.Constants.HOMICIDE ,0)|
      IF(configData.IncludeHumanTraff ,hygenics_crim.Constants.HUMAN_TRAFFICKING ,0)|
      IF(configData.IncludeIdTheft ,hygenics_crim.Constants.IDENTITY_THEFT ,0)|
      IF(configData.IncludeKidnapping ,hygenics_crim.Constants.KIDNAPPING_ABDUCTION ,0)|
      IF(configData.IncludeLiquorLaw ,hygenics_crim.Constants.LIQUOR_LAW_VIOLATIONS ,0)|
      IF(configData.IncludeMVTheft ,hygenics_crim.Constants.MOTOR_VEHICLE_THEFT ,0)|
      IF(configData.IncludePeepingTom ,hygenics_crim.Constants.PEEPING_TOM ,0)|
      IF(configData.IncludePornography ,hygenics_crim.Constants.PORNOGRAPHY_OBSCENE_MATERIAL ,0)|
      IF(configData.IncludeProstitution ,hygenics_crim.Constants.PROSTITUTION ,0)|
      IF(configData.IncludeRestraining ,hygenics_crim.Constants.RESTRAINING_ORDER_VIOLATIONS ,0)|
      IF(configData.IncludeRobberyComm ,hygenics_crim.Constants.ROBBERY_COMMERCIAL ,0)|
      IF(configData.IncludeRobberyRes ,hygenics_crim.Constants.ROBBERY_RESIDENTIAL ,0)|
      IF(configData.IncludeSOForce ,hygenics_crim.Constants.SEXOFFENSES_FORCIBLE ,0)|
      IF(configData.IncludeSONonForce ,hygenics_crim.Constants.SEXOFFENSES_NON_FORCIBLE ,0)|
      IF(configData.IncludeShoplift ,hygenics_crim.Constants.SHOPLIFTING ,0)|
      IF(configData.IncludeStolenProp ,hygenics_crim.Constants.STOLEN_PROPERTY_OFFENSES_FENCE ,0)|
      IF(configData.IncludeTerrorist ,hygenics_crim.Constants.TERRORIST_THREATS ,0)|
      IF(configData.IncludeTheft ,hygenics_crim.Constants.THEFT ,0)|
      IF(configData.IncludeTraffic ,hygenics_crim.Constants.TRAFFIC ,0)|
      IF(configData.IncludeTrespass ,hygenics_crim.Constants.TRESPASS_OF_REALPROPERTY ,0)|
      IF(configData.IncludeWeaponLaw ,hygenics_crim.Constants.WEAPON_LAW_VIOLATIONS ,0)|
      IF(configData.IncludeOther ,hygenics_crim.Constants.OTHER ,0)|
      IF(configData.IncludeCannotClassify ,hygenics_crim.Constants.CANNOT_CLASSIFY ,0)|
      IF(configData.IncludeWarrantFugitive ,hygenics_crim.Constants.WARRANT_FUGITIVE ,0)|
      IF(configData.IncludeObstructResist ,hygenics_crim.Constants.OBSTRUCT_RESIST ,0);
 END;
 
END;
