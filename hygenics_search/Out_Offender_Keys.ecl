import lib_keylib, lib_stringlib, lib_metaphone, Crim_Common;

lBaseKeyName 		:= 'key::moxie.fcra_criminal_offender.';
lST_IDsValidChars 	:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

string lST_IDValidChar(string pST_IDIn)
	:= lib_stringlib.stringlib.stringsubstitute(pST_IDIn, lST_IDsValidChars, ' ');

string lSingleSpace(string pString1, string pString2, string pString3='', string pString4='')
	:= trim(pString1) + ' '
	
		+ if(trim(pString2) = '',
		' ',
		trim(pString2) + ' ')
	   
		+ if(trim(pString3) = '',
		' ',
		trim(pString3) + ' ')
	   
		+ trim(pString4);

	rMoxieFileForKeybuildLayout := record
		Layout_Moxie_Offender;
		unsigned integer8 __filepos{virtual(fileposition)};
	end;

lMoxieFileForKeybuild := dataset(Name_Moxie_Offender_Dev, rMoxieFileForKeybuildLayout, flat)(length(trim(offender_key, left, right))>2);

//========================================================

	rSimpleKeysTableRecord := record
		lMoxieFileForKeybuild.DID;
		lMoxieFileForKeybuild.Offender_Key;
		lMoxieFileForKeybuild.SSN;
		lMoxieFileForKeybuild.state_of_origin;
		lMoxieFileForKeybuild.Case_Number;
		lMoxieFileForKeybuild.__filepos;
	end;

lSimpleKeysTable := table(lMoxieFileForKeybuild, rSimpleKeysTableRecord);

	A01 := buildindex(lSimpleKeysTable(DID<>''),
				{DID,(big_endian unsigned8)__filepos},
				lBaseKeyName + 'did.key',moxie,overwrite);
	A02 := buildindex(lSimpleKeysTable(Offender_Key<>''),
				{Offender_Key,(big_endian unsigned8)__filepos},
				lBaseKeyName + 'Offender_Key.key',moxie,overwrite);
	A03 := buildindex(lSimpleKeysTable(SSN<>''),
				{SSN,(big_endian unsigned8)__filepos},
				lBaseKeyName + 'SSN.key',moxie,overwrite);
	A04 := buildindex(lSimpleKeysTable(Case_Number+state_of_origin<>''),
				{Case_Number,state_of_origin,(big_endian unsigned8)__filepos},
				lBaseKeyName + 'Case_Number.State_Origin.key',moxie,overwrite);

//========================================================

	rNameKeysTableRecord := record
		lMoxieFileForKeybuild.DOB;
		lMoxieFileForKeybuild.Zip5;	//this is the clean zip
		lMoxieFileForKeybuild.State;
		lMoxieFileForKeybuild.Prim_Name;
		lMoxieFileForKeybuild.PreDir;
		lMoxieFileForKeybuild.PostDir;
		lMoxieFileForKeybuild.Prim_Range;
		lMoxieFileForKeybuild.Sec_Range;
		lMoxieFileForKeybuild.Addr_Suffix;
		string13		City	:= lMoxieFileForKeybuild.V_City_Name[1..13];
		string45        LFMName := lSingleSpace(lMoxieFileForKeybuild.lname,
												lMoxieFileForKeybuild.fname,
												lMoxieFileForKeybuild.mname
											   );
		string30        MFName  := lSingleSpace(lMoxieFileForKeybuild.mname,
												lMoxieFileForKeybuild.fname
											   );
		string45        FMLName := lSingleSpace(lMoxieFileForKeybuild.fname,
												lMoxieFileForKeybuild.mname,
												lMoxieFileForKeybuild.lname
											   );
		lMoxieFileForKeybuild.__filepos;
	end;

