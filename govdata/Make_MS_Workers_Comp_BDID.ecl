import business_header,business_header_ss,did_add,ut;

df := govdata.File_MS_Workers_Comp_In;

govdata.Layout_MS_Workers_Comp_base into_base(df L) := transform
	self.bdid := 0;
	self := l;
end;

df2 := project(df,into_base(LEFT));

business_header.MAC_Source_Match(df2,o1,
						false,bdid,
						false,'WC',
						false,foo,
						employer_name,
						emp_prim_range,emp_prim_name,emp_sec_range,emp_zip5,
						false, foo,
						true, employer_fein)


o2_bdid := o1(bdid != 0);
o2 := o1(bdid = 0);

myset := ['A','F'];

business_header_ss.MAC_Match_Flex(o2,myset,
			employer_name,
			emp_prim_range,emp_prim_name,emp_zip5,
			emp_sec_range,emp_st,
			foo,employer_fein,
			bdid,
			govdata.Layout_MS_Workers_Comp_base,
			false,score,
			o3)
			

outf := o3 + o2_bdid;

ut.MAC_SF_BuildProcess(outf,'~thor_data400::base::ms_workers_comp',do1,2);

export Make_MS_Workers_Comp_BDID := do1;
			