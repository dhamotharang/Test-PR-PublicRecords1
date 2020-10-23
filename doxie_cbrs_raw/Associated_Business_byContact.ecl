import doxie_cbrs;
export Associated_Business_byContact(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0
) := MODULE

shared k := doxie_cbrs.key_BDID_relsByContact;
nn := Max_val * 3;

doxie_cbrs.mac_RollStart
	(bdids, outf1, k,nn, Include_val,
	 bdid,, bdid, -score, bdid2)

shared out_f := outf1;


shared simple_count :=
	count(project(k(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid))), transform({k.bdid}, self := left)));

	export records := out_f;
	export record_count(boolean count_only = false) :=
													IF(count_only,simple_count,count(out_f));

END;
