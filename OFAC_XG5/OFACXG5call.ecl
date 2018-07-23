import iesp, Risk_Indicators, Fingerprint, ut, Gateway, codes, iesp;

// Note: this function assumes that the OFACversion has been checked and is 4 or greater, and that
// include_ofac is TRUE.
export OFACXG5call (DATASET(OFAC_XG5.Layout.InputLayout) indata, 
														boolean ofaconly_value = false,
														integer threshold_value = OFAC_XG5.Constants.DEF_THRESHOLD,
														boolean include_ofac=FALSE,
														boolean include_Additional_watchlists=FALSE,
														integer2 dob_radius = -1,
														DATASET(iesp.share.t_StringArrayItem) watchlists_original=dataset([], iesp.share.t_StringArrayItem),
														DATASET (Gateway.Layouts.Config) gateways=dataset([], Gateway.Layouts.Config))  := FUNCTION

DBNames_rec := ofac_xg5.Constants.DBNames_rec;

watchlists_requested := project (watchlists_original, transform (iesp.share.t_StringArrayItem,
                                                                 Self.value := StringLib.StringToUpperCase (Left.value))); 

customWLset := OFAC_XG5.GetSearchFiles(watchlists_requested);

fileToSearch := map('ALLV4' IN SET(watchlists_original, value) => OFAC_XG5.Constants.WCOAddtnlFiles_ALLV4,
                    include_ofac=false and include_additional_watchlists=false and ofaconly_value=false => customWLset,
										include_additional_watchlists => OFAC_XG5.Constants.WCOAddtnlFiles_ALL,
										include_ofac and include_additional_watchlists = false => OFAC_XG5.Constants.WCOFACNames + customWLset,
										ofaconly_value = true => OFAC_XG5.Constants.WCOFACNames + customWLset,
										OFAC_XG5.Constants.WCOFACNames);
    
fileToSearchDedup := dedup(sort(fileToSearch, dbname), dbname);
													
gateway_cfg  := gateways(Gateway.Configuration.IsBridgerwlc(servicename))[1];

//Build dataset to pass to XG5 containing one record but has all records (batch or XML) within the 'EntityRecords' nested dataset			
iesp.WsSearchCore.t_SearchRequest into_req(Risk_Indicators.iid_constants.ds_Record le) := transform

	self.user.ReferenceCode		:= gateway_cfg.TransactionId;
	
	self.Config.DataFiles := project(fileToSearchDedup, transform(iesp.WsSearchCore.t_ConfigDataFile,
			self.Name  := left.dbname;
			self.MinScore  := threshold_value;
			self := [];
			));

	self.Config.MatchOptions.GenerateOnName  := OFAC_XG5.Constants.GenerateResultsOnName;	
	self.Config.GeneralOptions.NoInputEcho  := false;	
	self.Config.GeneralOptions.MaxNumberOfMatchesReturned  := OFAC_XG5.Constants.MaxReturnRecs;
	self.Config.GeneralOptions.ScanNameForBlockedCountries  := true;
	self.Config.GeneralOptions.ScanAddressForBlockedCountries  := true;
	self.Config.GeneralOptions.SortResultsByEntityScore  := OFAC_XG5.Constants.SortResultsByScore;
	self.config.MatchOptions.ScoreAddress := OFAC_XG5.Constants.IncludeAddrinScoreLift;
	//If DOB radius requested, multiply by 12 here because XG5 uses months.
	self.config.ConflictOptions.DOBTolerance := if(dob_radius = -1, 0, dob_radius * 12); 
	self.Input.BlockID  := 1;	
	SELF.Input.EntityRecords := project(indata, transform(iesp.WsSearchCore.t_InputEntityRecord,			
			self.id  						:=  left.seq;
			FullNameMerged := TRIM(left.firstName)+' '+TRIM(left.middleName, LEFT, RIGHT)+' '+TRIM(left.lastName);
			self.name.First 			:=  if (left.searchtype = 'I' and trim(left.firstName) <> '', trim(left.firstName), ''); 
			self.name.Middle 			:= if (left.searchtype = 'I' and trim(left.middleName) <> '', trim(left.middleName), '');
			self.name.Last 			:=  if (left.searchtype = 'I' and trim(left.lastName) <> '' , trim(left.lastName), '');
			self.name.Full 			:=  map( left.searchtype in ['N', 'B'] and trim(left.fullName) <> ''  => trim(left.fullName),
																														left.searchtype in ['N', 'B'] and FullNameMerged <> '' => FullNameMerged,
																									     left.searchtype = 'I' and FullNameMerged = ''          => trim(left.fullName),
																									                                                               trim(left.fullName));
			self.EntityType 		:= trim(MAP(left.searchType  in ['N']  => 'Business', 
																			left.searchType  in [ 'I'] => 'Individual',
																			left.searchType  in [ 'B'] => 'Unknown',
																																		'Unknown'));

			self.EFTInfo._Type 	:= 'None';   // value required
			self.gender 				:= 'Unknown';  //value required

			Country 								:= left.country;
			StateProvinceDistrict 	:= codes.St2Name(left.state);
			BuildingOrStreetNumber	:= left.prim_range;
			StreetPreDirection			:= left.predir;
			StreetName 							:= left.prim_name;
			StreetPostDirection			:= left.addr_suffix;
			StreetSuffixOrType			:= left.postdir;
			UnitDesignation					:= left.unit_desig;
			UnitNumber							:= left.sec_range;
			City										:= left.city_name;
			PostalCode							:= left.z5;
			DOB											:= left.DOB;
			
			self.Addresses 			:= project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.WsSearchCore.t_InputAddress,																			
					self.Country 								:= Country; 
					self.StateProvinceDistrict 	:= StateProvinceDistrict;
					self._type 									:= 'Unknown';    //values['None','Current','Mailing','Previous','Unknown','']  need to be in this exact format, correct case.
					self.BuildingOrStreetNumber := BuildingOrStreetNumber;
					self.StreetPreDirection 		:= StreetPreDirection;
					self.StreetName 						:= StreetName;
					self.StreetPostDirection 		:= StreetPostDirection;
					self.StreetSuffixOrType 		:= StreetSuffixOrType;
					self.UnitDesignation 				:= UnitDesignation;
					self.UnitNumber 						:= UnitNumber;
					self.City 									:= City;
					self.PostalCode 						:= PostalCode;
					self 												:= [];
					));

			//dob_radius of -1 indicates to not consider DOB in the search/matching so account for that here 
			self.AdditionalInformation := if(left.dob not in ['', '0'] and dob_radius <> -1, 
																			 project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.WsSearchCore.t_InputAdditionalInfo,             
																							 self._Type  := 'DOB';
																							 self.Value  :=  DOB;  //format MM/DD/YYYY
																							 self := [];)), 
																			 project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.WsSearchCore.t_InputAdditionalInfo,             
																							 self._Type  := 'None';
																							 self := [];))),
			
			self := [];
			));

	self := [];
