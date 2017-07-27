
import Drivers, DriversV2, AutoKeyB2, doxie, AutoKeyI, AutoStandardI,Autokey,ut;

export dataset(layouts.search_ids) autokey_ids(
	boolean workHard		= true,
	boolean noFail			= false,
	boolean noDeepDive	= false,
	boolean useUberFetch = false
) := function

	ak_dataset	:= DriversV2.File_DL_base_for_Autokeys;
	consts			:= DriversV2.Constants;
	ak_keyname	:= consts.autokey_qa_Keyname;
	ak_typeStr	:= consts.autokey_typeStr;
	ak_skipSet	:= consts.autokey_skipSet;
	outrec			:= layouts.search_ids;
	word_inp := DLraw.uber_view.get_words();

	
	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typeStr;
		export set of string1 get_skip_set := ak_skipSet;
		export boolean workHard := ^.workHard;
		export boolean noFail := if(useUberFetch,true,^.noFail);
		export boolean useAllLookups := true;
	end;
	
	
	uber_mod := module(AutoKeyI.FetchI_Indv_Uber.new.params.full)
		export string autokey_keyname_root := ak_keyname;
		export boolean noFail := ^.noFail;
		export dataset(Autokey.Layout_Uber.word_params) word_inp := ^.word_inp;
	end;
	uk_ids := PROJECT(AutoKeyI.FetchI_Indv_Uber.new.do(uber_mod)
	,TRANSFORM({unsigned6 ID, boolean isDID, boolean isBDID, boolean IsFake}
	           ,SELF.id := LEFT.did
						 ,SELF.IsFake := TRUE
						 ,SELF := []));
	in_mod := AutoStandardI.GlobalModule();
	boolean addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_loose.params));
	ak_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
  ids := IF(~exists(ak_ids) and UseUberFetch and ~ addr_loose,uk_ids,ak_ids);
	
	// Autokey
	AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
	by_auto := project(outpl, outrec);
	
	// Get DIDs from autokey results
	hasdid	:= outpl(did > 0 and ~AutokeyB2.ISFakeID(did, ak_typeStr));
	newdids	:= join(
		hasdid, ids(isdid),
		left.id = right.id,
		transform(doxie.Layout_references, self.did := left.did)
	);
	// NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
	//       but that approach requires the use of tmsids & rmsids
	
	// Deep dive those DIDs
	seqs			:= DriversV2_Services.DLRaw.get_seq_from_dids(newdids);
	deepDives	:= project(seqs, transform(outrec, self.isDeepDive := true, self := left));
	
	// Assemble results
	dups		:= by_auto + if(not noDeepDive, deepDives);
	results	:= dedup(sort(dups, dl_seq, if(isDeepDive,1,0)), dl_seq);

	// output(ids, 					named('ids'));					// DEBUG
	// output(outpl, 				named('outpl'));				// DEBUG
	// output(olddids, 			named('olddids'));			// DEBUG
	// output(newdids, 			named('newdids'));			// DEBUG
	// output(by_auto, 			named('ak_by_auto'));		// DEBUG
	// output(deepDives, 		named('deepDives'));		// DEBUG
	// output(noDeepDive,		named('noDeepDive'));		// DEBUG
	// output(dups,					named('dups'));					// DEBUG
	// output(results,			named('results'));			// DEBUG
	// OUTPUT(word_inp,NAMED('word_inp'));
	// OUTPUT(COUNT(ak_ids),NAMED('ak_ids'));
	// OUTPUT(COUNT(uk_ids),NAMED('uk_ids'));
	return results;
	
end;