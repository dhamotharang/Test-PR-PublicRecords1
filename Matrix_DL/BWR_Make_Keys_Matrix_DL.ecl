import lib_keylib, lib_stringlib, lib_metaphone;

#workunit('name','Matrix DL ' + Matrix_DL.Version_Development + ' Keybuild');

lBaseKeyName := 'key::moxie.matrix_dl.';

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
	Matrix_DL.Layout_Moxie;
    unsigned integer8 __filepos{ virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset('~thor_data400::out::Matrix_DL_Moxie',rMoxieFileForKeybuildLayout,flat);

rSimpleKeysTableRecord
 :=
  record
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

buildindex(lSimpleKeysTable(DID<>''),{DID,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'did.key',moxie,overwrite);
buildindex(lSimpleKeysTable(PreGLB_DID<>''),{preGLB_did,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'pgid.key',moxie,overwrite);
buildindex(lSimpleKeysTable(SSN<>''),{SSN,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'ssn.key',moxie,overwrite);
buildindex(lSimpleKeysTable(DL_Number<>''),{DL_Number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dl_number.key',moxie,overwrite);
buildindex(lSimpleKeysTable(DL_Number+Old_DL_Number<>''),{dl_number,old_dl_number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dl_number.old_dl_number.key',moxie,overwrite);
buildindex(lSimpleKeysTable(Old_DL_Number+DL_Number<>''),{old_dl_number,dl_number,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'old_dl_number.dl_number.key',moxie,overwrite);
buildindex(lSimpleKeysTable(Sex_Flag+Race+Age<>''),{Sex_Flag,Race,Age,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'sex_flag.race.age.key',moxie,overwrite);

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

buildindex(lNameKeysTable(LFMName<>''),{LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'lfmname.key',moxie,overwrite);
buildindex(lNameKeysTable(DOB+LFMName<>''),{DOB,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.lfmname.key',moxie,overwrite);
buildindex(lNameKeysTable(MFName+DOB<>''),{MFName,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'mfname.dob.key',moxie,overwrite);
buildindex(lNameKeysTable(DOB+FMLName<>''),{DOB,FMLName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.fmlname.key',moxie,overwrite);
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

buildindex(lAddressKeysTable(St+LFMName<>''),{St,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.lfmname.key',moxie,overwrite);
buildindex(lAddressKeysTable(St+City+LFMName<>''),{St,City,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.lfmname.key',moxie,overwrite);
buildindex(lAddressKeysTable(Zip5+Street_Name+Suffix+PreDir+PostDir+Prim_Range+LName+Sec_Range<>''),{Zip5,Street_Name,Suffix,PreDir,PostDir,Prim_Range,LName,Sec_Range,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.street_name.suffix.predir.postdir.prim_range.lname.sec_range.key',moxie,overwrite);
buildindex(lAddressKeysTable(Zip5+Prim_Name+Prim_Range+LFMName<>''),{Zip5,Prim_Name,Prim_Range,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.prim_name.prim_range.lfmname.key',moxie,overwrite);
buildindex(lAddressKeysTable(St+Prim_Name+Prim_Range+LFMName+City<>''),{St,Prim_Name,Prim_Range,LFMName,City,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.prim_name.prim_range.lfmname.city.key',moxie,overwrite);

rDPHLNameKeysTableRecord
 :=
  record
	lMoxieFileForKeybuild.DID;
    lMoxieFileForKeybuild.St;
    lMoxieFileForKeybuild.Zip5;
    string13		city	:= lMoxieFileForKeybuild.V_City_Name[1..13];
	lMoxieFileForKeybuild.LName;
	lMoxieFileForKeybuild.FName;
	lMoxieFileForKeybuild.MName;
	lMoxieFileForKeybuild.DOB;
	lMoxieFileForKeybuild.County;
	string4			dob_year  := if((integer) (lMoxieFileForKeybuild.dob[1..4]) <> 0,
									lMoxieFileForKeybuild.dob[1..4],
									''
								   );
	string2			dob_month := if((integer) (lMoxieFileForKeybuild.dob[3..4]) <> 0,
									lMoxieFileForKeybuild.dob[3..4],
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
buildindex(lDPHLNameKeysTableDeDuped(St+County+LFMName<>''),{St,County,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.county.lfmname.key',moxie,overwrite);
//Added 20031003
buildindex(lDPHLNameKeysTableDeDuped(St+County+dph_lname+fname+mname+lname+dob<>''),{St,County,DPH_LName,FName,MName,LName,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.county.dph_lname.fname.mname.lname.dob.key',moxie,overwrite);
buildindex(lDPHLNameKeysTableDeDuped(Zip5+DPH_LName+FName+MName+LName<>''),{Zip5,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'zip.dph_lname.fname.mname.lname.key',moxie,overwrite);
buildindex(lDPHLNameKeysTableDeDuped(St+DPH_LName+FName+MName+LName<>''),{St,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dph_lname.fname.mname.lname.key',moxie,overwrite);
buildindex(lDPHLNameKeysTableDeDuped(St+City+DPH_LName+FName+MName+LName<>''),{St,City,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.dph_lname.fname.mname.lname.key',moxie,overwrite);
buildindex(lDPHLNameKeysTableDeDuped(DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
buildindex(lDPHLNameKeysTableDeDuped(St+DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{St,DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
buildindex(lDPHLNameKeysTableDeDuped(DPH_LName+FName+MName+LName<>''),{DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dph_lname.fname.mname.lname.key',moxie,overwrite);