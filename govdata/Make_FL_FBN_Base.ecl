import business_header,business_header_ss,ut,did_add;

df := govdata.File_FL_FBN_In;

outrec := govdata.layout_fl_fbn_base;

outrec into_out(df L) := transform
	self.bdid := 0;
	self := L;
end;

df2 := project(df,into_out(LEFT));

business_header.MAC_Source_Match(df2,outf1,
							false,bdid,
							false,'FF',
							false,foo,
							fic_fil_name,
							fic_fil_prim_range,fic_fil_prim_name,fic_fil_sec_range,fic_fil_zip,
							false,foo,
							true,fic_fil_fei_num);
							

wbdid := outf1(bdid != 0);
wobdid := outf1(bdid = 0);
myset := ['A','F'];

business_header_ss.mac_match_flex(wobdid,myset,
							fic_fil_name,
							fic_fil_prim_range,fic_fil_prim_name,fic_fil_zip,
							fic_fil_sec_range,fic_fil_st,
							foo,fic_fil_fei_num,
							bdid,
							outrec,
							false,foo,
							outf2);

outf := outf2 + wbdid;

ut.MAC_SF_BuildProcess(outf,'~thor_Data400::base::fl_fbn_base',do1,2);

export make_FL_FBN_Base := do1;

