import property,lib_keylib,lib_fileservices,ut;

// Delete the existing keys on thor ****************************************************************

/*DeleteKeys(string KeyFileName)
 :=
  if(lib_fileservices.fileservices.FileExists(KeyFileName),
	 lib_fileservices.FileServices.DeleteLogicalFile(KeyFileName),
	 output(KeyFileName + ' does not exist')
	)
 ;*/
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.big.key',key1);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.did.key',key2);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.fid.recording_date.key',key3);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.lfmname.key',key4);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.nameasis.key',key5);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.prim.cn.key',key6);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.prim.key',key7);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.prim.nameasis.key',key8);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.process_date.key',key9);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.ssn.key',key10);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.city.cn.key',key11);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.city.lfmname.key',key12);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.city.nameasis.key',key13);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.cn.key',key14);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.lfmname.key',key15);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.nameasis.key',key16);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.zip.cn.key',key17);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.zip.lfmname.key',key18);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.zip.nameasis.key',key19);

// Dataset ****************************************************************************************

string_rec := record
	property.Layout_Fares_Foreclosure;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

FC := DATASET('~thor_data400::base::foreclosure', string_rec, thor);

// FID Record set *********************************************************************************

fid_rec := record
	FC.foreclosure_id;
	FC.recording_date;
	FC.__filepos;
END;

FIDtable := table(FC,fid_rec);

// Process date set *******************************************************************************


pd_rec := record
	FC.process_date;
	FC.__filepos;
END;

PDtable := table(FC,pd_rec);

// DID Record set *********************************************************************************

did_rec := record
	FC.name1_did;
	FC.name2_did;
	FC.name3_did;
	FC.name4_did;
	string12 name_did := '';
	FC.__filepos;
END;

DIDtable := table(FC,did_rec);


did_rec FC_did(DIDtable d, unsigned1 did_count) := TRANSFORM
		self.name_did := choose(did_count,d.name1_did,d.name2_did,d.name3_did,d.name4_did);
		self := d;
END;

did_records := NORMALIZE(DIDtable,4,FC_did(left,counter));
did_duped := DEDUP(did_records(name_did <> ''),name_did,__filepos,ALL);


// SSN Record set *********************************************************************************

ssn_rec := record
	FC.name1_ssn;
	FC.name2_ssn;
	FC.name3_ssn;
	FC.name4_ssn;
	string9 name_ssn := '';
	FC.__filepos;
END;

SSNtable := table(FC,ssn_rec);


ssn_rec FC_ssn(SSNtable s, unsigned1 ssn_count) := TRANSFORM
	self.name_ssn := choose(ssn_count,s.name1_ssn,s.name2_ssn,s.name3_ssn,s.name4_ssn);
	self := s;
END;

ssn_records := NORMALIZE(SSNtable,4,FC_ssn(left,counter));
ssn_duped := DEDUP(ssn_records(name_ssn <> ''),name_ssn,__filepos,ALL);

// Lfmname, state, city, zip, prim_name, prim_range - Record set **********************************

lfm_rec := record
	FC.situs1_st;
	FC.situs2_st;
	FC.situs1_p_city_name;
	FC.situs2_p_city_name;
	FC.situs1_zip;
	FC.situs2_zip;
	FC.situs1_prim_range;
	FC.situs2_prim_range;
	FC.situs1_prim_name;
	FC.situs2_prim_name;
	FC.situs1_predir;
	FC.situs1_postdir;
	FC.situs1_addr_suffix;
	FC.situs1_sec_range;
	FC.situs2_predir;
	FC.situs2_postdir;
	FC.situs2_addr_suffix;
	FC.situs2_sec_range;
	FC.name1_last;
	FC.name2_last;
	FC.name3_last;
	FC.name4_last;
	string2 predir := '';
	string2 postdir := '';
	string4 addr_suffix := '';
	string20 name_last := '';
	string8 sec_range := '';
	string2 st := '';
	string5 zip := '';
	string28 prim_name := '';
	string10 prim_range := '';
	string25 city_name := '';
	varstring citylist := '';
	string25 cityfromzip := '';
	string60 lfmname := '';
	string60 lfmname1 := TRIM(FC.name1_last,right) + ' ' + IF(TRIM(FC.name1_first,right) = '', ' ',TRIM(FC.name1_first,right) + ' ') + TRIM(FC.name1_middle,right);
	string60 lfmname2 := TRIM(FC.name2_last,right) + ' ' + IF(TRIM(FC.name2_first,right) = '', ' ',TRIM(FC.name2_first,right) + ' ') + TRIM(FC.name2_middle,right);
	string60 lfmname3 := TRIM(FC.name3_last,right) + ' ' + IF(TRIM(FC.name3_first,right) = '', ' ',TRIM(FC.name3_first,right) + ' ') + TRIM(FC.name3_middle,right);
	string60 lfmname4 := TRIM(FC.name4_last,right) + ' ' + IF(TRIM(FC.name4_first,right) = '', ' ',TRIM(FC.name4_first,right) + ' ') + TRIM(FC.name4_middle,right);
	FC.__filepos;