lNameKeysTable := table(lMoxieFileForKeybuild,rNameKeysTableRecord);

	A05 := buildindex(lNameKeysTable(LFMName<>''),{LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'lfmname.key',moxie,overwrite);
	A06 := buildindex(lNameKeysTable(DOB+LFMName<>''),{DOB,LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'dob.lfmname.key',moxie,overwrite);
	A07 := buildindex(lNameKeysTable(MFName+DOB<>''),{MFName,DOB,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'mfname.dob.key',moxie,overwrite);
	A08 := buildindex(lNameKeysTable(DOB+FMLName<>''),{DOB,FMLName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'dob.fmlname.key',moxie,overwrite);
	A09 := buildindex(lNameKeysTable(Zip5+LFMName<>''),{Zip5,LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'z5.lfmname.key',moxie,overwrite);
	A10 := buildindex(lNameKeysTable(State+City+LFMName<>''),{State,City,LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'st.city.lfmname.key',moxie,overwrite);
	A11 := buildindex(lNameKeysTable(Zip5+Prim_Name+PreDir+PostDir+Prim_Range+Sec_Range<>''),{Zip5,Prim_Name,Addr_Suffix,PreDir,PostDir,Prim_Range,Sec_Range,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',moxie,overwrite);
	A12 := buildindex(lNameKeysTable(Zip5+Prim_Name+Prim_Range<>''),{Zip5,Prim_Name,Prim_Range,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'z5.prim_name.prim_range.key',moxie,overwrite);

//========================================================

	rDPHLNameKeysTableRecord := record
		lMoxieFileForKeybuild.State;
		lMoxieFileForKeybuild.Zip5;
		string13		city	:= lMoxieFileForKeybuild.V_City_Name[1..13];
		lMoxieFileForKeybuild.LName;
		lMoxieFileForKeybuild.FName;
		lMoxieFileForKeybuild.MName;
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
	end;

	rDPHLNameKeysTableRecord tNormalizeDPHLNames(rDPHLNameKeysTableRecord pInput,unsigned1 pCounter):= TRANSFORM
		self.dph_lname := choose(pCounter,
								 metaphonelib.DMetaPhone1(pInput.LName),
								 metaphonelib.DMetaPhone2(pInput.LName)
								);
		self := pInput;
	end;

lDPHLNameKeysTable 		  := table(lMoxieFileForKeybuild,rDPHLNameKeysTableRecord);
lDPHLNameKeysTableNorm 	  := normalize(lDPHLNameKeysTable,2,tNormalizeDPHLNames(left,Counter));
lDPHLNameKeysTableDeDuped := dedup(lDPHLNameKeysTableNorm(DPH_LName<>''),DPH_LName,__filepos,all);

	A13 := buildindex(lDPHLNameKeysTableDeDuped(Zip5+DPH_LName+FName+MName+LName<>''),{Zip5,DPH_LName,FName,MName,LName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'z5.dph_lname.fname.mname.lname.key',moxie,overwrite);
	A14 := buildindex(lDPHLNameKeysTableDeDuped(State+City+DPH_LName+FName+MName+LName<>''),{State,City,DPH_LName,FName,MName,LName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'st.city.dph_lname.fname.mname.lname.key',moxie,overwrite);
	A15 := buildindex(lDPHLNameKeysTableDeDuped(DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{DOB_Year,DOB_Month,DPH_LName,LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);
	A16 := buildindex(lDPHLNameKeysTableDeDuped(DPH_LName+FName+MName+LName<>''),{DPH_LName,FName,MName,LName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'dph_lname.fname.mname.lname.key',moxie,overwrite);

//========================================================

	rStatesKeysTableRecord := record
		lMoxieFileForKeybuild.State;
		lMoxieFileForKeybuild.state_of_origin;
		lMoxieFileForKeybuild.Place_Of_Birth;
		string45        LFMName   := lSingleSpace(lMoxieFileForKeybuild.lname,
												  lMoxieFileForKeybuild.fname,
												  lMoxieFileForKeybuild.mname);
		lMoxieFileForKeybuild.__filepos;
	end;

	rStatesKeysTableRecord tNormalizeStates(rStatesKeysTableRecord pInput,unsigned1 pCounter) := TRANSFORM
		self.State := map(pCounter = 1 => lST_IDValidChar(pInput.State),
						  pCounter = 2 => lST_IDValidChar(pInput.state_of_origin),
						  pCounter = 3 => lST_IDValidChar(pInput.Place_Of_Birth),
						  ''
						 );
		self := pInput;
	end;

lStatesKeysTable 		:= table(lMoxieFileForKeybuild,rStatesKeysTableRecord);
lStatesKeysTableNorm 	:= normalize(lStatesKeysTable,3,tNormalizeStates(left,Counter));
lStatesKeysTableDeDuped := dedup(lStatesKeysTableNorm(State<>''),State,__filepos,all);

	A17 := buildindex(lStatesKeysTableDeDuped(State+LFMName<>''),{State,LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'st.lfmname.key',moxie,overwrite);

//========================================================

	rStatesDPHKeysTableRecord := record
		lMoxieFileForKeybuild.State;
		lMoxieFileForKeybuild.state_of_origin;
		lMoxieFileForKeybuild.Place_Of_Birth;
		lMoxieFileForKeybuild.Zip5;
		string13		city	  := lMoxieFileForKeybuild.V_City_Name[1..13];
		lMoxieFileForKeybuild.LName;
		lMoxieFileForKeybuild.FName;
		lMoxieFileForKeybuild.MName;
		string4			dob_year  := if((integer) (lMoxieFileForKeybuild.dob[1..4]) <> 0,
										lMoxieFileForKeybuild.dob[1..4],
										''
									   );
		string2			dob_month := if((integer) (lMoxieFileForKeybuild.dob[5..6]) <> 0,
										lMoxieFileForKeybuild.dob[5..6],
										''
									   );
		string6			DPH_LName := '';
		string45        LFMName   := lSingleSpace(lMoxieFileForKeybuild.lname,
												  lMoxieFileForKeybuild.fname,
												  lMoxieFileForKeybuild.mname
												 );
		lMoxieFileForKeybuild.__filepos;
	end;

	rStatesDPHKeysTableRecord tNormalizeStatesDPH(rStatesDPHKeysTableRecord pInput,unsigned1 pCounter) := TRANSFORM
		self.State := map(pCounter = 1 or pCounter = 4 => lST_IDValidChar(pInput.State),
						  pCounter = 2 or pCounter = 5 => lST_IDValidChar(pInput.state_of_origin),
						  pCounter = 3 or pCounter = 6 => lST_IDValidChar(pInput.Place_Of_Birth),
						  '');
		self.DPH_LName := choose((pCounter & 1) + 1,
								 metaphonelib.DMetaPhone1(pInput.LName),
								 metaphonelib.DMetaPhone2(pInput.LName)
								);
		self := pInput;
	end;

lStatesDPHKeysTable 		:= table(lMoxieFileForKeybuild,rStatesDPHKeysTableRecord);
lStatesDPHKeysTableNorm 	:= normalize(lStatesDPHKeysTable,8,tNormalizeStatesDPH(left,Counter));
lStatesDPHKeysTableDeDuped 	:= dedup(lStatesDPHKeysTableNorm(State<>''),State,DPH_LName,__filepos,all);

	A18 := buildindex(lStatesDPHKeysTableDeDuped(State+DPH_LName+FName+MName+LName<>''),{State,DPH_LName,FName,MName,LName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'st.dph_lname.fname.mname.lname.key',moxie,overwrite);
	A19 := buildindex(lStatesDPHKeysTableDeDuped(State+DOB_Year+DOB_Month+DPH_LName+LFMName<>''),{State,DOB_Year,DOB_Month,DPH_LName,LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'st.dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);

//========================================================

	rST_IDsKeysTableRecord := record
		string15 ST_IDs	:= '';
		lMoxieFileForKeybuild.State_of_Origin;
		lMoxieFileForKeybuild.Case_Number;
		lMoxieFileForKeybuild.offender_id_num_1;
		lMoxieFileForKeybuild.offender_id_num_2;
		lMoxieFileForKeybuild.__filepos;
	end;

	rST_IDsKeysTableRecord tNormalizeST_IDs(rST_IDsKeysTableRecord pInput,unsigned1 pCounter):= TRANSFORM
		self.ST_IDs := choose(pCounter,
							  lib_stringlib.stringlib.stringfilterout(pInput.Case_Number,'~ !@$%^&*_+(\'`{}|:<>?-=[];./'),
							  lib_stringlib.stringlib.stringfilterout(pInput.offender_id_num_1,'~ !@$%^&*_+(\'`{}|:<>?-=[];./'),
							  lib_stringlib.stringlib.stringfilterout(pInput.offender_id_num_2,'~ !@$%^&*_+(\'`{}|:<>?-=[];./')
							 );
		self := pInput;
	end;

lST_IDsKeysTable 		:= table(lMoxieFileForKeybuild,rST_IDsKeysTableRecord);
lST_IDsKeysTableNorm 	:= normalize(lST_IDsKeysTable,3,tNormalizeST_IDs(left,Counter));
lST_IDsKeysTableDeDuped := dedup(lST_IDsKeysTableNorm(ST_IDs<>''),ST_IDs,__filepos,all);

	A20 := buildindex(lST_IDsKeysTableDeDuped(ST_IDs+State_of_Origin<>''),{ST_IDs,State_of_Origin,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'st_ids.state_origin.key',moxie,overwrite);

	rCountyKeysTableRecord := record
		string2		state_origin := '';
		string40	Case_Court_1 := '';
		string40	Case_Court_2 := '';
		string40	Case_Court_3 := '';
		string40	Case_Court_4 := '';
		string40	Case_Court_5 := '';
		string40	Case_Court_6 := '';
		string45    LFMName   	 := '';
		lMoxieFileForKeybuild.__filepos;
	end;

	rCountyKeysTableNormalizedRecord := record
		string2		state_origin := '';
		string40	Case_Court	 := '';
		string45    LFMName   	 := '';
		lMoxieFileForKeybuild.__filepos;
	end;

	rCountyKeysTableRecord tCreateCountyNameRecord(lMoxieFileForKeybuild pInput):= transform
		self.Case_Court_1 := Crim_Common.CountyKey.CountyNameStrings[1 + ((Crim_Common.CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * Crim_Common.CountyKey.ElementsPerCounty)];
		self.Case_Court_2 := Crim_Common.CountyKey.CountyNameStrings[2 + ((Crim_Common.CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * Crim_Common.CountyKey.ElementsPerCounty)];
		self.Case_Court_3 := Crim_Common.CountyKey.CountyNameStrings[3 + ((Crim_Common.CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * Crim_Common.CountyKey.ElementsPerCounty)];
		self.Case_Court_4 := Crim_Common.CountyKey.CountyNameStrings[4 + ((Crim_Common.CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * Crim_Common.CountyKey.ElementsPerCounty)];
		self.Case_Court_5 := Crim_Common.CountyKey.CountyNameStrings[5 + ((Crim_Common.CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * Crim_Common.CountyKey.ElementsPerCounty)];
		self.Case_Court_6 := Crim_Common.CountyKey.CountyNameStrings[6 + ((Crim_Common.CountyKey.VendorIDToCountyIndex(pInput.Vendor) - 1) * Crim_Common.CountyKey.ElementsPerCounty)];
		self.LFMName	  := lSingleSpace(pInput.lname,
										  pInput.fname,
										  pInput.mname
										 );
		self := pInput;
	end;

	rCountyKeysTableNormalizedRecord tNormalizeCounty(rCountyKeysTableRecord pInput,unsigned1 pCounter):= transform
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

lCountyKeysTableNamed		 := project(lMoxieFileForKeybuild(Vendor in Crim_Common.CountyKey.CountyVendorIDSet),tCreateCountyNameRecord(left));
lCountyKeysTableNamedNorm 	 := normalize(lCountyKeysTableNamed,6,tNormalizeCounty(left,counter));
lCountyKeysTableNamedDeduped := dedup(lCountyKeysTableNamedNorm(trim(Case_Court)<>''),State_Origin,Case_Court,__filepos,all);

	A21 := buildindex(lCountyKeysTableNamedDeduped,{State_Origin,Case_Court,LFMName,
									(big_endian unsigned8)__filepos},
									lBaseKeyName + 'st.county.lfmname.key',moxie,overwrite);

//===========================================================

// Offender keys
export Out_Offender_Keys := parallel
 (
	A01,   // fcra_criminal_offender.did.key                                                              
	A02,   // fcra_criminal_offender.Offender_Key.key                                                     
	A03,   // fcra_criminal_offender.SSN.key                                                              
	A04,   // fcra_criminal_offender.Case_Number.State_Origin.key                                         
	A05,   // fcra_criminal_offender.lfmname.key                                                          
	A06,   // fcra_criminal_offender.dob.lfmname.key                                                      
	A07,   // fcra_criminal_offender.mfname.dob.key                                                       
	A08,   // fcra_criminal_offender.dob.fmlname.key                                                      
	A09,   // fcra_criminal_offender.z5.lfmname.key                                                       
	A10,   // fcra_criminal_offender.st.city.lfmname.key                                                  
	A11,   // fcra_criminal_offender.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key          
	A12,   // fcra_criminal_offender.z5.prim_name.prim_range.key                                          
	A13,   // fcra_criminal_offender.z5.dph_lname.fname.mname.lname.key                                   
	A14,   // fcra_criminal_offender.st.city.dph_lname.fname.mname.lname.key                              
	A15,   // fcra_criminal_offender.dob_year.dob_month.dph_lname.lfmname.key                             
	A16,   // fcra_criminal_offender.dph_lname.fname.mname.lname.key                                      
	A17,   // fcra_criminal_offender.st.lfmname.key                                                       
	A18,   // fcra_criminal_offender.st.dph_lname.fname.mname.lname.key                                   
	A19,   // fcra_criminal_offender.st.dob_year.dob_month.dph_lname.lfmname.key                          
	A20,   // fcra_criminal_offender.st_ids.state_origin.key                                              
	A21    // fcra_criminal_offender.st.county.lfmname.key                                                
 );