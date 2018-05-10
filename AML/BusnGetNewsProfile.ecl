Import UT, Gateway;

EXPORT BusnGetNewsProfile (DATASET(Layouts.AMLRiskProfileInput) indata, 
													string UseXG5, 
													boolean IncludeNews,
													DATASET (Gateway.Layouts.Config) gateways)   := FUNCTION

//needs to be in release bug for V2
Layouts.BridgerSearchInput  PrepBridger(indata le)  := TRANSFORM
  self.seq     := le.seq;
	self.did      := le.did;
	self.bdid   :=   le.Bdid;
	self.historydate    := le.historydate;
	self.firstName        := le.firstname;
	self.middleName       := le.middleName;
	self.lastName         := le.lastName;
	self.DOB              := le.DOB;
	self.company_name      := le.company_name;
	self.prim_range 				:=  le.prim_range;
	self.predir 						:= le.predir;
	self.prim_name 					:=  le.prim_name;
	self.addr_suffix 				:=   le.addr_suffix;
	self.postdir 						:=   le.postdir;
	self.unit_desig 				:= le.unit_desig;
	self.sec_range 					:= le.sec_range;
	self.city_name 					:=  le.city_name;
  self.state 							:= le.state;
	self.z5 								:=   le.z5;
	self := [];
END;

PrepNewsProfile := project(indata, PrepBridger(left));

BridgerSearch := AML.BSSXG5GatewayCall(PrepNewsProfile, gateways);

CategoryRecord := RECORD
	string fullname;
	string notes;
	string SearchCriteria;
	string reason;
	string reasonLevel;
	string reasonCtgy;
	string reasonSubCtgy;
	string score;
	string bestname;
	integer BusProfileType;
	// integer IndProfileType;
	boolean OFACpresence;
	boolean amlCtgy;
	boolean exactamlCtgy;
	boolean possamlctgy;
	boolean exactnonamlctgy;
	boolean possnonamlctgy;
	
end;

BlockRec := record
  integer blockid;
	string errormessage;
	unsigned2 exactamlCtgycnt;
	unsigned2 possamlctgycnt;
	unsigned2 exactnonamlctgycnt;
	unsigned2 possnonamlctgycnt;	
	unsigned2 MaxBusProfileType;	
	unsigned2 MaxIndProfileType;	
	// string3 IndHighRiskNewsProfiles;	
	string4 BusHighRiskNewsProfiles;	
	// string3 IndHighRiskNewsProfileType;	
	string4 BusHighRiskNewsProfileType;	
	dataset(CategoryRecord) CatRec;
END;



