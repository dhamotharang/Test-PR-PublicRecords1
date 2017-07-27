import business_header,business_header_ss,did_add,ut;

df := govdata.File_IRS_Non_Profit_In;

govdata.Layout_IRS_NonProfit_base into_base(df L) := transform
	self.bdid := 0;
	self := l;
end;

df2 := project(df,into_base(LEFT));

business_header.MAC_Source_Match(df2,o1,
						false,bdid,
						false,'IN',
						false,foo,
						Primary_Name_Of_Organization,
						prim_range,prim_name,sec_range,zip,
						false, foo,
						false, foo)


o2_bdid := o1(bdid != 0);
o2 := o1(bdid = 0);

myset := ['A'];

business_header_ss.MAC_Match_Flex(o2,myset,
			Primary_Name_Of_Organization,
			prim_range,prim_name,zip,
			sec_range,st,
			foo,foo,
			bdid,
			govdata.Layout_IRS_NonProfit_base,
			false,score,
			o3)
			

outf := o3 + o2_bdid;

ut.MAC_SF_BuildProcess(outf,'~thor_data400::base::IRS_NonProfit',do1,2);

export Make_IRS_NonProfit_BDID := do1;
			
