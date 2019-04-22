import iesp, Risk_Indicators, Fingerprint, ut, Gateway;


/* -- need to all be migrated...
		dependencies:
		iesp.WsSearchCore
		Gateway.Configuration
		Gateway.Constants
		Gateway.SoapCall_BridgerXG4

*/

export BSSXG5GatewayCall (DATASET(Layouts.BridgerSearchInput) indata,
													DATASET (Gateway.Layouts.Config) gateways)  := FUNCTION

MinScore := 95;
MaxReturnRecs := 500;
WCFullDBName := 'WorldCompliance - Full.BDF';
//  the ';' is added to the end as not to get false positives, In each group id there is only one value ID in the SearchCriteria values.  group id="5" name="Source",  value id refers to the name of the source
// structure of the SearchCriteria value is,  group id, value id; group id2, value id2; group id3, value id3;........
OFACEvadersIds := '5,10274;';   //name="US-OFAC Foreign Sanctions Evaders List"
OFACPalestinianIds := '5,901;';   //name="US-U.S. OFAC - Palestinian Legislative Council List"
OFACPart561Ids := '5,1314;';   //name="US-U.S. OFAC - Part 561 List"
OFACParastatalIds := '5,759;';   //name="US-U.S. Office of Foreign Asset Control (OFAC) - Parastatal Entities of Iraq"
OFACSDNIds := '5,6;';   //name="US-U.S. Office of Foreign Asset Control (OFAC) - SDN List" 
SortResultsByScore := TRUE;
GenerateResultsOnName := TRUE;
IncludeAddrinScoreLift := TRUE;
DOBToleranceYrs := 2;  //AML req

				OFACSources := [		'US-OFAC Foreign Sanctions Evaders List', 
														'US-U.S. OFAC - Palestinian Legislative Council List', 
														'US-U.S. OFAC - Part 561 List', 
														'US-U.S. Office of Foreign Asset Control (OFAC) - Parastatal Entities of Iraq', 
														'US-U.S. Office of Foreign Asset Control (OFAC) - SDN List',
														'US-OFAC - Specially Designated Nationals (SDN) List', 
														'US-OFAC - Parastatal Entities of Iraq',
														'US-OFAC - Palestinian Legislative Council (PLC) List',
														'US-OFAC - Foreign Financial Institutions Subject to Part 561 List',
														'US-OFAC - Foreign Sanctions Evaders (FSE) List'
													];
// other OFAC listed not used yet in AML
// 'US-OFAC - Enforcement Actions'
// 'US-OFAC - Civil Penalties'	
// 'US-OFAC - Sectoral Sanctions Identifications (SSI) List' 
// 'US-OFAC - Non-SDN Iranian Sanctions Act (NS-ISA) List'
																																															
													
			gateway_cfg  := Gateway.Configuration.get()(Gateway.Configuration.IsBridgerXG5(servicename))[1];
			
			iesp.WsSearchCore.t_SearchRequest into_req(indata le) := transform

        SELF.Config.DataFiles := project(dataset([{1}], {unsigned a}), transform(iesp.WsSearchCore.t_ConfigDataFile,
							self.Name  := WCFullDBName;
							self.MinScore  := MinScore;
							self := [];
			));

				self.Config.MatchOptions.GenerateOnName  := GenerateResultsOnName;	
				self.Config.GeneralOptions.MaxNumberOfMatchesReturned  := MaxReturnRecs;
				self.Config.GeneralOptions.SortResultsByEntityScore  := SortResultsByScore;
				self.config.MatchOptions.ScoreAddress := IncludeAddrinScoreLift;
				self.config.ConflictOptions.DOBTolerance := DOBToleranceYrs;
				self.Input.BlockID  := le.seq;	
				SELF.Input.EntityRecords := project(dataset([{1}], {unsigned a}), transform(iesp.WsSearchCore.t_InputEntityRecord,			
																							self.id  :=  le.seq;
																							self.name.First := if(le.did <>  0, le.firstName, '');
																							self.name.Middle := if(le.did <>  0,le.middleName, '');
																							self.name.Last := if(le.did <>  0,le.lastName, '');	
																							self.name.Full := if(le.bdid <>  0,le.company_name, '');	
																							self.EntityType := if(le.did <> 0 and le.bdid = 0, 'Individual', 'Business');  // value required - 'Unknown' is an option
																							self.EFTInfo._Type := 'None';   // value equired
																							self.gender := 'Unknown';  //value equired
																							SELF.Addresses := project(dataset([{1}], {unsigned a}), transform(iesp.WsSearchCore.t_InputAddress,																			
																																															self.Country := 'United States';   // defaulted because Country is not in cleaned address
																																															self.StateProvinceDistrict := ut.St2Name(le.state);
																																															self._type := 'Current';    //values['None','Current','Mailing','Previous','Unknown','']
																																															self.BuildingOrStreetNumber := le.prim_range;
																																															self.StreetPreDirection := le.predir;
																																															self.StreetName := le.prim_name;
																																															self.StreetPostDirection := le.addr_suffix;
																																															self.StreetSuffixOrType := le.postdir;
																																															self.UnitDesignation := le.unit_desig;
																																															self.UnitNumber := le.sec_range;
																																															self.City := le.city_name;
																																															self.PostalCode := le.z5;
																																															self := [];));
																							
																							self.AdditionalInformation := if(le.did <> 0 and le.dob <> '' and le.dob <> '0', project(dataset([{1}], {unsigned a}), transform(iesp.WsSearchCore.t_InputAdditionalInfo,             
																																											 self._Type  := 'DOB';
																																											 self.Value  :=  le.DOB;
																																											 self := [];)), 
																																							project(dataset([{1}], {unsigned a}), transform(iesp.WsSearchCore.t_InputAdditionalInfo,             
																																											 self._Type  := 'None';
																																											 self := [];))),
																							
																							self := [];
																										));

				self := [];
			end;
																
		in_req := project(indata, into_req(left));																									

	outBridger := Gateway.SoapCall_BridgerSSXG5(in_req, gateway_cfg);
 
