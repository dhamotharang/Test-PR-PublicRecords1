import Bankrupt,lib_keylib,lib_fileservices,ut;

#workunit('name','Liens Key Build');

// Delete Keys
ut.Mac_Delete_File('~thor_data400::key::moxie.liens.fpos.data.key',key1);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.bdid.key',key2);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.did.key',key3);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.ssn.key',key4);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.uploaddate.key',key5);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.casenumber.key',key6);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.rmsid.key',key7);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.court_st.casenumber.key',key8);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.courtid.casenumber.book.page.key',key9);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.lfmname.key',key10);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.nameasis.key',key11);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.st.lfmname.key',key12);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.st.city.lfmname.key',key13);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.st.nameasis.key',key14);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.st.city.nameasis.key',key15);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.cn.key',key16);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.st.cn.key',key17);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.z5.cn.key',key18);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.st.city.cn.key',key19);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.z5.prim_name.prim_range.lfmname.key',key20);
ut.Mac_Delete_File('~thor_data400::key::moxie.Liens.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',key21);

// Begin Keybuild
string_rec := record
	Bankrupt.Layout_Liens;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

LK_MAIN := DATASET('~thor_data400::base::Liens', string_rec, thor);

LK := LK_MAIN : persist('~thor_data400::persist::liens_keys');

// Begin fpos key

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := (sizeof(Bankrupt.Layout_Liens)-8) * count(LK) : global;
headersize := if (sizeof(Bankrupt.Layout_Liens)>215, sizeof(Bankrupt.Layout_Liens), error('too bad')) : global;

dafile := INDEX(LK,{f:= moxietransform(__filepos, rawsize, headersize)},{LK},'~thor_data400::key::moxie.liens.fpos.data.key');

// End fpos key


// single field key Record set *********************************************************************************

bdid_rec := record
	LK.bdid;
	LK.did;
	LK.ssn_appended;
	LK.courtid;
	LK.uploaddate;
	LK.casenumber;
	LK.rmsid;
	LK.book;
	LK.page;
	string2 court_st := LK.courtid[1..2];
	LK.__filepos;
END;

BDIDtable := table(LK,bdid_rec);

// multiple field key Record set ******************************************************************************

lfmc_rec := record
	LK.def_company;
	LK.plain_company;
	LK.state;
	LK.p_city_name;
	LK.v_city_name;
	LK.zip;
	LK.prim_name;
	LK.prim_range;
	LK.predir;
	LK.postdir;
	LK.sec_range;
	LK.suffix;
	string2 l_court_st := LK.courtid[1..2];
	string25 ncity_name := '';
	varstring ncitylist := '';
	string25 ncityfromzip := '';
	string25 namcity_name := '';
	varstring namcitylist := '';
	string25 namcityfromzip := '';
	string25 cncityfromzip := '';
	varstring cncitylist := '';
	string80 cn_all := '';
	string10 c_tok := '';
	string45 lfmname := '';
	string60 def_lfmname := TRIM(LK.def_lname,right) + ' ' + IF(TRIM(LK.def_fname,right) = '', ' ',TRIM(LK.def_fname,right) + ' ') + TRIM(LK.def_mname,right);
	string60 plain_lfmname := TRIM(LK.plain_lname,right) + ' ' + IF(TRIM(LK.plain_fname,right) = '', ' ',TRIM(LK.plain_fname,right) + ' ') + TRIM(LK.plain_mname,right);
	string32 nameasis := '';
	string45 lfnameasis := '';
	string2 st := '';
	LK.__filepos;
END;

lfmc_table := table(LK,lfmc_rec);

// End Record Set


//Begin Normalize

//lfmname 

lfmc_rec norm_lfmname(lfmc_table L, unsigned1 l_count) := TRANSFORM
	self.lfmname := choose(l_count,L.def_lfmname,L.plain_lfmname);
	self := L;
END;

norm_lfm := normalize(lfmc_table,2,norm_lfmname(left,counter));
//sort_lfm := sort(norm_lfm,lfmname);
dedup_lfm := dedup(norm_lfm(lfmname <> ''),lfmname,__filepos,ALL);

//st.lfmname

lfmc_rec norm_stlfm(dedup_lfm L, unsigned1 l_count) := TRANSFORM
	self.st := choose(l_count,L.state,L.l_court_st);
	self := L;
END;

norm_stlf := normalize(dedup_lfm,2,norm_stlfm(left,counter));
dedup_stlfm := dedup(norm_stlf(st <> ''),st,lfmname,__filepos,ALL);

//nameasis

lfmc_rec norm_cname(lfmc_table C, unsigned1 c_count) := TRANSFORM
	self.nameasis := choose(c_count,C.def_company,C.plain_company);
	self := C;
END;

norm_comp := normalize(lfmc_table,2,norm_cname(left,counter));
//sort_comp := sort(norm_comp,nameasis);
dedup_comp := dedup(norm_comp(nameasis <> ''),nameasis,__filepos,ALL);

