EXPORT BWR_Check_Missing_Candidates := 'todo';output(BIPV2_ProxID.Files().outfile.qa(dotid in [1786858,4063037]));
UNSIGNED8 Proxidone := 1786858;
UNSIGNED8 Proxidtwo := 4063037;
BFile := BIPV2_ProxID.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile).Candidates(Proxid=Proxidone),100000),BIPV2_ProxID.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile).Candidates(Proxid=ProxidTwo),100000),BIPV2_ProxID.match_candidates(BFile).layout_candidates);
k := BIPV2_ProxID.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_ProxID.Layout_Specificities.R)[1]);
odlv := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odr);
BIPV2_ProxID.match_candidates(BFile).layout_attribute_matches ainto(BIPV2_ProxID.Keys(BFile).Attribute_Matches le) := TRANSFORM
SELF := le;
END;
am := PROJECT(BIPV2_ProxID.Keys(BFile).Attribute_Matches(Proxid1=Proxidone,Proxid2=Proxidtwo)+BIPV2_ProxID.Keys(BFile).Attribute_Matches(Proxid1=Proxidtwo,Proxid2=Proxidone),ainto(LEFT));
mtch := BIPV2_ProxID.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_ProxID.match_candidates(BFile).layout_matches),am);
// Put out easy to read versions of the 4944704 data
OUTPUT( odl,NAMED('ProxidOneCandiatesKey'));
OUTPUT( odr,NAMED('ProxidTwoCandiatesKey'));
OUTPUT( odlv,NAMED('ProxidOneFieldValues'));
OUTPUT( odrv,NAMED('ProxidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('ProxidOneRecords'));
OUTPUT( odr,NAMED('ProxidTwoRecords'));
dit10 				:= BIPV2_ProxID.Files().outfile.qa;
keycandidates := BIPV2_ProxID.Keys(BFile).Candidates;
dProxidsNotInKey := join(
	 dit10
	,keycandidates
	,left.proxid = right.proxid
	,transform(recordof(left),self := left)
	,left only
);
dProxidsNotInIt10 := join(
	 dit10
	,project(keycandidates	,recordof(keycandidates))
	,left.proxid = right.proxid
	,transform(recordof(right),self := right)
	,right only
);
dProxidsInBoth := join(
	 dit10
	,keycandidates
	,left.proxid = right.proxid
	,transform(recordof(left),self := left)
	,keep(1)
);
countdit10						 := count(dit10							);
countkeycandidates		 := count(keycandidates			);
countdProxidsNotInKey	 := count(dProxidsNotInKey	);
countdProxidsNotInIt10 := count(dProxidsNotInIt10	);
countdProxidsInBoth		 := count(dProxidsInBoth		);
output(countdit10							,named('countdit10'							));
output(countkeycandidates			,named('countkeycandidates'			));
output(countdProxidsNotInKey	,named('countdProxidsNotInKey'	));
output(countdProxidsNotInIt10	,named('countdProxidsNotInIt10'	));
output(countdProxidsInBoth		,named('countdProxidsInBoth'		));
output(dit10							,named('dit10'						));
output(keycandidates			,named('keycandidates'		));
output(dProxidsNotInKey		,named('dProxidsNotInKey'	));
output(dProxidsNotInIt10	,named('dProxidsNotInIt10'));
output(dProxidsInBoth			,named('dProxidsInBoth'		));
BIPV2_ProxID.output_test_cases(dProxidsInBoth);
