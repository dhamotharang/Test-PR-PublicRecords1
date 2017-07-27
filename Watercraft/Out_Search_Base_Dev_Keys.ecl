/*Now (tkirk)
Text In Open Window
*/
import lib_keylib, lib_stringlib, lib_metaphone, watercraft, watercraft_umf;

lBaseKeyName := 'key::moxie.watercraft_search.';

string lSingleSpace(string pString1, string pString2, string pString3='')
 := trim(pString1) + ' '
  + if(trim(pString2) = '',
	   ' ',
	   trim(pString2) + ' '
	  )
  + trim(pString3)
 ;

dMoxieFileForKeybuild := Watercraft.File_Base_Search_Dev_Plus;

rSimpleKeysTableRecord
 :=
  record
    dMoxieFileForKeybuild.state_origin;
	dMoxieFileForKeybuild.watercraft_key;
	dMoxieFileForKeybuild.sequence_key;
	dMoxieFileForKeybuild.DID;
	dMoxieFileForKeybuild.SSN;
	dMoxieFileForKeybuild.BDID;
	dMoxieFileForKeybuild.FEIN;
    dMoxieFileForKeybuild.DOB;
    dMoxieFileForKeybuild.Zip5;
    dMoxieFileForKeybuild.Prim_Name;
    dMoxieFileForKeybuild.PreDir;
    dMoxieFileForKeybuild.PostDir;
    dMoxieFileForKeybuild.Prim_Range;
    dMoxieFileForKeybuild.Sec_Range;
	dMoxieFileForKeybuild.Suffix;
	dMoxieFileForKeybuild.LName;
    string45        lfmname := lSingleSpace(dMoxieFileForKeybuild.lname,
											dMoxieFileForKeybuild.fname,
											dMoxieFileForKeybuild.mname
										   );
    string30        mfname  := lSingleSpace(dMoxieFileForKeybuild.mname,
											dMoxieFileForKeybuild.fname
										   );
    string45        fmlname := lSingleSpace(dMoxieFileForKeybuild.fname,
											dMoxieFileForKeybuild.mname,
											dMoxieFileForKeybuild.lname
										   );
	string28		street_name := dMoxieFileForKeybuild.Prim_Name;
	dMoxieFileForKeybuild.__filepos;
  end
 ;

lSimpleKeysTable := table(dMoxieFileForKeybuild,rSimpleKeysTableRecord);