//  helpful in Testing
	// ErrorRecs  := 	outBridger(SearchResult.ErrorMessage <> '');
	// NONErrorRecs  := 	outBridger(SearchResult.ErrorMessage = '');
		
// descRecord := RECORD    //  need if Descriptions are used
	// string typ;
	// string val;
// end;

entityDetailsRecord := RECORD, MAXLENGTH(16384)
	string fullname;
	string notes;
	string reason;
	string SearchCriteria;
	string score;
	string bestname;
	// string descriptioncount;    //  need if Descriptions are used
	//dataset(descRecord) descriptions;    //  need if Descriptions are used
end;

ResponseRec := record
  integer blockid;
	string errormessage;
	dataset(entityDetailsRecord) EDRec;
END;

// descRecord descx(iesp.WsSearchCore.t_ResultMatchEntityDescription le) := TRANSFORM   //  need if Descriptions are used
	// self.typ := (string)le._Type;
	// self.val := le.value;
// end;

// iesp.WsSearchCore.t_SearchResponse // SearchResult // EntityRecords[] // Matches[] // Entity // EntityDetails.full // checksum, reason
// we can have multiple entity records, if we request multiple entity records on the input...
// assuming we only do one, we need only hit a single return: XG5Call[1].SearchResult.EntityRecords[1]
// all data below that is about the single entity on input.
entityDetailsRecord	breakoutentity(iesp.WsSearchCore.t_ResultMatch le) := TRANSFORM
	self.notes := le.Entity.EntityDetails.Notes[1..4000];
	self.reason   := if(trim(le.entity.EntityUniqueID) = '', '', le.Entity.EntityDetails.reason);
	self.SearchCriteria := if(trim(le.entity.EntityUniqueID) = '', '', le.Entity.SearchCriteria);
	self.fullname := (string)le.Entity.EntityDetails.Name.full;
	self.score := (string)le.entity.Score;
	self.bestname := (string)le.Name.Best;
	// dcnt := count(le.Descriptions);
	// self.descriptioncount := (string)dcnt;
	//self.descriptions := project(le.Descriptions, descx(left));
	self := [];
end;
	

ResponseRec	breakoutmain(iesp.WsSearchCore.t_SearchResponse le) := TRANSFORM
  self.blockid := le.searchresult.EntityRecords[1].InputRecord.id;
  //self.blockid := le.blockid; // XG4?
//TODO:update for errors
	self.errormessage := le.searchresult.errormessage;
  
	self.EDRec := project(le.SearchResult.EntityRecords.Matches, breakoutentity(left));
end;	


/*
	Xg5call can have multiple returns if the soap call is given multiple requests,
	EntityRecords can have multiple if a single request contained multiple entity
	requests
*/

