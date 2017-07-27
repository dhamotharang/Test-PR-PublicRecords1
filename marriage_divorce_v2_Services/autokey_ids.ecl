import marriage_divorce_v2, AutoKeyB2, doxie, AutoKeyI, AutoStandardI, AutoHeaderI;
export autokey_ids  := module
export Input_params := interface(
AutoKeyI.AutoKeyStandardFetchBaseInterface,
AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
end;

export val(Input_params in_mod, 
	boolean workHard		= true,
	boolean noFail			= false,
	boolean noDeepDive	= false) := function
	outrec := layouts.search_ids;
	// Autokey constants
	consts			:= marriage_divorce_v2.constants(marriage_divorce_v2.version);
	ak_dataset	:= consts.ak_dataset;
	ak_keyname	:= consts.ak_keyname;
	ak_typeStr	:= consts.ak_typeStr;
	ak_skipSet	:= consts.ak_skipSet;
	
	// Autokey
	tempmod := module(project(in_mod,autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typestr;
		export set of string1 get_skip_set := ak_skipset;
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	ak_ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;
	AutokeyB2.mac_get_payload(ak_ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
	by_auto := project(outpl, outrec);
	
	// Get DIDs from autokey results
	hasdid	:= outpl(did > 0 and ~AutokeyB2.ISFakeID(did, ak_typeStr));
	newdids	:= join(
		hasdid, ak_ids(isdid),
		left.id = right.id,
		transform(layouts.l_did, self.did := left.did)
	);
	// NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
	//       but that approach requires the use of tmsids & rmsids
	
	// Deep dive those DIDs
	ids				:= marriage_divorce_v2_Services.MDRaw.get_id_from_did(newdids);
	deepDives	:= project(ids, transform(outrec, self.isDeepDive := true, self := left));
	
	// Assemble results
	dups		:= by_auto + if(not noDeepDive, deepDives);
	results	:= dedup(sort(dups, record_id, if(isDeepDive,1,0)), record_id);

	// output(ak_ids, 			named('ak_ids'));				// DEBUG
	// output(outpl, 				named('outpl'));				// DEBUG
	// output(by_auto, 			named('by_auto'));			// DEBUG
	// output(hasdid, 			named('hasdid'));				// DEBUG
	// output(newdids, 			named('newdids'));			// DEBUG
	// output(ids, 					named('ids'));					// DEBUG
	// output(deepDives, 		named('deepDives'));		// DEBUG
	// output(noDeepDive,		named('noDeepDive'));		// DEBUG
	// output(dups,					named('dups'));					// DEBUG
	// output(results,			named('results'));			// DEBUG

	return results;
end; // function
end; //module