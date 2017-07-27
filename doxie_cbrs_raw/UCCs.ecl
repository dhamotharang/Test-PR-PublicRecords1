import business_header, doxie_cbrs, uccd;
export UCCs(
	boolean Include_val = false,
	unsigned3 Max_val = 0
) := MODULE

shared k := uccd.Key_BDID;
nn := Max_val;

doxie_cbrs.mac_RollStart
	(doxie_cbrs.ds_subject_BDIDs, outf1, k,
	 nn,Include_val,bdid,true,bdid,debtor_name,-filing_Date)

shared out_f := outf1;
shared simple_count := 
	count(project(k(keyed(bdid in SET(doxie_cbrs.ds_SupergroupLevels, bdid))), transform({k.bdid}, self := left)));

	export records := out_f;
	export record_count(boolean count_only = false) := 
													IF(count_only,simple_count,count(out_f));
	
END;