import AutoStandardI, doxie, FCRA;

export SearchService_ids := module

	export val(CriminalRecords_Services.IParam.search in_mod,
						 boolean isFCRA = false,
						 dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := function
		
		ak_mod := module(project(in_mod,CriminalRecords_Services.IParam.ak_params,opt))	end;
		by_auto	:= CriminalRecords_Services.AutoKey_IDs.val(ak_mod);
		
		//lookup by deep dids
		deep_dids := limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip);
		by_deep_dids := if(
			not in_mod.noDeepDive,
			project(
				CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(deep_dids),
				transform(CriminalRecords_Services.layouts.l_search,self.isdeepdive:=true,self:=left)
			)
		);
		
		// lookup  by offender key
		offender_key := dataset([{in_mod.offender_key,false}],CriminalRecords_Services.layouts.l_search);
		
		// lookup by docnum
		docnum := dataset([{in_mod.doc_number}],CriminalRecords_Services.layouts.docnum_rec);
		by_docnum := CriminalRecords_Services.Raw.getOffenderKeys.byDocNums(docnum);
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0, CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(dids, isFCRA, flagfile));
		
		// lookup by CaseNumber
		casenum := dataset([{in_mod.case_number}], CriminalRecords_Services.layouts.casenum_rec);
		by_casenum := CriminalRecords_Services.Raw.getOffenderKeys.byCaseNum(casenum);
		
		// decide which type of lookup to use
		ids := map(in_mod.offender_key <> '' => offender_key,
							 in_mod.doc_number <> '' => by_docnum,
							 in_mod.DID <> '' => by_did,
							 in_mod.case_number <> '' => by_casenum,
							 by_auto + by_deep_dids);
		ids_d	:= dedup(sort(ids, offender_key, isDeepDive), offender_key);
		
		final_ids := if(isFCRA, by_did, ids_d);

		return final_ids;
		
	end;

end;