import FLAccidents,lib_keylib,lib_fileservices,ut;

string lSingleSpace(string pString1, string pString2, string pString3='')
 := trim(pString1) + ' '
  + if(trim(pString2) = '',
	   ' ',
	   trim(pString2) + ' '
	  )
  + trim(pString3)
 ;
 
// Delete the existing keys on thor ****************************************************************

ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash0.accident_nbr.key',key1);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash1.accident_nbr.key',key2);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash2v.accident_nbr.section_nbr.key',key3);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash3v.accident_nbr.section_nbr.key',key4);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash4.accident_nbr.section_nbr.key',key5);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash5.accident_nbr.section_nbr.passenger_nbr.key',key6);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash6.accident_nbr.section_nbr.key',key7);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash7.accident_nbr.key',key8);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrash8.accident_nbr.section_no.key',key9);

ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.accident_nbr.rec_type_x.key',key10);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.cn.rec_type_x.key',key11);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.dph_lname.fname.mname.lname.rec_type_x.key',key12);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.drivers_license_info.dl_state.key',key13);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.lfmname.rec_type_x.key',key14);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.nameasis.rec_type_x.key',key15);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.pcn.rec_type_x.key',key16);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.city.cn.rec_type_x.key',key17);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.city.dph_lname.fname.mname.lname.rec_type_x.key',key18);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.city.lfmname.rec_type_x.key',key19);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.city.nameasis.rec_type_x.key',key20);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.city.pcn.rec_type_x.key',key21);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.city.prim_name.prim_range.predir.postdir.suffix.key',key22);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.cn.rec_type_x.key',key23);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.lfmname.rec_type_x.key',key24);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.nameasis.rec_type_x.key',key25);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.st.pcn.rec_type_x.key',key26);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.tag_nbr.key',key27);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.tag_state.tag_nbr.key',key28);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.vin.key',key29);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.z5.prim_name.prim_range.key',key30);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',key31);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.zip.cn.rec_type_x.key',key32);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.zip.dph_lname.fname.mname.lname.key',key33);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.zip.lfmname.rec_type_x.key',key34);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.zip.nameasis.rec_type_x.key',key35);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.zip.pcn.rec_type_x.key',key36);
ut.Mac_Delete_File('~thor_data400::key::moxie.flcrashs.zip.prim_name.suffix.predir.postdir.prim_range.sec_range.key',key37);

//  accident_nbr - Record set **********************************

// flcrash0.accident_nbr.key
fc0_rec := record
	FLAccidents.Layout_FLCrash0_v2;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc0 := dataset('~thor_data400::in::flcrash0',fc0_rec, thor);

fc0k_rec := record
	fc0.accident_nbr;
    __filepos:=fc0.__filepos;
end;
fc0ktable := table(fc0,fc0k_rec);


// flcrash1.accident_nbr.key
fc1_rec := record
	FLAccidents.Layout_FLCrash1;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc1 := dataset('~thor_data400::in::flcrash1',fc1_rec, thor);

fc1k_rec := record
	fc1.accident_nbr;
    __filepos:=fc1.__filepos;
end;
fc1ktable := table(fc1,fc1k_rec);


// flcrash2v.accident_nbr.section_nbr.key
fc2v_rec := record
	FLAccidents.Layout_FLCrash2v_v2;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc2v := dataset('~thor_data400::in::flcrash2v',fc2v_rec, thor);

fc2vk_rec := record
	fc2v.accident_nbr;
	fc2v.section_nbr;
    __filepos:=fc2v.__filepos;
end;
fc2vktable := table(fc2v,fc2vk_rec);


// flcrash3v.accident_nbr.section_nbr.key
fc3v_rec := record
	FLAccidents.Layout_FLCrash3v_v2;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc3v := dataset('~thor_data400::in::flcrash3v',fc3v_rec, thor);

fc3vk_rec := record
	fc3v.accident_nbr;
	fc3v.section_nbr;
    __filepos:=fc3v.__filepos;
end;
fc3vktable := table(fc3v,fc3vk_rec);


