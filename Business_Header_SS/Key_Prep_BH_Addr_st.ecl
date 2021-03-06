IMPORT Business_Header, data_services;

f_a := business_header.files().base.CompanynameAddressBroad.keybuild
	((cn_st_bdids > 0 and cn_st_bdids < 100));

layout_address_index := RECORD
	f_a.state;
	qstring2 cn2 := f_a.company_name[1..2];
	qstring40 indic := datalib.companyclean(f_a.company_name)[1..40];
	qstring40 sec := datalib.companyclean(f_a.company_name)[41..80];
	//f_a.st_bdids;
	f_a.bdid;
	f_a.cn_st_bdids;
	f_a.__filepos;
END;

ft := table(f_a, layout_address_index);
fd := dedup(ft(cn_st_bdids <= 10), state, cn2, indic, sec, bdid, all);

layout_address_index2 := RECORD
	fd;
END;

EXPORT Key_Prep_BH_Addr_st := INDEX(
	fd, layout_address_index2, 
	data_services.data_location.prefix() + 'thor_data400::key::business_header.Addr_st' + thorlib.wuid());