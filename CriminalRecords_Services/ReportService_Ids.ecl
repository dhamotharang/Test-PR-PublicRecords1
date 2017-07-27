import AutoStandardI, doxie, FCRA;

export ReportService_ids := module

	export val(CriminalRecords_Services.IParam.report in_mod, 
						 boolean IsFCRA = false,
						 dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := function
	
		// lookup  by offender key
		offender_key_ids := dataset([{in_mod.offender_key,false}],layouts.l_search);
		offender_key:=if(in_mod.IncludeAllCriminalRecords,
						CriminalRecords_Services.Raw.getOffenderKeys.byoffenderID(offender_key_ids),
						offender_key_ids);
						
		// lookup by docnum
		docnum := dataset([{in_mod.doc_number}],layouts.docnum_rec);
		by_docnum := CriminalRecords_Services.Raw.getOffenderKeys.byDocNums(docnum);
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0,CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(dids, IsFCRA, flagfile));
		
		// decide which key to use
		ids := map(in_mod.offender_key <> '' => offender_key,
							 in_mod.doc_number <> '' => by_docnum,
							 in_mod.DID <> '' => by_did,
							 dataset([], layouts.l_search));
		ids_d	:= dedup(sort(ids, offender_key, isDeepDive), offender_key);
		
		final_ids := if(isFCRA, by_did, ids_d); // the only way to get data on FCRA-side is by DID
		
		return final_ids;
	
	end;

end;