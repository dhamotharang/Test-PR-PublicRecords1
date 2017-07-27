import business_header, doxie_cbrs;
export name_variations(
	boolean Include_val = false,
	unsigned3 Max_val = 0
) := MODULE

shared k := doxie_cbrs.key_BDID_NameVariations;
nn := if(Max_val > 0, Max_val, 10000);


outf1 := 
	table(k(Include_val and keyed(bdid = doxie_cbrs.subject_BDID) and seq <= nn),
			  {unsigned6 bdid := k.bdid2});
	
shared out_f := outf1;
export records := out_f;


shared simple_count := 
	count(project(k(keyed(bdid = doxie_cbrs.subject_BDID)), transform({k.bdid}, self := left)));


	export record_count(boolean count_only = false) := 
													IF(count_only,simple_count,count(out_f));
	
END;