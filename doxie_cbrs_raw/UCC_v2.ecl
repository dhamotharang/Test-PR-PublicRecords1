import doxie_cbrs, UCCv2, UCCv2_Services;

export UCC_v2(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0,
	string ssn_mask_value = 'NONE',
	string1 party_type = ''
) := MODULE

	shared uccKey := UCCv2.Key_Bdid_w_Type;

	doxie_cbrs.mac_RollStart(
		bdids, outf1,
		uccKey, Max_val * 3, Include_val,,keyed(Party_type='' or right.party_type=stringlib.stringtouppercase(Party_Type)[1]),if(party_type =stringlib.stringtouppercase(^.Party_Type)[1],0,1)
	);

	shared ids				:= choosen(dedup(project(outf1, UCCv2_Services.layout_tmsid), all), Max_val);
	shared uccRecs		:= UCCv2_Services.UCCRaw.report_view.by_tmsid(ids, ssn_mask_value);
	shared legacyRecs	:= UCCv2_Services.UCCRaw.legacy_view.by_tmsid(ids, ssn_mask_value);

	layout_ucc_party_clean := record
		uccv2_services.layout_ucc_party - [statementids, isdisputed];
	end;

	layout_ucc_rollup_clean := record
		unsigned2 penalt;
		uccv2_services.layout_ucc_filing;
		UCCv2_Services.assorted_layouts.matched_party_rec matched_party;
		dataset(uccv2_services.layout_ucc_hist)		filings{maxcount(UCCv2_Services.Constants.MAXCOUNT_FILINGS)};
		dataset(layout_ucc_party_clean)	debtors{maxcount(UCCv2_Services.Constants.MAXCOUNT_DEBTORS)};
		dataset(layout_ucc_party_clean)	secureds{maxcount(UCCv2_Services.Constants.MAXCOUNT_SECUREDS)};
		dataset(layout_ucc_party_clean)	assignees{maxcount(UCCv2_Services.Constants.MAXCOUNT_ASSIGNEES)};
		dataset(layout_ucc_party_clean)	creditors{maxcount(UCCv2_Services.Constants.MAXCOUNT_CREDITORS)};
		dataset(uccv2_services.layout_ucc_signer)	signers{maxcount(UCCv2_Services.Constants.MAXCOUNT_SIGNERS)};
		dataset(uccv2_services.layout_ucc_filofc)	filing_offices{maxcount(UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES)};
		dataset(uccv2_services.layout_ucc_coll)		collateral{maxcount(UCCv2_Services.Constants.MAXCOUNT_COLLATERAL)};
		boolean isDeepDive := false;
	end;

	export records := project(uccRecs, transform(layout_ucc_rollup_clean, self := left)); // so statementids are not exposed on non-fcra side
	export record_count(boolean count_only) :=
			IF(count_only,
			   count(project(dedup(sort(uccKey(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid)) and keyed(^.party_type='' or party_type= stringlib.stringtouppercase(^.party_Type)[1])),bdid,tmsid,rmsid),bdid,tmsid,rmsid), transform({uccKey.bdid}, self := left))),
				 count(uccRecs));
	export legacy_count := count(legacyRecs);
END;
