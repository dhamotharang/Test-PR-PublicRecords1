import Criminal_Records, autokeyb2, doxie, autokeyi, AutoStandardI;

export autokey_ids := module
	
	export val(CriminalRecords_Services.IParam.ak_params in_mod) := function
		// constants
		c := Criminal_Records.constants('');
		ak_QAname		:= c.ak_QAname;
		ak_typeStr	:= c.ak_typeStr;
		ak_skipSet	:= c.skip_set;
		ak_dataset	:= c.ak_dataset;
    
		// ****** SEARCH THE AUTOKEYS
		tempmod := module(project(in_mod,autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
			export string					autokey_keyname_root	:= ^.ak_QAname;
			export string					typestr								:= ^.ak_typeStr;
			export set of string1	get_skip_set					:= ^.ak_skipSet;
			export boolean				useAllLookups					:= true;
		end;
		ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;
		AutokeyB2.mac_get_payload(ids, ak_QAname, ak_dataset, outpl, did, zero, ak_typeStr);
		by_auto := dedup(sort(project(outpl,layouts.l_search),record),record);	
		
		// Get DIDs from autokey results
		hasdids	:= project(outpl(did > 0 and ~AutokeyB2.ISFakeID(did, ak_typeStr)),doxie.layout_references);
		
		// Deep dive those DIDs
		offender_keys := if( in_mod.isDeepDive, CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(hasdids) );
		
		// Assemble results
		dups		:= by_auto + offender_keys;
		results	:= dedup(sort(dups, offender_key, if(isDeepDive,1,0)), offender_key);
		// output(ids,named('autokey_ids'));
		// output(by_auto,named('autokey_by_auto'));
		// output(offender_keys,named('autokey_by_offender_keys'));
		// output(results,named('autokey_results'));
		return results;
	end;	
	
end;