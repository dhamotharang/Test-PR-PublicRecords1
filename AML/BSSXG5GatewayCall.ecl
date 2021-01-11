IMPORT AML, iesp, Risk_Indicators, Fingerprint, ut, Gateway;


/* -- need to all be migrated...
		dependencies:
		iesp.WsSearchCore
		Gateway.Configuration
		Gateway.Constants
		Gateway.SoapCall_BridgerXG4

*/

EXPORT BSSXG5GatewayCall (DATASET(AML.Layouts.BridgerSearchInput) indata,
													DATASET (Gateway.Layouts.Config) gateways) := FUNCTION



    MinScore := AML.AMLConstants.BRIDGER_MIN_SCORE;
    MaxReturnRecs := AML.AMLConstants.BRIDGER_MAX_RESULTS;
    WCFullDBName := AML.AMLConstants.BRIDGER_WC_FULL_DB_NAME;
    DOBToleranceYrs := AML.AMLConstants.BRIDGER_DOB_TOLERANCE_YRS;  //AML req
    SortResultsByScore := TRUE;
    GenerateResultsOnName := TRUE;
    IncludeAddrinScoreLift := TRUE;

                                                                                            
                        
    gateway_cfg  := Gateway.Configuration.get()(Gateway.Configuration.IsBridgerXG5(servicename))[1];
      
    iesp.WsSearchCore.t_SearchRequest into_req(indata le) := TRANSFORM

        SELF.Config.DataFiles := DATASET([TRANSFORM(iesp.WsSearchCore.t_ConfigDataFile,
                                          SELF.Name  := WCFullDBName;
                                          SELF.MinScore  := MinScore;
                                          SELF := [];)]);

        SELF.Config.MatchOptions.GenerateOnName  := GenerateResultsOnName;	
        SELF.Config.GeneralOptions.MaxNumberOfMatchesReturned  := MaxReturnRecs;
        SELF.Config.GeneralOptions.SortResultsByEntityScore  := SortResultsByScore;
        SELF.config.MatchOptions.ScoreAddress := IncludeAddrinScoreLift;
        SELF.config.ConflictOptions.DOBTolerance := DOBToleranceYrs;
        SELF.Input.BlockID  := le.seq;	
        SELF.Input.EntityRecords := DATASET([TRANSFORM(iesp.WsSearchCore.t_InputEntityRecord,			
                                              SELF.id  :=  le.seq;
                                              SELF.name.First := IF(le.did <>  0, le.firstName, '');
                                              SELF.name.Middle := IF(le.did <>  0,le.middleName, '');
                                              SELF.name.Last := IF(le.did <>  0,le.lastName, '');	
                                              SELF.name.Full := IF(le.bdid <>  0,le.company_name, '');	
                                              SELF.EntityType := IF(le.did <> 0 AND le.bdid = 0, 'Individual', 'Business');  // value required - 'Unknown' is an option
                                              SELF.EFTInfo._Type := 'None';   // value equired
                                              SELF.gender := 'Unknown';  //value equired
                                              SELF.Addresses := DATASET([TRANSFORM(iesp.WsSearchCore.t_InputAddress,																			
                                                                                    SELF.Country := 'United States';   // defaulted because Country is not in cleaned address
                                                                                    SELF.StateProvinceDistrict := ut.St2Name(le.state);
                                                                                    SELF._type := 'Current';    //values['None','Current','Mailing','Previous','Unknown','']
                                                                                    SELF.BuildingOrStreetNumber := le.prim_range;
                                                                                    SELF.StreetPreDirection := le.predir;
                                                                                    SELF.StreetName := le.prim_name;
                                                                                    SELF.StreetPostDirection := le.addr_suffix;
                                                                                    SELF.StreetSuffixOrType := le.postdir;
                                                                                    SELF.UnitDesignation := le.unit_desig;
                                                                                    SELF.UnitNumber := le.sec_range;
                                                                                    SELF.City := le.city_name;
                                                                                    SELF.PostalCode := le.z5;
                                                                                    SELF := [];)]);
                                              
                                              SELF.AdditionalInformation := IF(le.did <> 0 AND le.dob <> '' AND le.dob <> '0', 
                                                                                  DATASET([TRANSFORM(iesp.WsSearchCore.t_InputAdditionalInfo,             
                                                                                                     SELF._Type  := 'DOB';
                                                                                                     SELF.Value  :=  le.DOB;
                                                                                                     SELF := [];)]),
                                                                                  DATASET([TRANSFORM(iesp.WsSearchCore.t_InputAdditionalInfo,             
                                                                                                     SELF._Type  := 'None';
                                                                                                     SELF := [];)]));
                                              
                                              SELF := [];)]);



        SELF := [];
    END;
                                
    in_req := PROJECT(indata, into_req(LEFT));																									

    outBridger := Gateway.SoapCall_BridgerSSXG5(in_req, gateway_cfg);



    // OUTPUT(indata, NAMED('indata'), OVERWRITE);
    // OUTPUT(in_req, NAMED('in_req'), OVERWRITE);
    // OUTPUT(outBridger, NAMED('outBridger'), OVERWRITE);


    RETURN outBridger;												
END;

