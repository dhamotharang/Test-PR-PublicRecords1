import business_header,business_header_ss,did_add,ut;

df := govdata.file_ca_sales_tax_in;

govdata.layout_ca_sales_tax into_fullrec(df L) := transform
	self := L;
	self.bdid := 0;
end;

df2 := project(df,into_fullrec(LEFT));

business_header.MAC_Source_Match(df2,outf,	
						false, bdid,
						false,'ST',
						false,foo,
						firm_name,
						prim_range,prim_name,sec_range,zip,
						false,phone,
						false,fein)

o1 := outf(bdid = 0);
o1_bdid := outf(bdid != 0);

myset := ['A'];

business_header_ss.mac_match_flex(o1,myset,
						firm_name,
						prim_range,prim_name,zip,sec_range,st,
						phone,fein,bdid,
						govdata.Layout_CA_Sales_Tax,
						false,score,
						outf2)
						

o2 := outf2 + o1_bdid;

//output(o2,,'~thor_data400::base::CA_Sales_Tax_BDID_' + govdata.ca_sales_tax_file_date);

ut.MAC_SF_BuildProcess(o2,'~thor_data400::base::ca_sales_tax_bdid',do1,2);

export make_ca_sales_tax_bdid := do1;