// flcrash4.accident_nbr.section_nbr.key
fc4_rec := record
	FLAccidents.Layout_FLCrash4_v2;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc4 := dataset('~thor_data400::in::flcrash4',fc4_rec, thor);

fc4k_rec := record
	fc4.accident_nbr;
	fc4.section_nbr;
    __filepos:=fc4.__filepos;
end;
fc4ktable := table(fc4,fc4k_rec);


// flcrash5.accident_nbr.section_nbr.passenger_nbr.key
fc5_rec := record
	FLAccidents.Layout_FLCrash5_v2;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc5 := dataset('~thor_data400::in::flcrash5',fc5_rec, thor);

fc5k_rec := record
	fc5.accident_nbr;
	fc5.section_nbr;
	fc5.passenger_nbr;
    __filepos:=fc5.__filepos;
end;
fc5ktable := table(fc5,fc5k_rec);


// flcrash6.accident_nbr.section_nbr.key
fc6_rec := record
	FLAccidents.Layout_FLCrash6_v2;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc6 := dataset('~thor_data400::in::flcrash6',fc6_rec, thor);

fc6k_rec := record
	fc6.accident_nbr;
	fc6.section_nbr;
    __filepos:=fc6.__filepos;
end;
fc6ktable := table(fc6,fc6k_rec);


// flcrash7.accident_nbr.key
fc7_rec := record
	FLAccidents.Layout_FLCrash7_v2;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc7 := dataset('~thor_data400::in::flcrash7',fc7_rec, thor);

fc7k_rec := record
	fc7.accident_nbr;
    __filepos:=fc7.__filepos;
end;
fc7ktable := table(fc7,fc7k_rec);


// flcrash8.accident_nbr.section_no.key
fc8_rec := record
	FLAccidents.Layout_FLCrash8;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fc8 := dataset('~thor_data400::in::flcrash8',fc8_rec, thor);

fc8k_rec := record
	fc8.accident_nbr;
	fc8.section_no;
    __filepos:=fc8.__filepos;
end;
fc8ktable := table(fc8,fc8k_rec);


// flcrashs
fcs1_rec := record
	FLAccidents.Layout_FLCrashs;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
fcs1 := dataset('~thor_data400::in::flcrashs',fcs1_rec, thor);

fcs_rec := record, maxlength(4096)
	fcs1.rec_type_x;
	fcs1.accident_nbr;
	fcs1.dl_state;
	fcs1.drivers_license_info;
	fcs1.vin;
	fcs1.tag_nbr;
	fcs1.tag_state;
	fcs1.prim_range;
	fcs1.predir;
	fcs1.prim_name;
	fcs1.addr_suffix;
	fcs1.postdir;
	fcs1.sec_range;
	fcs1.p_city_name;
	fcs1.v_city_name;
	fcs1.st;
	fcs1.zip;
	fcs1.fname;
	fcs1.mname;
	fcs1.lname;
	fcs1.cname;
	string40	lfmname		:=lsinglespace(fcs1.lname,fcs1.fname,fcs1.mname);	//60 singlespace(lname,fname,mname)
	string25	nameasis	:=KeyLib.CompNameNoSyn(fcs1.cname);
	string25	city		:='';
	Varstring	city_all	:=ZipLib.ZipToCities(fcs1.zip);						//55 zipncities_cities(zip,p_city_name,v_city_name)
	string5		z5			:=fcs1.zip;
	string6		dph_lname	:=Metaphonelib.DMetaPhone1(fcs1.lname);				//20 dmetaphone(lname)
	string20	name_last	:=fcs1.lname;
	string10	cn			:='';
	string80	cn_all		:=keyLib.GongDacName(fcs1.cname);					//25 gongdacname(cname,"","B","")
	string5		pcn			:='';
	string40	pcn_all		:=keyLib.GongDaphcName(fcs1.cname);					//25 gongdaphcname(cname,"","B","")
	string4		suffix		:=fcs1.addr_suffix;
	__filepos:=fcs1.__filepos;
END;


fcsTable_0 := table(fcs1,fcs_rec);

////////////////////////
fcs_rec GetCity(fcsTable_0 L) := TRANSFORM
	self.city_all := Ziplib.ziptocities(L.zip);
	self := L;
