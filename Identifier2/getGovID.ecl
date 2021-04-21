IMPORT iesp,STD;

EXPORT getGovID(dataset(identifier2.layout_Identifier2) in_ds,
                iesp.mod_identifier2.t_Identifier2Request.SearchBy SearchBy,       
                iesp.mod_identifier2.t_Identifier2Request.Options Options ) := FUNCTION
 
  in_rec := in_ds[1];
  SET OF UNSIGNED1 InputGovIdAttributes :=SET(SearchBy.GovIdInAttributes,(unsigned1)value);

  _GovIdConst := Identifier2.Constants.GovID;

  CheckAttrib(Unsigned1 AttribVal) := EXISTS(InputGovIdAttributes)  AND AttribVal IN InputGovIdAttributes;
  
  // Validate if which  individual attributes are enabled
  isCheck_SSNFullNameMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNFullNameMatch);
  isCheck_SSNDeathMatchVerification := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNDeathMatchVerification);
  isCheck_SSNExists := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNExists);
  isCheck_MultipleIdentitySSN := CheckAttrib(_GovIdConst.EnumGovIdAttrib.MultipleIdentitySSN);
  isCheck_SSNLastNameMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNLastNameMatch);
  isCheck_SSNYOBDateAlert := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNYOBDateAlert);
  isCheck_SSN4FullNameMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSN4FullNameMatch);
  isCheck_SSNRandomized := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNRandomized);
  isCheck_SSNHistory := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNHistory);
  isCheck_SSN5FullNameMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSN5FullNameMatch);
  isCheck_Addr1Zip_StateMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.Addr1Zip_StateMatch);
  isCheck_Addr1LastNameMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.Addr1LastNameMatch);
  isCheck_IdentityOccupancyVerified := CheckAttrib(_GovIdConst.EnumGovIdAttrib.IdentityOccupancyVerified);
  isCheck_AddrDeliverable := CheckAttrib(_GovIdConst.EnumGovIdAttrib.AddrDeliverable);
  isCheck_AddrNotBusiness := CheckAttrib(_GovIdConst.EnumGovIdAttrib.AddrNotBusiness);
  isCheck_AddrNotHighRisk := CheckAttrib(_GovIdConst.EnumGovIdAttrib.AddrNotHighRisk);
  isCheck_AddrNotMaildrop := CheckAttrib(_GovIdConst.EnumGovIdAttrib.AddrNotMaildrop);
  isCheck_PropertyAndDeed  := CheckAttrib(_GovIdConst.EnumGovIdAttrib.PropertyAndDeed );
  isCheck_IdentityOwnershipVerified := CheckAttrib(_GovIdConst.EnumGovIdAttrib.IdentityOwnershipVerified);
  isCheck_NameStreetAddressMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.NameStreetAddressMatch);
  isCheck_NameCityStateMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.NameCityStateMatch);
  isCheck_NameZipMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.NameZipMatch);
  isCheck_Age_Verification := CheckAttrib(_GovIdConst.EnumGovIdAttrib.Age_Verification);
  isCheck_YOBSSNMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.YOBSSNMatch);
  isCheck_DOBSSNMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.DOBSSNMatch);
  isCheck_DOBFullVerified := CheckAttrib(_GovIdConst.EnumGovIdAttrib.DOBFullVerified);
  isCheck_DOBMonthYearVerified := CheckAttrib(_GovIdConst.EnumGovIdAttrib.DOBMonthYearVerified);
  isCheck_DOBYearVerified := CheckAttrib(_GovIdConst.EnumGovIdAttrib.DOBYearVerified);
  isCheck_DOBMonthDayVerified := CheckAttrib(_GovIdConst.EnumGovIdAttrib.DOBMonthDayVerified);
  isCheck_PhoneLastNameMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.PhoneLastNameMatch);
  isCheck_PhoneNotMobile := CheckAttrib(_GovIdConst.EnumGovIdAttrib.PhoneNotMobile);
  isCheck_PhoneNotDisconnected := CheckAttrib(_GovIdConst.EnumGovIdAttrib.PhoneNotDisconnected);
  isCheck_PhoneVerified := CheckAttrib(_GovIdConst.EnumGovIdAttrib.PhoneVerified);
  isCheck_PhoneFullNameMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.PhoneFullNameMatch);
  isCheck_DriverLicenseMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.DriverLicenseMatch);
  isCheck_DriversLicenseVerification := CheckAttrib(_GovIdConst.EnumGovIdAttrib.DriversLicenseVerification);
  isCheck_PassportValidation := CheckAttrib(_GovIdConst.EnumGovIdAttrib.PassportValidation);
  isCheck_OFAC := CheckAttrib(_GovIdConst.EnumGovIdAttrib.OFAC);
  isCheck_AdditionalWatchlists := CheckAttrib(_GovIdConst.EnumGovIdAttrib.AdditionalWatchlists);
  isCheck_LexIDDeathMatch := CheckAttrib(_GovIdConst.EnumGovIdAttrib.LexIDDeathMatch);
  isCheck_SSNLowIssuance := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNLowIssuance);
  isCheck_SSNSSAValid := CheckAttrib(_GovIdConst.EnumGovIdAttrib.SSNSSAValid);


  // Calculate each attribute  
  // Descriptions for each of the below Risk Indicator codes can be found at Risk_Indicators.getHRIDesc

  SSNFullNameMatch := MAP(isCheck_SSNFullNameMatch AND in_rec.nas_summary IN [9,12]
                          AND ~EXISTS(in_rec.ri(hri in ['MI','29','77','79','76']))  => _GovIdConst.PassValue
                          ,isCheck_SSNFullNameMatch => _GovIdConst.FailValue
                          ,_GovIdConst.DisabledValue
                          );

  SSNDeathMatchVerification := MAP(isCheck_SSNDeathMatchVerification AND ~EXISTS(in_rec.ri(hri in ['02','79'])) => _GovIdConst.PassValue
                                   ,isCheck_SSNDeathMatchVerification => _GovIdConst.FailValue
                                   ,_GovIdConst.DisabledValue
                                    );
  
  SSNExists := MAP(isCheck_SSNExists AND in_rec.SSNExistsOnAnAddress.SSNExistsOnAnAddress 
                   AND ~EXISTS(in_rec.ri(hri in ['26','79'])) =>  _GovIdConst.PassValue
                   ,isCheck_SSNExists => _GovIdConst.FailValue
                   ,_GovIdConst.DisabledValue
                   );


  MultipleIdentitySSN := MAP(isCheck_MultipleIdentitySSN AND in_rec.additionalidentities.uniqueadlcount < Options.MaxIdentities
                            AND ~EXISTS(in_rec.ri(hri in ['MI','CL','26','79']))   =>  _GovIdConst.PassValue
                            ,isCheck_MultipleIdentitySSN => _GovIdConst.FailValue
                            ,_GovIdConst.DisabledValue
                          );


  SSNLastNameMatch := MAP(isCheck_SSNLastNameMatch AND in_rec.nas_summary IN [7,9,11,12]
                         AND ~EXISTS(in_rec.ri(hri in ['MI','29','77','79','76'])) => _GovIdConst.PassValue
                          ,isCheck_SSNLastNameMatch => _GovIdConst.FailValue
                          ,_GovIdConst.DisabledValue
                          );

  SSNYOBDateAlert := MAP(isCheck_SSNYOBDateAlert 
                                    AND in_rec.verssn <>''
                                    AND  (unsigned) in_rec.ssa_date_last[1..4] >= (unsigned)in_rec.verDOB[1..4]
                                    AND in_rec.DOBMatchLevel IN [5,6,7,8]
                                    AND  ~EXISTS(in_rec.ri(hri in ['MI','28','29','79','NB','81','83'])) =>  _GovIdConst.PassValue
                         ,isCheck_SSNYOBDateAlert =>   _GovIdConst.FailValue
                         ,_GovIdConst.DisabledValue
                         );      

   
  SSN4FullNameMatch := MAP(isCheck_SSN4FullNameMatch AND in_rec.nas_summary IN [9,12]
                          AND  ~EXISTS(in_rec.ri(hri in ['MI','79','77','29','76']))  => _GovIdConst.PassValue
                          ,isCheck_SSN4FullNameMatch => _GovIdConst.FailValue
                          ,_GovIdConst.DisabledValue
                          );
  
  SSNRandomized := MAP(isCheck_SSNRandomized AND EXISTS(in_rec.ri(hri in ['RS','IS'])) 
                       AND ~EXISTS(in_rec.ri(hri in ['29','79'])) => _GovIdConst.PassValue
                      ,isCheck_SSNRandomized => _GovIdConst.FailValue
                      ,_GovIdConst.DisabledValue
                      );

  SSNHistory := MAP(isCheck_SSNHistory AND ~EXISTS(in_rec.ri(hri ='IS'))
                    AND ~EXISTS(in_rec.ri(hri in ['MI','79','77','29','76']))  => _GovIdConst.PassValue
                    ,isCheck_SSNHistory => _GovIdConst.FailValue
                    ,_GovIdConst.DisabledValue
                    );
 
  SSN5FullNameMatch := MAP(isCheck_SSN5FullNameMatch AND in_rec.SSN5FullNameMatch = 2 => _GovIdConst.PassValue
                           ,isCheck_SSN5FullNameMatch => _GovIdConst.FailValue
                           ,_GovIdConst.DisabledValue
                           );
 
  Addr1Zip_StateMatch := MAP(isCheck_Addr1Zip_StateMatch AND in_rec.InputZipMatchesState.InputZipMatchesState
                            AND ~EXISTS(in_rec.ri(hri ='78'))  => _GovIdConst.PassValue
                             ,isCheck_Addr1Zip_StateMatch => _GovIdConst.FailValue
                             ,_GovIdConst.DisabledValue
                             );
    
  Addr1LastNameMatch := MAP(isCheck_Addr1LastNameMatch AND ( in_rec.nas_summary IN [5,8,11,12] OR in_rec.nap_summary in [8,12])
                            AND ~EXISTS(in_rec.ri(hri in ['MI','PA','37','77','78','76','30'])) => _GovIdConst.PassValue
                          ,isCheck_Addr1LastNameMatch => _GovIdConst.FailValue
                          ,_GovIdConst.DisabledValue
                          );

  IdentityOccupancyVerified := MAP(isCheck_IdentityOccupancyVerified AND in_rec.InputAddressEverOccupant.WasEverOccupant
                                  AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','78','76','30']))   => _GovIdConst.PassValue
                                   ,isCheck_IdentityOccupancyVerified => _GovIdConst.FailValue
                                   ,_GovIdConst.DisabledValue
                                   );

  AddrDeliverable := MAP(isCheck_AddrDeliverable AND ~EXISTS(in_rec.ri(hri in ['11','78'])) AND ~in_rec.ADVODoNotDeliver => _GovIdConst.PassValue
                        ,isCheck_AddrDeliverable => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );
    
  AddrNotBusiness := MAP(isCheck_AddrNotBusiness AND ~EXISTS(in_rec.ri(hri in['CO','MO','78']))
                         AND ~(TRIM(in_rec.ADVOResidentialOrBusinessInd) IN ['B', 'C', 'D'] OR TRIM(in_rec.Sic_Code) <> '') => _GovIdConst.PassValue
                        ,isCheck_AddrNotBusiness => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );
    
  AddrNotHighRisk := MAP(isCheck_AddrNotHighRisk AND ~EXISTS(in_rec.ri(hri IN ['14','50','78'])) AND ~(in_rec.ADVODoNotDeliver OR in_rec.USPISHotList OR in_rec.ADVOAddressVacancyIndicator OR TRIM(in_rec.ADVODropIndicator) IN ['C', 'Y']) => _GovIdConst.PassValue
                        ,isCheck_AddrNotHighRisk => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );
   
  AddrNotMaildrop := MAP(isCheck_AddrNotMaildrop AND ~EXISTS(in_rec.ri(hri IN ['PO','12','78'])) => _GovIdConst.PassValue
                        ,isCheck_AddrNotMaildrop => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );

  PropertyAndDeed := MAP(isCheck_PropertyAndDeed AND in_rec.EverOwnedInputProperty.IsPropertyOwner
                         AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','78','76','30'])) => _GovIdConst.PassValue
                        ,isCheck_PropertyAndDeed => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );
    
  IdentityOwnershipVerified := MAP(isCheck_IdentityOwnershipVerified AND in_rec.CurrentlyOwnInputProperty.IsPropertyOwner
                                  AND ~EXISTS(in_rec.ri(hri in ['MI','PA','37','77','78','76','30'])) => _GovIdConst.PassValue
                                  ,isCheck_IdentityOwnershipVerified => _GovIdConst.FailValue
                                  ,_GovIdConst.DisabledValue
                                  );

  NameStreetAddressMatch := MAP(isCheck_NameStreetAddressMatch AND in_rec.NameStreetAddressMatch = 2 => _GovIdConst.PassValue
                               ,isCheck_NameStreetAddressMatch => _GovIdConst.FailValue
                               ,_GovIdConst.DisabledValue
                               );

  NameCityStateMatch := MAP(isCheck_NameCityStateMatch AND in_rec.NameCityStateMatch = 2 => _GovIdConst.PassValue
                            ,isCheck_NameCityStateMatch => _GovIdConst.FailValue
                            ,_GovIdConst.DisabledValue
                            );

  NameZipMatch := MAP(isCheck_NameZipMatch AND in_rec.NameZipMatch = 2 => _GovIdConst.PassValue
                      ,isCheck_NameZipMatch => _GovIdConst.FailValue
                      ,_GovIdConst.DisabledValue
                      );
 
  // Begin preparing information required for Age_Verification
  Input_DOB := iesp.ECL2ESP.DateToInteger(Searchby.DOB);
  hasValidInputDOB := STD.Date.IsValidDate(Input_DOB);

  Year_fromInputDOB := STD.Date.Year(Input_DOB);
  Month_fromInputDOB := STD.Date.Month(Input_DOB);
  firstOfYear_fromInputDOB := STD.Date.DateFromParts(Year_fromInputDOB,1,1);
  firstOfMonth_fromInputDOB := STD.Date.DateFromParts(Year_fromInputDOB,Month_fromInputDOB,1); // includes year and month
  Lastdayofyear_fromInputDOB := STD.Date.AdjustDate(firstOfYear_fromInputDOB,year_delta := 1,month_delta := 0,day_delta := -1);
  LastdayofMonth_fromInputDOB := STD.Date.AdjustDate(firstOfYear_fromInputDOB,year_delta := 0,month_delta := 1,day_delta := -1);
 
  AdjustedInputDate := MAP(in_rec.DOBMatchLevel = 8 => Input_DOB
                          ,in_rec.DOBMatchLevel = 7 => LastdayofMonth_fromInputDOB
                          ,in_rec.DOBMatchLevel IN [5,6] => Lastdayofyear_fromInputDOB
                          ,Std.Date.Today() // forcing input date to run date for other DOB match levels
                          ); 

  AgefromInput := Std.Date.YearsBetween(AdjustedInputDate,Std.Date.Today());

  AgetoUse := If(hasValidInputDOB,AgefromInput,in_rec.discovereddob.age);

  Age_Verification := MAP(isCheck_Age_Verification AND AgetoUse > Options.AgeThreshold AND (integer)in_rec.CVI > Options.CVIThreshold
                        AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','NB','76'])) => _GovIdConst.PassValue
                         ,isCheck_Age_Verification => _GovIdConst.FailValue
                         ,_GovIdConst.DisabledValue
                         );

  // End Age_Verification

  YOBSSNMatch := MAP(isCheck_YOBSSNMatch AND (in_rec.InputYOBMatchesSSN.InputYOBMatchesSSN OR in_rec.InputDOBMatchesSSN.InputDOBMatchesSSN) AND in_rec.DOBMatchLevel IN [5,6,7,8]
                    AND ~EXISTS(in_rec.ri(hri in ['MI','81','29','NB','83','79'])) => _GovIdConst.PassValue
                     ,isCheck_YOBSSNMatch => _GovIdConst.FailValue
                     ,_GovIdConst.DisabledValue
                     );
    
  DOBSSNMatch := MAP(isCheck_DOBSSNMatch AND in_rec.InputDOBMatchesSSN.InputDOBMatchesSSN
                     AND ~EXISTS(in_rec.ri(hri in ['MI','81','29','NB','83','79'])) => _GovIdConst.PassValue
                     ,isCheck_DOBSSNMatch => _GovIdConst.FailValue
                     ,_GovIdConst.DisabledValue
                     );

  DOBFullVerified := MAP(isCheck_DOBFullVerified AND in_rec.verify_dob='Y'
                          AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','NB','81','76','83']))  => _GovIdConst.PassValue
                        ,isCheck_DOBFullVerified => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );                       
    
  DOBMonthYearVerified := MAP(isCheck_DOBMonthYearVerified AND in_rec.DOBMatchLevel IN [7,8]
                              AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','NB','81','76','83'])) => _GovIdConst.PassValue
                              ,isCheck_DOBMonthYearVerified => _GovIdConst.FailValue
                              ,_GovIdConst.DisabledValue
                              );

  DOBYearVerified := MAP(isCheck_DOBYearVerified AND in_rec.DOBMatchLevel IN [5,6,7,8]
                         AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','NB','81','76','83'])) => _GovIdConst.PassValue
                        ,isCheck_DOBYearVerified => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );
    
  DOBMonthDayVerified := MAP(isCheck_DOBMonthDayVerified AND in_rec.DOBMatchLevel IN [4,8]
                            AND ~EXISTS(in_rec.ri(hri in ['MI','81','83'])) => _GovIdConst.PassValue
                             ,isCheck_DOBMonthDayVerified => _GovIdConst.FailValue
                             ,_GovIdConst.DisabledValue
                             );
    
  PhoneLastNameMatch := MAP(isCheck_PhoneLastNameMatch AND in_rec.nap_summary IN [7,9,11,12]
                            AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','31','76','80'])) => _GovIdConst.PassValue
                            ,isCheck_PhoneLastNameMatch => _GovIdConst.FailValue
                            ,_GovIdConst.DisabledValue
                            );

  PhoneNotMobile := MAP(isCheck_PhoneNotMobile AND ~EXISTS(in_rec.ri(hri in ['10','80'])) => _GovIdConst.PassValue
                        ,isCheck_PhoneNotMobile => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );
    
  PhoneNotDisconnected := MAP(isCheck_PhoneNotDisconnected AND ~EXISTS(in_rec.ri(hri IN ['07','08','80'])) => _GovIdConst.PassValue
                              ,isCheck_PhoneNotDisconnected => _GovIdConst.FailValue
                              ,_GovIdConst.DisabledValue
                              );

  PhoneVerified := MAP(isCheck_PhoneVerified AND (in_rec.nap_summary IN [7,9,11,12] OR (in_rec.nas_summary = 8 AND in_rec.nap_summary IN [6,7]))
                       AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','31','76','78','80'])) => _GovIdConst.PassValue
                       ,isCheck_PhoneVerified => _GovIdConst.FailValue
                       ,_GovIdConst.DisabledValue
                       );
    
  PhoneFullNameMatch := MAP(isCheck_PhoneFullNameMatch AND  in_rec.nap_summary IN [9,12] 
                            AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','31','76','80'])) => _GovIdConst.PassValue 
                            ,isCheck_PhoneFullNameMatch => _GovIdConst.FailValue
                            ,_GovIdConst.DisabledValue
                            );

  DriverLicenseMatch := MAP(isCheck_DriverLicenseMatch AND  in_rec.DriversLicense.HasValidDriversLicense 
                            AND ~EXISTS(in_rec.ri(hri in ['MI','37','77','78','76','30','LN','LE']))=> _GovIdConst.PassValue
                            ,isCheck_DriverLicenseMatch => _GovIdConst.FailValue
                            ,_GovIdConst.DisabledValue
                            );
  
  DriversLicenseVerification := MAP(isCheck_DriversLicenseVerification AND ~EXISTS(in_rec.ri(hri IN ['MI','DV','37','77','41','DD','DM','76','DF']))
                                   AND in_rec.dl_number <> '' => _GovIdConst.PassValue
                                   ,isCheck_DriversLicenseVerification => _GovIdConst.FailValue
                                   ,_GovIdConst.DisabledValue
                                   );

  PassportValidation := MAP(isCheck_PassportValidation AND  in_rec.PassportValidated => _GovIdConst.PassValue
                          ,isCheck_PassportValidation => _GovIdConst.FailValue
                          ,_GovIdConst.DisabledValue
                          );  
    
  OFAC := MAP(isCheck_OFAC AND ~EXISTS(in_rec.ri(hri = '32')) => _GovIdConst.PassValue
              ,isCheck_OFAC => _GovIdConst.FailValue
              ,_GovIdConst.DisabledValue
              );

  AdditionalWatchlists := MAP(isCheck_AdditionalWatchlists AND ~EXISTS(in_rec.ri(hri = 'WL')) => _GovIdConst.PassValue
                             ,isCheck_AdditionalWatchlists => _GovIdConst.FailValue
                             ,_GovIdConst.DisabledValue
                             );
    
  LexIDDeathMatch := MAP(isCheck_LexIDDeathMatch AND ~EXISTS(in_rec.ri(hri = 'DI')) => _GovIdConst.PassValue
                         ,isCheck_LexIDDeathMatch => _GovIdConst.FailValue
                         ,_GovIdConst.DisabledValue
                         );

  SSNLowIssuance := MAP(isCheck_SSNLowIssuance AND in_rec.valid_ssn = 'G' AND ~EXISTS(in_rec.ri(hri = '79')) => _GovIdConst.PassValue
                        ,isCheck_SSNLowIssuance => _GovIdConst.FailValue
                        ,_GovIdConst.DisabledValue
                        );
    
  SSNSSAValid := MAP(isCheck_SSNSSAValid AND ~EXISTS(in_rec.ri(hri IN ['06','79'])) => _GovIdConst.PassValue
                    ,isCheck_SSNSSAValid => _GovIdConst.FailValue
                    ,_GovIdConst.DisabledValue
                    );


