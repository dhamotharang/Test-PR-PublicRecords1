import AutoStandardI,doxie,doxie_cbrs,drivers,PAW,paw_services,ut,suppress;

export PAW_Raw := module
       global_mod := AutoStandardI.GlobalModule();
shared mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

	export getContactIDs := module
		export byDIDs(dataset(doxie.layout_references) in_dids) := function
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,PAW.Key_Did,
										keyed(left.did=right.did),
										transform(paw_services.Layouts.search,
															self := right),
										atmost(20000));  // < 20K contacts per did in index
			return joinup;
		end;
		export byBDIDs(dataset(doxie_cbrs.layout_references) in_bdids) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			joinup := join(deduped,PAW.Key_Bdid,
										keyed(left.bdid=right.bdid),
										transform(paw_services.Layouts.search,
															self := right),
										keep(20000), limit(0));
			return joinup;
		end;
		export byContactIDs(dataset(paw_services.Layouts.search) in_contact_ids) := function
    doxie_layout_references_plus := record(doxie.layout_references)
                                        unsigned4 global_sid;
                                        unsigned8 record_sid;  
                                    end;
    
			deduped := dedup(sort(in_contact_ids,contact_id),contact_id);
			joinup_pre := join(deduped,PAW.Key_contactID,
										keyed(left.contact_id=right.contact_id),
										transform(doxie_layout_references_plus,
															self := right),
										atmost(ut.limits.PAW_PER_CONTACTID)); // upto 25 recs per contactId in index
			joinup := project(suppress.MAC_SuppressSource(joinup_pre,mod_access),doxie.layout_references);							 
			fromdids := byDIDs(joinup);
			deduped2 := dedup(sort(in_contact_ids + fromdids,contact_id),contact_id);
			return deduped2;
		end;
	end;
	
	export getPAWcount (unsigned6 udid, unsigned in_glb, unsigned in_dppa, unsigned max_count=255) := function
		max_keep := if(max_count > 0, max_count, ut.limits.PAW_PER_CONTACTID);  // currently upto 25 records per contactid in paw.Key_contactID
		all_contacts := paw.Key_Did(did=udid);
		contact_ids :=  if(max_count > 0,choosen(all_contacts,max_count), all_contacts);
		paw_contacts_pre:= join(contact_ids, paw.Key_contactID,
																	keyed(left.contact_id=right.contact_id) and
																	(ut.glb_ok((unsigned1) in_glb) OR right.glb='N') and 
																	(right.DPPA_state='' OR drivers.state_dppa_ok(right.DPPA_state,(unsigned1)in_dppa,right.source)),
																	keep(max_keep), limit(0)
																	);
    paw_contacts := suppress.MAC_SuppressSource(paw_contacts_pre,mod_access);                              
		paw_count:= count(if(max_count > 0,choosen(paw_contacts, max_count),paw_contacts));
		return paw_count;
	end;
end;