//st.nameasis

lfmc_rec norm_stcname(dedup_comp L, unsigned1 l_count) := TRANSFORM
	self.st := choose(l_count,L.state,L.l_court_st);
	self := L;
END;

norm_stcomp := normalize(dedup_comp,2,norm_stcname(left,counter));
dedup_stcomp := dedup(norm_stcomp(st <> ''),st,nameasis,__filepos,ALL);

//lfmname.nameasis

lfmc_rec norm_lfmnamasis(dedup_lfm A, unsigned a_count) := TRANSFORM
	self.nameasis := choose(a_count,A.def_company,A.plain_company);
	self := A;
END;

norm_ln := normalize(dedup_lfm,2,norm_lfmnamasis(left,counter));

lfmc_rec norm_lnameasis(norm_ln B,unsigned b_count) :=TRANSFORM
	self.lfnameasis := choose(b_count,B.lfmname,B.nameasis);
	self := B;
END;

norm_lfnameasis := normalize(norm_ln,2,norm_lnameasis(left,counter));
dedup_lfnameasis := dedup(norm_lfnameasis(lfnameasis <> ''),lfnameasis,__filepos,ALL);


// End Normalize


// Begin Tokenize Company name

lfmc_rec dac_comp(dedup_comp D) := TRANSFORM
	self.cn_all := keyLib.GongDacName(D.nameasis);
	self		:= D;
END;

dedup_comp_postdac := project(dedup_comp,dac_comp(left));

lfmc_rec token_cn(dedup_comp_postdac P, unsigned1 cnt) := TRANSFORM
	self.c_tok := choose(cnt, P.cn_all[1..10], P.cn_all[11..20],P.cn_all[21..30],P.cn_all[31..40],
						   P.cn_all[41..50],P.cn_all[51..60],P.cn_all[61..70],P.cn_all[71..80]);
	self := P;
end;

norm_cn := NORMALIZE(dedup_comp_postdac,8,token_cn(left,counter));
//sort_cn := sort(norm_cn,c_tok);
dedup_cn := dedup(norm_cn(c_tok <> ''),c_tok,__filepos,ALL);

//normalize st.cn

lfmc_rec norm_stcn(dedup_cn L, unsigned1 l_count) := TRANSFORM
	self.st := choose(l_count,L.state,L.l_court_st);
	self := L;
END;

norm_scn := normalize(dedup_cn,2,norm_stcn(left,counter));
dedup_scn := dedup(norm_scn(st <> ''),st,c_tok,__filepos,ALL);


// End Tokanize company name

// Begin City from zip - lfmname


lfmc_rec GetCity(dedup_stlfm L) := TRANSFORM
	self.ncitylist := Ziplib.ziptocities(L.zip);
	self := L;
END;

city_rec := project(dedup_stlfm,GetCity(LEFT));

lfmc_rec normcity(lfmc_table n, integer cnt) := TRANSFORM
	self.ncityfromzip := if (cnt = 1, n.p_city_name, stringlib.stringextract(n.ncitylist,cnt));
	self := n
END;

city_records := normalize(city_rec,(INTEGER)Stringlib.StringExtract(LEFT.ncitylist, 1)+1,normcity(left,counter));

// End City from Zip - lfmname

// Begin City from zip - nameasis


lfmc_rec GetCity1(dedup_stcomp L) := TRANSFORM
	self.namcitylist := Ziplib.ziptocities(L.zip);
	self := L;
END;

ncity_rec := project(dedup_stcomp,GetCity1(LEFT));

lfmc_rec normcity1(lfmc_table n, integer cnt) := TRANSFORM
	self.namcityfromzip := if (cnt = 1, n.p_city_name, stringlib.stringextract(n.namcitylist,cnt));
	self := n
END;

ncity_records := normalize(ncity_rec,(INTEGER)Stringlib.StringExtract(LEFT.namcitylist, 1)+1,normcity1(left,counter));

// End City from Zip - nameasis

// Begin City from zip - cn


lfmc_rec GetCity2(dedup_scn L) := TRANSFORM
	self.cncitylist := Ziplib.ziptocities(L.zip);
	self := L;
END;

cncity_rec := project(dedup_scn,GetCity2(LEFT));

lfmc_rec normcity2(lfmc_table n, integer cnt) := TRANSFORM
	self.cncityfromzip := if (cnt = 1, n.p_city_name, stringlib.stringextract(n.cncitylist,cnt));
	self := n
END;

cncity_records := normalize(cncity_rec,(INTEGER)Stringlib.StringExtract(LEFT.cncitylist, 1)+1,normcity2(left,counter));

// End City from Zip - cn


// Begin Dedup

