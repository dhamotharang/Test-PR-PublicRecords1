import AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,faa,faaV2_Services;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	export val(params in_mod) := function
		c						:= faa.faa_autokey_constants(''); 
		ak_keyname	:= c.ak_keyname;
		//ak_logical	:= c.ak_logical;
		ak_dataset	:= c.ak_dataset; 
		ak_skipSet	:= c.ak_skipSet;
		ak_typeStr	:= c.ak_typeStr;
		str_autokeyname := c.str_autokeyname;
		
		tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := str_autokeyname;
			export string typestr := ak_typeStr;
			export set of string1 get_skip_set := ak_skipSet;
			export boolean useAllLookups := true;
		end;
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
		// hitting company keys and person keys.
		
		AutokeyB2.mac_get_payload(ids, str_autokeyname, ak_dataset, outpl, did_out, bdid_out, ak_typeStr)
		
		//output(ids,named('autokey_ids'));
    // use by_auto with 0 did and 0 bdid.
		by_auto := dedup(sort(project(outpl,
	      	transform (FaaV2_Services.Layouts.aircraftNumberPlus, 
		             self.did := (unsigned6) left.did_out, 
								 self.bdid := (unsigned6) left.bdid_out, 
								 self.n_number := left.n_number,
								 self := left,
                 self := [] )),record),record);
		
		//Get DIDs from autokey results
		// hasdids is payload record....
		hasdid	:= outpl(did_out > 0 and ~AutokeyB2.ISFakeID(did_out, ak_typeStr));
		newdids	:= join(
			hasdid, ids(isdid),
			left.id = right.id,
			transform(doxie.layout_references,
																  self.did := (unsigned6) left.did_out),
			                               limit(faav2_services.Constants.MAX_RECS_ON_JOIN,skip));
		
		// we want newdids to have did and n_number
		
		 // as well as outpl which will be a new layout. (ak_dataset)
		 // will have dids we want to look up.
		    // transform(doxie.layout_references, ak_dataset
				 
			// new dids will now be payload recs that a real did on them and came from did side
			// of autokeys.
		
		// Get BDIDs from autokey results
		hasbdid	:= outpl(bdid_out > 0 and ~AutokeyB2.ISFakeID(bdid_out, ak_typeStr));
		newbdids	:= join(
			hasbdid, ids(isbdid),
			left.id = right.id,
			transform(doxie_cbrs.layout_references, 
																self.bdid := (unsigned6) left.bdid_out),
																limit(faav2_services.constants.MAX_RECS_ON_JOIN,skip));
																		
		// NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
		//       but that approach requires the use of tmsids & rmsids
		
		// Deep dive those DIDs and BDIDs
	
		temp_aircraftNumber_ids := faaV2_Services.Raw.byDIDs(newdids) 
						+ faaV2_Services.Raw.byBDIDs(newbdids);		
		
    // project here into layout search setting deep dive to true
		aircraftNumber_ids := project(temp_aircraftNumber_ids, 
					transform(FaaV2_Services.Layouts.aircraftNumberPlus,
										self.isDeepDive := true, 
										self:=left));
										
		temp_newdids := project(newdids, transform(faav2_services.layouts.aircraftNumberPlus,
		                      self.did := left.did,
													self.n_number := '',
													self.aircraft_id := 0,
													self.bdid := 0,
													self := left,
													self := []));
		temp_newbdids := project(newbdids, transform(faav2_services.layouts.aircraftNumberPlus,
		                      self.bdid := left.bdid,
													self.n_number := '',
													self.aircraft_id := 0,
													self.did := 0,
		                      self := left,
													self := []));
		
		// by_auto is what we got from payload key.
		
		// Assemble results
		// new_dids and new_bdids only take for each payload row only take 1 or the other but not
		// both the person did or the business bdid
		
		// 
		//dups		:= by_auto (did=0 and bdid=0) // just results returned by aircraft number
		// took above filter on by_auto out  sure if correct.
		dups		:= by_auto  // just results returned by aircraft number
									+ temp_newdids // just results using the did search
									+ temp_newbdids // just results using the bdid search
									+ if (in_mod.isDeepDive , aircraftNumber_ids);
		
		// only add these if inmod.deepdive is set to true aircraftNumber_ids;
		// unique id's (n_number) plus did and bdid).
		results	:= dedup(sort(dups, n_number, did, bdid, aircraft_id,if(isDeepDive,1,0)), n_number, did, bdid, aircraft_id);
		
		return results;
	end;
end;