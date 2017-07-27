import LN_PropertyV2, AutoKeyB2, doxie, AutoKeyI, AutoStandardI;

l_sid := layouts.search_fid;
it 							:= AutoStandardI.InterfaceTranslator;


export autokey_ids(
	boolean workHard		= true,
	boolean noFail			= false,
	boolean noDeepDive	= false,
	input.params in_mod = module(project(AutoStandardI.GlobalModule(),input.params,opt))end) := function

	consts			:= LN_PropertyV2.Constants;
	ak_dataset	:= consts.ak_dataset;
	ak_keyname	:= consts.ak_keyname;
	ak_typeStr	:= consts.ak_typeStr;
	ak_skipSet	:= consts.ak_skipSet;
	l_did				:= layouts.search_did;
	
	tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := ak_skipset;
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

	// Autokey
	AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
	by_auto := Raw.cleanSids( project(outpl, l_sid) );
	
	// NOTE: One important aspect of the Raw.cleanSids call above is that it enforces LookupType
	//       filtering.  This is often done during the fetch for efficiency, but is also necessary
	//       here because the fetch can't enforce PartyType and LookupType at the same time.
	
	// Get DIDs from autokey results
	hasdid	:= outpl(did > 0 and ~AutokeyB2.ISFakeID(did, ak_typeStr));
	newdids	:= join(
		hasdid, ids(isdid),
		left.id = right.id,
		transform(l_did, self.did := left.did)
	);
	// NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
	//       but that approach requires the use of tmsids & rmsids
	
	// Deep dive those DIDs
	fids			:= Raw.get_fids_from_dids(newdids);
	deepDives	:= Raw.get_sids_from_fids(fids,true);
	
	// Assemble results
	dups		:= by_auto + if(not noDeepDive, deepDives);
	results	:= dedup(sort(dups, ln_fares_id, if(isDeepDive,1,0)), ln_fares_id);

	// output(ids, 					named('ids'));					// DEBUG
	// output(outpl, 				named('outpl'));				// DEBUG
	// output(olddids, 			named('olddids'));			// DEBUG
	// output(newdids, 			named('newdids'));			// DEBUG
	// output(by_auto, 			named('ak_by_auto'));		// DEBUG
	// output(deepDives, 		named('deepDives'));		// DEBUG
	// output(noDeepDive,		named('noDeepDive'));		// DEBUG
	// output(dups,					named('dups'));					// DEBUG
	// output(results,			named('results'));			// DEBUG

	return results;
end;