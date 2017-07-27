import ut;

eve := uccd.WithExpEvent;
par := uccd.WithExpParty;
col := uccd.WithExpCollateral;
smm := uccd.WithExpFilingSummary;

//make sure the states are ok
extradirect := eve(isDirect and file_state not in uccd.set_DirectStates);

allstates := uccd.DS_AllStates;
typeof(allstates) keepst(allstates r) := transform
	self := r;
end;

missingstates := join(dedup(table(eve, {file_state}), all), allstates, left.file_State = right.st, keepst(right), right only);

//
//'~thor_data400::base::ucc_summary_wexp'
//'~thor_data400::base::ucc_master_wexp'
//'~thor_data400::base::ucc_collateral_wexp'
ut.MAC_SF_BuildProcess(eve, '~thor_data400::base::ucc_event_wexp', outeve, 2)
ut.MAC_SF_BuildProcess(par, '~thor_data400::base::ucc_party_wexp', outpar, 2)
ut.MAC_SF_BuildProcess(col, '~thor_data400::base::ucc_collateral_wexp', outcol, 2)
ut.MAC_SF_BuildProcess(smm, '~thor_data400::base::ucc_summary_wexp', outsmm, 2)

buildfiles := parallel(outeve, outpar, outcol, outsmm);

//report counts

uccd.mac_CountByState(eve, evecount, 'EventStateCount')
uccd.mac_CountByState(par, parcount, 'PartyStateCount')
uccd.mac_CountByState(col, colcount, 'CollateralStateCount')
uccd.mac_CountByState(smm, smmcount, 'SummaryStateCount')

statecounts := parallel(evecount,parcount,colcount,smmcount);

checks := parallel(
		if(exists(extradirect), output(dedup(table(extradirect, {file_state}), all), named('add_to_set_DirectStates_rerun')),
														output('set_DirectStates in good shape.')),
		output(missingstates, named('states_with_no_data'))
		);

export Proc_AddExp := sequential(
	checks,
	parallel(buildfiles, statecounts)
		);