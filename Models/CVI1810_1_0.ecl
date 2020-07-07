IMPORT Risk_Indicators, STD;

EXPORT CVI1810_1_0(INTEGER1 NAP_Summary, 
                                          INTEGER1 NAS_Summary, 
                                          Risk_Indicators.Layout_Output l, 
                                          STRING5 inTweak, 
                                          STRING50 veraddr, 
                                          STRING20 verlast, 
                                          BOOLEAN OFAC=TRUE, 
                                          BOOLEAN IncludeDOBinCVI=FALSE,
                                          BOOLEAN IncludeDLinCVI=FALSE,
                                          BOOLEAN IncludeITIN=FALSE, 
                                          boolean includecompliancecap=FALSE,
                                          Risk_Indicators.iid_constants.IOverrideOptions OverrideOptions = MODULE(Risk_Indicators.iid_constants.IOverrideOptions)END) := FUNCTION

  TempCVI := Risk_Indicators.cviScoreV1(NAP_Summary, NAS_Summary, l, inTweak, veraddr, verlast, OFAC,
                                                                        IncludeDOBinCVI, IncludeDLinCVI, includeITIN, includecompliancecap, OverrideOptions);
                                                                        
  FinalCVI := TempCVI;
  
  // If custom Overrides are needed in the future, add them here like so:
  /*FinalCVI := MAP(OverrideOptions.isCodeMS and (INTEGER)TempCVI > 10 => '10',
							OverrideOptions.isCodePO and (INTEGER)TempCVI > 10 => '10',
							OverrideOptions.isCodeCL and (INTEGER)TempCVI > 10 => '10',
							OverrideOptions.isCodeMI and (INTEGER)TempCVI > 10=> '10',
							OverrideOptions.isCodeDI AND (INTEGER)TempCVI > 10 => '10',
                            TempCVI);*/
                            
  RETURN FinalCVI;

END;