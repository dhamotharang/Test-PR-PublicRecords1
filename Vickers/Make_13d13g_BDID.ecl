import business_header,business_header_ss,ut,did_add;

df := vickers.File_13d13g_In;

outrec := vickers.layout_13d13g_base;

outrec into_out(df L) := transform
	self.bdid := 0;
	self := l;
end;

df2 := project(df,into_out(LEFT));

business_header.MAC_Source_Match(df2,outf1,
							false,bdid,
							false,'V',
							false,foo,
							filer_name,
							prim_range,prim_name,sec_range,zip,
							true,contact_phone,
							false,foo);


df3 := outf1(bdid = 0);
outf2 := outf1(bdid != 0);
myset := ['A','P'];

business_header_ss.mac_match_flex(df3,myset,
							filer_name,
							prim_range,prim_name,zip,sec_range,st,
							contact_phone,foo,
							bdid,
							outrec,
							false,foo,
							outf3);
							
outfinal := outf2 + outf3;

ut.MAC_SF_BuildProcess(outfinal,'~thor_data400::base::vickers_13d13g_base',do1,2);

export Make_13d13g_BDID := do1;