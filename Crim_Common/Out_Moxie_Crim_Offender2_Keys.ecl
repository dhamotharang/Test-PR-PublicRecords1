import lib_keylib, lib_stringlib, lib_metaphone;

//#workunit('name','Crim_Offender2_DID Keybuild');

lBaseKeyName 	:= 'key::moxie.crim_offender2_did.';

lST_IDsValidChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

string lST_IDValidChar(string pST_IDIn)
 := lib_stringlib.stringlib.stringsubstitute(pST_IDIn,lST_IDsValidChars,' ');

string lSingleSpace(string pString1, string pString2, string pString3='', string pString4='')
 := trim(pString1) + ' '
  + if(trim(pString2) = '',
	   ' ',
	   trim(pString2) + ' '
	  )
  + if(trim(pString3) = '',
	   ' ',
	   trim(pString3) + ' '
	  )
  + trim(pString4)
 ;

rMoxieFileForKeybuildLayout
 :=
  record
	Layout_Moxie_Crim_Offender2.previous;
    unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

dMoxieFileForKeybuild := dataset(Crim_Common.Name_Moxie_Crim_Offender2_Dev,rMoxieFileForKeybuildLayout,flat);

//========================================================

rSimpleKeysTableRecord
 :=
  record
	dMoxieFileForKeybuild.DID;
	dMoxieFileForKeybuild.PGID;
	dMoxieFileForKeybuild.Offender_Key;
	dMoxieFileForKeybuild.FBI_Num;
	dMoxieFileForKeybuild.INS_Num;
	dMoxieFileForKeybuild.DOC_Num;
	dMoxieFileForKeybuild.DLE_Num;
	dMoxieFileForKeybuild.SSN;
	dMoxieFileForKeybuild.State_Origin;
	dMoxieFileForKeybuild.Case_Number;
	dMoxieFileForKeybuild.ID_Num;
	dMoxieFileForKeybuild.__filepos;
  end
 ;

dSimpleKeysTable := table(dMoxieFileForKeybuild,rSimpleKeysTableRecord);

