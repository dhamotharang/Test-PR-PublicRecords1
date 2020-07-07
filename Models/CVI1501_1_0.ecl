IMPORT Risk_Indicators, STD;

EXPORT CVI1501_1_0(INTEGER1 NAP_Summary, INTEGER1 NAS_Summary, Risk_Indicators.Layout_Output l, STRING5 inTweak, STRING50 veraddr, STRING20 verlast, 
								BOOLEAN OFAC=TRUE, BOOLEAN IncludeDOBinCVI=FALSE,BOOLEAN IncludeDLinCVI=FALSE, BOOLEAN IncludeITIN=FALSE, boolean includecompliancecap=false, 
                                Risk_Indicators.iid_constants.IOverrideOptions OverrideOptions = MODULE(Risk_Indicators.iid_constants.IOverrideOptions)END) := FUNCTION

  TempCVI := Risk_Indicators.cviScoreV1(NAP_Summary, NAS_Summary, l, inTweak, veraddr, verlast, OFAC,
                                                                        IncludeDOBinCVI, IncludeDLinCVI, includeITIN, includecompliancecap, OverrideOptions);
                                                                        
  CVI1501_1Override := __COMMON__(if((NAS_Summary=7 and NAP_Summary=7) OR (NAS_Summary=9 and NAP_Summary=9), '20', TempCVI));

  FinalCVI :=     MAP(OverrideOptions.isCodeMS and (INTEGER)CVI1501_1Override > 10 => '10',
							OverrideOptions.isCodePO and (INTEGER)CVI1501_1Override > 10 => '10',
							OverrideOptions.isCodeCL and (INTEGER)CVI1501_1Override > 10 => '10',
							OverrideOptions.isCodeMI and (INTEGER)CVI1501_1Override > 10=> '10',
							OverrideOptions.isCodeDI AND (INTEGER)CVI1501_1Override > 10 => '10',
                            CVI1501_1Override);
                            
RETURN FinalCVI;

END;