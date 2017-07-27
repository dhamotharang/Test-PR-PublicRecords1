IMPORT doxie,doxie_cbrs,fbnv2_services;

EXPORT FBNV2_Raw(
	dataset(doxie.layout_references) dids = DATASET([],doxie.layout_references),
	dataset(doxie_cbrs.layout_references) bdids = DATASET([],doxie_cbrs.layout_references)
	) := FUNCTION

	rmsid_did := FBNV2_services.FBN_raw.get_rmsids_from_dids(dids);
	rmsid_bdid := FBNV2_services.FBN_raw.get_rmsids_from_bdids(bdids);
	
    srch_ids := project(rmsid_did+rmsid_bdid,
                transform(FBNV2_services.layout_search_IDs,SELF:=LEFT;SELF:=[]));

	RETURN FBNV2_services.get_FBN(srch_ids,false).report;

END;