Key01 := buildindex(dSimpleKeysTable(DID<>''),
					{DID,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'did.key',moxie,overwrite);
/*
Key02 := buildindex(dSimpleKeysTable(PGID<>''),
					{PGID,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'pgid.key',moxie,overwrite);
*/
Key03 := buildindex(dSimpleKeysTable(Offender_Key<>''),
					{Offender_Key,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'Offender_Key.key',moxie,overwrite);
Key04 := buildindex(dSimpleKeysTable(FBI_Num<>''),
					{FBI_Num,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'FBI_Num.key',moxie,overwrite);
Key05 := buildindex(dSimpleKeysTable(INS_Num<>''),
					{INS_Num,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'INS_Num.key',moxie,overwrite);
Key06 := buildindex(dSimpleKeysTable(SSN<>''),
					{SSN,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'SSN.key',moxie,overwrite);
Key07 := buildindex(dSimpleKeysTable(Case_Number+State_Origin<>''),
					{Case_Number,State_Origin,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'Case_Number.State_Origin.key',moxie,overwrite);
Key08 := buildindex(dSimpleKeysTable(ID_Num+State_Origin<>''),
					{ID_Num,State_Origin,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'ID_Num.State_Origin.key',moxie,overwrite);
Key09 := buildindex(dSimpleKeysTable(DOC_Num+State_Origin<>''),
					{DOC_Num,State_Origin,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'DOC_Num.State_Origin.key',moxie,overwrite);
Key10 := buildindex(dSimpleKeysTable(DLE_Num+State_Origin<>''),
					{DLE_Num,State_Origin,(big_endian unsigned8)__filepos},
					lBaseKeyName + 'DLE_Num.State_Origin.key',moxie,overwrite);

//========================================================

rNameKeysTableRecord
 :=
  record
    dMoxieFileForKeybuild.DOB;
    dMoxieFileForKeybuild.Zip5;	//this is the clean zip
	dMoxieFileForKeybuild.State;
    dMoxieFileForKeybuild.Prim_Name;
    dMoxieFileForKeybuild.PreDir;
    dMoxieFileForKeybuild.PostDir;
    dMoxieFileForKeybuild.Prim_Range;
    dMoxieFileForKeybuild.Sec_Range;
	dMoxieFileForKeybuild.Addr_Suffix;
	dMoxieFileForKeybuild.SSN;
    string13		City	:= dMoxieFileForKeybuild.V_City_Name[1..13];
    string45        LFMName := lSingleSpace(dMoxieFileForKeybuild.lname,
											dMoxieFileForKeybuild.fname,
											dMoxieFileForKeybuild.mname
										   );
    string45        LFMName2:= trim(lSingleSpace(dMoxieFileForKeybuild.lname,
												 dMoxieFileForKeybuild.fname,
												 dMoxieFileForKeybuild.mname
											    )) + trim(' ' + dMoxieFileForKeybuild.name_suffix)
												;
    string30        MFName  := lSingleSpace(dMoxieFileForKeybuild.mname,
											dMoxieFileForKeybuild.fname
										   );
    string45        FMLName := lSingleSpace(dMoxieFileForKeybuild.fname,
											dMoxieFileForKeybuild.mname,
											dMoxieFileForKeybuild.lname
										   );
	dMoxieFileForKeybuild.__filepos;
  end
 ;

dNameKeysTable := table(dMoxieFileForKeybuild,rNameKeysTableRecord);

Key11 := buildindex(dNameKeysTable(LFMName<>''),{LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'lfmname.key',moxie,overwrite);
Key12 := buildindex(dNameKeysTable(DOB+LFMName<>''),{DOB,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.lfmname.key',moxie,overwrite);
Key13 := buildindex(dNameKeysTable(MFName+DOB<>''),{MFName,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'mfname.dob.key',moxie,overwrite);
Key14 := buildindex(dNameKeysTable(DOB+FMLName<>''),{DOB,FMLName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob.fmlname.key',moxie,overwrite);
Key15 := buildindex(dNameKeysTable(Zip5+LFMName<>''),{Zip5,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.lfmname.key',moxie,overwrite);
Key16 := buildindex(dNameKeysTable(State+City+LFMName<>''),{State,City,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.lfmname.key',moxie,overwrite);
Key17a:= buildindex(dNameKeysTable(Zip5+Prim_Name+PreDir+PostDir+Prim_Range+Sec_Range<>''),{Zip5,Prim_Name,Addr_Suffix,PreDir,PostDir,Prim_Range,Sec_Range,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',moxie,overwrite);
Key17b:= buildindex(dNameKeysTable(Zip5+Prim_Name+PreDir+PostDir+Prim_Range+Sec_Range<>''),{Zip5,Prim_Name,Addr_Suffix,PreDir,PostDir,Prim_Range,Sec_Range,LFMName2,SSN,DOB,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn.dob.key',moxie,overwrite);

//========================================================

rDPHLNameKeysTableRecord
 :=
  record
	dMoxieFileForKeybuild.State;
	dMoxieFileForKeybuild.Zip5;
	string13		city	:= dMoxieFileForKeybuild.V_City_Name[1..13];
	dMoxieFileForKeybuild.LName;
	dMoxieFileForKeybuild.FName;
	dMoxieFileForKeybuild.MName;
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

dDPHLNameKeysTable 		  := table(dMoxieFileForKeybuild,rDPHLNameKeysTableRecord);
dDPHLNameKeysTableNorm 	  := normalize(dDPHLNameKeysTable,2,tNormalizeDPHLNames(left,Counter));
dDPHLNameKeysTableDeDuped := dedup(dDPHLNameKeysTableNorm(DPH_LName<>''),DPH_LName,__filepos,all);

Key18 := buildindex(dDPHLNameKeysTableDeDuped(Zip5+DPH_LName+FName+MName+LName<>''),{Zip5,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'z5.dph_lname.fname.mname.lname.key',moxie,overwrite);
Key19 := buildindex(dDPHLNameKeysTableDeDuped(State+City+DPH_LName+FName+MName+LName<>''),{State,City,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.city.dph_lname.fname.mname.lname.key',moxie,overwrite);
Key20 := buildindex(dDPHLNameKeysTableDeDuped(DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
Key21 := buildindex(dDPHLNameKeysTableDeDuped(DPH_LName+FName+MName+LName<>''),{DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'dph_lname.fname.mname.lname.key',moxie,overwrite);

//========================================================

rStatesKeysTableRecord
 :=
  record
	dMoxieFileForKeybuild.State;
	dMoxieFileForKeybuild.State_Origin;
	dMoxieFileForKeybuild.Place_Of_Birth;
	string45        LFMName   := lSingleSpace(dMoxieFileForKeybuild.lname,
											  dMoxieFileForKeybuild.fname,
											  dMoxieFileForKeybuild.mname
										     );
	dMoxieFileForKeybuild.__filepos;
  end
 ;

rStatesKeysTableRecord tNormalizeStates(rStatesKeysTableRecord pInput,unsigned1 pCounter)
 :=
  TRANSFORM
	self.State := map(pCounter = 1 => lST_IDValidChar(pInput.State),
					  pCounter = 2 => lST_IDValidChar(pInput.State_Origin),
					  pCounter = 3 => lST_IDValidChar(pInput.Place_Of_Birth),
					  ''
					 );
	self := pInput;
end;

dStatesKeysTable 		:= table(dMoxieFileForKeybuild,rStatesKeysTableRecord);
dStatesKeysTableNorm 	:= normalize(dStatesKeysTable,3,tNormalizeStates(left,Counter));
dStatesKeysTableDeDuped := dedup(dStatesKeysTableNorm(State<>''),State,__filepos,all);

Key22 := buildindex(dStatesKeysTableDeDuped(State+LFMName<>''),{State,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.lfmname.key',moxie,overwrite);

//========================================================

rStatesDPHKeysTableRecord
 :=
  record
	dMoxieFileForKeybuild.State;
	dMoxieFileForKeybuild.State_Origin;
	dMoxieFileForKeybuild.Place_Of_Birth;
	dMoxieFileForKeybuild.Zip5;
	string13		city	  := dMoxieFileForKeybuild.V_City_Name[1..13];
	dMoxieFileForKeybuild.LName;
	dMoxieFileForKeybuild.FName;
	dMoxieFileForKeybuild.MName;
	string4			dob_year  := if((integer) (dMoxieFileForKeybuild.dob[1..4]) <> 0,
									dMoxieFileForKeybuild.dob[1..4],
									''
								   );
	string2			dob_month := if((integer) (dMoxieFileForKeybuild.dob[5..6]) <> 0,
									dMoxieFileForKeybuild.dob[5..6],
									''
								   );
	string6			DPH_LName := '';
	string45        LFMName   := lSingleSpace(dMoxieFileForKeybuild.lname,
											  dMoxieFileForKeybuild.fname,
											  dMoxieFileForKeybuild.mname
										     );
	dMoxieFileForKeybuild.__filepos;
  end
 ;

rStatesDPHKeysTableRecord tNormalizeStatesDPH(rStatesDPHKeysTableRecord pInput,unsigned1 pCounter)
 :=
  TRANSFORM
	self.State := map(pCounter = 1 or pCounter = 4 => lST_IDValidChar(pInput.State),
					  pCounter = 2 or pCounter = 5 => lST_IDValidChar(pInput.State_Origin),
					  pCounter = 3 or pCounter = 6 => lST_IDValidChar(pInput.Place_Of_Birth),
					  ''
					 );
	self.DPH_LName := choose((pCounter & 1) + 1,
							 metaphonelib.DMetaPhone1(pInput.LName),
							 metaphonelib.DMetaPhone2(pInput.LName)
							);
	self := pInput;
end;

dStatesDPHKeysTable 		:= table(dMoxieFileForKeybuild,rStatesDPHKeysTableRecord);
dStatesDPHKeysTableNorm 	:= normalize(dStatesDPHKeysTable,8,tNormalizeStatesDPH(left,Counter));
dStatesDPHKeysTableDeDuped 	:= dedup(dStatesDPHKeysTableNorm(State<>''),State,DPH_LName,__filepos,all);

Key23 := buildindex(dStatesDPHKeysTableDeDuped(State+DPH_LName+FName+MName+LName<>''),{State,DPH_LName,FName,MName,LName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dph_lname.fname.mname.lname.key',moxie,overwrite);
Key24 := buildindex(dStatesDPHKeysTableDeDuped(State+DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{State,DOB_Year,DOB_Month,DPH_LName,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);

//========================================================

rST_IDsKeysTableRecord
 :=
  record
	string15 ST_IDs	:= '';
	dMoxieFileForKeybuild.State_Origin;
	dMoxieFileForKeybuild.Case_Number;
	dMoxieFileForKeybuild.DOC_Num;
	dMoxieFileForKeybuild.FBI_Num;
	dMoxieFileForKeybuild.DLE_Num;
	dMoxieFileForKeybuild.__filepos;
  end
 ;

rST_IDsKeysTableRecord tNormalizeST_IDs(rST_IDsKeysTableRecord pInput,unsigned1 pCounter)
 :=
  TRANSFORM
	self.ST_IDs := choose(pCounter,
						  lib_stringlib.stringlib.stringfilterout(pInput.Case_Number,'~ !@$%^&*_+(\'`{}|:<>?-=[];./'),
						  lib_stringlib.stringlib.stringfilterout(pInput.DOC_Num,'~ !@$%^&*_+(\'`{}|:<>?-=[];./'),
						  lib_stringlib.stringlib.stringfilterout(pInput.FBI_Num,'~ !@$%^&*_+(\'`{}|:<>?-=[];./'),
						  lib_stringlib.stringlib.stringfilterout(pInput.DLE_Num,'~ !@$%^&*_+(\'`{}|:<>?-=[];./')
						 );
	self := pInput;
end;

dST_IDsKeysTable 		:= table(dMoxieFileForKeybuild,rST_IDsKeysTableRecord);
dST_IDsKeysTableNorm 	:= normalize(dST_IDsKeysTable,4,tNormalizeST_IDs(left,Counter));
dST_IDsKeysTableDeDuped := dedup(dST_IDsKeysTableNorm(ST_IDs<>''),ST_IDs,__filepos,all);

Key25 := buildindex(dST_IDsKeysTableDeDuped(ST_IDs+State_Origin<>''),{ST_IDs,State_Origin,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st_ids.state_origin.key',moxie,overwrite);

rCountyKeysTableRecord
 :=
  record
	string2		state_origin := '';
	string40	Case_Court_1 := '';
	string40	Case_Court_2 := '';
	string40	Case_Court_3 := '';
	string40	Case_Court_4 := '';
	string40	Case_Court_5 := '';
	string40	Case_Court_6 := '';
	string45    LFMName   	 := '';
	dMoxieFileForKeybuild.__filepos;
  end
 ;

rCountyKeysTableNormalizedRecord
 :=
  record
	string2		state_origin := '';
	string40	Case_Court	 := '';
	string45    LFMName   	 := '';
	dMoxieFileForKeybuild.__filepos;
  end
 ;

rCountyKeysTableRecord tCreateCountyNameRecord(dMoxieFileForKeybuild pInput)
 :=
  transform
	self.Case_Court_1 := CountyKey.CountyNameStrings[1 + ((CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * CountyKey.ElementsPerCounty)];
	self.Case_Court_2 := CountyKey.CountyNameStrings[2 + ((CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * CountyKey.ElementsPerCounty)];
	self.Case_Court_3 := CountyKey.CountyNameStrings[3 + ((CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * CountyKey.ElementsPerCounty)];
	self.Case_Court_4 := CountyKey.CountyNameStrings[4 + ((CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * CountyKey.ElementsPerCounty)];
	self.Case_Court_5 := CountyKey.CountyNameStrings[5 + ((CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * CountyKey.ElementsPerCounty)];
	self.Case_Court_6 := CountyKey.CountyNameStrings[6 + ((CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * CountyKey.ElementsPerCounty)];
	self.LFMName	  := lSingleSpace(pInput.lname,
									  pInput.fname,
									  pInput.mname
									 );
	self := pInput;
  end
 ;

rCountyKeysTableNormalizedRecord tNormalizeCounty(rCountyKeysTableRecord pInput,unsigned1 pCounter)
 :=
  transform
	self.Case_Court := choose(pCounter,
							  pInput.Case_Court_1,
							  pInput.Case_Court_2,
							  pInput.Case_Court_3,
							  pInput.Case_Court_4,
							  pInput.Case_Court_5,
							  pInput.Case_Court_6
							 );
	self := pInput;
end;

dCountyKeysTableNamed		 := project(dMoxieFileForKeybuild(Vendor in CountyKey.CountyVendorIDSet),tCreateCountyNameRecord(left));
dCountyKeysTableNamedNorm 	 := normalize(dCountyKeysTableNamed,6,tNormalizeCounty(left,counter));
dCountyKeysTableNamedDeduped := dedup(dCountyKeysTableNamedNorm(trim(Case_Court)<>''),State_Origin,Case_Court,__filepos,all);

Key26 := buildindex(dCountyKeysTableNamedDeduped,{State_Origin,Case_Court,LFMName,
								(big_endian unsigned8)__filepos},
								lBaseKeyName + 'st.county.lfmname.key',moxie,overwrite);

//===========================================================

export Out_Moxie_Crim_Offender2_Keys
 := parallel
   (
	Key01,	// DID
//	Key02,	// PGID not used any longer
	Key03,	// offender_key
	Key04,	// FBI_Num
	Key05,	// INS_Num
	Key06,	// SSN
	Key07,	// Case_Number.State_Origin
	Key08,	// ID_Num.State_Origin
	Key09,	// DOC_Num.State_Origin
	Key10,	// DLE_Num.State_Origin
	Key11,	// lfmname
	Key12,	// dob.lfmname
	Key13,	// mfname.dob
	Key14,	// dob.fmlname
	Key15,	// z5.lfmname
	Key16,	// st.city.lfmname
	Key17a,	// z5.prim_name.suffix.predir.postdir.prim_range.sec_range
	Key17b,	// z5.prim_name.suffix.predir.postdir.prim_range.sec_range.lfmname.ssn
	Key18,	// z5.dph_lname.fname.mname.lname
	Key19,	// st.city.dph_lname.fname.mname.lname
	Key20,	// dob_year.dob_month.dph_lname.lfmname
	Key21,	// dph_lname.fname.mname.lname
	Key22,	// st.lfmname
	Key23,	// st.dob_year.dob_month.dph_lname.lfmname
	Key24,	// st.dph_lname.fname.mname.lname
	Key25,	// st_ids.state_origin
	Key26	  // st.county.lfmname
   );