k01 := buildindex(lSimpleKeysTable(watercraft_key<>''),{watercraft_key,sequence_key,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'watercraft_key.sequence_key.key',moxie,overwrite);
k02 := buildindex(lSimpleKeysTable(watercraft_key<>''),{state_origin,watercraft_key,sequence_key,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'state_origin.watercraft_key.sequence_key.key',moxie,overwrite);
k03 := buildindex(lSimpleKeysTable(DID<>''),{DID,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'did.key',moxie,overwrite);
k04 := buildindex(lSimpleKeysTable(SSN<>''),{SSN,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'ssn.key',moxie,overwrite);
k05 := buildindex(lSimpleKeysTable(bdid<>''),{bdid,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'bdid.key',moxie,overwrite);
k06 := buildindex(lSimpleKeysTable(fein<>''),{fein,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'fein.key',moxie,overwrite);
k07 := buildindex(lSimpleKeysTable(LFMName<>''),{LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'lfmname.key',moxie,overwrite);
k08 := buildindex(lSimpleKeysTable(DOB+LFMName<>''),{DOB,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.lfmname.key',moxie,overwrite);
k09 := buildindex(lSimpleKeysTable(MFName+DOB<>''),{MFName,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'mfname.dob.key',moxie,overwrite);
k10 := buildindex(lSimpleKeysTable(DOB+FMLName<>''),{DOB,FMLName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.fmlname.key',moxie,overwrite);
k11 := buildindex(lSimpleKeysTable(Zip5+LFMName<>''),{Zip5,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.lfmname.key',moxie,overwrite);
k12 := buildindex(lSimpleKeysTable(Zip5+Street_Name+Suffix+PreDir+PostDir+Prim_Range+LName+Sec_Range<>''),{Zip5,Street_Name,Suffix,PreDir,PostDir,Prim_Range,LName,Sec_Range,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.street_name.suffix.predir.postdir.prim_range.lname.sec_range.key',moxie,overwrite);
k13 := buildindex(lSimpleKeysTable(Zip5+Street_Name+Suffix+PreDir+PostDir+Prim_Range+Sec_Range<>''),{Zip5,Street_Name,Suffix,PreDir,PostDir,Prim_Range,Sec_Range,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.street_name.suffix.predir.postdir.prim_range.sec_range.key',moxie,overwrite);
k14 := buildindex(lSimpleKeysTable(Zip5+Prim_Name+Prim_Range<>''),{Zip5,Prim_Name,Prim_Range,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.prim_name.prim_range.key',moxie,overwrite);
k15 := buildindex(lSimpleKeysTable(Zip5+Prim_Name+suffix+predir+postdir+Prim_Range+sec_range<>''),{Zip5,Prim_Name,suffix,predir,postdir,prim_range,sec_range,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',moxie,overwrite);
k16 := buildindex(lSimpleKeysTable(Zip5+Prim_Name+suffix+predir+postdir+Prim_Range+sec_range+lfmname+ssn<>''),{Zip5,Prim_Name,suffix,predir,postdir,prim_range,sec_range,lfmname,ssn,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.key',moxie,overwrite);

/*
	Street_Name and Prim_Name are the same length, but for naming
	consistency within the key, I duplicate here rather than have
	any confusion over the proper field being used in the key
*/
rAddressKeysTableRecord
 :=
  record
    dMoxieFileForKeybuild.St;
    dMoxieFileForKeybuild.Zip5;
    string13		city	:= dMoxieFileForKeybuild.V_City_Name[1..13];
	varstring		ZipToCityList := ZipLib.ZipToCities(dMoxieFileForKeybuild.Zip5);
	string28		street_name := dMoxieFileForKeybuild.Prim_Name;
    dMoxieFileForKeybuild.Prim_Name;
    dMoxieFileForKeybuild.Prim_Range;
    string45        lfmname := lSingleSpace(dMoxieFileForKeybuild.lname,
											dMoxieFileForKeybuild.fname,
											dMoxieFileForKeybuild.mname
										   );
	dMoxieFileForKeybuild.__filepos;
  end
 ;

lAddressKeysTable := table(dMoxieFileForKeybuild,rAddressKeysTableRecord);

rAddressKeysTableRecord tNormalizeAddressKeysCities(rAddressKeysTableRecord pInput,integer pCounter)
 :=
  transform
	self.city	:= if(pCounter=1,pInput.City,stringlib.stringextract(pInput.ZipToCityList,pCounter));
	self		:= pInput;
  end
 ;
 
dAddressKeysNormCity	:= normalize(lAddressKeysTable,
									 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
									 tNormalizeAddressKeysCities(left,counter)
									);
dAddressKeysNormDist	:= distribute(dAddressKeysNormCity, hash(City,St,LFMName,__filepos));
dAddressKeysNormSort	:= sort(dAddressKeysNormDist,City,St,LFMName,__filepos, local);
dAddressKeysNormDedup	:= dedup(dAddressKeysNormSort,City,St,LFMName,__filepos,local);

k17 := buildindex(dAddressKeysNormDedup(St+City+LFMName<>''),{St,City,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.lfmname.key',moxie,overwrite);

dAddressKeysNormLongDist	:= distribute(dAddressKeysNormCity, hash(St,Prim_Name,Prim_Range,LFMName,City,__filepos));
dAddressKeysNormLongSort	:= sort(dAddressKeysNormLongDist,St,Prim_Name,Prim_Range,LFMName,City,__filepos, local);
dAddressKeysNormLongDedup	:= dedup(dAddressKeysNormSort,St,Prim_Name,Prim_Range,LFMName,City,__filepos,local);

k18 := buildindex(dAddressKeysNormLongDedup(St+Prim_Name+Prim_Range+LFMName+City<>''),{St,Prim_Name,Prim_Range,LFMName,City,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.prim_name.prim_range.lfmname.city.key',moxie,overwrite);

rDPHLNameKeysTableRecord
 :=
  record
	dMoxieFileForKeybuild.DID;
    dMoxieFileForKeybuild.St;
	dMoxieFileForKeybuild.State_Origin;
    dMoxieFileForKeybuild.Zip5;
    string13		city	:= dMoxieFileForKeybuild.V_City_Name[1..13];
	varstring		ZipToCityList := ZipLib.ZipToCities(dMoxieFileForKeybuild.Zip5);
	dMoxieFileForKeybuild.LName;
	dMoxieFileForKeybuild.FName;
	dMoxieFileForKeybuild.MName;
	dMoxieFileForKeybuild.DOB;
	dMoxieFileForKeybuild.County;
	string4			dob_year  := if((integer) (dMoxieFileForKeybuild.dob[1..4]) <> 0,
									dMoxieFileForKeybuild.dob[1..4],
									''
								   );
	string2			dob_month := if((integer) (dMoxieFileForKeybuild.dob[5..6]) <> 0,
									dMoxieFileForKeybuild.dob[5..6],
									''
								   );
	string6			dph_lname := '';
    string45        lfmname := lSingleSpace(dMoxieFileForKeybuild.lname,
											dMoxieFileForKeybuild.fname,
											dMoxieFileForKeybuild.mname
										   );
	dMoxieFileForKeybuild.__filepos;
  end
 ;

rDPHLNameKeysTableRecord tNormalizeDPHLNames(rDPHLNameKeysTableRecord pInput,unsigned1 pCounter)
 :=
  TRANSFORM
	self.dph_lname := choose(pCounter,
							 metaphonelib.DMetaPhone1(pInput.LName),
							 metaphonelib.DMetaPhone2(pInput.LName)
							);
	self := pInput;
end;

lDPHLNameKeysTable := table(dMoxieFileForKeybuild,rDPHLNameKeysTableRecord);
lDPHLNameKeysTableNorm := normalize(lDPHLNameKeysTable,2,tNormalizeDPHLNames(left,Counter));
lDPHLNameKeysTableDeDuped := dedup(lDPHLNameKeysTableNorm,DPH_LName,__filepos,all);
/* Doesn't like this distribute/dedup.  Not necessary, just thought more efficient
//lDPHLNameKeysTableDist := distribute(lDPHLNameKeysTableNorm,hash(DPH_LName+__filepos));
//lDPHLNameKeysTableDeDuped := dedup(lDPHLNameKeysTableDist,DPH_LName,__filepos,local);
*/

k19 := buildindex(lDPHLNameKeysTableDeDuped(St+County+LFMName<>''),{St,County,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.county.lfmname.key',moxie,overwrite);
k20 := buildindex(lDPHLNameKeysTableDeDuped(St+County+dph_lname+fname+mname+lname+dob<>''),{St,County,DPH_LName,FName,MName,LName,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.county.dph_lname.fname.mname.lname.dob.key',moxie,overwrite);
k21 := buildindex(lDPHLNameKeysTableDeDuped(Zip5+DPH_LName+FName+MName+LName<>''),{Zip5,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.dph_lname.fname.mname.lname.key',moxie,overwrite);
k22 := buildindex(lDPHLNameKeysTableDeDuped(DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
k23 := buildindex(lDPHLNameKeysTableDeDuped(DPH_LName+FName+MName+LName<>''),{DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dph_lname.fname.mname.lname.key',moxie,overwrite);

rStDPHLNameKeysRecord
 :=
  record
	lDPHLNameKeysTableDeDuped.st;
	lDPHLNameKeysTableDeDuped.state_origin;
	lDPHLNameKeysTableDeDuped.dph_lname;
	lDPHLNameKeysTableDeDuped.fname;
	lDPHLNameKeysTableDeDuped.mname;
	lDPHLNameKeysTableDeDuped.lname;
	lDPHLNameKeysTableDeDuped.lfmname;
	lDPHLNameKeysTableDeDuped.dob_year;
	lDPHLNameKeysTableDeDuped.dob_month;
	lDPHLNameKeysTableDeDuped.__filepos;
	string2		st2 := '';
  end
 ;

dStDPHLNameKeysTable 		:= table(lDPHLNameKeysTableDeDuped,rStDPHLNameKeysRecord);

rStDPHLNameKeysRecord tNormalizeStDph(dStDPHLNameKeysTable pInput,unsigned1 pCounter)
 :=
  TRANSFORM
	self.st2	:= choose(pCounter,
						  pInput.st,
						  pInput.state_origin
						 );
	self 		:= pInput;
end;

dStDPHLNameKeysTableNorm 	:= normalize(dStDPHLNameKeysTable,2,tNormalizeStDph(left,Counter));
dStDPHLNameKeysTableDeDuped	:= dedup(dStDPHLNameKeysTableNorm,St,DPH_LName,lname,fname,mname,__filepos,all);

k24 := buildindex(dStDPHLNameKeysTableDeDuped(St2+DPH_LName+FName+MName+LName<>''),{St2,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dph_lname.fname.mname.lname.key',moxie,overwrite);
k25 := buildindex(dStDPHLNameKeysTableDeDuped(St2+DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{St2,DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
k26 := buildindex(dStDPHLNameKeysTableDeDuped(St2+LFMName<>''),{St2,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.lfmname.key',moxie,overwrite);

rDPHLNameKeysTableRecord tNormalizeDPHLNameKeysCities(rDPHLNameKeysTableRecord pInput,integer pCounter)
 :=
  transform
	self.city	:= if(pCounter=1,pInput.City,stringlib.stringextract(pInput.ZipToCityList,pCounter));
	self		:= pInput;
  end
 ;

dDPHLNameKeysTableNormCity	:= normalize(lDPHLNameKeysTableDeDuped,
										 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
										 tNormalizeDPHLNameKeysCities(left,counter)
										);
dDPHLNameKeysTableNormDist	:= distribute(dDPHLNameKeysTableNormCity,hash(St,City,DPH_LName,FName,MName,LName,__filepos));
dDPHLNameKeysTableNormSort	:= sort(dDPHLNameKeysTableNormDist,St,City,DPH_LName,FName,MName,LName,__filepos, local);
dDPHLNameKeysTableNormDedup	:= dedup(dDPHLNameKeysTableNormSort,St,City,DPH_LName,FName,MName,LName,__filepos,local);

k27 := buildindex(dDPHLNameKeysTableNormDedup(St+City+DPH_LName+FName+MName+LName<>''),{St,City,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.dph_lname.fname.mname.lname.key',moxie,overwrite);




//Pulled From VehLic****************************************************************************************************
nameasis_rec := record
	string5 z5 := '';
	string60 nameasis := '';
	string10 cn := '';
	string80 cn_source := '';
	string2	 st2 := '';
	string25 city := '';
	varstring		ZipToCityList :='';
	dMoxieFileForKeybuild.st;
	dMoxieFileForKeybuild.State_Origin;
	dMoxieFileForKeybuild.__filepos;
end;

nameasis_rec use_nameasis(dMoxieFileForKeybuild l) := TRANSFORM
	self.nameasis := Lib_KeyLib.KeyLib.KeylibStripPunctuation(l.company_name);
	self.cn_source := Lib_KeyLib.KeyLib.GongDacName(self.nameasis);
	self.city := l.p_city_name;
	self.cn := '';
	self := l;
end;

dNameAsIs := dMoxieFileForKeybuild(lname='' and company_name<>'');
nameasis_n := project(dNameAsIs,use_nameasis(left));

k28 := buildindex(nameasis_n,{nameasis,(big_endian unsigned8 )__filepos},
			lBaseKeyName + 'nameasis.key',moxie,overwrite);

nameasis_rec	tStNameAsIsNorm(nameasis_n pInput, unsigned1 pCounter)
 :=
  transform
	self.st2	:= choose(pCounter,
						  pInput.st,
						  pInput.state_origin
						 );
	self		:= pInput;
  end
 ;

StNameAsIsNorm	:= NORMALIZE(nameasis_n,2,tStNameAsIsNorm(left,counter));
StnameasisDedup	:= DEDUP(StNameAsIsNorm(nameasis<>''),st2,nameasis,__filepos,all);

k29 := buildindex(StnameasisDedup,{st2,nameasis,(big_endian unsigned8 )__filepos},
			lBaseKeyName + 'st.nameasis.key',moxie,overwrite);

nameasis_rec tcn_from_cn_source1(nameasis_rec pInput, unsigned1 pCounter)
 :=
  transform
	self.cn	:= choose(pCounter,
					  pInput.cn_source[01..10],
					  pInput.cn_source[11..20],
					  pInput.cn_source[21..30],
					  pInput.cn_source[31..40],
					  pInput.cn_source[41..50],
					  pInput.cn_source[51..60],
					  pInput.cn_source[61..70],
					  pInput.cn_source[71..80]
					 );
	self	:= pInput;
  end
 ;

cn_from_nameasis1			:= normalize(nameasis_n,8,tcn_from_cn_source1(left,counter));
cn_from_nameasis1_dedup 	:= dedup(cn_from_nameasis1(cn<>''),cn,__filepos,all);
cn_st_from_nameasis1		:= normalize(StnameasisDedup,8,tcn_from_cn_source1(left,counter));
cn_st_from_nameasis1_dedup	:= dedup(cn_st_from_nameasis1(cn<>''),st,cn,__filepos,all);

k30 := buildindex(cn_from_nameasis1_dedup,{cn,(big_endian unsigned8 )__filepos},
			lBaseKeyName + 'cn.key',moxie,overwrite);
k31 := buildindex(cn_st_from_nameasis1_dedup,{st2,cn,(big_endian unsigned8 )__filepos},
			lBaseKeyName + 'st.cn.key',moxie,overwrite);

nameasis_rec2 := record
	// nameasis keys is 61 long, because old Moxie keys used to be.
	string5 z5 := '';
	string60 nameasis := '';
	string10 cn := '';
	string80 cn_source := '';
	string2	 st := '';
	string13 city := '';
	dMoxieFileForKeybuild.__filepos;
end;

nameasis_rec2 tNormalize_nameasis_Cities(nameasis_rec pInput,integer pCounter)
 :=
  transform
	self.city		:= if(pCounter=1,pInput.City,stringlib.stringextract(pInput.ZipToCityList,pCounter));
	self		:= pInput;
  end
 ;
 
nameasis_st_city_duped 			:= DEDUP(nameasis_n(nameasis<>'' AND (st<>'') AND (city<>'')),st,city,nameasis,__filepos,all);
nameasis_duped_NormCity			:= normalize(nameasis_st_city_duped,
										 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
										 tNormalize_nameasis_Cities(left,counter)
										);
nameasis_duped_NormCityDist		:= distribute(nameasis_duped_NormCity,hash(st,city,nameasis,__filepos));
nameasis_duped_NormCitySort		:= sort(nameasis_duped_NormCityDist,st,city,nameasis,__filepos, local);
nameasis_duped_NormCityDeDup	:= dedup(nameasis_duped_NormCitySort,st,city,nameasis,__filepos,local);

k32 := buildindex(nameasis_duped_NormCityDeDup,{st,city,nameasis,(big_endian unsigned8 )__filepos},
					lBaseKeyName + 'st.city.nameasis.key',moxie,overwrite);

nameasis_rec2 tcn_from_cn_source2(nameasis_rec2 pInput, unsigned1 pCounter)
 :=
  transform
	self.cn	:= choose(pCounter,
					  pInput.cn_source[01..10],
					  pInput.cn_source[11..20],
					  pInput.cn_source[21..30],
					  pInput.cn_source[31..40],
					  pInput.cn_source[41..50],
					  pInput.cn_source[51..60],
					  pInput.cn_source[61..70],
					  pInput.cn_source[71..80]
					 );
	self	:= pInput;
  end
 ;

cn_st_city_from_nameasis		:= normalize(nameasis_duped_NormCityDeDup,8,tcn_from_cn_source2(left,counter));
cn_st_city_from_nameasis_dedup	:= dedup(cn_st_city_from_nameasis(cn<>''),st,city,cn,__filepos,all);

k33 := buildindex(cn_st_city_from_nameasis_dedup,{st,city,cn,(big_endian unsigned8 )__filepos},
					lBaseKeyName + 'st.city.cn.key',moxie,overwrite);


//End Pulled From VehLic****************************************************************************************************

rJoinedRecord
 :=
  record
	string30			watercraft_key;
	string30			sequence_key;
	string2				state_origin := '';
	string30			hull_number := '';
	string40			watercraft_name := '';
	string50			name_of_vessel := '';
	string8				call_sign := '';
	string10			official_number := '';
    unsigned integer8	__filepos;
  end
 ;

rJoinedRecord	TJoinToMainForKeys(dMoxieFileForKeybuild pSearch, Watercraft.File_Base_Main_Dev pMain)
 :=
  transform
	self.watercraft_key	:= pSearch.watercraft_key;
	self.sequence_key	:= pSearch.sequence_key;
	self.state_origin	:= pSearch.state_origin;
	self.hull_number	:= pMain.hull_number;
	self.watercraft_name:= pMain.watercraft_name;
	self.name_of_vessel	:= '';	// from coastguard file
	self.call_sign		:= '';	// from coastguard file
	self.official_number:= '';	// from coastguard file
	self.__filepos		:= pSearch.__filepos;
  end
 ;

dSearchDist		:= distribute(dMoxieFileForKeybuild,hash(watercraft_key,sequence_key));
dSearchSort		:= sort(dSearchDist,watercraft_key,sequence_key,local);
dMainDist		:= distribute(Watercraft.File_Base_Main_Dev,hash(watercraft_key,sequence_key));
dMainSort		:= sort(dMainDist,watercraft_key,sequence_key,local);
dCGuardDist		:= distribute(Watercraft.File_Base_Coastguard_Dev,hash(watercraft_key,sequence_key));
dCGuardSort		:= sort(dCGuardDist,watercraft_key,sequence_key,local);

dSearchAndMain	:= join(dSearchSort,dMainSort,
						left.watercraft_key = right.watercraft_key
					and left.sequence_key = right.sequence_key,
						tJoinToMainForKeys(left,right),
						left outer,
						local
					   );

rJoinedRecord	TJoinToCGuardForKeys(dSearchAndMain pSearchAndMain, dCGuardSort pCGuard)
 :=
  transform
	self.name_of_vessel	:= pCGuard.name_of_vessel;
	self.call_sign		:= pCGuard.call_sign;
	self.official_number:= pCGuard.official_number;
	self				:= pSearchAndMain;
  end
 ;

dSearchWithBoth	:= join(dSearchAndMain,dCGuardSort,
						left.watercraft_key = right.watercraft_key
					and left.sequence_key = right.sequence_key,
						TJoinToCGuardForKeys(left,right),
						left outer,
						local
					   );

k34 := buildindex(dSearchWithBoth(hull_number<>''),{hull_Number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'hull_number.key',moxie,overwrite,dataset(dMoxieFileForKeybuild));
k35 := buildindex(dSearchWithBoth(hull_number<>''),{state_origin,hull_Number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'state_origin.hull_number.key',moxie,overwrite,dataset(dMoxieFileForKeybuild));
k36 := buildindex(dSearchWithBoth(official_Number<>''),{official_Number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'official_number.key',moxie,overwrite,dataset(dMoxieFileForKeybuild));
k37 := buildindex(dSearchWithBoth(call_sign<>''),{call_sign,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'call_sign.key',moxie,overwrite,dataset(dMoxieFileForKeybuild));

rJoinedRecord	tNormalizeVesselName(rJoinedRecord pInput, integer pCounter)
 :=
  transform
	self.name_of_vessel		:=	case(pCounter,
									 1 => pInput.name_of_vessel,
									 2 => pInput.watercraft_name,
									 pInput.name_of_vessel
								    );
	self					:=	pInput;
  end
 ;

dNormalizedName		:=	normalize(dSearchWithBoth,2,tNormalizeVesselName(left,counter));
dNormalizedNameDist	:=	distribute(dNormalizedName,hash(__filepos));
dNormalizedNameSort	:=	sort(dNormalizedNameDist,name_of_vessel,__filepos,local);
dNormalizedNameDedup:=	dedup(dNormalizedNameSort,name_of_vessel,__filepos,local);

k38 := buildindex(dNormalizedNameDedup(name_of_vessel<>''),{name_of_vessel,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'name_of_vessel.key',moxie,overwrite,dataset(dMoxieFileForKeybuild));


export Out_Search_Base_Dev_Keys
 :=
  parallel(
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
		   ,k27
		   ,k28
		   ,k29
		   ,k30
		   ,k31
		   ,k32
		   ,k33
		   ,k34
		   ,k35
		   ,k36
		   ,k37
		   ,k38
		   )
 ;