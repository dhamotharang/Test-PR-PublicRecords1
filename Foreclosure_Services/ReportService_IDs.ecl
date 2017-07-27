import doxie,Foreclosure_services,doxie_cbrs,doxie;

export ReportService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export boolean noDeepDive := false;
		export string70 ForeclosureId :='';
	end;
	export val(params in_mod, boolean isNodSearch=false) := function
		
		// For SSN search
		by_auto	:= Foreclosure_services.AutoKey_IDs.val(in_mod,isNodSearch);
		
		//For ForeclosureID search
	  by_ForeclosureId := dataset([{in_mod.ForeclosureId,0,0,false}],foreclosure_services.Layouts.FIDNumberPlus);
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := if((unsigned)in_mod.DID > 0,foreclosure_services.Raw.byDIDs(dids,isNodSearch));

		// lookup by BDID
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := if((unsigned)in_mod.BDID > 0,foreclosure_services.Raw.byBDIDs(bdids,isNodSearch));
		 ids := map(
				in_mod.ForeclosureId <> '' => by_ForeclosureId,
				(unsigned)in_mod.DID <> 0 => by_did,
				(unsigned)in_mod.BDID <> 0 => by_bdid,
				by_auto);

		
		ids_d	:= dedup(sort(ids,record), record);
		// output(dids);
		return ids_d;
	end;
end;
