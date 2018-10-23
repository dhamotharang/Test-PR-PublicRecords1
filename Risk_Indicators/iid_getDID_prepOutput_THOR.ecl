/*2017-06-01T19:41:18Z (laura Weiner_prod)
RR-11357: realtime 5.0 FCRA Boca Shell on Thor
*/
import didville, did_add, doxie, suppress, gateway;

// this function will take the input data, append the DID and do all default values in layout output
EXPORT iid_getDID_prepOutput_THOR(DATASET(risk_indicators.layout_input) indata, unsigned1 dppa, unsigned1 glb, 
							boolean isFCRA=false,
							unsigned1 BSversion, string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
							unsigned1 append_best=0/*0-don't append best, 1-save best ssn, 2-append best ssn to input if missing*/,
							dataset(Gateway.Layouts.Config) gateways,
							unsigned8 BSOptions=0	// this is initially being passed for the cap one riskview batch service so we dont call neutral roxie
							) := function

	FCRAScoreCheck := isFCRA and bsVersion > 2 ; //FCRA versions > 2, can't give back score < 80

	// SIMPLIFY ALL OF THIS LOGIC DOWN TO JUST APPENDING DID WHEN MISSING ON INPUT.  IF IT'S ALREADY POPULATED, USE THAT ONE IN THE THOR JOB
	didprep := PROJECT(indata(did=0), TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));
	
	// didprep_TEMP := PROJECT(indata, TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));
	
	matchset_input := ['A','D','S','P','Z'];

	did_Add.MAC_Match_Flex(didprep, matchset_input,
												 SSN, DOB, fName, mname, LName, suffix, 
												 prim_range, prim_name, sec_range, z5,
												 st, Phone10,
												 did,
												 didville.Layout_Did_OutBatch,
												 true, score,	//these should default to zero in definition
												 0,	  //dids with a score below here will be dropped 	
												 resu);
 
 
 // if the input has the DID already, don't send that input record through the didappend again
	already_has_did := PROJECT(indata(did<>0), TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));
  all_dids := ungroup(resu + already_has_did);
	unique_dids := dedup(sort(project(distribute(all_dids, hash64(did)),transform(doxie.layout_references,self:=left)), did, LOCAL), did, LOCAL);

	// all_dids := didprep_TEMP;  // JUST USE THE INPUT FILE DIDS TO AVOID ANY DID APPEND LOGIC FOR THIS INITIAL THOR TEST
	bestSSN := risk_indicators.collection_shell_mod.getBestCleaned(unique_dids, 
																																	DataRestriction, 
																																	GLB_Purpose:=1, //is this right??
																																	clean_address:=false); // don't need clean address, just the best SSN
	
	bestSSNappended := join(distribute(all_dids, hash64(did)), 
													distribute(bestSSN, hash64(did)), 
													left.did<>0 and left.did=right.did,
												TRANSFORM(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, 
																	SELF.best_ssn := right.ssn,
																	SELF.did_ct := 1,
																	SELF := left), left outer, keep(1), LOCAL);
	withBestSSN := if(append_best=0, project(all_dids, transform(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, self.did_ct:=1, self := left)),	bestSSNappended);

 	risk_indicators.layout_output inputToOutLayout(indata le, withBestSSN rt) := transform
		self.did := rt.did;

		self.score := rt.score;
		self.addrvalflag := IF(le.in_streetAddress<>'',iid_constants.addrvalflag(le.addr_status),'');
		self.dwelltype := iid_constants.dwelltype(le.addr_type);
		self.firstscore := 255;
		self.lastscore := 255;
		self.hphonescore := 255;
		self.wphonescore := 255;
		self.socsscore := 255;
		self.dobscore := 255;
		self.addrscore := 255;
		self.cmpyscore := 255;
		self.didcount := if(rt.did<>0, 1, 0);
		
		self.BestSSN := rt.best_ssn;
		self := le;
		self := [];
	end;

	did_from_input := join(indata, withBestSSN, left.seq=right.seq, inputToOutLayout(LEFT, RIGHT));

	appType := Suppress.Constants.ApplicationTypes.DEFAULT;
	// search1_by_did := false;
	Suppress.MAC_Suppress(did_from_input,got_DIDbySSN_t1_pulled,appType,Suppress.Constants.LinkTypes.SSN,ssn);
	// search2_by_did := true;
	Suppress.MAC_Suppress(got_DIDbySSN_t1_pulled,got_DIDbySSN_t2,appType,Suppress.Constants.LinkTypes.DID,did);

	layout_output CheckDIDorSSN(layout_output le, layout_output ri) := TRANSFORM
		SELF.did := ri.did;
		SELF.pullidflag := if(ri.did = 0 and le.did != 0, '1', '');
		SELF := le;
	END;
	got_DIDbySSN := GROUP(sort(join(did_from_input, got_DIDbySSN_t2, 
													left.seq = right.seq and left.did=right.did, 		
													CheckDIDorSSN(LEFT, RIGHT), LEFT OUTER, keep(1)),seq,did), seq,DID);	
													
	FCRAMin := got_DIDbySSN(score >= Risk_Indicators.iid_constants.min_FCRA_did_score);

	FCRAData := join(ungroup(got_DIDbySSN), FCRAMin,
		left.seq = right.seq,
		transform(layout_output, self.did := 0, self.score := 0, self := left, self := []),
		left only);
	//only return records >80 for FCRA, version >2 and no retaining did options set. Must keep a empty
	//record of did of 0 and score of 0 on row to be like we had it prior to change
	got_DIDbySSN2 := if(FCRAScoreCheck,
		//(UseInputDidORRid = false and RetainInputDID=false and CapOneBatch = false), 
		Group(Sort(FCRAData + FCRAMin, seq, did), seq, did), got_DIDbySSN);												
// output(resuTemp, named('resuTemp'));
// output(possibleNameSwap, named('possiblenameswap'));
// output(resuTemp2, named('resutemp2'));
// output(resu, named('resu'));
// output(withNeutral, named('withNeutral'));	
// output(bestrecs, named('bestrecs'));	
	return got_DIDbySSN2;
end;