import doxie,doxie_cbrs,doxie_raw,FaaV2_PilotServices;

export ReportService_IDs := module
	export params := interface
		export string8 unique_id := '';
		export string1 letter_code := '';
    export string14 did;
		export unsigned6 airmen_id := 0;
	end;
	export val(params in_mod,boolean isFCRA = false) := function
		
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);

	  by_did := Raw.byDIDs(dids, isFCRA);
		
		// airmen_uniqueID:= dataset([{in_mod.unique_id,in_mod.letter_code,0,false}],FaaV2_Pilotservices.Layouts.pilotUniqueIDPlus);
    FaaV2_Pilotservices.Layouts.pilotUniqueIDPlus SetFromID () := transform
      Self.unique_id := in_mod.unique_id;
      Self.letter_code := in_mod.letter_code;
			Self.airmen_id := in_mod.airmen_id;
      Self := [];
    end;
		airmen_uniqueID:= dataset([SetFromID ()]);

		by_unique_id := Raw.byUniqueID (airmen_uniqueID,isFCRA);
		
		ids_1 := map(
				in_mod.unique_id <> '' => by_unique_id,
				in_mod.did <> '' => by_did);
				
		ids:=if (isFCRA, by_did,ids_1);		
				
		ids_d	:= dedup(sort(ids, airmen_id), airmen_id);

    // airmen unique_ids are returned here.
		return ids_d;
	end;
end;