END;

lfmtable := table(FC,lfm_rec);


// nameasis, cn record set ************************************************************************ 

n_rec := record
	FC.situs1_st;
	FC.situs2_st;
	FC.situs1_p_city_name;
	FC.situs2_p_city_name;
	FC.situs1_zip;
	FC.situs2_zip;
	FC.situs1_prim_range;
	FC.situs2_prim_range;
	FC.situs1_prim_name;
	FC.situs2_prim_name;
	FC.name1_company;
	FC.name2_company;
	FC.name3_company;
	FC.name4_company;
	string2 nst := '';
	string5 nzip := '';
	string28 nprim_name := '';
	string10 nprim_range := '';
	string25 ncity_name := '';
	varstring ncitylist := '';
	varstring cncitylist := '';
	string25 ncityfromzip := '';
	string25 cncityfromzip := '';
	string60 nameasis := '';
	string80 cn_all := '';
	string10 c_tok := '';
	FC.__filepos;
END;

ntable := table(FC,n_rec);

// LFMNAME PLAIN KEY ******************************************************************************

// lfmname - Normalize

lfm_rec FC_lfmname(lfmtable l, unsigned1 lfm_count) := TRANSFORM
	self.lfmname := choose(lfm_count,l.lfmname1,l.lfmname2,l.lfmname3,l.lfmname4);
	self := l;	
END;

lfm_records := NORMALIZE(lfmtable,4,FC_lfmname(left,counter));
lfm_duped := DEDUP(lfm_records(lfmname <> ''),lfmname,__filepos,ALL);

// END LFMNAME PLAIN KEY **************************************************************************

// NAMEASIS PLAIN KEY *****************************************************************************

// nameasis - Normalize

n_rec FC_nameasis(ntable n, unsigned1 nameasis_count) := TRANSFORM
	self.nameasis := choose(nameasis_count,n.name1_company,n.name2_company,n.name3_company,n.name4_company);
	self := n;	
END;

n_records := NORMALIZE(ntable,4,FC_nameasis(left,counter));
n_duped := DEDUP(n_records(nameasis <> ''),nameasis,__filepos,ALL);

// END LFMNAME PLAIN KEY **************************************************************************

// CN PLAIN KEY ***********************************************************************************

// cn - Normalize **** splitting the company name into 8 tokens ****

n_rec dac_it(n_duped blarg) := TRANSFORM
	self.cn_all := keyLib.GongDacName(blarg.nameasis);
	self		:= blarg;
END;

n_duped_postdac := project(n_duped,dac_it(left));

n_rec use_cn(n_duped_postdac blarg, unsigned1 cnt) := TRANSFORM
	self.c_tok := choose(cnt, blarg.cn_all[1..10], blarg.cn_all[11..20],blarg.cn_all[21..30],blarg.cn_all[31..40],
						   blarg.cn_all[41..50],blarg.cn_all[51..60],blarg.cn_all[61..70],blarg.cn_all[71..80]);
	self := blarg;
end;

cn_records := NORMALIZE(n_duped_postdac,8,use_cn(left,counter));
cn_duped := dedup(cn_records(c_tok <> ''),c_tok,__filepos,ALL);

// END CN PLAIN KEY *******************************************************************************


// KEYS FOR LFMNAME *******************************************************************************

// address,prim_name,prim_range normalize for lfmname


lfm_rec FC_lfmstrec(lfm_duped a, unsigned1 addr_count) := TRANSFORM
	self.st := choose(addr_count,a.situs1_st,a.situs2_st);
	self.zip := choose(addr_count,a.situs1_zip,a.situs2_zip);
	self.prim_range := choose(addr_count,a.situs1_prim_range,a.situs2_prim_range);
	self.prim_name := choose(addr_count,a.situs1_prim_name,a.situs2_prim_name);
	self := a;
END;

lfmstr_rec := NORMALIZE(lfm_duped,2,FC_lfmstrec(left,counter));
lfmst_duped := DEDUP(lfmstr_rec,st,zip,prim_range,prim_name,lfmname,__filepos,ALL);


lfm_rec norm_last_name(lfmtable l,unsigned1 name_count) := TRANSFORM
	self.name_last := choose(name_count,l.name1_last,l.name2_last,l.name3_last,l.name4_last);
	self := l;
