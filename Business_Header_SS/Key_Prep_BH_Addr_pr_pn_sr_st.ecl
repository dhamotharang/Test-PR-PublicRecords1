IMPORT Business_Header;

f_a := Business_Header_SS.File_Prep_BH_CompanyName_Address_Plus
	((pr_pn_sr_st_bdids > 0 and pr_pn_sr_st_bdids < 100) or
	 (cn_pr_pn_sr_st_bdids > 0 and cn_pr_pn_sr_st_bdids < 100));

layout_address_index := RECORD
	f_a.state;
	f_a.prim_name;
	f_a.prim_range;
	f_a.sec_range;
	qstring2 cn2 := f_a.company_name[1..2];
	qstring40 indic := datalib.companyclean(f_a.company_name)[1..40];
	qstring40 sec := datalib.companyclean(f_a.company_name)[41..80];
	//f_a.pr_pn_sr_st_bdids;
	f_a.bdid;
	f_a.cn_pr_pn_sr_st_bdids;
	f_a.__filepos;
END;

ft := table(f_a, layout_address_index);
fd := dedup(ft(cn_pr_pn_sr_st_bdids <= 10), state, prim_name, prim_range, sec_range, cn2, indic, sec, bdid, all);

layout_address_index2 := RECORD
	fd;
END;

EXPORT Key_Prep_BH_Addr_pr_pn_sr_st := INDEX(
	fd, layout_address_index2, 
	'~thor_data400::key::business_header.Addr_pr_pn_sr_st' + thorlib.wuid());