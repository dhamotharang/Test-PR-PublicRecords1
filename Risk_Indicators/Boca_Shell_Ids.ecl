import doxie,watchdog,doxie_raw,progressive_phone,ut, Relationship, riskwise;

export Boca_Shell_Ids(GROUPED DATASET(Risk_Indicators.Layout_Output) iid_res,
                       boolean includeRelativeInfo=true,
											 string50 DataRestriction=iid_constants.default_DataRestriction,
											 unsigned8 BSOptions) := FUNCTION

IsAML  := (BSOptions & iid_constants.BSOptions.IsAML) > 0;

Layout_Boca_Shell_ids get_all_dids(Risk_Indicators.Layout_Output le, 
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

                self := [];
END;

iids_dedp := dedup(sort(ungroup(iid_res),did), did);

justDids := PROJECT(iids_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));

rellyids := Relationship.proc_GetRelationship(justDids,TopNCount:=100,
				RelativeFlag :=TRUE,AssociateFlag:=TRUE,
				doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result;   

rel_ids := JOIN(iid_res, rellyids, 
							 LEFT.did=RIGHT.did1, 
							 get_all_dids(LEFT,RIGHT.did2,true,LEFT.fname,LEFT.lname));		

bsids := GROUP(IF(includeRelativeInfo,rel_ids(seq <> 99999999)) + 
						PROJECT(iid_res, get_all_dids(LEFT,LEFT.did,false,LEFT.fname,LEFT.lname)));
						

RETURN bsids;

END;