BlockRec   GetResultTypes(BridgerSearch le) := TRANSFORM
  self.blockid := le.blockid;
	self.errormessage := le.errormessage;
	self.catrec := project(le.catrec, transform(CategoryRecord,
												amlCtgy := if(StringLib.StringToUpperCase(trim(left.reasonCtgy)) + '-' + StringLib.StringToUpperCase(trim(left.reasonSubCtgy)) in AMLConstants.AMLNewsCategory, true, false);						
	
												self.fullname := left.fullname;
												self.notes  := left.notes;
												self.reason  := left.reason;
												self.reasonLevel  := left.reasonLevel;
												self.reasonCtgy  := left.reasonCtgy;
												self.reasonSubCtgy  := left.reasonSubCtgy;
												self.OFACpresence  := left.OFACpresence;
												self.SearchCriteria := left.SearchCriteria;
												self.score   := left.score;
												self.bestname  := left.bestname;
												self.BusProfileType  := Map(
																									left.OFACpresence   =>  9,
												                          StringLib.StringToUpperCase(left.reasonCtgy)  = 'SANCTION LIST'  => 8,
																									StringLib.StringToUpperCase(left.reasonCtgy)  = 'ENFORCEMENT'  => 7,
																									StringLib.StringToUpperCase(left.reasonCtgy)  = 'ADVERSE MEDIA'  => 6,
																									StringLib.StringToUpperCase(left.reasonCtgy)  = 'INVESTIGATION' or StringLib.StringToUpperCase(left.reasonCtgy) = 'EXCLUDED PARTY'  => 5,
																									StringLib.StringToUpperCase(left.reasonCtgy)  = 'ASSOCIATED ENTITY'  => 4,
																									StringLib.StringToUpperCase(left.reasonCtgy)  = 'END-USE CONTROLS'  => 3,
																									StringLib.StringToUpperCase(left.reasonCtgy)  = 'COMPANY OF INTEREST' or StringLib.StringToUpperCase(left.reasonCtgy) = 'GOVERNMENT CORP'  => 2,
																									 1);
												// self.IndProfileType  := Map(
																									// left.OFACpresence   =>  9,
												                          // left.reasonCtgy  = 'SANCTION LIST'  => 8,
																									// left.reasonCtgy  = 'ENFORCEMENT'  => 7,
																									// left.reasonCtgy  = 'PEP' and left.reasonSubCtgy <> 'FORMER PEP' => 6,
																									// (left.reasonCtgy  = 'PEP' or left.reasonCtgy  = 'ENFORCEMENT' or left.reasonCtgy  = 'ASSOCIATED ENTITY' 
																									// or left.reasonCtgy  = 'ADVERSE MEDIA' or left.reasonCtgy  = 'INVESTIGATION' or 	left.reasonCtgy  = 'INFLUENTIAL PERSON' )	
																										// and left.reasonSubCtgy = 'FORMER PEP'  => 5,
																									// left.reasonCtgy  = 'ADVERSE MEDIA'  => 4,
																									// left.reasonCtgy  = 'INVESTIGATION' or left.reasonCtgy = 'EXCLUDED PARTY'  => 3,
																									// left.reasonCtgy  = 'ASSOCIATED ENTITY'   => 2,
																									 // 1);
												// self.category   := left.category;
												// self.subcategory := left.subcategory;
												   
                        self.amlCtgy  := amlCtgy;												
												self.exactamlCtgy   := if(amlCtgy and (integer)left.score = 100, true, false); 
												self.possamlctgy   := if(amlCtgy and (integer)left.score < 100, true, false); 
												self.exactnonamlctgy  := if(~amlCtgy and (integer)left.score = 100, true, false); 
												self.possnonamlctgy   := if(~amlCtgy and (integer)left.score < 100, true, false))); 
	
	self := [];  
End;

newResulttypes := project(BridgerSearch, GetResultTypes(left));

BlockRec   GetNewsCnt(newResulttypes le) := TRANSFORM
  self.blockid := le.blockid;
	self.errormessage := le.errormessage;
	self.catrec := le.catrec;											
  self.exactamlCtgycnt  := count(le.catrec(exactamlCtgy = true ));	
  self.possamlctgycnt  := count(le.catrec(possamlctgy = true ));
  self.exactnonamlctgycnt  := count(le.catrec(exactnonamlctgy = true ));	
  self.possnonamlctgycnt  := count(le.catrec(possnonamlctgy = true));
	// self.maxIndProfileType  := IF(count(le.catrec) = 0, 1, max(le.catrec,IndProfileType));
	self.maxBusProfileType  :=  IF(count(le.catrec) = 0, 1, max(le.catrec, BusProfileType));
	self := [];  
End;

CtgyCounts := project(newResulttypes, GetNewsCnt(left));



BlockRec  GetKRI(CtgyCounts ri) := TRANSFORM
  self.	blockid   										:=  ri.blockid;

	self.BusHighRiskNewsProfiles   :=   
																							map(ri.errormessage <> ''  																	=> '-999',
																									ri.exactamlCtgycnt > 1        															=>  '9',
																									ri.exactamlCtgycnt = 1 				 															=>  '8',
																									ri.exactnonamlctgycnt > 1 		 															=>  '7',
																									ri.exactnonamlctgycnt = 1 		 															=>  '6',
																									ri.possamlctgycnt > 1 				 															=>  '5',
																									ri.possamlctgycnt = 1 				 															=>  '4',
																									ri.possnonamlctgycnt > 1			 															=>  '3',
																									ri.possnonamlctgycnt = 1 			 															=>  '2',
																									ri.exactamlCtgycnt = 0 and ri.possamlctgycnt = 0	and 
																									ri.exactnonamlctgycnt = 0 and ri.possnonamlctgycnt = 0		 	=>  '1',
																									'0');


	  self.BusHighRiskNewsProfileType   :=  	
																							MAP(ri.errormessage <> ''  																	  => '-999',
																										ri.errormessage = '' 	                                    => (string)ri.maxBusProfileType, 
																										'0');
		self := ri;
