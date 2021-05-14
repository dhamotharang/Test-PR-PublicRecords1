import Relationship, riskwise, risk_indicators, _Control;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Ids(GROUPED DATASET(Risk_Indicators.Layout_Output) iid_res,
                       boolean includeRelativeInfo=true,
											 string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
											 unsigned8 BSOptions) := FUNCTION

IsAML  := (BSOptions & risk_indicators.iid_constants.BSOptions.IsAML) > 0;

risk_indicators.Layout_Boca_Shell_ids get_all_dids(Risk_Indicators.Layout_Output le, 
								unsigned6 in_did, 
                boolean relat, STRING20 f_name, STRING20 l_name) :=
TRANSFORM
						    samePerson := in_did in[le.did2,le.did3] and relat;
                SELF.seq := if(sameperson, 99999999, le.seq);
                self.historydate := le.historydate;
                SELF.did := in_did;
                SELF.isrelat := relat;
                SELF.fname := f_name;
                SELF.lname := l_name;
								self.skip_opt_out := if(relat, true, le.skip_opt_out); // only do opt out on the consumer on input, don't need it on relatives
                self := [];
END;

iids_dedp := dedup(sort(ungroup(iid_res),did), did);

justDids := PROJECT(iids_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));

//pass in doTHOR here in onThor = TRUE?
rellyids := Relationship.proc_GetRelationshipNeutral(justDids,TopNCount:=100,
				RelativeFlag :=TRUE,AssociateFlag:=TRUE,
				doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost, doThor:=onThor).result;   

rel_ids_roxie := JOIN(iid_res, rellyids, 
                      LEFT.did=RIGHT.did1, 
                      get_all_dids(LEFT,RIGHT.did2,true,LEFT.fname,LEFT.lname));

rel_ids_thor := JOIN(DISTRIBUTE(iid_res, HASH64(did)), 
                     DISTRIBUTE(rellyids, HASH64(did1)), 
                     LEFT.did=RIGHT.did1, 
                     get_all_dids(LEFT,RIGHT.did2,true,LEFT.fname,LEFT.lname), LOCAL);
                     
#IF(onThor)
  rel_ids := rel_ids_thor;
#ELSE
  rel_ids := rel_ids_roxie;
#END

bsids := GROUP(IF(includeRelativeInfo,rel_ids(seq <> 99999999)) + 
						PROJECT(iid_res, get_all_dids(LEFT,LEFT.did,false,LEFT.fname,LEFT.lname)));
						

RETURN bsids;

END;