END;

city_rec := project(fcsTable_0,GetCity(LEFT));

fcs_rec normcity(city_rec n, integer cnt) := TRANSFORM
	self.city := if (cnt = 1, n.p_city_name, stringlib.stringextract(n.city_all,cnt));
	self := n
END;

fcsTable_1 := normalize(city_rec,(INTEGER)Stringlib.StringExtract(LEFT.city_all, 1)+1,normcity(left,counter));
///////////////////
fcs_rec dac_comp(fcsTable_1 D) := TRANSFORM
	self.cn_all := keyLib.GongDacName(D.nameasis);
	self		:= D;
END;

cn_rec := project(fcsTable_1,dac_comp(left));

fcs_rec token_cn(cn_rec P, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, P.cn_all[1..10], P.cn_all[11..20],P.cn_all[21..30],P.cn_all[31..40],
						   P.cn_all[41..50],P.cn_all[51..60],P.cn_all[61..70],P.cn_all[71..80]);
	self := P;
end;

fcsTable_2 := NORMALIZE(cn_rec,8,token_cn(left,counter));
///////////////////////////////
fcs_rec use_pcn(fcsTable_2 l, unsigned1 cnt) := TRANSFORM
	self.pcn := choose(cnt,l.pcn_all[1..5], l.pcn_all[6..10],l.pcn_all[11..15],l.pcn_all[16..20],
							 l.pcn_all[21..25],l.pcn_all[26..30],l.pcn_all[31..35],l.pcn_all[36..40]);
	self := l;
end;

fcsTable := NORMALIZE(fcsTable_2,8,use_pcn(left,counter));


// #general keys	#########################
// flcrashs.accident_nbr.rec_type_x.key
fcs1k_rec := record
	fcs1.accident_nbr;
	fcs1.rec_type_x;
    __filepos:=fcs1.__filepos;
end;
fcs1ktable := table(fcs1,fcs1k_rec);

// #people keys	############################
// lfmname.rec_type_x
lfm_k_rec := record
	fcsTable.lfmname;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
lfm_table := table(fcsTable,lfm_k_rec);
lfm_duped := dedup(lfm_table,lfmname,rec_type_x,__filepos,ALL);

// st.lfmname.rec_type_x
st_lfm_k_rec := record
	fcsTable.st;
	fcsTable.lfmname;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_lfm_table := table(fcsTable,st_lfm_k_rec);
st_lfm_duped := dedup(st_lfm_table,st,lfmname,rec_type_x,__filepos,ALL);

// st.city.lfmname.rec_type_x
st_city_lfm_k_rec := record
	fcsTable.st;
	fcsTable.city;
	fcsTable.lfmname;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_city_lfm_table := table(fcsTable,st_city_lfm_k_rec);
st_city_lfm_duped := dedup(st_city_lfm_table,st,city,lfmname,rec_type_x,__filepos,ALL);

// zip.lfmname.rec_type_x
zip_lfm_k_rec := record
	fcsTable.zip;
	fcsTable.lfmname;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
zip_lfm_table := table(fcsTable,zip_lfm_k_rec);
zip_lfm_duped := dedup(zip_lfm_table,zip,lfmname,rec_type_x,__filepos,ALL);

// flcrashs.dph_lname.fname.mname.lname.rec_type_x.key
dph_fml_k_rec := record
	fcsTable.dph_lname;
	fcsTable.fname;
	fcsTable.mname;
	fcsTable.lname;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
dph_fml_table := table(fcsTable,dph_fml_k_rec);
dph_fml_duped := dedup(dph_fml_table,dph_lname,fname,mname,lname,rec_type_x,__filepos,ALL);

// st.city.dph_lname.fname.mname.lname.rec_type_x
st_city_dph_fml_k_rec := record
	fcsTable.st;
	fcsTable.city;
	fcsTable.dph_lname;
	fcsTable.fname;
	fcsTable.mname;
	fcsTable.lname;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_city_dph_fml_table := table(fcsTable,st_city_dph_fml_k_rec);
