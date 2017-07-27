/*2011-04-04T15:17:00Z (Cristopher Albee)
Post review changes; re-review needed.
*/
import doxie,doxie_cbrs,doxie_raw;

export PAWSearchService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export unsigned6 contactID := 0;
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
	end;
	export val(params in_mod) := function
		// autokeys
		by_auto	:= AutoKey_IDs.val(in_mod);

		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),doxie.layout_references);
		by_deep_dids := if(not in_mod.noDeepDive,PAW_Raw.getContactIDs.byDIDs(deep_dids));
		contact_ids_by_deep_dids := project(by_deep_dids,transform(Layouts.search,self.isDeepDive := true,self := left));
		
		// deep BDIDs
		deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),doxie_cbrs.layout_references);
		by_deep_bdids := if(not in_mod.noDeepDive,PAW_Raw.getContactIDs.byBDIDs(deep_bdids));		
		contact_ids_by_deep_bdids := project(by_deep_bdids,transform(Layouts.search,self.isDeepDive := true,self := left));

		by_fetch := MAP(
			COUNT(by_auto + contact_ids_by_deep_dids + contact_ids_by_deep_bdids) <= Constants.CONTACTID_LIMIT 
			    => by_auto + contact_ids_by_deep_dids + contact_ids_by_deep_bdids,
			COUNT(by_auto + contact_ids_by_deep_dids) <= Constants.CONTACTID_LIMIT
					=> by_auto + contact_ids_by_deep_dids,
			COUNT(by_auto) > 0
					=> by_auto,
			/* DEFAULT: */ DATASET([],Layouts.search)
		);
			
		// lookup by contact id
		contact_ids := dataset([{in_mod.contactID,false}],Layouts.search);
		by_contact_id := if(in_mod.contactID > 0,PAW_Raw.getContactIDs.byContactIDs(contact_ids));

		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0,PAW_Raw.getContactIDs.byDIDs(dids));

		// lookup by BDID
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := if((unsigned)in_mod.BDID > 0,PAW_Raw.getContactIDs.byBDIDs(bdids));
 
		
		// combine...
		ids := map(
			in_mod.contactID <> 0      => by_contact_id,
			(unsigned)in_mod.DID <> 0  => by_did,
			(unsigned)in_mod.BDID <> 0 => by_bdid,
			/*default................. */ by_fetch
			);

		// ...and shifting deep-dive-only to the end
		ids_d := dedup(sort(ids, contact_id, isDeepDive), contact_id);
		// output(by_auto, named('by_auto'));
		// output(contact_ids, named('contact_ids'));
		// output(by_deep_bdids, named('by_deep_bdids'));
		// output(deep_dids, named('deep_dids'));
		// output(deep_bdids, named('deep_bdids'));
		
		// output(ids_d, named('ids_d'));
		
		IF( (COUNT(by_auto) = 0 AND COUNT(contact_ids_by_deep_dids) > Constants.CONTACTID_LIMIT),
			FAIL(11,'Subject of search not found; number of possible associations is excessive.')
		);

		IF( (COUNT(by_auto) > Constants.CONTACTID_LIMIT),
			FAIL(11,doxie.ErrorCodes(11))
		);
		
		return ids_d;
	end;
end;


/*
ERROR(11,doxie.ErrorCodes(11))
*/