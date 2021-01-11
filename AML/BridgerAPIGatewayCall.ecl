IMPORT AML, Gateway, iesp, ut, STD;

EXPORT BridgerAPIGatewayCall(DATASET(AML.Layouts.BridgerSearchInput) inData,
                             DATASET(Gateway.Layouts.Config) gateways) := FUNCTION
                          

    
    gatewayConfig := Gateway.Configuration.get()(Gateway.Configuration.IsBridgerAPI(servicename))[1];
    
    
    //based on the URL pull the clientID, userID, and password from the URL
    requestedURL := gatewayConfig.url;
    
    splitURLSemiColon := STD.STr.SplitWords(requestedURL, ';');
    splitURLColon := STD.STr.SplitWords(splitURLSemiColon[2], ':');

    httpReq := STD.Str.Find(splitURLSemiColon[1], '//', 1);
    actualURL := STD.Str.Find(splitURLColon[2], '@', 1);

    clientID := splitURLSemiColon[1][httpReq + 2 ..];
    userID := splitURLColon[1];
    password := splitURLColon[2][..actualURL - 1];
    urlToUse := TRIM(splitURLSemiColon[1][..httpReq + 1]) + TRIM(splitURLColon[2][actualURL + 1..]);

    
    
    gatewayConfig2 := PROJECT(gatewayConfig, TRANSFORM(Gateway.Layouts.Config,
                                                        SELF.url := IF(LEFT.url = AML.AMLConstants.EMPTY_STRING, LEFT.url, urlTouse);
                                                        SELF := LEFT;));
    
    inputRequest := PROJECT(inData, TRANSFORM(iesp.gateway_bridgerAPI.t_SearchRequest,
                                              SELF.Context.ClientID := clientID;
                                              SELF.Context.UserID := userID;
                                              SELF.Context.Password := password;
                                              
                                              SELF.Config.Watchlist.AutomaticFalsePositiveRules.DOBTolerance := AML.AMLConstants.BRIDGER_DOB_TOLERANCE_YRS;
                                              SELF.Config.Watchlist.DataFiles.WatchlistDataFile := DATASET([TRANSFORM(iesp.gateway_bridgerAPI.t_WatchlistDataFiles,
                                                                                                                      SELF.MinScore := AML.AMLConstants.BRIDGER_MIN_SCORE;
                                                                                                                      SELF.Name := AML.AMLConstants.BRIDGER_WC_FULL_DB_NAME;
                                                                                                                      SELF := [];)]);
                                              
                                              SELF.Input.BlockID := (STRING)LEFT.seq;
                                              SELF.Input.InputRecords := DATASET([TRANSFORM(iesp.gateway_bridgerAPI.t_InputRecord,
                                                                                            SELF.Entity.Gender := 'Unknown';
                                                                                            SELF.Entity.Name.First := IF(LEFT.did <> 0, LEFT.firstName, AML.AMLConstants.EMPTY_STRING);
                                                                                            SELF.Entity.Name.Middle := IF(LEFT.did <> 0, LEFT.middleName, AML.AMLConstants.EMPTY_STRING);
                                                                                            SELF.Entity.Name.Last := IF(LEFT.did <> 0, LEFT.lastName, AML.AMLConstants.EMPTY_STRING);	
                                                                                            SELF.Entity.Name.Full := IF(LEFT.bdid <> 0, LEFT.company_name, AML.AMLConstants.EMPTY_STRING);
                                                                                            
                                                                                            SELF.Entity.EntityType := IF(LEFT.did <> 0 AND LEFT.bdid = 0, 'Individual', 'Business'); 
                                                                                            SELF.Entity.AdditionalInfo := DATASET([TRANSFORM(iesp.gateway_bridgerAPI.t_AdditionalInfo,
                                                                                                                                              SELF._Type := IF(LEFT.did <> 0 AND LEFT.dob <> AML.AMLConstants.EMPTY_STRING AND LEFT.dob <> '0', 'DOB', 'None');
                                                                                                                                              SELF.Value := IF(LEFT.did <> 0 AND LEFT.dob <> AML.AMLConstants.EMPTY_STRING AND LEFT.dob <> '0', LEFT.DOB, AML.AMLConstants.EMPTY_STRING);
                                                                                                                                              SELF := [];)]);
                                                                                                                                              
                                                                                            SELF.Entity.Addresses := DATASET([TRANSFORM(iesp.gateway_bridgerAPI.t_AddressPieces, 
                                                                                                                                        SELF.Country := 'United States';   // defaulted because Country is not in cleaned address
                                                                                                                                        SELF.StateProvinceDistrict := ut.St2Name(LEFT.state);
                                                                                                                                        SELF._type := 'Current';    //values['None','Current','Mailing','Previous','Unknown','']
                                                                                                                                        SELF.BuildingOrStreetNumber := LEFT.prim_range;
                                                                                                                                        SELF.StreetPreDirection := LEFT.predir;
                                                                                                                                        SELF.StreetName := LEFT.prim_name;
                                                                                                                                        SELF.StreetPostDirection := LEFT.addr_suffix;
                                                                                                                                        SELF.StreetSuffixOrType := LEFT.postdir;
                                                                                                                                        SELF.UnitDesignation := LEFT.unit_desig;
                                                                                                                                        SELF.UnitNumber := LEFT.sec_range;
                                                                                                                                        SELF.City := LEFT.city_name;
                                                                                                                                        SELF.PostalCode := LEFT.z5;
                                                                                                                                        SELF := [];)]);
                                                                                            SELF := [];)]); 
                                              
                                              SELF := [];));				
																											

    outBridger := Gateway.SoapCall_BridgerAPI(inputRequest, gatewayConfig2);
    
    convertToCoreLayout := PROJECT(outBridger, TRANSFORM(iesp.WsSearchCore.t_SearchResponse,
    
                                                        recordDetails := LEFT.searchResult.records[1].recordDetails;
                                                        matches := LEFT.searchResult.records[1].Watchlist.Matches;
                                                        
                                                        SELF.searchResult.BlockID := (UNSIGNED)LEFT.searchResult.BlockID;
                                                        
                                                        SELF.searchResult.EntityRecords := DATASET([TRANSFORM(iesp.WsSearchCore.t_ResultEntityRecord,
                                                                                                              SELF.InputRecord.ID := (UNSIGNED)LEFT.searchResult.BlockID;
                                                                                                              SELF.InputRecord.Name.First := recordDetails.Name.First;
                                                                                                              SELF.InputRecord.Name.Middle := recordDetails.Name.Middle;
                                                                                                              SELF.InputRecord.Name.Last := recordDetails.Name.Last;
                                                                                                              SELF.InputRecord.EntityType := recordDetails.EntityType;
                                                                                                              SELF.InputRecord.Addresses := DATASET([TRANSFORM(iesp.WsSearchCore.t_InputAddress, SELF := recordDetails.addresses[1]; SELF := [];)]);
                                                                                                              SELF.InputRecord.AdditionalInformation := DATASET([TRANSFORM(iesp.WsSearchCore.t_InputAdditionalInfo, 
                                                                                                                                                                            SELF.value := IF(STD.Str.ToUpperCase(TRIM(recordDetails.additionalInfo[1]._Type)) = 'DOB', STD.Str.FilterOut(recordDetails.additionalInfo[1].value, '-'), recordDetails.additionalInfo[1].value); 
                                                                                                                                                                            SELF := recordDetails.additionalInfo[1]; 
                                                                                                                                                                            SELF := [];)]);
                                                                                                              
                                                                                                              
                                                                                                              SELF.Matches := PROJECT(matches, TRANSFORM(iesp.WsSearchCore.t_ResultMatch, 
                                                                                                                                                          SELF.address.conflict := LEFT.Conflicts.AddressConflict;
                                                                                                                                                          SELF.address.BestIsPartial := LEFT.BestAddressIsPartial;
                                                                                                                                                          SELF.address.BestInputID := 255;
                                                                                                                                                          SELF.address.BestListID := 255;
                                                                                                                                                          SELF.address.addressDetails := PROJECT(LEFT.EntityDetails.Addresses, TRANSFORM(iesp.WsSearchCore.t_ResultMatchEntityAddress, 
                                                                                                                                                                                                                                          SELF.ID := COUNTER;
                                                                                                                                                                                                                                          SELF._Type := AML.BridgerEnumConversions.convertAddressType(LEFT._Type);
                                                                                                                                                                                                                                          SELF.StreetAddress1 := LEFT.Street1; 
                                                                                                                                                                                                                                          SELF.StreetAddress2 := LEFT.Street2; 
                                                                                                                                                                                                                                          SELF.City := LEFT.City; 
                                                                                                                                                                                                                                          SELF.State := LEFT.StateProvinceDistrict; 
                                                                                                                                                                                                                                          SELF.PostalCode := LEFT.PostalCode; 
                                                                                                                                                                                                                                          SELF.Country := LEFT.Country; 
                                                                                                                                                                                                                                          SELF.Notes := LEFT.Comments; 
                                                                                                                                                                                                                                          SELF := [];));
                                                                                                                                                          
                                                                                                                                                          SELF.citizenship.conflict := LEFT.Conflicts.CitizenshipConflict;
                                                                                                                                                          
                                                                                                                                                          SELF.country.conflict := LEFT.Conflicts.CountryConflict;
                                                                                                                                                          SELF.country.Best := LEFT.BestCountry;
                                                                                                                                                          SELF.country.BestScore := IF(LEFT.BestCountryScore = -1, 0, LEFT.BestCountryScore);
                                                                                                                                                          SELF.country.BestType := LEFT.BestCountryType;
                                                                                                                                                          
                                                                                                                                                          SELF.dob.BestIsPartial := LEFT.BestDOBIsPartial;
                                                                                                                                                          SELF.dob.Conflict := LEFT.Conflicts.DOBConflict;
                                                                                                                                                          
                                                                                                                                                          SELF.entity.entityDetails.CheckSum := LEFT.CheckSum;
                                                                                                                                                          SELF.entity.entityDetails.Date := IF(LEFT.EntityDetails.dateListed <> AML.AMLConstants.EMPTY_STRING, LEFT.EntityDetails.dateListed + 'T00:00:00Z', LEFT.EntityDetails.dateListed);
                                                                                                                                                          SELF.entity.entityDetails.Gender := LEFT.EntityDetails.gender;
                                                                                                                                                          SELF.entity.entityDetails.Name := LEFT.EntityDetails.name;
                                                                                                                                                          SELF.entity.entityDetails.Notes := LEFT.EntityDetails.comments;
                                                                                                                                                          SELF.entity.entityDetails.Number := LEFT.EntityDetails.listReferenceNumber;
                                                                                                                                                          SELF.entity.entityDetails.Reason := LEFT.EntityDetails.reasonListed;  
                                                                                                                                                          SELF.entity.entityDetails._Type := AML.BridgerEnumConversions.convertEntityType(LEFT.EntityDetails.entityType);
                                                                                                                                                          
                                                                                                                                                          SELF.entity.EntityUniqueID := LEFT.EntityUniqueID;
                                                                                                                                                          SELF.entity.Name := LEFT.EntityName;
                                                                                                                                                          SELF.entity.Score := LEFT.EntityScore;
                                                                                                                                                          SELF.entity.SourceNumber := LEFT.EntityDetails.listReferenceNumber;
                                                                                                                                                          
                                                                                                                                                          SELF.file.Build := LEFT.file._Build;
                                                                                                                                                          SELF.file.Custom := LEFT.file.Custom;
                                                                                                                                                          SELF.file.ID := 1;
                                                                                                                                                          SELF.file.Name := LEFT.file.Name;
                                                                                                                                                          SELF.file.Published := LEFT.file.Published;
                                                                                                                                                          SELF.file._Type := LEFT.file._Type;
                                                                                                                                                          
                                                                                                                                                          SELF.gender.conflict := LEFT.Conflicts.GenderConflict;
                                                                                                                                                          
                                                                                                                                                          SELF.id.conflict := LEFT.Conflicts.IDConflict;
                                                                                                                                                          SELF.id.IdentificationDetails := PROJECT(LEFT.EntityDetails.IDs, TRANSFORM(iesp.WsSearchCore.t_ResultMatchEntityID,
                                                                                                                                                                                                                                      SELF.ID := COUNTER;
                                                                                                                                                                                                                                      SELF._Type := AML.BridgerEnumConversions.convertEntityID(LEFT._Type);
                                                                                                                                                                                                                                      SELF.Number := LEFT.Number;
                                                                                                                                                                                                                                      SELF := LEFT;
                                                                                                                                                                                                                                      SELF := [];));
                                                                                                                                                                                                                                      
                                                                                                                                                          SELF.Name.AddressName := LEFT.AddressName;
                                                                                                                                                          SELF.Name.BestID := COUNTER;
                                                                                                                                                          SELF.Name.Best := LEFT.BestName;
                                                                                                                                                          SELF.Name.BestScore := LEFT.BestNameScore;
                                                                                                                                                          SELF.Name.AddressInputInstance := -1;
                                                                                                                                                          SELF.Name.IndexMatch := TRUE;
                                                                                                                                                          SELF.Name.AKAs := PROJECT(LEFT.EntityDetails.AKAs, TRANSFORM(iesp.WsSearchCore.t_ResultMatchEntityAKA,
                                                                                                                                                                                                                        SELF.ID := COUNTER;
                                                                                                                                                                                                                        SELF._Type := AML.BridgerEnumConversions.convertAKAType(LEFT._Type);
                                                                                                                                                                                                                        SELF.Category := AML.BridgerEnumConversions.convertAKACategory(LEFT.Category);
                                                                                                                                                                                                                        SELF.Notes := LEFT.Comments;
                                                                                                                                                                                                                        SELF.Full := LEFT.Name.Full;
                                                                                                                                                                                                                        SELF.Title := LEFT.Name.Title;
                                                                                                                                                                                                                        SELF.First := LEFT.Name.First;
                                                                                                                                                                                                                        SELF.Middle := LEFT.Name.Middle;
                                                                                                                                                                                                                        SELF.Last := LEFT.Name.Last;
                                                                                                                                                                                                                        SELF.Generation := LEFT.Name.Generation;
                                                                                                                                                                                                                        SELF := [];));
                                                                                                                                                          
                                                                                                                                                          SELF.Descriptions := PROJECT(LEFT.EntityDetails.AdditionalInfo, TRANSFORM(iesp.WsSearchCore.t_ResultMatchEntityDescription,
                                                                                                                                                                                                                                    infoType := AML.BridgerEnumConversions.convertAdditionalInfoType(LEFT._Type);
                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                    //if DOB is the info type - change format to be backwards compatible
                                                                                                                                                                                                                                    rawValue := LEFT._Value;
                                                                                                                                                                                                                                    typeValue := IF(infoType = 4, rawValue[..4] + '/' + INTFORMAT((UNSIGNED)rawValue[6..7], 2, 1) + '/' + INTFORMAT((UNSIGNED)rawValue[9..], 2, 1), rawValue);
                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                    SELF.ID := COUNTER;
                                                                                                                                                                                                                                    SELF._Type := infoType;
                                                                                                                                                                                                                                    SELF.Value := typeValue;
                                                                                                                                                                                                                                    SELF.Notes := LEFT.Comments;
                                                                                                                                                                                                                                    SELF := [];));
                                                                                                                                                                                                            
                                                                                                                                                          
                                                                                                                                                          
                                                                                                                                                          
                                                                                                                                                          
                                                                                                                                                          SELF := [];));
                                                                                                              
                                                                                                              
                                                                                                              SELF := [];)]);
                                                        SELF := [];));
    


    // OUTPUT(indata, NAMED('indata'));    
    // OUTPUT(inputRequest, NAMED('inputRequest'));
    // OUTPUT(convertToCoreLayout, NAMED('convertToCoreLayout')); 

		
		RETURN convertToCoreLayout;												
END;