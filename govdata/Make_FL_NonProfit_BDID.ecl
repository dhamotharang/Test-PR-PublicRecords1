import business_header,business_header_ss,did_add,ut;

df := govdata.File_FL_Non_Profit_Corp_In;

govdata.Layout_FL_Non_Profit_Corp_Base into_base(df L) := transform
	self.bdid := 0;
	self := l;
end;

df2 := project(df,into_base(LEFT));

business_header.MAC_Source_Match(df2,outf,	
						false, bdid,
						false,'FN',
						false,foo,
						ANNUAL_COR_NAME,
						corp_prim_range,corp_prim_name,corp_sec_range,corp_zip,
						false,corp_phone,
						true,ANNUAL_COR_FEI_NUMBER)

o1 := outf(bdid = 0);
o1_bdid := outf(bdid != 0);

myset := ['A','F'];

business_header_ss.mac_match_flex(o1,myset,
						annual_cor_name,
						corp_prim_range,corp_prim_name,corp_zip,corp_sec_range,corp_st,
						phone,annual_cor_fei_number,bdid,
						govdata.Layout_FL_Non_Profit_Corp_Base,
						false,score,
						outf2)
						

o2 := outf2 + o1_bdid;

//output(o2,,'~thor_data400::base::CA_Sales_Tax_BDID_' + govdata.ca_sales_tax_file_date);

ut.MAC_SF_BuildProcess(o2,'~thor_data400::base::FL_NonProfit_bdid',do1,2);

export Make_FL_NonProfit_BDID := do1;

