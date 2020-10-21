import doxie_cbrs, UCCv2, UCCv2_Services;

export UCC_Legacy(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0,
	string ssn_mask_value = 'NONE',
	string1 party_type = ''
) := MODULE

	shared uccKey := UCCv2.Key_Bdid_w_Type;

	doxie_cbrs.mac_RollStart(
		bdids, outf1,
		uccKey, Max_val * 2, Include_val,,keyed(Party_type='' or right.party_type=stringlib.stringtouppercase(Party_Type)[1]),if(party_type =stringlib.stringtouppercase(^.Party_Type)[1],0,1)
	);


	ids_withLevel := dedup(project(outf1, UCCv2_Services.layout_legacy.level_rec), all);
	uccRecs := UCCv2_Services.UCCRaw.legacy_view.raw_with_levels(ids_withLevel, ssn_mask_value);

	shared out_f := uccRecs;

	export records := out_f;
	export record_count(boolean count_only) :=
			IF(count_only,
			   count(project(dedup(sort(uccKey(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid)) and keyed(^.party_type='' or party_type= stringlib.stringtouppercase(^.party_Type)[1])),bdid,tmsid,rmsid),bdid,tmsid,rmsid), transform({uccKey.bdid}, self := left))),
				 count(out_f));
END;
