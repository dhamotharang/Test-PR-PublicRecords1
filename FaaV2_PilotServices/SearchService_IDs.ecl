import doxie,doxie_cbrs,doxie_raw, faav2_pilotServices;

export SearchService_IDs := module
	  export params := interface(faav2_pilotServices.AutoKey_IDs.params)
		export string8 unique_id := '';
		export string1 letter_code := '';
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
	end;
	export val(params in_mod,boolean isFCRA=false) := function
		// autokeys
		by_auto	:= FaaV2_Pilotservices.AutoKey_IDs.val(in_mod);
		
		// deep DIDs		
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
									 transform(doxie.layout_references,  
										 self.did :=  left.did,
										  self := left));
		by_deep_dids := if(not in_mod.noDeepDive,faav2_PilotServices.Raw.byDIDs(deep_dids));
		
		// lookup by pilot registration # id (unique_id field)
    FaaV2_Pilotservices.Layouts.pilotUniqueIDPlus SetFromID () := transform
      Self.unique_id := in_mod.unique_id;
      Self.letter_code := in_mod.letter_code;
      Self := [];
    end;
		airmen_uniqueID:= dataset([SetFromID ()]);
		by_unique_id := faav2_pilotServices.Raw.byUniqueID (airmen_uniqueID);
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := faav2_pilotServices.Raw.byDIDs(dids,isFCRA);
		
		ids_1 := map(
			in_mod.unique_id <> '' => by_unique_id, 
			(unsigned)in_mod.DID <> 0 => by_did,
			by_auto + project (by_deep_dids, transform (faav2_pilotServices.Layouts.pilotUniqueIDPlus, Self.IsDeepDive := true; Self := Left)));

		// ...and shifting deep-dive-only to the end
		ids := if (isFCRA,by_did,ids_1);
		ids_d	:= dedup(sort(ids, airmen_id, isDeepDive), airmen_id, isDeepDive);
		
		return ids_d;
	end;
end;
