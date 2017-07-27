import AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,ut,Foreclosure_Services;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;

	export val(params in_mod, boolean isNodSearch=false) := function
		c				:= Foreclosure_Services.Constants('');
        ak_keyname        := if(isNodSearch,c.ak_nod_keyname,c.ak_keyname);
        ak_dataset        := if(isNodSearch,c.ak_nod_dataset,c.ak_dataset);
        ak_skipSet        := if(isNodSearch,c.ak_nod_skipSet,c.ak_skipSet);
        ak_typeStr        := if(isNodSearch,c.ak_nod_typeStr,c.ak_typeStr);
        str_autokeyname   := if(isNodSearch,c.str_nod_autokeyname,c.str_autokeyname);
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := str_autokeyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

		AutokeyB2.mac_get_payload(ids, str_autokeyname, ak_dataset, outpl, did, bdid, ak_typeStr)
		by_auto := dedup(sort(project(outpl,
	      	transform (Foreclosure_Services.Layouts.FIDNumberPlus, 
								 self.did := (unsigned6) left.did, 
								 self.fid := left.foreclosure_id,
								 self.bdid := (unsigned6) left.bdid;
								 self := [] )),record),record);

		hasdid	:= outpl((unsigned6) did > 0 and ~AutokeyB2.ISFakeID((unsigned6) did, ak_typeStr));
		newdids	:= join(
			hasdid, ids(isdid),
			left.id = right.id,
			transform(doxie.layout_references, 
									self.did := (unsigned6) left.did),
									limit(ut.limits.Foreclosure_PER_DID,skip));
	
		hasbdid	:= outpl((unsigned6) bdid > 0 and ~AutokeyB2.ISFakeID((unsigned6) bdid, ak_typeStr));										
		newbdids	:= join(
					hasbdid, ids(isbdid),
					left.id = right.id,
					transform(doxie_cbrs.layout_references, 
							self.bdid := (unsigned6) left.bdid),
							limit(ut.limits.Foreclosure_PER_BDID,skip));


		temp_Foreclosure_ids := Foreclosure_Services.Raw.byDIDs(newdids,isNodSearch) + Foreclosure_Services.Raw.byBDIDs(newbdids,isNodSearch);		
		
		Foreclosure_ids := project(temp_Foreclosure_ids, 
					transform(Foreclosure_Services.Layouts.FIDNumberPlus,
										self.isDeepDive := true, 
										self:=left));
	
		dups := by_auto + if (in_mod.isDeepDive , Foreclosure_ids);
		// results	:= dedup(sort(dups, fid, if(isDeepDive,1,0)), fid);
		results	:= dedup(sort(dups, record, if(isDeepDive,1,0)), record);
		
	//for debugging purpose
	// output(ids,,named('AutokeyIDS_ids'));
	// output(outpl,,named('AutokeyIDS_outpl'));
	// output(by_auto,,named('AutokeyIDS_by_auto'));
	// output(newdids,,named('AutokeyIDS_newdids'));
	// output(results,,named('AutokeyIDS_results'));
	
		return results;
	end;

end;