dedup_bdid := dedup(BDIDtable(bdid <> ''),bdid,__filepos,ALL);
dedup_did := dedup(BDIDtable(did <> ''),did,__filepos,ALL);
dedup_ssn := dedup(BDIDtable(ssn_appended <> ''),ssn_appended,__filepos,ALL);
dedup_ud := dedup(BDIDtable(uploaddate <> ''),uploaddate,__filepos,ALL);
dedup_caseno := dedup(BDIDtable(casenumber <> ''),casenumber,__filepos,ALL);
dedup_rmsid := dedup(BDIDtable(rmsid <> ''),rmsid,__filepos,ALL);
dedup_st_caseno := dedup(BDIDtable(court_st <> ''),court_st,casenumber,__filepos,ALL);
dedup_ccbp := dedup(BDIDtable(courtid <> ''),courtid,casenumber,book,page,__filepos,ALL);
dedup_stclf := dedup(city_records(st <> ''),st,ncityfromzip,lfmname,__filepos,ALL);
dedup_stcnam := dedup(ncity_records(st <> ''),st,namcityfromzip,nameasis,__filepos,ALL);
dedup_zcn := dedup(dedup_cn(zip <> ''),zip,c_tok,__filepos,ALL);
dedup_stccn := dedup(cncity_records(st <> ''),st,cncityfromzip,c_tok,__filepos,ALL);
dedup_zppr := dedup(dedup_lfnameasis(zip <> ''),zip,prim_name,prim_range,lfnameasis,__filepos,ALL);
dedup_big := dedup(lfmc_table(zip <> ''),zip,prim_name,suffix,predir,postdir,prim_range,sec_range,__filepos,ALL);

// Build Keys

fposkey := buildindex(dafile,moxie,overwrite);
bdid_key := BUILDINDEX(dedup_bdid,{bdid,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.bdid.key',MOXIE,overwrite);
did_key := BUILDINDEX(dedup_did,{did,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.did.key',MOXIE,overwrite);
ssn_key := BUILDINDEX(dedup_ssn,{ssn_appended,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.ssn.key',MOXIE,overwrite);
ud_key := BUILDINDEX(dedup_ud,{uploaddate,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.uploaddate.key',MOXIE,overwrite);
caseno_key := BUILDINDEX(dedup_caseno,{casenumber,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.casenumber.key',MOXIE,overwrite);
rmsid_key := BUILDINDEX(dedup_rmsid,{rmsid,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.rmsid.key',MOXIE,overwrite);
st_caseno_key := BUILDINDEX(dedup_st_caseno,{court_st,casenumber,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.court_st.casenumber.key',MOXIE,overwrite);
ccbp_key := BUILDINDEX(dedup_ccbp,{courtid,casenumber,book,page,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.courtid.casenumber.book.page.key',MOXIE,overwrite);
lfmname_key := BUILDINDEX(dedup_lfm,{lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.lfmname.key',MOXIE,overwrite);
nameasis_key := BUILDINDEX(dedup_comp,{nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.nameasis.key',MOXIE,overwrite);
stlf_key := BUILDINDEX(dedup_stlfm,{st,lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.st.lfmname.key',MOXIE,overwrite);
stclf_key := BUILDINDEX(dedup_stclf,{st,ncityfromzip,lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.st.city.lfmname.key',MOXIE,overwrite);
stnam_key := BUILDINDEX(dedup_stcomp,{st,nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.st.nameasis.key',MOXIE,overwrite);
stcnam_key := BUILDINDEX(dedup_stcnam,{st,namcityfromzip,nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.st.city.nameasis.key',MOXIE,overwrite);
cn_key := BUILDINDEX(dedup_cn,{c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.cn.key',MOXIE,overwrite);
stcn_key := BUILDINDEX(dedup_scn,{st,c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.st.cn.key',MOXIE,overwrite);
zcn_key := BUILDINDEX(dedup_zcn,{zip,c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.z5.cn.key',MOXIE,overwrite);
stccn_key := BUILDINDEX(dedup_stccn,{st,cncityfromzip,c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.st.city.cn.key',MOXIE,overwrite);
zkey := BUILDINDEX(dedup_zppr,{zip,prim_name,prim_range,lfnameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.z5.prim_name.prim_range.lfmname.key',MOXIE,overwrite);
big_key := BUILDINDEX(dedup_big,{zip,prim_name,suffix,predir,postdir,prim_range,sec_range,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.Liens.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',MOXIE,overwrite);


// End Build Keys


export Liens_Keys := sequential(key1,key2,key3,key4,key5,key6,key7,key8,key9,
								 key10,key11,key12,key13,key14,key15,key16,key17,key18,key19,key20,key21,parallel(fposkey,bdid_key,did_key,ssn_key,ud_key,caseno_key,rmsid_key,st_caseno_key,ccbp_key,lfmname_key),
			parallel(nameasis_key,stlf_key,stclf_key,stnam_key,stcnam_key,cn_key,stcn_key,
			zcn_key,stccn_key,zkey,big_key));