END;

lname_rec := NORMALIZE(lfmtable,4,norm_last_name(left,counter));

lfm_rec FC_addr(lname_rec a, unsigned1 addr_count) := TRANSFORM
	self.city_name := choose(addr_count,a.situs1_p_city_name,a.situs2_p_city_name);
	self.zip := choose(addr_count,a.situs1_zip,a.situs2_zip);
	self.prim_range := choose(addr_count,a.situs1_prim_range,a.situs2_prim_range);
	self.prim_name := choose(addr_count,a.situs1_prim_name,a.situs2_prim_name);
	self.predir := choose(addr_count,a.situs1_predir,a.situs2_predir);
	self.postdir := choose(addr_count,a.situs1_postdir,a.situs2_postdir);
	self.addr_suffix := choose(addr_count,a.situs1_addr_suffix,a.situs2_addr_suffix);
	self.sec_range := choose(addr_count,a.situs1_sec_range,a.situs2_sec_range);
	self := a;
END;

l_records := NORMALIZE(lname_rec,2,FC_addr(left,counter));
l_duped := DEDUP(l_records,city_name,zip,prim_range,prim_name,predir,postdir,addr_suffix,sec_range,name_last,__filepos,ALL);


// city from zip for lfmname

lfm_rec GetCity(lfmst_duped L) := TRANSFORM
	self.citylist := Ziplib.ziptocities(L.zip);
	self := L;
END;

city_rec := project(lfmst_duped,GetCity(LEFT));

lfm_rec normcity1(lfmtable n, integer cnt) := TRANSFORM
	self.cityfromzip := if (cnt = 1, n.situs1_p_city_name, if (cnt = 2, n.situs2_p_city_name, stringlib.stringextract(n.citylist,cnt)));
	self := n
END;

