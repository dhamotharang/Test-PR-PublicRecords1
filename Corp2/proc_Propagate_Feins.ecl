import versioncontrol;

export proc_Propagate_Feins(

	 string					pNewVersion
	,set of string	pSetPropagateStates	= []
	,string					pPropagateVersion		= 'father'
	,boolean				pOverwrite					= false
	
) :=
function
	//Yes, as I understand it, I would join the IL records from the current base file to 
	//the father base file IL records, on corp-key, propagating the fein from the father record 
	//to the current base when the current base’s fein is blank.

	shared corpbasecurrent	:= files(									).base.corp.qa	;
	shared corpbasefather		:= files(pPropagateVersion).base.corp.new	;

	shared corpbasecurrentIL 		:= corpbasecurrent(			corp_state_origin in pSetPropagateStates and (corp_fed_tax_id = '' or trim(corp_fed_tax_id,left,right) = '-')		); // current state records w/o fein
	shared corpbasecurrentNotIL	:= corpbasecurrent(not(	corp_state_origin in pSetPropagateStates and (corp_fed_tax_id = '' or trim(corp_fed_tax_id,left,right) = '-'))	); // rest of current records
	shared corpbasefatherIL			:= corpbasefather	(			corp_state_origin in pSetPropagateStates and corp_fed_tax_id != ''  and trim(corp_fed_tax_id,left,right) != '-'	); // father state records w/ fein
                                            
	//join current IL recs to father IL recs, left outer
	shared patchedILrecs := join(
		 distribute(corpbasecurrentIL	, hash(corp_key))
		,distribute(corpbasefatherIL	, hash(corp_key))
		,left.corp_key = right.corp_key
		,transform(recordof(corpbasecurrentIL), self.corp_fed_tax_id := right.corp_fed_tax_id; self := left)
		,local
		,left outer
		,keep(1)
	);

	shared All_recs_patched := patchedILrecs + corpbasecurrentNotIL;

	VersionControl.macBuildNewLogicalFile(filenames(pNewVersion).base.corp.new	,All_recs_patched	,Build_Corp_Base_File,,,true	);

	shared firstpart := sequential(
		 Build_Corp_Base_File
		,output(count(corpbasecurrent	(corp_state_origin in pSetPropagateStates																																				)), named('CorpBaseCurrentStateRecs'					))
		,output(count(corpbasecurrent	(corp_state_origin in pSetPropagateStates and corp_fed_tax_id != ''	and trim(corp_fed_tax_id,left,right) != '-'	)), named('CorpBaseCurrentStateRecsWithFein'	))
		,output(count(patchedILrecs		(corp_state_origin in pSetPropagateStates																																				)), named('CorpBasePatchedStateRecs'					))
		,output(count(patchedILrecs		(corp_state_origin in pSetPropagateStates and corp_fed_tax_id != ''	and trim(corp_fed_tax_id,left,right) != '-'	)), named('CorpBasePatchedStateRecsWithFein'	))
		,output(count(corpbasefather		(corp_state_origin in pSetPropagateStates																																				)), named('CorpBaseFatherStateRecs'						))
		,output(count(corpbasefather		(corp_state_origin in pSetPropagateStates and corp_fed_tax_id != ''	and trim(corp_fed_tax_id,left,right) != '-'	)), named('CorpBaseFatherStateRecsWithFein'		))
		,output(count(All_recs_patched	(corp_state_origin in pSetPropagateStates																																				)), named('CorpBaseNewStateRecs'							))
		,output(count(All_recs_patched	(corp_state_origin in pSetPropagateStates and corp_fed_tax_id != ''	and trim(corp_fed_tax_id,left,right) != '-'	)), named('CorpBaseNewStateRecsWithFein'			))
		,output(count(All_recs_patched																																																									 ), named('CorpBaseNewRecs'										))
		,output(count(corpbasecurrent																																																									 ), named('CorpBaseCurrentRecs'								))

	);

	shared promoteit := sequential(
		 corp2.promote(pNewVersion,'base').new2built
		,corp2.promote(pNewVersion,'base').built2qa2father
	);
	
	return sequential(
		 firstpart
		,promoteit
	);
	
end;