end;

in_req := project(Risk_Indicators.iid_constants.ds_Record, into_req(left));																									

outBridger := Gateway.SoapCall_BridgerSSXG5(in_req, gateway_cfg);

ErrorRecs  		:= 	outBridger(SearchResult.ErrorMessage <> '');
NONErrorRecs  := 	outBridger(SearchResult.ErrorMessage = '');
EntityRecords := 	NONErrorRecs[1].SearchResult.EntityRecords;

OFAC_XG5.Layout.SearchResultsSlimmed PrepResponse(EntityRecords le, integer C) := TRANSFORM
			self.BlockID	:= le.InputRecord.ID;
			MergedInputRecordName := TRIM(le.InputRecord.name.first)+' '+TRIM(le.InputRecord.name.middle, LEFT, RIGHT)+' '+TRIM(le.InputRecord.name.last);
      self.ResponseFullName := if(MergedInputRecordName = '', le.InputRecord.name.full, MergedInputRecordName);
			self.EntityRecords := le;
			self := le;
			self := [];
END;
																
SlimOutBridger := project(EntityRecords,  
											PrepResponse(left,counter));
											
//if the gateway does return an error, we need to format a "fake" record that contains the sequence number to match to later
OFAC_XG5.Layout.SearchResultsSlimmed PrepResponseErr(indata le) := TRANSFORM
      self.seq := le.seq;
      self.blockid := le.seq;
      self.ErrorMessage := 'ERR';
      self := [];
END;

SlimOutBridgerError := if(count(ErrorRecs) > 0,
													project(indata, PrepResponseErr(left)),
													dataset([],OFAC_XG5.Layout.SearchResultsSlimmed));
													
OFAC_XG5.Layout.SearchResultsSlimmed Addinput(indata le, SlimOutBridger ri, integer C) := TRANSFORM
			self := le;
			self := ri;
END;		


AddinputBack 	:= join(indata, SlimOutBridger, 
												left.seq = right.blockid,
												Addinput(LEFT,RIGHT, counter));
																							 
AddinputBackErr := if(count(ErrorRecs) > 0, AddinputBack + SlimOutBridgerError, AddinputBack);   

addentityseq := project(AddinputBackErr, 
												transform(OFAC_XG5.Layout.SearchResultsSlimmed, 
													self.EntityRecSeq := counter, 
													self := left));           	
	
// output(dob_radius, named('Call_dob_radius'), overwrite);
// output(indata, named('Call_indata'), overwrite);
// output(gateways, named('gateways'), overwrite);
// output(gateway_cfg, named('gateway_cfg'), overwrite);
// output(customWLset, named('customWLset'), overwrite);
// output(fileToSearch, named('fileToSearch'), overwrite);
// output(in_req, named('Call_in_req'), overwrite);
// output(outBridger, named('Call_outBridger'), overwrite);
// output(ErrorRecs, named('Call_ErrorRecs'), overwrite);
// output(NONErrorRecs, named('Call_NONErrorRecs'), overwrite);
// output(EntityRecords, named('Call_EntityRecords'), overwrite);
// output(SlimOutBridger, named('Call_SlimOutBridger'), overwrite);
// output(SlimOutBridgerError, named('Call_SlimOutBridgerError'), overwrite);
// output(AddinputBack, named('Call_AddinputBack'), overwrite);
// output(AddinputBackErr, named('Call_AddinputBackErr'), overwrite);
// output(addentityseq, named('Call_addentityseq'), overwrite);
		
return addentityseq;			

									
END;

