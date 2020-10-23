import busreg, doxie_cbrs;

export business_registrations(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0
) := MODULE

shared k := BusReg.key_busreg_company_bdid;
nn := Max_val;

doxie_cbrs.mac_RollStart
	(bdids, outf1, k,
	 nn,Include_val,bdid,true,bdid,company_name,-record_date,
	 true, doxie_cbrs.layout_business_registration_records)

shared out_f := outf1;


shared simple_count :=
	count(project(k(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid))), transform({k.bdid}, self := left)));

	export records := out_f;
	export record_count(boolean count_only = false) :=
													IF(count_only,simple_count,count(out_f));

END;
