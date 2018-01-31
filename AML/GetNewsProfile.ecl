
Import UT, Gateway, Risk_Indicators;

/*
for testing use this declaration with set up the gateways in the appropriate stored variable
*/
// gateway_ext := dataset([
	// {'bridgerxg5','http://bridger_dev:[PASSWORD_REDACTED]@10.173.132.10:7001/WsSearchCore?ver_=1'}
	// ,
	// {'searchcore','HTTP://khillqa:[PASSWORD_REDACTED]@gatewaycertesp.sc.seisint.com:7726/WsGateway/?ver_=1.93'}
// ],  Risk_Indicators.Layout_Gateways_In );
// ],  Gateway.Layouts.Config );
// #stored('Gateways', gateway_ext);



EXPORT GetNewsProfile (DATASET(Layouts.AMLRiskProfileInput) indata, 
																											string1 UseXG5, 
																											boolean IncludeNews, 
																											DATASET (Gateway.Layouts.Config) gateways )   := FUNCTION

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

// BridgerSearch := AML.BSSXG5GatewayCall(PrepNewsProfile, Gateways);
// Bridger4 := AML.BSSXG4GatewayCall(PrepNewsProfile, gateways);

BridgerSearch := IF(UseXG5 in ['2', '1'],	AML.BSSXG5GatewayCall(PrepNewsProfile, gateways), AML.BSSXG4GatewayCall(PrepNewsProfile, gateways));

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
	integer IndProfileType;
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
	unsigned2 MaxIndProfileType;	
	dataset(CategoryRecord) CatRec;
END;



BlockRec   GetResultTypes(BridgerSearch le) := TRANSFORM
  self.blockid := le.blockid;
	self.errormessage := le.errormessage;
	self.catrec := project(le.catrec, transform(CategoryRecord,
												PrepamlCtgy := trim(left.reasonCtgy) + '-' + trim(left.reasonSubCtgy); 						
												amlCtgy := if(StringLib.StringToUpperCase(PrepamlCtgy)in AMLConstants.AMLNewsCategory, true, false);
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
                        reasonCtgyUC := StringLib.StringToUpperCase(left.reasonCtgy);
												reasonSubCtgyUC := StringLib.StringToUpperCase(left.reasonSubCtgy);
												self.IndProfileType  := Map(  //  set to uppercase in gateway call  todo
																									left.OFACpresence   																																									=>  9,
												                          reasonCtgyUC  = 'SANCTION LIST'  																																			=> 8,
																									reasonCtgyUC  = 'ENFORCEMENT'  																																				=> 7,
																									reasonCtgyUC  = 'PEP' and reasonSubCtgyUC <> 'FORMER PEP' 																						=> 6,
																									(reasonCtgyUC  = 'PEP' or reasonCtgyUC  = 'ENFORCEMENT' or reasonCtgyUC  = 'ASSOCIATED ENTITY' 
																									or reasonCtgyUC  = 'ADVERSE MEDIA' or reasonCtgyUC  = 'INVESTIGATION' or 	reasonCtgyUC  = 'INFLUENTIAL PERSON' )	
																										and reasonSubCtgyUC = 'FORMER PEP'  																																=> 5,
																									reasonCtgyUC  = 'ADVERSE MEDIA'  																																			=> 4,
																									reasonCtgyUC  = 'INVESTIGATION' or reasonCtgyUC = 'EXCLUDED PARTY'  																	=> 3,
																									reasonCtgyUC  = 'ASSOCIATED ENTITY'   																																=> 2,
																									 1);

												   
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
	self.maxIndProfileType  := IF(count(le.catrec) = 0, 1, max(le.catrec,IndProfileType));
	self := [];  
End;

CtgyCounts := project(newResulttypes, GetNewsCnt(left));

Layouts.AMLRiskProfileInput  AddKRI(indata le, CtgyCounts ri) := TRANSFORM
  self.seq   											:=  le.seq;
	self.did     										:=  le.did;
	self.bdid       								:=  le.bdid;
	self.historydate     						:=  le.historydate;
	self.firstName        					:=  le.firstName;
	self.middleName        					:=  le.middleName;
	self.lastName          					:=  le.lastName;
	self.DOB             						:=  le.DOB;
	self.company_name         			:=  le.company_name;
	self.state     									:=  le.state;
	self.IndHighRiskNewsProfiles   	:=  if(le.did <> 0, 	
																							map(ri.errormessage <> '' 																		  => '-999',
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
																									'0'),
																									'0');

		self.IndHighRiskNewsProfileType   	:=  if(le.did <> 0, 		
																								MAP(ri.errormessage <> ''  => '-999',
																										ri.errormessage = '' 	 => (string)ri.maxIndProfileType, 
																										'0'),
																										'0');


	  self := [];
	END;

	NewsProfileKRI :=  join(indata, CtgyCounts,  left.seq = right.blockid,
													AddKRI(left,right), left outer);

	finalwithxg5 := join(NewsProfileKRI, BridgerSearch, left.seq = right.blockid,
											TRANSFORM(Layouts.AMLRiskProfileInput, self.XG5Return := right.XG5Return, self:=left));
	
 	finalKri := IF(UseXG5 = '1',finalwithxg5,NewsProfileKRI);
	
	Layouts.AMLRiskProfileInput  AddNoNewsKRI(indata le) := TRANSFORM
  self.seq   											:=  le.seq;
	self.did     										:=  le.did;
	self.bdid       								:=  le.bdid;
	self.historydate     						:=  le.historydate;
	self.firstName        					:=  le.firstName;
	self.middleName        					:=  le.middleName;
	self.lastName          					:=  le.lastName;
	self.DOB             						:=  le.DOB;
	self.company_name         			:=  le.company_name;
	self.state     									:=  le.state;
	self.IndHighRiskNewsProfiles   	:= 	'0';
	self.IndHighRiskNewsProfileType := 	'0';
	  self := [];
	END;
	
	NoNewsProfileKRI :=  project(indata(did <>0), AddNoNewsKRI(left));
													
	NewsProfileAttrib := IFF(IncludeNews, finalKri, NoNewsProfileKRI);	
	
										
						
//TESTING
// output(indata, named('indata'));
// output(UseXG5, named('UseXG5'));
// output(PrepNewsProfile, named('PrepNewsProfile'), overwrite);	
// output(BridgerSearch, named('BridgerSearch'), overwrite);	
// output(newResulttypes, named('newResulttypes'), overwrite);	
// output(CtgyCounts, named('CtgyCounts'), overwrite);	
// output(NewsProfileKRI, named('NewsProfileKRI'), overwrite);	
	
		return(NewsProfileAttrib);	
		
END;