//  Build a dataset with all these attributes

  rec_GovIdAttributes := record
    string50 Attribute ;
    unsigned1 Result ;
  end;

  dsGovIdAttributes := DATASET([{_GovIdConst.String_SSNFullNameMatch,SSNFullNameMatch}
                                ,{_GovIdConst.String_SSNDeathMatchVerification,SSNDeathMatchVerification}
                                ,{_GovIdConst.String_SSNExists,SSNExists}
                                ,{_GovIdConst.String_MultipleIdentitySSN,MultipleIdentitySSN}
                                ,{_GovIdConst.String_SSNLastNameMatch,SSNLastNameMatch}
                                ,{_GovIdConst.String_SSNYOBDateAlert,SSNYOBDateAlert}
                                ,{_GovIdConst.String_SSN4FullNameMatch,SSN4FullNameMatch}
                                ,{_GovIdConst.String_SSNRandomized,SSNRandomized}
                                ,{_GovIdConst.String_SSNHistory,SSNHistory}
                                ,{_GovIdConst.String_SSN5FullNameMatch,SSN5FullNameMatch}
                                ,{_GovIdConst.String_Addr1Zip_StateMatch,Addr1Zip_StateMatch}
                                ,{_GovIdConst.String_Addr1LastNameMatch,Addr1LastNameMatch}
                                ,{_GovIdConst.String_IdentityOccupancyVerified,IdentityOccupancyVerified}
                                ,{_GovIdConst.String_AddrDeliverable,AddrDeliverable}
                                ,{_GovIdConst.String_AddrNotBusiness,AddrNotBusiness}
                                ,{_GovIdConst.String_AddrNotHighRisk,AddrNotHighRisk}
                                ,{_GovIdConst.String_AddrNotMaildrop,AddrNotMaildrop}
                                ,{_GovIdConst.String_PropertyAndDeed ,PropertyAndDeed }
                                ,{_GovIdConst.String_IdentityOwnershipVerified,IdentityOwnershipVerified}
                                ,{_GovIdConst.String_NameStreetAddressMatch,NameStreetAddressMatch}
                                ,{_GovIdConst.String_NameCityStateMatch,NameCityStateMatch}
                                ,{_GovIdConst.String_NameZipMatch,NameZipMatch}
                                ,{_GovIdConst.String_Age_Verification,Age_Verification}
                                ,{_GovIdConst.String_YOBSSNMatch,YOBSSNMatch}
                                ,{_GovIdConst.String_DOBSSNMatch,DOBSSNMatch}
                                ,{_GovIdConst.String_DOBFullVerified,DOBFullVerified}
                                ,{_GovIdConst.String_DOBMonthYearVerified,DOBMonthYearVerified}
                                ,{_GovIdConst.String_DOBYearVerified,DOBYearVerified}
                                ,{_GovIdConst.String_DOBMonthDayVerified,DOBMonthDayVerified}
                                ,{_GovIdConst.String_PhoneLastNameMatch,PhoneLastNameMatch}
                                ,{_GovIdConst.String_PhoneNotMobile,PhoneNotMobile}
                                ,{_GovIdConst.String_PhoneNotDisconnected,PhoneNotDisconnected}
                                ,{_GovIdConst.String_PhoneVerified,PhoneVerified}
                                ,{_GovIdConst.String_PhoneFullNameMatch,PhoneFullNameMatch}
                                ,{_GovIdConst.String_DriverLicenseMatch,DriverLicenseMatch}
                                ,{_GovIdConst.String_DriversLicenseVerification,DriversLicenseVerification}
                                ,{_GovIdConst.String_PassportValidation,PassportValidation}
                                ,{_GovIdConst.String_OFAC,OFAC}
                                ,{_GovIdConst.String_AdditionalWatchlists,AdditionalWatchlists}
                                ,{_GovIdConst.String_LexIDDeathMatch,LexIDDeathMatch}
                                ,{_GovIdConst.String_SSNLowIssuance,SSNLowIssuance}
                                ,{_GovIdConst.String_SSNSSAValid,SSNSSAValid}
                                ],rec_GovIdAttributes);


  GovIdPass := COUNT(dsGovIdAttributes(Result = _GovIdConst.PassValue )) >= MAX(SearchBy.GovIdThreshold,1);
 
  // Build xml string using the dataset
  recXMLstring := record
    string attrtag;
    string50 GovIdPasstag ;
  END;

  recXMLstring XformAddTags( dsGovIdAttributes L) := TRANSFORM
    SELF.attrtag :=  '<' + L.Attribute +'>' + (STRING) L.Result + '</' + L.Attribute + '>';
    SELF.GovIdPasstag := '<GovIdPass>' + IF(GovIdPass,'1','0') + '</GovIdPass>';
  END;

  withTags := PROJECT(dsGovIdAttributes,XformAddTags(LEFT));

  recXMLstring Xformrollup(recXMLstring L, recXMLstring R) := TRANSFORM
    SELF.attrtag := L.attrtag + R.attrtag ;
    SELF.GovIdPasstag := L.GovIdPasstag
  END;

  rolledup := ROLLUP(withTags, Xformrollup(LEFT, RIGHT),GovIdPasstag);

  _xmlstring := rolledup[1].GovIdPasstag + rolledup[1].attrtag ;
  
  Result := Project (in_ds,TRANSFORM(identifier2.layout_Identifier2,
                                     SELF.GovIdOutResult := IF(SearchBy.GovIdThreshold > 0, _xmlstring,'') ,
                                     SELF := LEFT 
                                     ));

  RETURN Result;
END;
