import AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,ut,dnb,dnb_Services;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	export val(params in_mod) := function
		c				:= dnb.dnb_autokey_constants('');  // TODO: may not need year here
		ak_keyname		:= c.ak_keyname;
		//ak_logical		:= c.ak_logical;
		ak_dataset		:= c.ak_dataset; 
		ak_skipSet		:= c.ak_skipSet;
		ak_typeStr		:= c.ak_typeStr;
		str_autokeyname	:= c.str_autokeyname;
    
  mod_access := project(in_mod, Doxie.IDataAccess, opt);
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := str_autokeyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
  ids_suppressed := IF(mod_access.use_DNB(), ids);
		// hitting company keys and person keys.
		
			
		AutokeyB2.mac_get_payload(ids_suppressed, str_autokeyname, ak_dataset, outpl, 0, bdid, ak_typeStr)
  outpl_suppressed := IF(mod_access.use_DNB(), outpl);
		by_auto := dedup(sort(project(outpl_suppressed,
	      	transform (dnb_Services.Layouts.dnbNumberPlus, 
								 self.duns_number := left.duns_number,
								 self.bdid :=left.bdid;
								 self := [] )),record),record);

	
		hasbdid	:= outpl_suppressed((unsigned6) bdid > 0 and ~AutokeyB2.ISFakeID((unsigned6) bdid, ak_typeStr));										
		newbdids	:= join(
					hasbdid, ids_suppressed(isbdid),
					left.id = right.id,
					transform(doxie_cbrs.layout_references, 
							self.bdid := left.bdid),
							limit(dnb_services.constants.MAX_RECS_ON_JOIN,skip));


		temp_dnb_ids := dnb_Services.Raw.byBDIDs(newbdids, mod_access);		
		
    // project here into layout search setting deep dive to true
		dnbID_ids := project(temp_dnb_ids, 
					transform(dnb_Services.Layouts.dnbNumberPlus,
										self.isDeepDive := true, 
										self:=left));
	
		temp_newbdids := project(newbdids, transform(dnb_Services.Layouts.dnbNumberPlus,
							self.bdid := left.bdid,
							self.duns_number := '',
							// self.dnb_id := 0,
							// self.did := 0,
							self := []));
					

		dups		:= by_auto
				 // + temp_newdids // just results using the did search
				 + temp_newbdids // just results using the bdid search
				 + if (in_mod.isDeepDive , dnbID_ids);
		
		results	:= dedup(sort(dups, duns_number, bdid, if(isDeepDive,1,0)), duns_number, bdid);
		
	//for debugging purpose
	// output(ids,,named('AutokeyIDS_ids'));
	// output(outpl,,named('AutokeyIDS_outpl'));
	// output(by_auto,,named('AutokeyIDS_by_auto'));
	// output(results,,named('AutokeyIDS_results'));
	
		return results;
	end;
end;