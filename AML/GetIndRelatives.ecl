import header, riskwise, relationship;

EXPORT GetIndRelatives (  DATASET(Layouts.LayoutAMLShellV2) IdsIn    

													 ) := FUNCTION;

IndividDIDS := project(IdsIn, transform(Layouts.RelatLayoutV2, self.seq := left.seq,
												self.historydate := left.historydate,
												self.origdid := left.did, 
												self.subjectdid := left.did, 
												self.RelatDegree := 0,
												self.relatdid  := left.did,
												self.relation := 'self';
												self.isrelat := false;
												self.dob := left.dob;
												self.street_addr := left.street_addr;
												self.Relatfname := left.fname;
												self.Relatlname := left.lname;
												self := left;
												self := [])
												);
iids_dedp := dedup(sort(IndividDIDS(subjectdid<>0),subjectdid), subjectdid);
justDids := PROJECT(iids_dedp, 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.subjectdid));									 
rellyids := Relationship.proc_GetRelationshipNeutral(justDids,TopNCount:=100,
			RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result;

Layouts.RelatLayoutV2 GetRelatInfo(IndividDIDS le, Relationship.layout_GetRelationship.interfaceOutputNeutral ri, integer degree) := TRANSFORM
	
		self.seq := le.seq;
		self.origdid := le.origdid;
		self.subjectdid := ri.did1;
		self.relatDID := ri.did2;
		self.relation := Header.relative_titles.fn_get_str_title(ri.title);
		self.historydate := le.historydate;
		self.isrelat := true;
		self.RelatDegree :=  if(ri.title in Header.relative_titles.set_Parent, 10,  degree);

		self := [];
END;

FirstLevelRelat :=  join(IndividDIDS, rellyids, 
										left.subjectdid = right.did1,
                    GetRelatInfo(left, right, 1), left outer);
//get parents of first degree relatives
FirstLevelRelat_dedp := dedup(sort(FirstLevelRelat,subjectdid), relatDID);
FirstLevelRelatDids := PROJECT(FirstLevelRelat_dedp, 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.relatDID));	
rellyids2 :=Relationship.proc_GetRelationshipNeutral(FirstLevelRelatDids,TopNCount:=10,
			RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result;   

RelatParents := join(FirstLevelRelat, rellyids2, 
										left.relatDID = right.did1
										and right.did2 <> 0
										and (right.title in Header.relative_titles.set_Parent) ,
                   GetRelatInfo(left, right, 10),
									 left outer);	
									 
FirstlevelParents := RelatParents(StringLib.StringToUpperCase(relation) in ['FATHER', 'MOTHER', 'PARENT']); //just for debugging

SecLevelParentsDD := dedup(sort(FirstlevelParents, seq, origdid, subjectdid, relatdid, relation), seq, origdid, subjectdid, relatdid, relation);	
			 
RelativesPrep := 	FirstLevelRelat + IndividDIDS + SecLevelParentsDD;

AllRelatives := dedup(sort(RelativesPrep, seq, origdid, subjectdid, relatdid, relation, relatdegree), seq, origdid, subjectdid, relatdid, relation);
									 
// output(IdsIn, named('IdsIn'));								 
// output(IndividDIDS, named('IndividDIDS'));								 
// output(FirstLevelRelat, named('FirstLevelRelat'));								 
// output(SecondLevelRelat, named('SecondLevelRelat'));								 							 								 			 
// output(RelativesPrep, named('RelativesPrep'));								 
// output(AllRelatives, named('AllRelatives'));								 
							 
RETURN(AllRelatives);

END;
												
 
