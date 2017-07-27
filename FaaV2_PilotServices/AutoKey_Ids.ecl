import AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,ut,faa,faaV2_PilotServices;

export AutoKey_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	export val(params in_mod) := function
		c						:= faa.faa_airmen_ak_constants('');  
		ak_keyname	:= c.ak_keyname;
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
		// hitting just person keys.
		
		// didout6 is unsigned6 version of string12 did_out
		
		AutokeyB2.mac_get_payload(ids, str_autokeyname, ak_dataset, outpl, did_out6, zero, ak_typeStr)
   
		by_auto := dedup(sort(project(outpl,
	      	transform (FaaV2_PilotServices.Layouts.pilotUniqueIDPlus, 
		             self.did := left.did_out6, 
								 self.unique_id := left.unique_id,
								 self.letter_code := left.letter_code,
								 self.airmen_id := left.airmen_id,
								 self := left )),airmen_id),airmen_id);
		//Get DIDs from autokey results
		// hasdids is payload record....
	
		hasdid	:= outpl(did_out6 > 0 and ~AutokeyB2.ISFakeID(did_out6, ak_typeStr));
		newdids	:= join(
			hasdid, ids(isdid),
			left.id = right.id,
			transform(doxie.layout_references, 
									self.did := left.did_out6),
									limit(faav2_Pilotservices.constants.MAX_RECS_ON_JOIN,skip));
	
		tempnewdids := project(newdids, transform(faav2_PilotServices.layouts.pilotUniqueIDPlus,
															self.did := left.did,
															self.airmen_id := 0,
		                          self.unique_id := '',
		                          self.letter_code := '',
															));																												
		// Deep dive those DIDs 
	
		temp_pilotUniqueID_ids := faaV2_PilotServices.Raw.byDIDs(newdids); 
		
    // project here into layout search setting deep dive to true
		pilotUniqueID_ids := project(temp_pilotUniqueID_ids, 
					transform(FaaV2_PilotServices.Layouts.pilotUniqueIDPlus,
										self.isDeepDive := true, 
										self:=left));
	
		// by_auto is what we got from payload key.
		
		dups		:= by_auto  // just results returned by aircraft number
		              + tempnewdids  // just results using the did search
									+ if (in_mod.isDeepDive , pilotUniqueID_ids);
		//
		// only add these if inmod.deepdive is set to true : pilotUniqueID_ids;
		
		results	:= dedup(sort(dups, airmen_id, if(isDeepDive,1,0)), airmen_id);
	
		return results;
	end;
end;