END;

NewsProfileKRI :=  project(CtgyCounts,  GetKRI(left));

SortNewProf := sort(NewsProfileKRI, blockid);

BlockRec rollnewprofile(SortNewProf le, SortNewProf ri )  := TRANSFORM
				self.BusHighRiskNewsProfiles := max(le.BusHighRiskNewsProfiles, ri.BusHighRiskNewsProfiles );
				self.BusHighRiskNewsProfileType  := max(le.BusHighRiskNewsProfileType, ri.BusHighRiskNewsProfileType);
				self := ri;
END;

RollBusnNewsProf :=  rollup(SortNewProf, left.blockid = right.blockid,
													rollnewprofile(left,right));

Layouts.AMLRiskProfileInput  AddKRI(indata le, RollBusnNewsProf ri) := TRANSFORM
  self.	seq   										:=  le.seq;
	self.did     										:=  le.did;
	self.bdid       								:=  le.bdid;
	self.historydate     						:=  le.historydate;
	self.firstName        					:=  le.firstName;
	self.middleName        					:=  le.middleName;
	self.lastName          					:=  le.lastName;
	self.DOB             						:=  le.DOB;
	self.company_name         			:=  le.company_name;
	self.state     									:=  le.state;

	self.BusHighRiskNewsProfiles   	:=  ri.BusHighRiskNewsProfiles;
	self.BusHighRiskNewsProfileType :=  ri.BusHighRiskNewsProfileType;
	self.xg5return 									:= [];
	self := [];
END;

AddNewsProfileKRI :=  join(indata(bdid <>0), RollBusnNewsProf,  
													left.seq = right.blockid,
													AddKRI(left,right), left outer);
													
finalBusnWithxg5 := join(AddNewsProfileKRI, BridgerSearch, left.seq = right.blockid,
											TRANSFORM(Layouts.AMLRiskProfileInput, self.XG5Return := right.XG5Return, self:=left), left outer);
											
finalBusnKri := IF(UseXG5 = '1',finalBusnWithxg5,AddNewsProfileKRI);											
													
Layouts.AMLRiskProfileInput  NoNewsKRI(indata le) := TRANSFORM
  self.	seq   										:=  le.seq;
	self.did     										:=  le.did;
	self.bdid       								:=  le.bdid;
	self.historydate     						:=  le.historydate;
	self.firstName        					:=  le.firstName;
	self.middleName        					:=  le.middleName;
	self.lastName          					:=  le.lastName;
	self.DOB             						:=  le.DOB;
	self.company_name         			:=  le.company_name;
	self.state     									:=  le.state;

	self.BusHighRiskNewsProfiles   	:=  '0';
	self.BusHighRiskNewsProfileType :=  '0';
	self.xg5return 									:= [];
	self := [];
END;

NoNewsProfileKRI :=  project(indata(bdid <>0), NoNewsKRI(left));
													
NewsProfileAttrib := IFF(IncludeNews, finalBusnKri, NoNewsProfileKRI);
													
// output(indata, named('indata'));
// output(gateways, named('gateways'));
// output(PrepNewsProfile, named('PrepNewsProfile'), overwrite);	
// output(BridgerSearch, named('BridgerSearch'), overwrite);	
// output(newResulttypes, named('newResulttypes'), overwrite);	
// output(CtgyCounts, named('CtgyCounts'), overwrite);	
// output(NewsProfileKRI, named('NewsProfileKRI'), overwrite);	
// output(SortNewProf, named('SortNewProf'), overwrite);	
// output(RollBusnNewsProf, named('RollBusnNewsProf'), overwrite);	
	

		
		return(NewsProfileAttrib);												
END;