st_city_dph_fml_duped := dedup(st_city_dph_fml_table,st,city,dph_lname,fname,mname,lname,rec_type_x,__filepos,ALL);

// zip.dph_lname.fname.mname.lname
zip_dph_fml_k_rec := record
	fcsTable.zip;
	fcsTable.dph_lname;
	fcsTable.fname;
	fcsTable.mname;
	fcsTable.lname;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
zip_dph_fml_table := table(fcsTable,zip_dph_fml_k_rec);
zip_dph_fml_duped := dedup(zip_dph_fml_table,zip,dph_lname,fname,mname,lname,rec_type_x,__filepos,ALL);

// #company keys	#######################
// nameasis.rec_type_x
nameasis_k_rec := record
	fcsTable.nameasis;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
nameasis_table := table(fcsTable,nameasis_k_rec);
nameasis_duped := dedup(nameasis_table,nameasis,rec_type_x,__filepos,ALL);

// st.nameasis.rec_type_x
st_nameasis_k_rec := record
	fcsTable.st;
	fcsTable.nameasis;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_nameasis_table := table(fcsTable,st_nameasis_k_rec);
st_nameasis_duped := dedup(st_nameasis_table,st,nameasis,rec_type_x,__filepos,ALL);

// st.city.nameasis.rec_type_x
st_city_nameasis_k_rec := record
	fcsTable.st;
	fcsTable.city;
	fcsTable.nameasis;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_city_nameasis_table := table(fcsTable,st_city_nameasis_k_rec);
st_city_nameasis_duped := dedup(st_city_nameasis_table,st,city,nameasis,rec_type_x,__filepos,ALL);

// zip.nameasis.rec_type_x
zip_nameasis_k_rec := record
	fcsTable.zip;
	fcsTable.nameasis;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
zip_nameasis_table := table(fcsTable,zip_nameasis_k_rec);
zip_nameasis_duped := dedup(zip_nameasis_table,zip,nameasis,rec_type_x,__filepos,ALL);

// flcrashs.cn.rec_type_x.key
cn_k_rec := record
	fcsTable.cn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
cn_table := table(fcsTable,cn_k_rec);
cn_duped := dedup(cn_table,cn,rec_type_x,__filepos,ALL);

// st.cn.rec_type_x
st_cn_k_rec := record
	fcsTable.st;
	fcsTable.cn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_cn_table := table(fcsTable,st_cn_k_rec);
st_cn_duped := dedup(st_cn_table,st,cn,rec_type_x,__filepos,ALL);

// st.city.cn.rec_type_x
st_cty_cn_k_rec := record
	fcsTable.st;
	fcsTable.city;
	fcsTable.cn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_cty_cn_table := table(fcsTable,st_cty_cn_k_rec);
st_cty_cn_duped := dedup(st_cty_cn_table,st,city,cn,rec_type_x,__filepos,ALL);

// zip.cn.rec_type_x
zip_cn_k_rec := record
	fcsTable.zip;
	fcsTable.cn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
zip_cn_table := table(fcsTable,zip_cn_k_rec);
zip_cn_duped := dedup(zip_cn_table,zip,cn,rec_type_x,__filepos,ALL);

// pcn.rec_type_x
pcn_k_rec := record
	fcsTable.pcn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
pcn_table := table(fcsTable,pcn_k_rec);
pcn_duped := dedup(pcn_table,pcn,rec_type_x,__filepos,ALL);

// st.pcn.rec_type_x
st_pcn_k_rec := record
	fcsTable.st;
	fcsTable.pcn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_pcn_table := table(fcsTable,st_pcn_k_rec);
st_pcn_duped := dedup(st_pcn_table,st,pcn,rec_type_x,__filepos,ALL);

// st.city.pcn.rec_type_x
st_cty_pcn_k_rec := record
	fcsTable.st;
	fcsTable.city;
	fcsTable.pcn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
st_cty_pcn_table := table(fcsTable,st_cty_pcn_k_rec);
st_cty_pcn_duped := dedup(st_cty_pcn_table,st,city,pcn,rec_type_x,__filepos,ALL);

