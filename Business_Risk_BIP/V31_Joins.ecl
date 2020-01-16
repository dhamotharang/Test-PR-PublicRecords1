IMPORT Business_Risk_BIP, BizLinkFull, STD, BIPV2;

EXPORT V31_Joins := MODULE

  EXPORT joinV31BIP (DATASET(Business_Risk_BIP.Layouts.Shell) withDID, 
                    DATASET(Business_Risk_BIP.Layouts.Shell) BIPAppendv31,
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN Options, 
										BIPV2.mod_sources.iParams linkingOptions) := FUNCTION
  
  // Make sure that something is populated, even if we don't get a hit on the key, and verify that the attribute is included in the version we are running
    checkBlank(STRING field, STRING default_val, UNSIGNED minVersion=2) := MAP(Options.BusShellVersion < minVersion => '',
																																						 field = '' 												  => default_val,
																																																								     field);
    // Function to blank out attributes that are not to be returned in the requested business shell version.
    checkVersion(STRING field, UNSIGNED minVersion=2) := IF(Options.BusShellVersion < minVersion, '', field);

    calculateValueFor := Business_Risk_BIP.mod_BusinessShellVersionLogic(Options);
  
    chkInput := JOIN(withDID, BIPAppendv31, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
      SELF.BIP_IDs := RIGHT.BIP_IDs;
      SELF.Verification.InputIDMatchConfidence := checkBlank((STRING)RIGHT.SeleIDWeight,'0');
      SELF.Verification.InputIDMatchPowID		:= (STRING)RIGHT.BIP_IDs.PowID.LinkID;
      SELF.Verification.InputIDMatchProxID	:= (STRING)RIGHT.BIP_IDs.ProxID.LinkID;
      SELF.Verification.InputIDMatchSeleID	:= (STRING)RIGHT.BIP_IDs.SeleID.LinkID;
      SELF.Verification.InputIDMatchOrgID		:= (STRING)RIGHT.BIP_IDs.OrgID.LinkID;
      SELF.Verification.InputIDMatchUltID		:= (STRING)RIGHT.BIP_IDs.UltID.LinkID;
      SELF.UltIDWeight := RIGHT.UltIDWeight;
      SELF.UltIDScore := RIGHT.UltIDScore;
      SELF.OrgIDWeight := RIGHT.OrgIDWeight;
      SELF.OrgIDScore := RIGHT.OrgIDScore;
      SELF.SeleIDWeight := RIGHT.SeleIDWeight;
      SELF.SeleIDScore := RIGHT.SeleIDScore;
      SELF.ProxIDWeight := RIGHT.ProxIDWeight;
      SELF.ProxIDScore := RIGHT.ProxIDScore;
      SELF.PowIDWeight := RIGHT.PowIDWeight;
      SELF.PowIDScore := RIGHT.PowIDScore;
                        
      UseBest := LEFT.input_echo.SeleID <> 0 AND (LEFT.input_echo.Companyname = '' 
            AND LEFT.input_echo.StreetAddress1 = ''
						AND LEFT.input_echo.City = ''
						AND LEFT.input_echo.State = ''
						AND LEFT.input_echo.Zip = '');
                                                
      SELF.input_echo.companyname := IF(UseBest,RIGHT.input_echo.CompanyName, LEFT.input_echo.CompanyName);
      SELF.input_echo.StreetAddress1 := IF(UseBest,RIGHT.input_echo.StreetAddress1, LEFT.input_echo.StreetAddress1);
      SELF.input_echo.city := IF(UseBest,RIGHT.input_echo.City, LEFT.input_echo.City);
      SELF.input_echo.state := IF(UseBest,RIGHT.input_echo.State, LEFT.input_echo.State);
      SELF.input_echo.zip := IF(UseBest,RIGHT.input_echo.Zip, LEFT.input_echo.Zip);
      // SELF.input_echo.phone10 := IF(UseBest,(STRING10)RIGHT.input_echo.Phone10, LEFT.input_echo.Phone10);
      SELF.input_echo.FEIN := RIGHT.Clean_Input.FEIN;
      SELF.input_echo.phone10 := (STRING10)RIGHT.Clean_Input.Phone10;
      
      SELF.Clean_Input.companyname := RIGHT.Clean_Input.CompanyName;
      SELF.Clean_Input.city := RIGHT.Clean_Input.City;
      SELF.Clean_Input.state := RIGHT.Clean_Input.State;
      SELF.Clean_Input.phone10 := (STRING10)RIGHT.Clean_Input.Phone10;

      companyAddress := RIGHT.Clean_Input.StreetAddress1;
      companyAddress2 := RIGHT.Clean_Input.StreetAddress2;
      InputAddrValid := IF(companyAddress = '', '-1', '1'); 
                                                                    
      SELF.Verification.InputAddrValid := InputAddrValid;
      SELF.Verification.InputAddrValidNoID := calculateValueFor._InputAddrValidNoID(InputAddrValid);

      Chkphone10 := (STRING10)RIGHT.Clean_Input.Phone10;
      InputPhoneValid := IF(TRIM(Chkphone10) = '', '-1', Business_Risk_BIP.Common.SetBoolean(Business_Risk_BIP.Common.validPhone(Chkphone10)));
      SELF.Verification.InputPhoneValid := InputPhoneValid; 		// This will get set to -1 below if no BIP IDs assigned
      SELF.Verification.InputPhoneValidNoID := calculateValueFor._InputPhoneValidNoID(InputPhoneValid);
      
      SELF.Clean_Input.StreetAddress1 := companyAddress;
      SELF.Clean_Input.StreetAddress2 := TRIM(STD.Str.ToUppercase(companyAddress2));
      SELF.Clean_Input.Prim_Range :=  RIGHT.Clean_Input.Prim_Range;
      SELF.Clean_Input.Predir := RIGHT.Clean_Input.Predir;
      SELF.Clean_Input.Prim_Name := RIGHT.Clean_Input.Prim_Name;
      SELF.Clean_Input.Addr_Suffix := RIGHT.Clean_Input.Addr_Suffix;
      SELF.Clean_Input.FEIN := RIGHT.Clean_Input.FEIN;
      SELF.Clean_Input.Postdir := RIGHT.Clean_Input.Postdir;
      SELF.Clean_Input.Sec_Range := RIGHT.Clean_Input.Sec_Range;
      SELF.Clean_Input.Unit_Desig := RIGHT.Clean_Input.Unit_Desig; 

      SELF.Clean_Input.Zip5 := RIGHT.Clean_Input.Zip;

      BusNameCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(RIGHT.Input_Echo.CompanyName) <> '');
      SELF.Input.InputCheckBusName := BusNameCheck;
    
      SELF.Input.InputCheckBusAltName := Business_Risk_BIP.Common.SetBoolean(TRIM(RIGHT.Input_Echo.AltCompanyName) <> '');
    
      BusAddrLine1Check := Business_Risk_BIP.Common.SetBoolean(TRIM(companyAddress) <> ''); // To allow for both parsed and unparsed addresses check companyAddress
      SELF.Input.InputCheckBusAddr := BusAddrLine1Check;
    
      BusAddrCityCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(RIGHT.Clean_Input.City) <> '');
      SELF.Input.InputCheckBusCity := BusAddrCityCheck;
    
      BusAddrStateCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(RIGHT.Clean_Input.State) <> '');
      SELF.Input.InputCheckBusState := BusAddrStateCheck;
    
      BusAddrZipCheck := Business_Risk_BIP.Common.SetBoolean(TRIM(RIGHT.Clean_Input.Zip) <> '');
      SELF.Input.InputCheckBusZip := BusAddrZipCheck;
    
      InputCheckBusAddrZip := checkVersion(Business_Risk_BIP.Common.SetBoolean(
                                         BusAddrLine1Check = '1' AND (BusAddrZipCheck = '1' OR (BusAddrCityCheck = '1' AND BusAddrStateCheck = '1'))),
                                         Business_Risk_BIP.Constants.BusShellVersion_v31);
                                         
      SELF.Input.InputCheckBusAddrZip := InputCheckBusAddrZip;
    
      SELF := LEFT,
      SELF := []),
    LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
  
    // OUTPUT(ChkInput, NAMED('ChkInput'));
    // OUTPUT(dsReturn,NAMED('dsReturn'));
    
    RETURN ChkInput;
    
  END;
 
 EXPORT joinV31BIP_BestInfo (DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound, 
                    DATASET(Business_Risk_BIP.Layouts.Shell) BestBusinessInfo,
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := FUNCTION
  
    // Make sure that something is populated, even if we don't get a hit on the key, and verify that the attribute is included in the version we are running
    checkBlank(STRING field, STRING default_val, UNSIGNED minVersion=2) := MAP(Options.BusShellVersion < minVersion => '',
																																						 field = '' 												  => default_val,
																																																								     field);
    // Function to blank out attributes that are not to be returned in the requested business shell version.
    checkVersion(STRING field, UNSIGNED minVersion=2) := IF(Options.BusShellVersion < minVersion, '', field);

    calculateValueFor := Business_Risk_BIP.mod_BusinessShellVersionLogic(Options);
    
  	dsReturn := JOIN(LinkIDsFound, BestBusinessInfo, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
          SELF.Best_Info.BestCompanyName := RIGHT.Best_Info.BestCompanyName;
          SELF.Best_Info.BestCompanyAddress1 := RIGHT.Best_Info.BestCompanyAddress1;
          SELF.Best_Info.BestCompanyCity := RIGHT.Best_Info.BestCompanyCity;
          SELF.Best_Info.BestCompanyState := RIGHT.Best_Info.BestCompanyState;
          SELF.Best_Info.BestCompanyZip := RIGHT.Best_Info.BestCompanyZip;
          SELF.Best_Info.BestCompanyFEIN := RIGHT.Best_Info.BestCompanyFEIN;
          SELF.Best_Info.BestCompanyPhone := RIGHT.Best_Info.BestCompanyPhone;
          SELF.Best_Info.BestPrimRange := RIGHT.Best_Info.BestPrimRange;
          SELF.Best_Info.BestPreDir := RIGHT.Best_Info.BestPreDir;
          SELF.Best_Info.BestPrimName := RIGHT.Best_Info.BestPrimName;
          SELF.Best_Info.BestAddrSuffix := RIGHT.Best_Info.BestAddrSuffix;
          SELF.Best_Info.BestPostDir := RIGHT.Best_Info.BestPostDir;
          SELF.Best_Info.BestUnitDesig := RIGHT.Best_Info.BestUnitDesig;
          SELF.Best_Info.BestSecRange := RIGHT.Best_Info.BestSecRange;
          SELF.Best_Info.BestAssessedValue := checkBlank(RIGHT.Best_Info.BestAssessedValue, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
          SELF.Best_Info.BestLotSize := checkBlank(RIGHT.Best_Info.BestLotSize, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
          SELF.Best_Info.BestBldgSize := checkBlank(RIGHT.Best_Info.BestBldgSize, '0', Business_Risk_BIP.Constants.BusShellVersion_v30);
          SELF.Best_Info.BestTypeAdvo := checkBlank(RIGHT.Best_Info.BestTypeAdvo, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
          SELF.Best_Info.BestZipcodeType := checkBlank(RIGHT.Best_Info.BestZipcodeType, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
          SELF.Best_Info.BestVacancy := checkBlank(RIGHT.Best_Info.BestVacancy, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
          SELF.Best_Info.BestTypeOther := checkBlank(RIGHT.Best_Info.BestTypeOther, '-1', Business_Risk_BIP.Constants.BusShellVersion_v30);
          SELF.Verification.AddrIsBest := RIGHT.Verification.AddrIsBest;

          SELF.Input_Echo.CompanyName := RIGHT.Input_Echo.CompanyName;
          SELF.Input_Echo.StreetAddress1 := RIGHT.Input_Echo.StreetAddress1;
          SELF.Input_Echo.City := RIGHT.Input_Echo.City;
          SELF.Input_Echo.State := RIGHT.Input_Echo.State;
          SELF.Input_Echo.Zip := RIGHT.Input_Echo.Zip;
          SELF.Input_Echo.fein := RIGHT.Input_Echo.fein;
          SELF.Input_Echo.Phone10 := RIGHT.Input_Echo.Phone10;
          SELF.Input_Echo.prim_range := RIGHT.Input_Echo.prim_range;
          SELF.Input_Echo.predir := RIGHT.Input_Echo.predir;
          SELF.Input_Echo.prim_name := RIGHT.Input_Echo.prim_name ;
          SELF.Input_Echo.addr_suffix := RIGHT.Input_Echo.addr_suffix;
          SELF.Input_Echo.postdir := RIGHT.Input_Echo.postdir;
          SELF.Input_Echo.unit_desig := RIGHT.Input_Echo.unit_desig;
          SELF.Input_Echo.sec_range := RIGHT.Input_Echo.sec_range;          
          
          SELF.Clean_Input.Phone10 := (STRING10)RIGHT.Clean_Input.Phone10;
          
          SELF := LEFT),
    LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
    
    // OUTPUT(dsReturn, NAMED('gbh_Returned'));
    
    RETURN dsReturn;
    
  END;
  
END;
