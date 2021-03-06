import doxie_cbrs, doxie;

EXPORT WatercraftReportService_ids(WatercraftV2_Services.Interfaces.report_params in_params, 
																	boolean isFCRA = false) := FUNCTION
	
	bdids := dataset([{in_params.bdid}], doxie_cbrs.layout_references);
	dids  := dataset([{in_params.did}],doxie.layout_references);
	watercraftkeys :=dataset([{in_params.wk,in_params.seqk,in_params.st}],WatercraftV2_services.Layouts.search_watercraftkey);

  //
  //while WaterCraftSearch also has the DID, BDID, HullNum, and VesselName search methods
	//there are performance advantages to NOT having them called in WaterCraftSearch.
	//instead leave them as they are below.
	//problem may be attributed to autokey bug.  it looks as though autokeys are called on a ID-type request (e.g. HullNum, etc)
  //
	
  //********Did and Bdid
	by_bdid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_bdids(bdids);
	by_did  := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_dids(dids,isFCRA);

	//*********hullnum
	hullnum :=dataset([{in_params.hull_num}],WatercraftV2_services.Layouts.search_hullnum);
	byhullnum :=WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_hullnum(hullnum);
		
	//*********vesselname
	uvesl_nam := stringlib.stringtouppercase(in_params.vesl_nam);
	vslname :=dataset([{in_params.vesl_nam}],WatercraftV2_services.Layouts.search_vesselname);
	byvslname :=WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_vesselname(vslname);

  //*********name and address
  // autokey search
  in_ak_params := module(project(in_params,WatercraftV2_Services.Interfaces.ak_params, opt))
  END;
	by_nm_addr := WatercraftV2_services.autokey_ids.val(in_ak_params, false, false);
																														
	watercraft_keys := MAP(in_params.wk <> '' => watercraftkeys, 
												 in_params.DID <> '' => by_did,
												 in_params.hull_num <> '' => byhullnum,
												 in_params.vesl_nam <> '' => byvslname,
												 in_params.BDID <> '' => by_bdid,
												 // if neither of the above case is provided, then we're running a search (vs. report); penalty will be applied to the final output
												 by_nm_addr);
												 
	final_watercraft_keys := if(isFCRA, by_did, watercraft_keys);		
	
	RETURN final_watercraft_keys;

END;