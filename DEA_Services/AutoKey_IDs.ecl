import AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,ut,DEA,DEA_Services;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	export val(params in_mod) := function
		c				:= DEA.Constants('');  // TODO: may not need year here
		ak_keyname		:= c.ak_keyname;
		//ak_logical		:= c.ak_logical;
		ak_dataset		:= dataset([],DEA_Services.Layouts.layout_Index);//dea.File_DEA;//c.ak_dataset;
		ak_skipSet		:= c.skip_Set;
		ak_typeStr		:= c.ak_typeStr;
		str_autokeyname	:= c.ak_QAname;
		
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := str_autokeyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
		// hitting company keys and person keys.
		
			
		AutokeyB2.mac_get_payload(ids, str_autokeyname, ak_dataset, outpl, (unsigned6) did, (unsigned6) bdid, ak_typeStr)
		by_auto := dedup(sort(project(outpl,
	      	transform (DEA_Services.Layouts.DEANumberPlus, 
								 self.did := (unsigned6) left.did, 
								 self.dea_registration_number := left.dea_registration_number,
								 self.bdid := (unsigned6) left.bdid;
								 self := [] )),record),record);

		//Get DIDs from autokey results
		// hasdids is payload record....
	
		hasdid	:= outpl((unsigned6) did > 0 and ~AutokeyB2.ISFakeID((unsigned6) did, ak_typeStr));
		newdids	:= join(
			hasdid, ids(isdid),
			left.id = right.id,
			transform(doxie.layout_references, 
									self.did := (unsigned6) left.did),
									limit(ut.limits.DEA_PER_DID,skip));
	
		hasbdid	:= outpl((unsigned6) bdid > 0 and ~AutokeyB2.ISFakeID((unsigned6) bdid, ak_typeStr));										
		newbdids	:= join(
					hasbdid, ids(isbdid),
					left.id = right.id,
					transform(doxie_cbrs.layout_references, 
							self.bdid := (unsigned6) left.bdid),
							limit(ut.limits.DEA_PER_BDID,skip));


		// Deep dive those DIDs 
		temp_DEA_ids := DEA_Services.Raw.byDIDs(newdids) + DEA_Services.Raw.byBDIDs(newbdids);		
		
    // project here into layout search setting deep dive to true
		DEA_ids := project(temp_DEA_ids, 
					transform(DEA_Services.Layouts.DEANumberPlus,
										self.isDeepDive := true, 
										self:=left));
	
		dups := by_auto + if (in_mod.isDeepDive , DEA_ids);
		results	:= dedup(sort(dups, dea_registration_number, if(isDeepDive,1,0)), dea_registration_number);
		
	//for debugging purpose
	// output(ids,,named('AutokeyIDS_ids'));
	// output(outpl,,named('AutokeyIDS_outpl'));
	// output(by_auto,,named('AutokeyIDS_by_auto'));
	// output(newdids,,named('AutokeyIDS_newdids'));
	// output(results,,named('AutokeyIDS_results'));
	
		return results;
	end;
end;