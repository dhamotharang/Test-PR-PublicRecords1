import doxie_cbrs, BankruptcyV3, BankruptcyV2_Services;

export Bankruptcy_v2(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0,
	string ssn_mask_value = 'NONE'
) := MODULE

shared k := BankruptcyV3.key_bankruptcyv3_bdid();

doxie_cbrs.mac_RollStart
	(bdids, outf10, k,
	 Max_val * 4,Include_val,p_bdid,true,p_bdid,p_bdid,p_bdid)

shared outf1 := outf10;

//**** TMSIDS FOR REGULAR REPORT VIEW
shared ids := choosen(dedup(project(outf1, transform(bankruptcyv2_services.layout_tmsid_ext,self.isdeepdive := false,self := left)),all), Max_val);
shared lie := BankruptcyV2_Services.bankruptcy_raw().report_view(in_tmsids := ids,in_ssn_mask := ssn_mask_value);

shared out_f := lie;

	export records := out_f;
	export record_count(boolean count_only) :=
			IF(count_only,
			   count(project(k(keyed(p_bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid))), transform({k.p_bdid}, self := left))),
				 count(out_f));

END;
