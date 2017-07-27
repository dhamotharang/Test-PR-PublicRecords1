
import  AutoKeyB2, doxie, AutoKeyI, AutoStandardI,DriversVTSA;

export dataset(layouts.search_ids) autokey_ids(
	boolean workHard		= true,
	boolean noFail			= false
) := function

	ak_dataset	:= DriversVTSA.File_DL_base_for_Autokeys;
	consts			:= DriversVTSA.Constants;
	ak_keyname	:= consts.autokey_qa_Keyname;
	ak_typeStr	:= consts.autokey_typeStr;
	ak_skipSet	:= consts.autokey_skipSet;
	outrec			:= layouts.search_ids;

	
	tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
		export string autokey_keyname_root := ak_keyname;
		export string typestr := ak_typeStr;
		export set of string1 get_skip_set := ak_skipSet;
		export boolean workHard := ^.workHard;
		export boolean noFail := ^.noFail;
		export boolean useAllLookups := true;
	end;
	
					 
	in_mod := AutoStandardI.GlobalModule();
	boolean addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_loose.params));
	ak_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
	ids := ak_ids;
	
	// Autokey
	AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr)
	by_auto := project(outpl, outrec);
	
	// NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
	//       but that approach requires the use of tmsids & rmsids
	
	
	// Assemble results
	dups		:= by_auto;// + if(not noDeepDive, deepDives);
	results	:= dedup(sort(by_auto, dl_seq), dl_seq);

	return results;
	
end;