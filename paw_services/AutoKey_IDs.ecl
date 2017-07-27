import AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,PAW,ut;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export nodeepdive := false;
	end;
	export val(params in_mod) := function
		ak_keyname := PAW.Constant('').ak_QAname;
		ak_typestr := PAW.Constant('').ak_typeStr;
		ak_dataset := PAW.file_SearchAutokey(PAW.File_Base);

    // custom autokey-search behavior: person-search just by address or by phone may bring a lot of matches,
    // we can prevent query from failure when there's enough company info in the input.
    boolean skip_person_search := (in_mod.companyname != '' or in_mod.fein != '') and 
                                  (in_mod.lastname = '') and (in_mod.firstname = '') and (in_mod.ssn = '');
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := ak_keyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := if (skip_person_search, ['C'], []);
			export boolean useAllLookups := true;
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
		
		AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, bdid, ak_typeStr)
		by_auto := dedup(sort(project(outpl,Layouts.search),record),record);
		
		// Get DIDs from autokey results
		hasdid	:= outpl(did > 0 and ~AutokeyB2.ISFakeID(did, ak_typeStr));
		newdids	:= join(
			hasdid, ids(isdid),
			left.id = right.id,
			transform(doxie.layout_references, self.did := left.did)
		);
		
		// Get BDIDs from autokey results
		hasbdid	:= outpl(bdid > 0 and ~AutokeyB2.ISFakeID(bdid, ak_typeStr));
		newbdids	:= join(
			hasbdid, ids(isbdid),
			left.id = right.id,
			transform(doxie_cbrs.layout_references, self.bdid := left.bdid)
		);
		
		// NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
		//       but that approach requires the use of tmsids & rmsids
		
		// Deep dive those DIDs and BDIDs
		contact_ids := PAW_Raw.getContactIDs.byDIDs(newdids) + 
			if(~in_mod.noDeepDive,project(PAW_Raw.getContactIDs.byBDIDs(newbdids),transform(Layouts.search,self.isDeepDive:=TRUE,self:=left))
			);
		
		// Assemble results
		dups		:= by_auto + contact_ids;
		results	:= dedup(sort(dups, contact_id,if(isDeepDive,1,0)), contact_id);

		return results;
	end;
end;
