import doxie_cbrs, LiensV2, LiensV2_Services;

export Liens_v2(
  dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0,
	string ssn_mask_value = '',
	string32 appType
) := MODULE

shared k := LiensV2.key_liens_BDID;

doxie_cbrs.mac_RollStart
	(bdids, outf10, k,
	 Max_val * 4,Include_val,p_bdid,true,p_bdid,p_bdid,p_bdid)

shared outf1 := outf10;

//**** TMSIDS FOR REGULAR REPORT VIEW
shared ids := choosen(dedup(project(outf1, liensv2_services.layout_tmsid),all), Max_val);
shared lie := LiensV2_Services.liens_raw.report_view.by_tmsid(ids,ssn_mask_value,,,,,appType);

//**** RMSIDS FOR MOXIE VIEW
shared rmsids := choosen(dedup(project(outf1, liensv2_services.layout_rmsid),all), Max_val * 2);


shared out_f := lie;


	export records := out_f;
	export records_moxieView := LiensV2_Services.liens_raw.moxie_view.by_rmsid(rmsids,ssn_mask_value);
	export record_count(boolean count_only) :=
			IF(count_only,
			   count(project(k(keyed(p_bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid))), transform({k.p_bdid}, self := left))),
				 count(out_f));

END;
