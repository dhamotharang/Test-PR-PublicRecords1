import prof_license, lib_metaphone, lib_keylib, lib_stringlib;
#workunit ('name', 'Build professional license key');

key_build_rec
 :=
  record
  prof_license.layout_proflic_out;
  unsigned integer8 __fpos{ virtual(fileposition)};
  end
 ;


moxie_file := Prof_License.File_doxie;


base_key_Name := '~thor_data400::key::moxie.prof_licenses.';

searchpattern1 := '^(.*) (.*)-(.*)$';

searchpattern2 := '^(.*) (.*)$';

searchpattern3 := '^(.*)-(.*)$';

var_lname_Rec := record

string20 lname1;
string20 lname2;
string20 lname3;
string20 lname4;

key_build_rec;

end;


var_lname_Rec Normalizelname(moxie_file L,unsigned1 C)
 :=
  transform
  
    self.lname1 := L.lname;
	
	self.lname2	:= if(REGEXFIND(searchpattern1, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern1,trim(L.lname, left, right), 1), 
	               if(REGEXFIND(searchpattern2, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern2,trim(L.lname, left, right), 1),
				   if(REGEXFIND(searchpattern3, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern3,trim(L.lname, left, right), 1),'000000')));
	
	self.lname3	:= if(REGEXFIND(searchpattern1, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern1,trim(L.lname, left, right), 2) +'-' + REGEXFIND(searchpattern1,trim(L.lname, left, right), 3), 
	               if(REGEXFIND(searchpattern2, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern2,trim(L.lname, left, right), 2),
				   if(REGEXFIND(searchpattern3, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern3,trim(L.lname, left, right), 2), '000000')));
    
	self.lname4	:= if(REGEXFIND(searchpattern1, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern1,trim(L.lname, left, right), 2) + '-' + REGEXFIND(searchpattern1,trim(L.lname, left, right), 3) + ' ' + REGEXFIND(searchpattern1,trim(L.lname, left, right), 1),
	               if(REGEXFIND(searchpattern2, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern2,trim(L.lname, left, right), 2) + ' ' + REGEXFIND(searchpattern2,trim(L.lname, left, right), 1),
				   if(REGEXFIND(searchpattern3, trim(L.lname, left, right)) = true, REGEXFIND(searchpattern3,trim(L.lname, left, right), 2) + '-' + REGEXFIND(searchpattern3,trim(L.lname, left, right), 1), '000000')));
	
	self.lname := choose(C, self.lname1, self.lname2, self.lname3, self.lname4);
	self 	:= L;
end;

var_lname_norm	:= normalize(moxie_file,4,Normalizelname(left,counter));

var_lname_file   := var_lname_norm(lname <> '000000');

string SingleSpace(string pString1, string pString2, string pString3='') := 
trim(pString1) + ' ' + if(trim(pString2) = '',' ',trim(pString2) + ' ')+ trim(pString3);

//--build index with lname

lfm_keys_rec  := record

string45 lfmname := SingleSpace(var_lname_file.lname, var_lname_file.fname, var_lname_file.mname);	
var_lname_file.__fpos;
end;
	
lfm_keys_file := table(var_lname_file, lfm_keys_rec); 

//--build index with simple fields
simple_keys_rec := record

moxie_file.did;
moxie_file.best_ssn;
string20 license_number := StringLib.stringfilterout(moxie_file.license_number, '-');
moxie_file.source_st;
moxie_file.date_last_seen;
string60 vendor  := stringlib.stringtouppercase(stringlib.StringCleanSpaces80(moxie_file.vendor));
//string45 lfmname := SingleSpace(var_lname_file.lname, var_lname_file.fname, var_lname_file.mname);		
												 
string5  z5      := moxie_file.Zip;
string4  suffix  := moxie_file.suffix;
moxie_file.Prim_Name;
moxie_file.PreDir;
moxie_file.PostDir;
moxie_file.Prim_Range;
moxie_file.Sec_Range;	
moxie_file.profession_or_board;
moxie_file.__fpos;
end;

simple_keys_file := table(moxie_file, simple_keys_rec);

// -- BUILD SIMPLE KEYS