city_records := normalize(city_rec,(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+2,normcity1(left,counter));

// dedup lfmname keys

lst_duped := dedup(lfmst_duped(st <> ''),st,lfmname,__filepos,ALL);
lst1_duped := dedup(city_records(st <> ''),st,cityfromzip,lfmname,__filepos,ALL);
lzip_duped := dedup(lfmst_duped(zip <> ''),zip,lfmname,__filepos,ALL);
lzip2_duped := dedup(lfmst_duped(zip <> ''),zip,prim_name,prim_range,lfmname,__filepos,ALL);
zip1_duped := dedup(l_duped(zip <> ''),zip,prim_name,predir,postdir,prim_range,addr_suffix,name_last,sec_range,__filepos,ALL);

// END KEYS FOR LFMNAME ***************************************************************************


// KEYS FOR NAMEASIS ******************************************************************************

// address,prim_name,prim_range normalize for nameasis

n_rec FC_naddr(ntable a, unsigned1 naddr_count) := TRANSFORM
	self.nst := choose(naddr_count,a.situs1_st,a.situs2_st);
	self.ncity_name := choose(naddr_count,a.situs1_p_city_name,a.situs2_p_city_name);
	self.nzip := choose(naddr_count,a.situs1_zip,a.situs2_zip);
	self.nprim_range := choose(naddr_count,a.situs1_prim_range,a.situs2_prim_range);
	self.nprim_name := choose(naddr_count,a.situs1_prim_name,a.situs2_prim_name);
	self := a;
END;

nm_records := NORMALIZE(n_duped,2,FC_naddr(left,counter));
nm_duped := DEDUP(nm_records,nst,ncity_name,nzip,nprim_range,nprim_name,nameasis,__filepos,ALL);

// city from zip for nameasis

n_rec nGetCity(nm_duped L) := TRANSFORM
	self.ncitylist := Ziplib.ziptocities(L.nzip);
	self := L;
END;


ncity_rec := project(nm_duped,nGetCity(LEFT));

n_rec normcity2(ntable n, integer cnt) := TRANSFORM
	self.ncityfromzip := if (cnt = 1, n.situs1_p_city_name, if (cnt = 2, n.situs2_p_city_name, stringlib.stringextract(n.ncitylist,cnt)));
	self := n
END;

ncity_records := normalize(ncity_rec,(INTEGER)Stringlib.StringExtract(LEFT.ncitylist, 1)+2,normcity2(left,counter));

// Nameasis keys 

nst_duped := dedup(nm_duped(nst <> ''),nst,nameasis,__filepos,ALL);
nst1_duped := dedup(ncity_records(nst <> ''),nst,ncityfromzip,nameasis,__filepos,ALL);
nzip_duped := dedup(nm_duped(nzip <> ''),nzip,nameasis,__filepos,ALL);
nzip2_duped := dedup(nm_duped(nzip <> ''),nzip,nprim_name,nprim_range,nameasis,__filepos,ALL);

// END KEYS FOR NAMEASIS **************************************************************************


// KEYS FOR COMPANY NAME TOKEN ********************************************************************

// address,prim_name,prim_range normalize for cn

cn1_records := NORMALIZE(cn_duped,2,FC_naddr(left,counter));
cn1_duped := DEDUP(cn1_records,nst,ncity_name,nzip,nprim_range,nprim_name,c_tok,__filepos,ALL);


// city from zip for cn

n_rec cnGetCity(cn1_duped L) := TRANSFORM
	self.cncitylist := Ziplib.ziptocities(L.nzip);
	self := L;
END;


cncity_rec := project(cn1_duped,cnGetCity(LEFT));

n_rec normcity3(ntable n, integer cnt) := TRANSFORM
	self.cncityfromzip := if (cnt = 1, n.situs1_p_city_name, if (cnt = 2, n.situs2_p_city_name, stringlib.stringextract(n.cncitylist,cnt)));
	self := n
END;

cncity_records := normalize(cncity_rec,(INTEGER)Stringlib.StringExtract(LEFT.cncitylist, 1)+2,normcity3(left,counter));

// cn keys

cst_duped := dedup(cn1_duped(nst <> ''),nst,c_tok,__filepos,ALL);
cst1_duped := dedup(cncity_records(nst <> ''),nst,cncityfromzip,c_tok,__filepos,ALL);
czip_duped := dedup(cn1_duped(nzip <> ''),nzip,c_tok,__filepos,ALL);
czip2_duped := dedup(cn1_duped(nzip <> ''),nzip,nprim_name,nprim_range,c_tok,__filepos,ALL);

// END KEYS COMPANY NAME TOKEN ********************************************************************


// BUILDING INDEXES *******************************************************************************


// Building plain Keys 

a := BUILDINDEX(FIDtable,{foreclosure_id,recording_date,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.fid.recording_date.key',MOXIE,overwrite);
b := BUILDINDEX(PDtable,{process_date,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.process_date.key',MOXIE,overwrite);
c := BUILDINDEX(did_duped,{name_did,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.did.key',MOXIE,overwrite);
d := BUILDINDEX(ssn_duped,{name_ssn,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.ssn.key',MOXIE,overwrite);
e := BUILDINDEX(lfm_duped,{lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.lfmname.key',MOXIE,overwrite);
f := BUILDINDEX(n_duped,{nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.nameasis.key',MOXIE,overwrite);

// Building lfmname keys

g := BUILDINDEX(lst_duped,{st,lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.st.lfmname.key',MOXIE,overwrite);
h := BUILDINDEX(lst1_duped,{st,cityfromzip,lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.st.city.lfmname.key',MOXIE,overwrite);
i := BUILDINDEX(lzip_duped,{zip,lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.zip.lfmname.key',MOXIE,overwrite);
j := BUILDINDEX(zip1_duped,{zip,prim_name,predir,postdir,prim_range,addr_suffix,name_last,sec_range,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.big.key',MOXIE,overwrite);
k := BUILDINDEX(lzip2_duped,{zip,prim_name,prim_range,lfmname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.prim.key',MOXIE,overwrite);

// building nameasis keys

l := BUILDINDEX(nst_duped,{nst,nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.st.nameasis.key',MOXIE,overwrite);
m := BUILDINDEX(nst1_duped,{nst,ncityfromzip,nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.st.city.nameasis.key',MOXIE,overwrite);
n := BUILDINDEX(nzip_duped,{nzip,nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.zip.nameasis.key',MOXIE,overwrite);
o := BUILDINDEX(nzip2_duped,{nzip,nprim_name,nprim_range,nameasis,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.prim.nameasis.key',MOXIE,overwrite);

// building company name token keys

p := BUILDINDEX(cst_duped,{nst,c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.st.cn.key',MOXIE,overwrite);
q := BUILDINDEX(cst1_duped,{nst,cncityfromzip,c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.st.city.cn.key',MOXIE,overwrite);
r := BUILDINDEX(czip_duped,{nzip,c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.zip.cn.key',MOXIE,overwrite);
s := BUILDINDEX(czip2_duped,{nzip,nprim_name,nprim_range,c_tok,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.foreclosure.prim.cn.key',MOXIE,overwrite);

// END BUILDING INDEXES

// *********************************************


export Out_Moxie_Foreclosure_Keys := sequential(key1,key2,key3,key4,key5,key6,key7,key8,key9,
												 key10,key11,key12,key13,key14,key15,key16,key17,key18,key19,
												 parallel(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s));


// END CODE

