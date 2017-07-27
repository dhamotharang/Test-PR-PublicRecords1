import business_header,business_header_ss,did_add,ut;

df := govdata.File_FDIC_In;

govdata.layout_fdic_bdid into_bdid(df L) := transform
	self := l;
	self.bdid := 0;
end;

df2 := project(df,into_bdid(LEFT));

business_header.MAC_Source_Match(df2,outf1,
						false,bdid,
						false,'FD',
						false,foo,
						name,
						prim_range,prim_name,sec_range,zip,
						false,phone,
						false,fein)
						

o1 := outf1(bdid = 0);
o1_bdid := outf1(bdid != 0);
myset := ['A'];

business_header_ss.MAC_Match_Flex(o1,myset,name,
					prim_range,prim_name,zip,sec_range,st,
					phone,fein,bdid,govdata.layout_FDIC_BDID,
					false,bdidscore,outf2)

outf := outf2 + o1_bdid;

//output(outf,,'~thor_data400::base::govdata_FDIC_BDID_' + govdata.FDIC_Build_Date);

ut.MAC_SF_BuildProcess(outf,'~thor_data400::base::govdata_FDIC_BDID',do1,2);

export make_FDIC_BDID := do1;

