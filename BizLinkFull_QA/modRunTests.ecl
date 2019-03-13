IMPORT BIPV2, SALT37;
EXPORT modRunTests(DATASET(BIPV2.IdAppendLayouts.AppendInput) dInData, ROW(modLayouts.ProfileRec) rInRow):= MODULE  
 
SHARED dThorInput := CHOOSEN(dInData(source not in ['T1','T2','T3','T4','T5', 'T', 'P', 'B#']),10);

SHARED appendThor:=  BIPV2.IdAppendThor(dThorInput,
																					,scoreThreshold := 75
																					,weightThreshold := 0 
																					,primForce := false
																					,reAppend := true);
	
SHARED dTHOR := appendThor.IdsOnly() : INDEPENDENT;																				

EXPORT j_In_THOR := JOIN(dTHOR, dThorInput, left.request_id=right.request_id, TRANSFORM({STRING mode; SALT37.UIDType uniqueid; INTEGER2 weight; INTEGER2 score; UNSIGNED4 KeysUsed; UNSIGNED4 KeysFailed; 
																																								BOOLEAN 	IsTruncated := FALSE ; STRING keysused_desc; STRING errorcode; RECORDOF(left) L; RECORDOF(right)R;},
																																									SELF.mode 	:= '1';
																																									SELF.uniqueid := 0;
																																									SELF.weight		:= 0;
																																									SELF.score		:= 0;
																																									SELF.KeysUsed := 0;
																																									SELF.KeysFailed := 0;
																																									SELF.keysused_desc := '';
																																									SELF.errorcode := '';
																																									SELF.L 			:= LEFT;
																																									SELF.R			:= RIGHT;));

SHARED dRoxieInput := CHOOSEN(dInData(source in ['T1','T2','T3','T4','T5', 'T', 'P', 'B#']),10);

// SHARED appendRoxie := BIPV2.IdAppendRoxieRemote(dRoxieInput);
															// ,scoreThreshold := 75 // 75 is the default, valid values are >= 51 and <= 100
															// ,weightThreshold := 0 // default is 0. Can be set higher to ensure a stronger match
															// , // Set to true to enforce that prim_range match unless not specified in input
															// ,,,,reAppend := true);


SHARED appendRoxie := BIPV2.IdAppendThor(dRoxieInput
															    ,scoreThreshold := 75
																	,weightThreshold := 0 
																	,primForce := false
																	,reAppend := true
																	,mimicRoxie :=true);
															
EXPORT dROXIE := appendRoxie.IdsOnly() :INDEPENDENT;			

EXPORT j_In_ROXIE := JOIN(dRoxie, dRoxieInput, left.request_id=right.request_id, TRANSFORM({STRING mode; SALT37.UIDType uniqueid; INTEGER2 weight; INTEGER2 score; UNSIGNED4 KeysUsed; UNSIGNED4 KeysFailed; 
																																									BOOLEAN IsTruncated := FALSE ; STRING keysused_desc; STRING errorcode; RECORDOF(left) L; RECORDOF(right)R;},
																																									SELF.mode 		:= '2';
																																									SELF.uniqueid := 0;
																																									SELF.weight		:= 0;
																																									SELF.score		:= 0;
																																									SELF.KeysUsed := 0;
																																									SELF.KeysFailed := 0;
																																									SELF.keysused_desc := '';
																																									SELF.errorcode := '';
																																									SELF.L 				:= LEFT;
																																									SELF.R 				:= RIGHT;));

//IdFunctions call
SHARED idFunctionsInput  := CHOOSEN(dInData(source='T'),100);

SHARED roxieIP 		 := 'http://10.173.3.1:9876'; // Dev 1-way 1
SHARED serviceName := 'BIPV2.IDfunctions_Service';