// zip.pcn.rec_type_x
zip_pcn_k_rec := record
	fcsTable.zip;
	fcsTable.pcn;
	fcsTable.rec_type_x;
	__filepos:=fcsTable.__filepos;
end;
zip_pcn_table := table(fcsTable,zip_pcn_k_rec);
zip_pcn_duped := dedup(zip_pcn_table,zip,pcn,rec_type_x,__filepos,ALL);

// #other keys	#########################
// z5.prim_name.prim_range
z5_pn_pr_k_rec := record
	fcsTable.z5;
	fcsTable.prim_name;
	fcsTable.prim_range;
	__filepos:=fcsTable.__filepos;
end;
z5_pn_pr_table := table(fcsTable,z5_pn_pr_k_rec);
z5_pn_pr_duped := dedup(z5_pn_pr_table,z5,prim_name,prim_range,__filepos,ALL);

// z5.prim_name.suffix.predir.postdir.prim_range.sec_range
z5_pn_sfx_pre_pos_pr_sr_k_rec := record
	fcsTable.z5;
	fcsTable.prim_name;
	fcsTable.suffix;
	fcsTable.predir;
	fcsTable.postdir;
	fcsTable.prim_range;
	fcsTable.sec_range;
	__filepos:=fcsTable.__filepos;
end;
z5_pn_sfx_pre_pos_pr_sr_table := table(fcsTable,z5_pn_sfx_pre_pos_pr_sr_k_rec);
z5_pn_sfx_pre_pos_pr_sr_duped := dedup(z5_pn_sfx_pre_pos_pr_sr_table,z5,prim_name,suffix,predir,postdir,prim_range,sec_range,__filepos,ALL);

// zip.prim_name.suffix.predir.postdir.prim_range.sec_range
zip_pn_sfx_pre_pos_pr_sr_k_rec := record
	fcsTable.zip;
	fcsTable.prim_name;
	fcsTable.suffix;
	fcsTable.predir;
	fcsTable.postdir;
	fcsTable.prim_range;
	fcsTable.sec_range;
	__filepos:=fcsTable.__filepos;
end;
zip_pn_sfx_pre_pos_pr_sr_table := table(fcsTable,zip_pn_sfx_pre_pos_pr_sr_k_rec);
zip_pn_sfx_pre_pos_pr_sr_duped := dedup(zip_pn_sfx_pre_pos_pr_sr_table,zip,prim_name,suffix,predir,postdir,prim_range,sec_range,__filepos,ALL);

// st.city.prim_name.prim_range.predir.postdir.suffix
st_cty_pn_pr_pre_pos_sfx_k_rec := record
	fcsTable.st;
	fcsTable.city;
	fcsTable.prim_name;
	fcsTable.prim_range;
	fcsTable.predir;
	fcsTable.postdir;
	fcsTable.suffix;
	__filepos:=fcsTable.__filepos;
end;
st_cty_pn_pr_pre_pos_sfx_table := table(fcsTable,st_cty_pn_pr_pre_pos_sfx_k_rec);
st_cty_pn_pr_pre_pos_sfx_duped := dedup(st_cty_pn_pr_pre_pos_sfx_table,st,city,prim_name,prim_range,predir,postdir,suffix,__filepos,ALL);

// flcrashs.vin.key
vin_k_rec := record
	fcs1.vin;
    __filepos:=fcs1.__filepos;
end;
vin_table := table(fcs1,vin_k_rec);
vin_duped := dedup(vin_table,vin,__filepos,ALL);

// flcrashs.tag_nbr.key
tag_nbr_k_rec := record
	fcs1.tag_nbr;
    __filepos:=fcs1.__filepos;
end;
tag_nbr_table := table(fcs1,tag_nbr_k_rec);
tag_nbr_duped := dedup(tag_nbr_table,tag_nbr,__filepos,ALL);

// tag_state.tag_nbr
tag_st_nbr_k_rec := record
	fcs1.tag_state;
	fcs1.tag_nbr;
    __filepos:=fcs1.__filepos;
end;
tag_st_nbr_table := table(fcs1,tag_st_nbr_k_rec);
tag_st_nbr_duped := dedup(tag_st_nbr_table,tag_state,tag_nbr,__filepos,ALL);

