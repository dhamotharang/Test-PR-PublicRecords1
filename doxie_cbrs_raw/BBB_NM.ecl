import BBB, doxie_cbrs;

export BBB_NM(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0
) := MODULE

shared k := BBB.Key_BBB_Non_Member_BDID;
nn := Max_val * 2;

doxie_cbrs.mac_RollStart
	(bdids, outf1, k,
	 nn,Include_val,bdid,true,bdid,company_name,address)

shared out_f := outf1;
shared simple_count :=
	count(project(k(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid))), transform({k.bdid}, self := left)));

	export records := out_f;
	export record_count(boolean count_only = false) :=
													IF(count_only,simple_count,count(out_f));

END;
