import Header, Relationship, riskwise, risk_indicators;

export Boca_Shell_Ids_AML(GROUPED DATASET(Risk_Indicators.Layout_Output) iid_res,
                       boolean includeRelativeInfo=true,
											 string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
											 unsigned8 BSOptions) :=
FUNCTION

IsAML  := (BSOptions & risk_indicators.iid_constants.BSOptions.IsAML) > 0;

risk_indicators.Layout_Boca_Shell_ids get_all_dids(Risk_Indicators.Layout_Output le, unsigned6 in_did, 
                boolean relat, STRING20 f_name, STRING20 l_name,unsigned1 titleNo=0) :=
TRANSFORM
                SELF.seq := le.seq;
                self.historydate := le.historydate;
                SELF.did := in_did;
                SELF.isrelat := relat;
                SELF.fname := f_name;
                SELF.lname := l_name;
                SELF.relation := if (isAML and titleNo>0, Header.relative_titles.fn_get_str_title(titleNo),'');
                self := [];
END;

iids_dedp := dedup(sort(ungroup(iid_res),did), did);
justDids := PROJECT(iids_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));

rellyids := Relationship.proc_GetRelationshipNeutral(justDids,TopNCount:=100,
				RelativeFlag :=TRUE,AssociateFlag:=TRUE,
				doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result;   

rel_ids := JOIN(iid_res, rellyids, 
							 LEFT.did=RIGHT.did1, 
							 get_all_dids(LEFT,RIGHT.did2,true,LEFT.fname,LEFT.lname, RIGHT.title));		

ids := GROUP(IF(includeRelativeInfo,rel_ids) + PROJECT(iid_res, get_all_dids(LEFT,LEFT.did,false,LEFT.fname,LEFT.lname)));

RETURN ids;

END;