svcOut := RECORD
	SALT37.UIDType uniqueid;
	INTEGER2 weight;
	INTEGER2 score;
	UNSIGNED4 KeysUsed := 0;
	UNSIGNED4 KeysFailed := 0;
	BOOLEAN IsTruncated := FALSE;
	SALT37.UIDType seleid;
	SALT37.UIDType orgid;
	SALT37.UIDType ultid;
	SALT37.UIDType proxid;
	SALT37.UIDType powid; 
	SALT37.UIDType rcid;
	STRING acctno;
	STRING keysused_desc;
END;

svcInput := BIPV2.IDFunctions.rec_SearchInput;

dsBatch := PROJECT(idFunctionsInput,
	TRANSFORM(svcInput, 
		SELF.acctno := (STRING)LEFT.request_id;
		SELF.results_limit := 0;
		SELF.inSeleid := '0';
		SELF.allow7DigitMatch := FALSE;
		SELF.HSort := FALSE;
		SELF := LEFT;
	));

recRequest := {
	DATASET(svcInput) search_input {xpath('search_input/Row')},
};

inputs0 := PROJECT(dsBatch, 
	TRANSFORM(recRequest,
		SELF.search_input := LEFT;));

input := DISTRIBUTE(inputs0, RANDOM());

output_layout := svcOut;
            
errx := {(output_layout)
	STRING errorcode := '';
	INTEGER transaction_time {xpath('_call_latency_ms')};
};

errx err_out(input L) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

// parallel(2) is the default for a SOAPCALL
SHARED dIdFunctions :=
	SOAPCALL(input, roxieIP, servicename, {input}, DATASET(errx)
		,XPATH(servicename + 'Response/Results/Result/Dataset/Row') //you can look at the XML output from wsecl to get this (but the first 'results' doesnt show there)
		,ONFAIL(err_out(left)), PARALLEL(1)
		// RETRY(3), TIMEOUT(300)
		,MERGE(1)
	);

 SHARED idsonlyoutput_layout := RECORD
  unsigned8 request_id;
  unsigned6 dotid := 0;
  unsigned2 dotscore := 0;
  unsigned2 dotweight := 0;
  unsigned6 empid := 0;
  unsigned2 empscore := 0;
  unsigned2 empweight := 0;
  unsigned6 powid := 0;
  unsigned2 powscore  := 0;
  unsigned2 powweight := 0;
  unsigned6 proxid := 0;
  unsigned2 proxscore := 0;
  unsigned2 proxweight := 0;
  unsigned6 seleid := 0;
  unsigned2 selescore := 0;
  unsigned2 seleweight := 0;
  unsigned6 orgid := 0;
  unsigned2 orgscore := 0;
  unsigned2 orgweight := 0;
  unsigned6 ultid := 0;
  unsigned2 ultscore := 0;
  unsigned2 ultweight := 0;
  integer8 error_code := 0;
  string error_msg := '';
 END;

EXPORT j_In_IDFUNCTIONS	:=join(dIdFunctions, idFunctionsInput, (integer)left.acctno = right.request_id, transform({STRING mode;  SALT37.UIDType uniqueid; INTEGER2 weight; INTEGER2 score; UNSIGNED4 KeysUsed; UNSIGNED4 KeysFailed; 
																																									BOOLEAN IsTruncated := FALSE ; STRING keysused_desc; STRING errorcode; idsonlyoutput_layout L; RECORDOF(right)R;},
																																									SELF.mode 		:= '3';
																																									SELF.uniqueid := left.uniqueid;
																																									SELF.weight := left.weight;
																																									SELF.score := left.score;
																																									SELF.KeysUsed := left.KeysUsed;
																																									SELF.KeysFailed := left.KeysFailed;
																																									SELF.IsTruncated :=left.IsTruncated;
																																									SELF.keysused_desc := left.keysused_desc;
																																									SELF.errorcode := left.errorcode;
																																									SELF.L.request_id := (integer) left.acctno;
																																									SELF.L := LEFT;
																																									SELF.R := RIGHT;));

																																									
											
END; 