// flcrashs.drivers_license_info.dl_state.key
dl_st_k_rec := record
	fcsTable.drivers_license_info;
	fcsTable.dl_state;
	__filepos:=fcsTable.__filepos;
end;
dl_st_table := table(fcsTable,dl_st_k_rec);
dl_st_duped := dedup(dl_st_table,drivers_license_info,dl_state,__filepos,ALL);

// BUILDING INDEXES *******************************************************************************

// #general keys
// accident_nbr
a := BUILDINDEX(fc0ktable,{accident_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash0.accident_nbr.key',MOXIE,overwrite);
// accident_nbr
b := BUILDINDEX(fc1ktable,{accident_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash1.accident_nbr.key',MOXIE,overwrite);
// accident_nbr.section_no
c := BUILDINDEX(fc2vktable,{accident_nbr,section_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash2v.accident_nbr.section_nbr.key',MOXIE,overwrite);
// accident_nbr.section_no
d := BUILDINDEX(fc3vktable,{accident_nbr,section_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash3v.accident_nbr.section_nbr.key',MOXIE,overwrite);
// accident_nbr.section_no
e := BUILDINDEX(fc4ktable,{accident_nbr,section_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash4.accident_nbr.section_nbr.key',MOXIE,overwrite);
// accident_nbr.section_no.passenger_nbr
f := BUILDINDEX(fc5ktable,{accident_nbr,section_nbr,passenger_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash5.accident_nbr.section_nbr.passenger_nbr.key',MOXIE,overwrite);
// accident_nbr.section_no
g := BUILDINDEX(fc6ktable,{accident_nbr,section_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash6.accident_nbr.section_nbr.key',MOXIE,overwrite);
// accident_nbr
h := BUILDINDEX(fc7ktable,{accident_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash7.accident_nbr.key',MOXIE,overwrite);
// accident_nbr.section_no
i := BUILDINDEX(fc8ktable,{accident_nbr,section_no,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrash8.accident_nbr.section_no.key',MOXIE,overwrite);
// accident_nbr.rec_type_x
j := BUILDINDEX(fcs1ktable,{accident_nbr,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.accident_nbr.rec_type_x.key',MOXIE,overwrite);

// #people keys
// lfmname.rec_type_x
k := BUILDINDEX(lfm_duped,{lfmname,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.lfmname.rec_type_x.key',MOXIE,overwrite);
// st.lfmname.rec_type_x
l := BUILDINDEX(st_lfm_duped,{st,lfmname,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.lfmname.rec_type_x.key',MOXIE,overwrite);
// st.city.lfmname.rec_type_x
m := BUILDINDEX(st_city_lfm_duped,{st,city,lfmname,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.city.lfmname.rec_type_x.key',MOXIE,overwrite);
// zip.lfmname.rec_type_x
n := BUILDINDEX(zip_lfm_duped,{zip,lfmname,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.zip.lfmname.rec_type_x.key',MOXIE,overwrite);
// dph_lname.fname.mname.lname.rec_type_x
o := BUILDINDEX(dph_fml_duped,{dph_lname,fname,mname,lname,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.dph_lname.fname.mname.lname.rec_type_x.key',MOXIE,overwrite);
// st.city.dph_lname.fname.mname.lname.rec_type_x
p := BUILDINDEX(st_city_dph_fml_duped,{st,city,dph_lname,fname,mname,lname,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.city.dph_lname.fname.mname.lname.rec_type_x.key',MOXIE,overwrite);
// zip.dph_lname.fname.mname.lname
q := BUILDINDEX(zip_dph_fml_duped,{zip,dph_lname,fname,mname,lname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.zip.dph_lname.fname.mname.lname.key',MOXIE,overwrite);


// #company keys
// nameasis.rec_type_x
r := BUILDINDEX(nameasis_duped,{nameasis,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.nameasis.rec_type_x.key',MOXIE,overwrite);
// st.nameasis.rec_type_x
s := BUILDINDEX(st_nameasis_duped,{st,nameasis,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.nameasis.rec_type_x.key',MOXIE,overwrite);
// st.city.nameasis.rec_type_x
t := BUILDINDEX(st_city_nameasis_duped,{st,city,nameasis,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.city.nameasis.rec_type_x.key',MOXIE,overwrite);
// zip.nameasis.rec_type_x
u := BUILDINDEX(zip_nameasis_duped,{zip,nameasis,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.zip.nameasis.rec_type_x.key',MOXIE,overwrite);
// cn.rec_type_x
v := BUILDINDEX(cn_duped,{cn,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.cn.rec_type_x.key',MOXIE,overwrite);
// st.cn.rec_type_x
w := BUILDINDEX(st_cn_duped,{st,cn,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.cn.rec_type_x.key',MOXIE,overwrite);
// st.city.cn.rec_type_x
x := BUILDINDEX(st_cty_cn_duped,{st,city,cn,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.city.cn.rec_type_x.key',MOXIE,overwrite);
// zip.cn.rec_type_x
y := BUILDINDEX(zip_cn_duped,{zip,cn,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.zip.cn.rec_type_x.key',MOXIE,overwrite);
// pcn.rec_type_x
z := BUILDINDEX(pcn_duped,{pcn,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.pcn.rec_type_x.key',MOXIE,overwrite);
// st.pcn.rec_type_x
aa := BUILDINDEX(st_pcn_duped,{st,pcn,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.pcn.rec_type_x.key',MOXIE,overwrite);
// st.city.pcn.rec_type_x
bb := BUILDINDEX(st_cty_pcn_duped,{st,pcn,city,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.city.pcn.rec_type_x.key',MOXIE,overwrite);
// zip.pcn.rec_type_x
cc := BUILDINDEX(zip_pcn_duped,{zip,pcn,rec_type_x,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.zip.pcn.rec_type_x.key',MOXIE,overwrite);


// #other keys
// z5.prim_name.prim_range
dd := BUILDINDEX(z5_pn_pr_duped,{z5,prim_name,prim_range,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.z5.prim_name.prim_range.key',MOXIE,overwrite);
// z5.prim_name.suffix.predir.postdir.prim_range.sec_range
ee := BUILDINDEX(z5_pn_sfx_pre_pos_pr_sr_duped,{z5,prim_name,suffix,predir,postdir,prim_range,sec_range,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',MOXIE,overwrite);
// zip.prim_name.suffix.predir.postdir.prim_range.sec_range
ff := BUILDINDEX(zip_pn_sfx_pre_pos_pr_sr_duped,{zip,prim_name,suffix,predir,postdir,prim_range,sec_range,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.zip.prim_name.suffix.predir.postdir.prim_range.sec_range.key',MOXIE,overwrite);
// st.city.prim_name.prim_range.predir.postdir.suffix
gg := BUILDINDEX(st_cty_pn_pr_pre_pos_sfx_duped,{st,city,prim_name,prim_range,predir,postdir,suffix,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.st.city.prim_name.prim_range.predir.postdir.suffix.key',MOXIE,overwrite);
// vin
hh := BUILDINDEX(vin_duped,{vin,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.vin.key',MOXIE,overwrite);
// tag_nbr
ii := BUILDINDEX(tag_nbr_duped,{tag_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.tag_nbr.key',MOXIE,overwrite);
// tag_state.tag_nbr
jj := BUILDINDEX(tag_st_nbr_duped,{tag_state,tag_nbr,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.tag_state.tag_nbr.key',MOXIE,overwrite);
// drivers_license_info.dl_state
kk := BUILDINDEX(dl_st_duped,{drivers_license_info,dl_state,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.flcrashs.drivers_license_info.dl_state.key',MOXIE,overwrite);


export Out_MOXIE_FLAccidents_Keys := sequential(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,
												 key11,key12,key13,key14,key15,key16,key17,key18,key19,
												 key20,key21,key22,key23,key24,key25,key26,key27,key28,
												 key29,key30,key31,key32,key33,key34,key35,key36,key37,
												 parallel(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,
															w,x,y,z,aa,bb,cc,dd,ee,ff,gg,hh,ii,jj,kk
															)
												);