// NewsMain := project( NONErrorRecs, breakoutmain(left));
NewsMain := project( outBridger, breakoutmain(left));


CategoryRecord := RECORD, MAXLENGTH(16384)
	string fullname;
	string notes;
	string SearchCriteria;
	string source;
	string reason;
	string reasonLevel;
	string reasonCtgy;
	string reasonSubCtgy;
	string score;
	string bestname;
	string offense;
	string level;
	string lastupdated;
	string country;
	// string category;
	// string subcategory;
	boolean OFACpresence;
	
end;

ResponseRecSlim := record
  integer blockid;
	string errormessage;
	dataset(CategoryRecord) CatRec;
	iesp.WsSearchCore.t_SearchResponse XG5Return;
END;

// NOTES PARSER ------------------------------------------------
PATTERN notdelim := PATTERN('[^|]');
PATTERN notcomma := PATTERN('[^,]');
PATTERN ws1 := PATTERN('[ \t]');

PATTERN ws := ws1*;
PATTERN recA := notdelim+;
PATTERN recB := notcomma+;
PATTERN endrec := '||' ws;
//extra recA created to keep seperate/track of those should level be optional
PATTERN lvl := recA;
PATTERN cat := recA;
PATTERN sub := recA;

PATTERN source :=  'Source:' ws recB ws ',' ws recA;
PATTERN offense := 'Offense:' ws recA;
PATTERN levcat  := ('Level:' ws lvl ws '|' ws)* 'Category:' ws cat ws '|' ws 'Subcategory:' ws sub;
PATTERN lastup :=  'Last updated:' ws recA;
PATTERN skp := recA ('|' recA)*; // some contain single embedded pipes as field delims

PATTERN thedata := (levcat | source | offense | lastup | skp);
RULE allrecs := FIRST ws thedata (endrec thedata)* LAST;
// ------------------------------------------------

CategoryRecord parseXform(entityDetailsRecord le) := TRANSFORM
												self.fullname := le.fullname;
//												self.notes  := left.notes;
												self.reason := le.reason;
//												self.SearchCriteria := le.SearchCriteria;
												self.source := TRIM(MATCHTEXT(source/recA));
												OFACSearchCriteria :=   TRIM(MATCHTEXT(source/recA)) in OFACSources;
												self.OFACpresence := OFACSearchCriteria;
												self.reasonLevel := TRIM(MATCHTEXT(levcat/lvl));
												self.reasonCtgy := TRIM(MATCHTEXT(levcat/cat));
												self.reasonSubCtgy := TRIM(MATCHTEXT(levcat/sub));
												self.score   := le.score;
												self.bestname  := le.bestname;

												self.country := TRIM(MATCHTEXT(source/recB));
												self.offense:= TRIM(MATCHTEXT(offense/recA));
												self.lastupdated := TRIM(MATCHTEXT(lastup/recA));
												// category   := StringLib.StringToUpperCase((string30)REGEXFIND(searchpatternCtgy,left.notes,1));
												// self.category   := category;
												// subcategory := StringLib.StringToUpperCase((string30)REGEXFIND(searchpatternSubCtgy,left.notes,1));
												// self.subcategory := subcategory;
												
												self  := [];
END;


ResponseRecSlim   GetCategories(ResponseRec le, iesp.WsSearchCore.t_SearchResponse ri) := TRANSFORM
  self.blockid := le.blockid;
	self.errormessage := le.errormessage;
	self.catrec := parse(le.EDRec, Notes, allrecs, parseXform(left), BEST, SCAN, NOCASE);
	self.XG5Return := ri;
	self := [];  
End;


CategoryRec := join(NewsMain, outBridger,
												left.blockid = right.searchresult.EntityRecords[1].InputRecord.id,
												GetCategories(left, right) );


// output(indata, named('indataNEWS'), overwrite);
// output(in_req, named('in_req'), overwrite); 
// output(gateways, named('gatewaysGateCall'), overwrite);
// output(gateway_cfg, named('gateway_cfgGateCall'), overwrite);
// output(outBridger, named('outBridger'), overwrite);
// output(NewsMain, named('NewsMain'), overwrite);
// output(CategoryRec, named('CategoryRec'), overwrite);
// output(CategoryRec[1].XG5Return, named('xg5res'));
		
		return CategoryRec;												
END;

