import doxie_cbrs, YellowPages, MDR;

export YellowPage(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean Include_val = false,
	unsigned3 Max_val = 0
) := MODULE

shared k := YellowPages.key_YellowPages_BDID;
nn := Max_val * 2;

doxie_cbrs.mac_RollStart
	(bdids, outf1, k,
   nn,Include_val,bdid, MDR.sourceTools.SourceIsYellow_Pages(right.source),bdid,business_name+prim_name+phone10, primary_key)

shared out_f := outf1;


shared simple_count :=
	count(project(k(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels(bdids), bdid)) and MDR.sourceTools.SourceIsYellow_Pages(source)), transform({k.bdid,k.source}, self := left)));

	export records := out_f;
	export record_count(boolean count_only = false) :=
													IF(count_only,simple_count,count(out_f));

END;