K01 := buildindex(simple_keys_file(DID<>''),{DID,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'did.key',moxie,overwrite);
K02 := buildindex(simple_keys_file(best_SSN<>''),{best_SSN,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'ssn.key',moxie,overwrite);
K03 := buildindex(simple_keys_file(license_number<>''),{license_number,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'license_number.key',moxie,overwrite);
K04 := buildindex(lfm_keys_file(lfmname<>''),{lfmname,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'lfmname.key',moxie,overwrite);								
K05 := buildindex(simple_keys_file(Z5+Prim_name+suffix+PreDir+PostDir+Prim_Range+Sec_Range<>''),
                {Z5,prim_Name,suffix,PreDir,PostDir,Prim_Range,Sec_Range,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',moxie,overwrite);
K06 := buildindex(simple_keys_file(Z5+Prim_Name+Prim_Range<>''),{Z5,Prim_Name,Prim_Range,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'z5.prim_name.prim_range.key',moxie,overwrite);								
K07 := buildindex(simple_keys_file(source_st+vendor+date_last_seen<>''),{source_st,vendor,date_last_seen,profession_or_board,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'source_st.vendor.date_last_seen.profession_or_board.key',moxie,overwrite);	
								
// -- BUILD PERSONAL NAME ADDRESS KEYS

pAddress_Keys_Rec
 :=
  record
	  var_lname_file.st;
		var_lname_file.source_st;
		var_lname_file.lname;
    string2 	  st2				:= '';	
    string25		city	:= var_lname_file.p_City_Name;
	  varstring		ZipToCityList := ZipLib.ZipToCities(var_lname_file.Zip);
    string45    lfmname := SingleSpace(var_lname_file.lname, var_lname_file.fname, var_lname_file.mname);		
	  var_lname_file.__fpos;
  end
 ;

pAddress_Keys_Table := table(var_lname_file, pAddress_Keys_Rec);

pAddress_Keys_Rec NormalizeSt(pAddress_Keys_Rec L,unsigned1 C)
 :=
  transform
	self.st2	:= choose(C, L.st, L.source_st);
	self 	:= L;
end;

pAddress_St_Keys_File	:= normalize(PAddress_Keys_Table,2,NormalizeSt(left,counter));
pSt_Keys_Dist		:= distribute(pAddress_St_Keys_File,hash(st2,lname,__fpos));
pSt_Keys_Sort		:= sort(pSt_Keys_Dist(st2<>''),st2,lname,__fpos,local);	
pSt_Keys_Dedup	  := dedup(pSt_Keys_Sort,st2,lname,__fpos,local);

K08 := buildindex(pSt_Keys_Dedup,{St2,LFMName,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'st2.lfmname.key',moxie,overwrite);

pAddress_Keys_Rec NormalizeCities(pAddress_Keys_Table L,integer C)
 :=
  transform
	self.city	:= if(C=1,L.City,stringlib.stringextract(L.ZipToCityList,C));
	self 		  := L;
  end
 ;
 
pAddress_City_Keys_File	:= normalize(pAddress_Keys_Table,
									 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
									 NormalizeCities(left,counter)
									);
pAddress_City_Keys_Dist	:= distribute(pAddress_City_Keys_File, hash(City,St,LFMName,__fpos));
pAddress_City_Keys_Sort	:= sort(pAddress_City_Keys_Dist,City,St,LFMName,__fpos, local);
pAddress_City_Keys_Dedup	:= dedup(pAddress_City_Keys_Sort,City,St,LFMName,__fpos,local);

K09 := buildindex(pAddress_City_Keys_Dedup(St<>''),{St,City,LFMName,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'st.city.lfmname.key',moxie,overwrite);


//--BUILD DPHLNAME KEYS	
										 
DPHLName_Keys_Rec
 :=
  record
	var_lname_file.st;
	var_lname_file.source_st;
	string5 z5 := var_lname_file.zip;
	var_lname_file.lname;
	var_lname_file.fname;
	var_lname_file.mname;
	string2		st2 := '';
    string25	city	:= var_lname_file.p_City_Name;
	varstring	ZipToCityList := ZipLib.ZipToCities(var_lname_file.Zip);
    string45    lfmname := SingleSpace(var_lname_file.lname, var_lname_file.fname, var_lname_file.mname);				
    string6		dph_lname := '';
    var_lname_file.__fpos;
  end
 ;

DPHLName_Keys_Table := table(var_lname_file,DPHLName_Keys_Rec);

DPHLName_Keys_Rec NormalizeDPHLNames(DPHLName_Keys_Rec L,unsigned1 C)
 :=
  TRANSFORM
	self.dph_lname := choose(C,
							 metaphonelib.DMetaPhone1(L.lname),
							 metaphonelib.DMetaPhone2(L.lname)
							);
	self := L;
end;

DPHLName_Keys_File := normalize(DPHLName_Keys_Table,2,NormalizeDPHLNames(left,Counter));
DPHLName_Keys_DeDup := dedup(DPHLName_Keys_File(dph_lname <> ''),dph_lname,fname,mname,lname,__fpos,all);
DPHLName_z5_Keys_DeDup := dedup(DPHLName_Keys_File(dph_lname <> ''),z5,dph_lname,fname,mname,lname,__fpos,all);

k10 := buildindex(DPHLName_Keys_DeDup(dph_lname+fname+mname+lname<>''),{DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'dph_lname.fname.mname.lname.key',moxie,overwrite);
k11 := buildindex(DPHLName_Keys_Table(z5+LFMName<>''),{z5,LFMName,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'z5.lfmname.key',moxie,overwrite);
k12 := buildindex(DPHLName_z5_Keys_DeDup(Z5+DPH_LName+FName+MName+LName<>''),{Z5,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'z5.dph_lname.fname.mname.lname.key',moxie,overwrite);
							
DPHLName_Keys_Rec NormalizeStDph(DPHLName_Keys_Rec L,unsigned1 C)
 :=
  TRANSFORM
	self.st2	:= choose(C,L.st,L.source_st);
	self 		  := L;
end;

St_DPHLName_Keys_File 	:= normalize(DPHLName_Keys_File,2,NormalizeStDph(left,Counter));
St_DPHLName_Keys_DeDup	:= dedup(St_DPHLName_Keys_File,St2,DPH_LName,lname,fname,mname,__fpos,all);

k13 := buildindex(St_DPHLName_Keys_DeDup(St2+DPH_LName+lname+fname+mname <> ''),{St2,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'st2.dph_lname.fname.mname.lname.key',moxie,overwrite);
								
DPHLName_Keys_Rec NormalizeCitiesDPH(DPHLName_Keys_Rec L,integer C)
 :=
  transform
	self.city	:= if(C = 1, L.City,stringlib.stringextract(L.ZipToCityList,C));
	self 		  := L;
  end
 ;								
								
City_DPHLName_Keys_File 	:= normalize(DPHLName_Keys_File,
										 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
										 NormalizeCitiesDPH(left,counter)
										);
City_DPHLName_Keys_dist	  := distribute(City_DPHLName_Keys_File,hash(St,City,DPH_LName,FName,MName,LName,__fpos));
City_DPHLName_Keys_sort	  := sort(City_DPHLName_Keys_dist,St,City,DPH_LName,FName,MName,LName,__fpos, local);
City_DPHLName_Keys_dedup  := dedup(City_DPHLName_Keys_sort,St,City,DPH_LName,FName,MName,LName,__fpos,local);

k14 := buildindex(City_DPHLName_Keys_dedup(St+City+DPH_LName+FName+MName+LName<>''),{St,City,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'st.city.dph_lname.fname.mname.lname.key',moxie,overwrite);


//--BUILD NAMEASSIS KEYS

nameasis_keys_rec := record

	moxie_file.st;
	moxie_file.source_st;
	//moxie_file.lname;
	string5  z5 := moxie_file.zip;
	string30 nameasis := KeyLib.CompNameNoSyn(moxie_file.company_name);
	string2	    st2 := '';
	string25		city	:= moxie_file.p_City_Name;
	varstring		ZipToCityList := ZipLib.ZipToCities(moxie_file.Zip);
	moxie_file.__fpos;
end;

nameasis_keys_table := table(moxie_file, nameasis_keys_rec);

k15 := buildindex(nameasis_keys_table(nameasis <>''),{nameasis,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'nameasis.key',moxie,overwrite);

k16 := buildindex(nameasis_keys_table(z5 + nameasis <>''),{z5,nameasis,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'z5.nameasis.key',moxie,overwrite);
															
nameasis_keys_rec 	NormalizeStNameasis(nameasis_keys_rec L, unsigned1 C)	

:= transform
	self.st2	:= choose(C, L.st, L.source_st);
	self 	:= L;
end;

Nameasis_St_Keys_File	:= normalize(nameasis_keys_table,2,NormalizeStNameasis(left,counter));
Nameasis_St_Keys_Dist		:= distribute(Nameasis_St_Keys_File,hash(st2,nameasis,__fpos));
Nameasis_St_Keys_Sort		:= sort(Nameasis_St_Keys_Dist(st2<>''),st2,nameasis,__fpos,local);	
Nameasis_St_Keys_Dedup	  := dedup(Nameasis_St_Keys_Sort,st2,nameasis,__fpos,local);

K17 := buildindex(Nameasis_St_Keys_Dedup(st2 + nameasis <>''),{St2,nameasis,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'st2.nameasis.key',moxie,overwrite);

nameasis_keys_rec NormalizeCitiesNameasis(nameasis_keys_rec L,integer C)
 :=
  transform
	self.city	:= if(C=1,L.City,stringlib.stringextract(L.ZipToCityList,C));
	self 		  := L;
  end
 ;
 
nameasis_City_Keys_File	:= normalize(nameasis_keys_table,
									 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
									 NormalizeCitiesNameasis(left,counter)
									);
nameasis_City_Keys_Dist	:= distribute(nameasis_City_Keys_File, hash(St,City,nameasis,__fpos));
nameasis_City_Keys_Sort	:= sort(nameasis_City_Keys_Dist,St,City,nameasis,__fpos, local);
nameasis_City_Keys_Dedup	:= dedup(nameasis_City_Keys_Sort,St,City,nameasis,__fpos,local);

K18 := buildindex(nameasis_City_Keys_Dedup(St + city + nameasis <>''),{St,City,nameasis,
								(big_endian unsigned8)__fpos},
								base_key_Name + 'st.city.nameasis.key',moxie,overwrite);


//--BUILD CN PCN KEYS

cn_pcn_keys_rec := record

	moxie_file.st;
	moxie_file.source_st;
	//var_lname_file.lname;
	string5     z5     := moxie_file.zip;
	string80    cn_all := keyLib.GongDacName(moxie_file.company_name);
	string10    cn     := '';
	string40    pcn_all := keyLib.GongDaphcName(moxie_file.company_name);
	string5     pcn    := '';
	string2	    st2    := '';
	string25		city	 := moxie_file.p_City_Name;
	varstring		ZipToCityList := ZipLib.ZipToCities(moxie_file.Zip);
	moxie_file.__fpos;
end;

CN_PCN_keys_Table := table(moxie_file, cn_pcn_keys_rec);

//--BUILD CN ONLY KEYS
cn_pcn_keys_rec Normlizecn(cn_pcn_keys_rec L, integer C) := transform
	self.cn := choose(C, L.cn_all[1..10], L.cn_all[11..20],L.cn_all[21..30],
						L.cn_all[31..40],L.cn_all[41..50],L.cn_all[51..60],
						L.cn_all[61..70],L.cn_all[71..80]);
	self := L;
end;

cn_keys_file := NORMALIZE(CN_PCN_keys_Table, 8,Normlizecn(LEFT, COUNTER));

cn_keys_dedup := dedup(cn_keys_file(cn <> ''), cn,__fpos,all);

cn_z5_keys_dedup := dedup(cn_keys_file(z5 + cn <> ''), z5,cn,__fpos,all);

k19 := BUILDINDEX(cn_keys_dedup, {cn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'cn.key', moxie,overwrite);
			
k20 := BUILDINDEX(cn_z5_keys_dedup, {z5,cn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'z5.cn.key', moxie,overwrite);
			
//--BUILD CN ADDRESS KEYS 			
			
cn_pcn_Keys_Rec NormalizeStCn(cn_pcn_Keys_Rec L,unsigned1 C)
 :=
  TRANSFORM
	self.st2	:= choose(C,L.st,L.source_st);
	self 		  := L;
end;

Cn_St_Keys_File 	:= normalize(cn_keys_file,2,NormalizeStCn(left,Counter));
Cn_St_Keys_DeDup	:= dedup(Cn_St_Keys_File(st2 + cn <> ''),St2,cn,__fpos,all);
	
k21 := BUILDINDEX(Cn_St_Keys_DeDup, {st2,cn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'st2.cn.key', moxie,overwrite);
			
cn_pcn_keys_rec NormalizeCitiesCn(cn_pcn_keys_rec L,integer C)
 :=
  transform
	self.city	:= if(C=1,L.City,stringlib.stringextract(L.ZipToCityList,C));
	self 		  := L;
  end
 ;
 
cn_City_Keys_File	:= normalize(cn_keys_file,
									 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
									 NormalizeCitiesCn(left,counter)
									);	
									
cn_City_Keys_Dedup	:= dedup(cn_City_Keys_File(st + city + cn <> ''),St,City,cn,__fpos,all);
			
k22 := BUILDINDEX(cn_City_Keys_Dedup, {st,city,cn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'st.city.cn.key', moxie,overwrite);

//--BUILD PCN ONLY KEYS

cn_pcn_keys_rec Normlizepcn(cn_pcn_keys_rec L, integer C) := transform
	self.pcn := choose(C,l.pcn_all[1..5], l.pcn_all[6..10],l.pcn_all[11..15],l.pcn_all[16..20],
						   l.pcn_all[21..25],l.pcn_all[26..30],l.pcn_all[31..35],l.pcn_all[36..40]);
	self := L;
end;

pcn_keys_file := NORMALIZE(CN_PCN_keys_Table, 8, Normlizepcn(LEFT, COUNTER));

pcn_keys_dedup := dedup(pcn_keys_file(pcn <> ''), pcn, __fpos, all);

pcn_z5_keys_dedup := dedup(pcn_keys_file(z5 + pcn <> ''), z5, pcn, __fpos, all);


k23 := BUILDINDEX(pcn_keys_dedup, {pcn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'pcn.key', moxie,overwrite);
			
k24 := BUILDINDEX(pcn_z5_keys_dedup, {z5,pcn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'z5.pcn.key', moxie,overwrite);
			
//--BUILD PCN ADDRESS KEYS 			
			
cn_pcn_Keys_Rec NormalizeStPcn(cn_pcn_Keys_Rec L,unsigned1 C)
 :=
  TRANSFORM
	self.st2	:= choose(C,L.st,L.source_st);
	self 		  := L;
end;

Pcn_St_Keys_File 	:= normalize(pcn_keys_file,2,NormalizeStPcn(left,Counter));
Pcn_St_Keys_DeDup	:= dedup(Pcn_St_Keys_File(st2 + pcn <> ''),St2,pcn, __fpos,all);
	
k25 := BUILDINDEX(Pcn_St_Keys_DeDup, {st2,pcn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'st2.pcn.key', moxie,overwrite);
			
cn_pcn_keys_rec NormalizeCitiesPcn(cn_pcn_keys_rec L,integer C)
 :=
  transform
	self.city	:= if(C=1,L.City,stringlib.stringextract(L.ZipToCityList,C));
	self 		  := L;
  end
 ;
 
pcn_City_Keys_File	:= normalize(pcn_keys_file,
									 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
									 NormalizeCitiesCn(left,counter)
									);	
									
pcn_City_Keys_Dedup	:= dedup(pcn_City_Keys_File(st + city + pcn <> ''),St,City,pcn,__fpos,all);
			
k26 := BUILDINDEX(cn_City_Keys_Dedup, {st,city,pcn,(big_endian unsigned8 )__fpos},
				base_key_Name + 'st.city.pcn.key', moxie,overwrite);


export proc_build_moxie_keys := parallel(
			k01
		   ,k02
		   ,k03
		   ,k04
		   ,k05
		   ,k06
		   ,k07
		   ,k08
		   ,k09
		   ,k10
		   ,k11
		   ,k12
		   ,k13
		   ,k14
		   ,k15
		   ,k16
		   ,k17
		   ,k18
		   ,k19
		   ,k20
		   ,k21
		   ,k22
		   ,k23
		   ,k24
		   ,k25
		   ,k26
		   )
 ;

