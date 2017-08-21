import lib_keylib, lib_stringlib, lib_metaphone;

#workunit('name','DL ' + Drivers.Version_Development + ' Keybuild');

lBaseKeyName := 'key::moxie.dl.';

string lSingleSpace(string pString1, string pString2, string pString3='')
 := trim(pString1) + ' '
  + if(trim(pString2) = '',
	   ' ',
	   trim(pString2) + ' '
	  )
  + trim(pString3)
 ;

rMoxieFileForKeybuildLayout
 :=
  record
	Drivers.Layout_DL_ToMike;
    unsigned integer8 __filepos{ virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset(Drivers.Cluster + 'out::DL_ToMike',rMoxieFileForKeybuildLayout,flat);

rSimpleKeysTableRecord
 :=
  record
  lMoxieFileForKeybuild.orig_state;
	lMoxieFileForKeybuild.lic_issue_date;
	lMoxieFileForKeybuild.DID;
	lMoxieFileForKeybuild.PreGLB_DID;
	lMoxieFileForKeybuild.SSN;
	lMoxieFileForKeybuild.DL_Number;
	lMoxieFileForKeybuild.Old_DL_Number;
	lMoxieFileForKeybuild.race;
	lMoxieFileForKeybuild.sex_flag;
	lMoxieFileForKeybuild.age;
	lMoxieFileForKeybuild.__filepos;
  end
 ;

lSimpleKeysTable := table(lMoxieFileForKeybuild,rSimpleKeysTableRecord);

did_keys:= 
								buildindex(lSimpleKeysTable(DID<>''),{DID,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'did.key',moxie,overwrite);
/* It's time we quit building this
buildindex(lSimpleKeysTable(PreGLB_DID<>''),{preGLB_did,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'pgid.key',moxie,overwrite);*/
ssn_keys:= 
								buildindex(lSimpleKeysTable(SSN<>''),{SSN,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'ssn.key',moxie,overwrite);
dl_num_keys:= 
								buildindex(lSimpleKeysTable(DL_Number<>''),{DL_Number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dl_number.key',moxie,overwrite);
dl_num_old1_keys:=
								buildindex(lSimpleKeysTable(DL_Number+Old_DL_Number<>''),{dl_number,old_dl_number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dl_number.old_dl_number.key',moxie,overwrite);
dl_num_old2_keys:=
								buildindex(lSimpleKeysTable(Old_DL_Number+DL_Number<>''),{old_dl_number,dl_number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'old_dl_number.dl_number.key',moxie,overwrite);
gender_keys:=
								buildindex(lSimpleKeysTable(Sex_Flag+Race+Age<>''),{Sex_Flag,Race,Age,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'sex_flag.race.age.key',moxie,overwrite);
dl_state_keys:=
								buildindex(lSimpleKeysTable(DL_Number<>''),{Orig_State,DL_Number,	// in ECL, it's "orig_state," but it's state_origin everywhere else
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'state_origin.dl_number.key',moxie,overwrite);
dl_state_qa_keys:=
								buildindex(lSimpleKeysTable(DL_Number<>''),{Orig_State,Lic_Issue_Date,    // Added key for QA
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'state_origin.lic_issue_date.key',moxie,overwrite);

rNameKeysTableRecord
 :=
  record
    lMoxieFileForKeybuild.DOB;
    lMoxieFileForKeybuild.Zip5;
    string45        lfmname := lSingleSpace(lMoxieFileForKeybuild.lname,
											lMoxieFileForKeybuild.fname,
											lMoxieFileForKeybuild.mname
										   );
    string30        mfname  := lSingleSpace(lMoxieFileForKeybuild.mname,
											lMoxieFileForKeybuild.fname
										   );
    string45        fmlname := lSingleSpace(lMoxieFileForKeybuild.fname,
											lMoxieFileForKeybuild.mname,
											lMoxieFileForKeybuild.lname
										   );
	lMoxieFileForKeybuild.__filepos;
  end
 ;

lNameKeysTable := table(lMoxieFileForKeybuild,rNameKeysTableRecord);

lfm_keys:=
								buildindex(lNameKeysTable(LFMName<>''),{LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'lfmname.key',moxie,overwrite);
dob_keys:=
								buildindex(lNameKeysTable(DOB+LFMName<>''),{DOB,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.lfmname.key',moxie,overwrite);
mfn_keys:=
								buildindex(lNameKeysTable(MFName+DOB<>''),{MFName,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'mfname.dob.key',moxie,overwrite);
fmln_keys:=
								buildindex(lNameKeysTable(DOB+FMLName<>''),{DOB,FMLName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.fmlname.key',moxie,overwrite);
zip_keys:=
								buildindex(lNameKeysTable(Zip5+LFMName<>''),{Zip5,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'zip.lfmname.key',moxie,overwrite);

/*
	Street_Name and Prim_Name are the same length, but for naming
	consistency within the key, I duplicate here rather than have
	any confusion over the proper field being used in the key
*/
rAddressKeysTableRecord
 :=
  record
    lMoxieFileForKeybuild.St;
    lMoxieFileForKeybuild.Zip5;
    string13		city	:= lMoxieFileForKeybuild.V_City_Name[1..13];
	varstring		ZipToCityList := ZipLib.ZipToCities(lMoxieFileForKeybuild.Zip5);
	string28		street_name := lMoxieFileForKeybuild.Prim_Name;
    lMoxieFileForKeybuild.Prim_Name;
    lMoxieFileForKeybuild.PreDir;
    lMoxieFileForKeybuild.PostDir;
    lMoxieFileForKeybuild.Prim_Range;
    lMoxieFileForKeybuild.Sec_Range;
	lMoxieFileForKeybuild.Suffix;
	lMoxieFileForKeybuild.LName;
    string45        lfmname := lSingleSpace(lMoxieFileForKeybuild.lname,
											lMoxieFileForKeybuild.fname,
											lMoxieFileForKeybuild.mname
										   );
	lMoxieFileForKeybuild.__filepos;
  end
 ;

lAddressKeysTable := table(lMoxieFileForKeybuild,rAddressKeysTableRecord);

address1_keys:=
								buildindex(lAddressKeysTable(St+LFMName<>''),{St,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.lfmname.key',moxie,overwrite);
address2_keys:=
								buildindex(lAddressKeysTable(Zip5+Street_Name+Suffix+PreDir+PostDir+Prim_Range+LName+Sec_Range<>''),{Zip5,Street_Name,Suffix,PreDir,PostDir,Prim_Range,LName,Sec_Range,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.street_name.suffix.predir.postdir.prim_range.lname.sec_range.key',moxie,overwrite);
address3_keys:=
								buildindex(lAddressKeysTable(Zip5+Prim_Name+Prim_Range+LFMName<>''),{Zip5,Prim_Name,Prim_Range,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.prim_name.prim_range.lfmname.key',moxie,overwrite);

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

address4_keys:=
								buildindex(dAddressKeysNormDedup(St+City+LFMName<>''),{St,City,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.lfmname.key',moxie,overwrite);

dAddressKeysNormLongDist	:= distribute(dAddressKeysNormCity, hash(St,Prim_Name,Prim_Range,LFMName,City,__filepos));
dAddressKeysNormLongSort	:= sort(dAddressKeysNormLongDist,St,Prim_Name,Prim_Range,LFMName,City,__filepos, local);
dAddressKeysNormLongDedup	:= dedup(dAddressKeysNormSort,St,Prim_Name,Prim_Range,LFMName,City,__filepos,local);

address5_keys:=
								buildindex(dAddressKeysNormLongDedup(St+Prim_Name+Prim_Range+LFMName+City<>''),{St,Prim_Name,Prim_Range,LFMName,City,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.prim_name.prim_range.lfmname.city.key',moxie,overwrite);

rDPHLNameKeysTableRecord
 :=
  record
	lMoxieFileForKeybuild.DID;
    lMoxieFileForKeybuild.St;
    lMoxieFileForKeybuild.Zip5;
    string13		city	:= lMoxieFileForKeybuild.V_City_Name[1..13];
	varstring		ZipToCityList := ZipLib.ZipToCities(lMoxieFileForKeybuild.Zip5);
	lMoxieFileForKeybuild.LName;
	lMoxieFileForKeybuild.FName;
	lMoxieFileForKeybuild.MName;
	lMoxieFileForKeybuild.DOB;
	lMoxieFileForKeybuild.County;
	string4			dob_year  := if((integer) (lMoxieFileForKeybuild.dob[1..4]) <> 0,
									lMoxieFileForKeybuild.dob[1..4],
									''
								   );
	string2			dob_month := if((integer) (lMoxieFileForKeybuild.dob[5..6]) <> 0,
									lMoxieFileForKeybuild.dob[5..6],
									''
								   );
	string6			dph_lname := '';
    string45        lfmname := lSingleSpace(lMoxieFileForKeybuild.lname,
											lMoxieFileForKeybuild.fname,
											lMoxieFileForKeybuild.mname
										   );
	lMoxieFileForKeybuild.__filepos;
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

lDPHLNameKeysTable := table(lMoxieFileForKeybuild,rDPHLNameKeysTableRecord);
lDPHLNameKeysTableNorm := normalize(lDPHLNameKeysTable,2,tNormalizeDPHLNames(left,Counter));
lDPHLNameKeysTableDeDuped := dedup(lDPHLNameKeysTableNorm,DPH_LName,__filepos,all);
/* Doesn't like this distribute/dedup.  Not necessary, just thought more efficient
//lDPHLNameKeysTableDist := distribute(lDPHLNameKeysTableNorm,hash(DPH_LName+__filepos));
//lDPHLNameKeysTableDeDuped := dedup(lDPHLNameKeysTableDist,DPH_LName,__filepos,local);
*/

//Added 20031003
dphln1_keys:=
								buildindex(lDPHLNameKeysTableDeDuped(St+County+LFMName<>''),{St,County,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.county.lfmname.key',moxie,overwrite);
//Added 20031003
dphln2_keys:=
								buildindex(lDPHLNameKeysTableDeDuped(St+County+dph_lname+fname+mname+lname+dob<>''),{St,County,DPH_LName,FName,MName,LName,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.county.dph_lname.fname.mname.lname.dob.key',moxie,overwrite);
dphln3_keys:=
								buildindex(lDPHLNameKeysTableDeDuped(Zip5+DPH_LName+FName+MName+LName<>''),{Zip5,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'zip.dph_lname.fname.mname.lname.key',moxie,overwrite);
dphln4_keys:=
								buildindex(lDPHLNameKeysTableDeDuped(St+DPH_LName+FName+MName+LName<>''),{St,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dph_lname.fname.mname.lname.key',moxie,overwrite);
dphln5_keys:=
								buildindex(lDPHLNameKeysTableDeDuped(DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
dphln6_keys:=
								buildindex(lDPHLNameKeysTableDeDuped(St+DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{St,DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
dphln7_keys:=
								buildindex(lDPHLNameKeysTableDeDuped(DPH_LName+FName+MName+LName<>''),{DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dph_lname.fname.mname.lname.key',moxie,overwrite);

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

dphln8_keys:=
								buildindex(dDPHLNameKeysTableNormDedup(St+City+DPH_LName+FName+MName+LName<>''),{St,City,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.dph_lname.fname.mname.lname.key',moxie,overwrite);

export proc_moxie_dl_keybuild := 	sequential(Drivers.Out_Moxie_Dev_FPos_Data_Key,
									parallel( did_keys, ssn_keys, dl_num_keys, dl_num_old1_keys, dl_num_old2_keys, gender_keys, dl_state_keys, dl_state_qa_keys),
									parallel ( lfm_keys, dob_keys, mfn_keys, fmln_keys, zip_keys),
									parallel ( address1_keys, address2_keys, address3_keys, address4_keys, address5_keys),
									parallel ( dphln1_keys, dphln2_keys, dphln3_keys, dphln4_keys, dphln5_keys, dphln6_keys, dphln7_keys, dphln8_keys));
