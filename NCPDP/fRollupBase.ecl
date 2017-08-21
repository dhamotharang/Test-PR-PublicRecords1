import ut;

export fRollupBase	:= MODULE

	export roll_by_id (pDataset, pLayout, pIDfield)	:= functionmacro
		dDistributed		:=	distribute(pDataset,hash(pIDfield));

		dDataset_sort := sort(dDistributed ,except dt_first_seen                
																					,dt_last_seen 
																					,record_type
																					,local
													);	
   
   pLayout RollupUpdate(pLayout l, pLayout r) := transform
      self.dt_first_seen                  := ut.EarliestDate(
                                                             ut.EarliestDate(l.dt_first_seen,	r.dt_first_seen)
                                                            ,ut.EarliestDate(l.dt_last_seen,	r.dt_last_seen)
																														);
      self.dt_last_seen                   := MAX(l.dt_last_seen,r.dt_last_seen);
      self 																:= if(l.record_type = 'C', l, r);
   end;
	 
   dDataset_rollup := rollup( dDataset_sort
                              ,RollupUpdate(left, right)
                              ,except 
                               dt_first_seen                
                               ,dt_last_seen
															 ,record_type
                               ,local
                              );
															
   return dDataset_rollup;

	endmacro;
	
	export roll_by_id2(pDataset, pLayout, pIDfield1, pIDfield2) := functionmacro
		dDistributed := distribute(pDataset, hash(pIDfield1, pIDfield2));

		dDataset_sort := sort(dDistributed,
		                      pIDfield1, pIDfield2, record,
													   except dt_first_seen, dt_last_seen, record_type,
													local);

    pLayout RollupUpdate(pLayout L, pLayout R) := transform
      self.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
                                            ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
      self.dt_last_seen  := MAX(L.dt_last_seen, R.dt_last_seen);
      self 							 := if(L.record_type = 'C', L, R);
    end;
	 
    dDataset_rollup := rollup(dDataset_sort,
                              RollupUpdate(left, right),
                              pIDfield1, pIDfield2, record,
															   except dt_first_seen, dt_last_seen, record_type,
                              local);

    return dDataset_rollup;
	endmacro;

	export roll_by_id4(pDataset, pLayout, pIDfield1, pIDfield2, pIDfield3, pIDfield4) := functionmacro
		dDistributed := distribute(pDataset, hash(pIDfield1, pIDfield2, pIDfield3, pIDfield4));

		dDataset_sort := sort(dDistributed,
		                      pIDfield1, pIDfield2, pIDfield3, pIDfield4, record,
													   except dt_first_seen, dt_last_seen, record_type,
													local);

    pLayout RollupUpdate(pLayout L, pLayout R) := transform
      self.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
                                            ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
      self.dt_last_seen  := MAX(L.dt_last_seen, R.dt_last_seen);
      self 							 := if(L.record_type = 'C', L, R);
    end;
	 
    dDataset_rollup := rollup(dDataset_sort,
                              RollupUpdate(left, right),
                              pIDfield1, pIDfield2, pIDfield3, pIDfield4, record,
															   except dt_first_seen, dt_last_seen, record_type,
                              local);

    return dDataset_rollup;
	endmacro;

	export prov_info(dataset(NCPDP.Layouts.Base.prov_information) pDataset) := function

		dCleaned_file	:= roll_by_id(pDataset, NCPDP.Layouts.Base.prov_information, NCPDP_provider_id);
		
		return dCleaned_file;
	end;
	
	export prov_relat(dataset(NCPDP.Layouts.Base.prov_relationship) pDataset) := function

		dCleaned_file	:= roll_by_id4(pDataset, NCPDP.Layouts.Base.prov_relationship, NCPDP_provider_id,
		                                relationship_id, payment_center_id, remit_and_reconciliation_id);
		
		return dCleaned_file;
	end;
	
	export medicaid(dataset(NCPDP.Layouts.Base.medicaid_information) pDataset) := function

		dCleaned_file	:= roll_by_id2(pDataset, NCPDP.Layouts.Base.medicaid_information, NCPDP_provider_id, medicaid_id);
		
		return dCleaned_file;
	end;
	
	export taxonomy(dataset(NCPDP.Layouts.Base.taxonomy_information) pDataset) := function

		dCleaned_file	:= roll_by_id2(pDataset, NCPDP.Layouts.Base.taxonomy_information, NCPDP_provider_id, taxonomy_code);
		
		return dCleaned_file;
	end;
	
	export demographic(dataset(NCPDP.Layouts.Base.relationship_demographic) pDataset) := function

		dCleaned_file	:= roll_by_id(pDataset, NCPDP.Layouts.Base.relationship_demographic, relationship_id);
		
		return dCleaned_file;
	end;
	
	export pay_center(dataset(NCPDP.Layouts.Base.payment_center_information) pDataset) := function

		dCleaned_file	:= roll_by_id(pDataset, NCPDP.Layouts.Base.payment_center_information, id);
		
		return dCleaned_file;
	end;
	
	export parent_org(dataset(NCPDP.Layouts.Base.parent_organization_information) pDataset) := function

		dCleaned_file	:= roll_by_id(pDataset, NCPDP.Layouts.Base.parent_organization_information, id);
		
		return dCleaned_file;
	end;
	
	export eprescribe(dataset(NCPDP.Layouts.Base.eprescribe_information) pDataset) := function

		dCleaned_file	:= roll_by_id2(pDataset, NCPDP.Layouts.Base.eprescribe_information, NCPDP_provider_id, network_id);
		
		return dCleaned_file;
	end;
	
	export remit(dataset(NCPDP.Layouts.Base.remit_information) pDataset) := function

		dCleaned_file	:= roll_by_id(pDataset, NCPDP.Layouts.Base.remit_information, id);
		
		return dCleaned_file;
	end;

	export state_lic(dataset(NCPDP.Layouts.Base.state_license_information) pDataset) := function

		dCleaned_file	:= roll_by_id2(pDataset, NCPDP.Layouts.Base.state_license_information, NCPDP_provider_id, license_number);
		
		return dCleaned_file;
	end;
	
	export services(dataset(NCPDP.Layouts.Base.services_information) pDataset) := function

		dCleaned_file	:= roll_by_id(pDataset, NCPDP.Layouts.Base.services_information, NCPDP_provider_id);
		
		return dCleaned_file;
	end;
	
	// old_NCPDP_provider_id is not part of the key.  We can simply use the roll_by_id.
	export change_owner(dataset(NCPDP.Layouts.Base.change_ownership_information) pDataset) := function

		dCleaned_file	:= roll_by_id(pDataset, NCPDP.Layouts.Base.change_ownership_information, NCPDP_provider_id);
		
		return dCleaned_file;
	end;

end;