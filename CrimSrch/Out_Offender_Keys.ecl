import lib_keylib, lib_stringlib, lib_metaphone;

lBaseKeyName 	:= 'key::moxie.fcra_criminal_offender.';

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
	Layout_Moxie_Offender;
    unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset(CrimSrch.Name_Moxie_Offender_Dev,rMoxieFileForKeybuildLayout,flat);

//========================================================

rSimpleKeysTableRecord
 :=
  record
	lMoxieFileForKeybuild.DID;
	lMoxieFileForKeybuild.Offender_Key;
	lMoxieFileForKeybuild.SSN;
	lMoxieFileForKeybuild.state_of_origin;
	lMoxieFileForKeybuild.Case_Number;
	lMoxieFileForKeybuild.__filepos;
  end
 ;

lSimpleKeysTable := table(lMoxieFileForKeybuild,rSimpleKeysTableRecord);

A01 := buildindex(lSimpleKeysTable(DID<>''),
			{DID,(big_endian unsigned8)__filepos},
			lBaseKeyName + 'did.key',moxie,overwrite);
A02 :=buildindex(lSimpleKeysTable(Offender_Key<>''),
			{Offender_Key,(big_endian unsigned8)__filepos},
			lBaseKeyName + 'Offender_Key.key',moxie,overwrite);
A03 := buildindex(lSimpleKeysTable(SSN<>''),
			{SSN,(big_endian unsigned8)__filepos},
			lBaseKeyName + 'SSN.key',moxie,overwrite);
A04 := buildindex(lSimpleKeysTable(Case_Number+state_of_origin<>''),
			{Case_Number,state_of_origin,(big_endian unsigned8)__filepos},
			lBaseKeyName + 'Case_Number.State_Origin.key',moxie,overwrite);

//========================================================

rNameKeysTableRecord
 :=
  record
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
  end
 ;

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

rDPHLNameKeysTableRecord
 :=
  record
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

rStatesKeysTableRecord
 :=
  record
	lMoxieFileForKeybuild.State;
	lMoxieFileForKeybuild.state_of_origin;
	lMoxieFileForKeybuild.Place_Of_Birth;
	string45        LFMName   := lSingleSpace(lMoxieFileForKeybuild.lname,
											  lMoxieFileForKeybuild.fname,
											  lMoxieFileForKeybuild.mname
										     );
	lMoxieFileForKeybuild.__filepos;
  end
 ;

rStatesKeysTableRecord tNormalizeStates(rStatesKeysTableRecord pInput,unsigned1 pCounter)
 :=
  TRANSFORM
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

rStatesDPHKeysTableRecord
 :=
  record
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
  end
 ;

rStatesDPHKeysTableRecord tNormalizeStatesDPH(rStatesDPHKeysTableRecord pInput,unsigned1 pCounter)
 :=
  TRANSFORM
	self.State := map(pCounter = 1 or pCounter = 4 => lST_IDValidChar(pInput.State),
					  pCounter = 2 or pCounter = 5 => lST_IDValidChar(pInput.state_of_origin),
					  pCounter = 3 or pCounter = 6 => lST_IDValidChar(pInput.Place_Of_Birth),
					  ''
					 );
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

rST_IDsKeysTableRecord
 :=
  record
	string15 ST_IDs	:= '';
	lMoxieFileForKeybuild.State_of_Origin;
	lMoxieFileForKeybuild.Case_Number;
	lMoxieFileForKeybuild.offender_id_num_1;
	lMoxieFileForKeybuild.offender_id_num_2;
	lMoxieFileForKeybuild.__filepos;
  end
 ;

rST_IDsKeysTableRecord tNormalizeST_IDs(rST_IDsKeysTableRecord pInput,unsigned1 pCounter)
 :=
  TRANSFORM
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

//========================================================

lCountyVendorIDSet		:= ['16','17','18','19','20','21','22','23','24','25',
							'26','27','28','29','30','32','34','35','36','38',
							'A1','A2','A3','A4','A5','A6','A7','A8','A9','40',
							'42','43','44','45','47','49','50','51','AA','52',
							'53','54','55','56','57','58','59','60','AB','AC',
							'AD','62','63','AE','64','65','66','AF','67','AG',
							'AH','68','70','71','72','73','74','AI','75','76',
							'77','78','79','80','83','AJ','AN','AP','AQ','AS',
							'84','85','86','87','AT','AM'
						   ];
lElementsPerCounty		:= 6;	// must be this many names per county for this to work
lCountyNameStrings 		:= ['SAN BERNARDINO ',		// San Bernardino
							'SAN BERNADINO  ',
							'               ',
							'               ',
							'               ',
							'               ',
							'LOS ANGELES    ',		// Los Angeles
							'L.A.           ',
							'L. A.          ',
							'L A            ',
							'LA             ',
							'               ',
							'DADE           ',		// Dade
							'MIAMI-DADE     ',
							'MIAMI DADE     ',
							'               ',
							'               ',
							'               ',
							'PALM BEACH     ',		// Palm Beach
							'PALM BCH       ',
							'WEST PALM BEACH',
							'               ',
							'               ',
							'               ',
							'FRESNO         ',		// Fresno
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'ORANGE         ',		// Orange, CA
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SANDIEGO       ',		// San Diego
							'SAN DIEGO      ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SANTA BARBARA  ',		// Santa Barbara
							'SANTA BARBRA   ',
							'SANTABARBARA   ',
							'SANTABARBRA    ',
							'               ',
							'               ',
							'PIMA           ',		// Pima, AZ
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'HILLSBOROUGH   ',		// Hillsborough, FL
							'HILLSBORO      ',
							'               ',
							'               ',
							'               ',
							'               ',
							'HILLSBOROUGH   ',		// Hillsborough, FL (DMV)
							'HILLSBORO      ',
							'               ',
							'               ',
							'               ',
							'               ',
							'BROWARD        ',		// Broward, FL
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'BAY            ',		// Bay, FL
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'CONTRA COSTA   ',		// Contra Costa, CA
							'CONTRA COASTA  ',
							'               ',
							'               ',
							'               ',
							'               ',
							'CHARLOTTE      ',		// Charlotte, FL
							'CHARLOTT       ',
							'               ',
							'               ',
							'               ',
							'               ',
							'ALACHUA        ',		// Alachua, FL
							'ALLACHUA       ',
							'               ',
							'               ',
							'               ',
							'               ',
							'DUVAL          ',		// Duval, FL
							'DUVALL         ',
							'               ',
							'               ',
							'               ',
							'               ',
							'HINDS          ',		// Hinds, MS
							'HINES          ',
							'               ',
							'               ',
							'               ',
							'               ',
							'PINELLAS       ',		// Pinellas, FL
							'PINNELLAS      ',
							'PINNELAS       ',
							'PINELAS        ',
							'               ',
							'               ',
							'BEXAR          ',		// Bexar, TX
							'BEJAR          ',
							'BEHAR          ',
							'               ',
							'               ',
							'               ',
							'MARIN          ',		// Marin, CA (Arrest Logs)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SAN BERNARDINO ',		// San Bernardino, CA (Arrest Logs)
							'SAN BERNADINO  ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SANTA MONICA   ',		// Santa Monica, CA (Arrest Logs)
							'SANTAMONICA    ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SARASOTA       ',		// Sarasota, FL (Arrest Logs)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'BREVARD        ',		// Brevard, FL (Arrest Logs)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SHELBY         ',		// Shelby, TN (Arrest Logs)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'OKANOGAN       ',		// Okanogan, WA (Arrest Logs)
							'OKANOGON       ',
							'               ',
							'               ',
							'               ',
							'               ',
							'PLACER         ',		// Placer, CA (Arrest Logs)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'ESCAMBIA       ',		// Escambia, FL (Arrest Logs)
							'ESCOMBIA       ',
							'               ',
							'               ',
							'               ',
							'               ',
							'BREVARD        ',		// Brevard, FL
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'PASCO          ',		// Osceola, FL (Crim)
							'PASSCO         ',
							'               ',
							'               ',
							'               ',
							'               ',
							'PASCO          ',		// Pasco, FL (Traffic)
							'PASSCO         ',
							'               ',
							'               ',
							'               ',
							'               ',
							'OSCEOLA        ',		// Osceola, FL
							'OSSEOLA        ',
							'OSCEOLLA       ',
							'OSSEOLLA       ',
							'               ',
							'               ',
							'COOK           ',		// Cook, IL
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'TRAVIS         ',		// Travis, TX
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'MONTGOMERY     ',		// Montgomery, TX
							'MONTGOMEREY    ',
							'               ',
							'               ',
							'               ',
							'               ',
							'GREGG          ',		// Gregg, TX
							'GREG           ',
							'               ',
							'               ',
							'               ',
							'               ',
							'POTTER         ',		// Potter, TX
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'HARRIS         ',		// Harris, TX (Arrest Logs)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'HARRIS         ',		// Harris, TX (Court)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'RIVERSIDE      ',		// Riverside, CA (Court)
							'RIVER SIDE     ',
							'               ',
							'               ',
							'               ',
							'               ',
							'CHAMBERS       ',		// Chambers, TX (Court)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SACRAMENTO     ',		// Sacramento, CA (Court)
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'SANTACRUZ      ',		// Santa Cruz, CA (Court)
							'SANTA CRUZ     ',
							'               ',
							'               ',
							'               ',
							'               ',
							'FAIRFAX        ',		// Fairfax, VA (Court '57')
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'VICTORIA       ',		// Victoria, TX (Court '58')
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'EL PASO        ',		// El Paso, TX (Court '59')
							'ELPASO         ',
							'               ',
							'               ',
							'               ',
							'               ',
							'DENTON         ',		// Denton, TX (Court '60')
							'DENTIN         ',
							'               ',
							'               ',
							'               ',
							'               ',
							'VOLUSIA        ',		// Volusia, FL (Arrest Logs 'AB')
							'VOLUCIA        ',
							'               ',
							'               ',
							'               ',
							'               ',
							'YELLOWSTONE    ',		// Yellowstone, MT (Arrest Logs 'AC')
							'YELLOW STONE   ',
							'               ',
							'               ',
							'               ',
							'               ',
							'CALHOUN        ',		// Calhoun, AL (Arrest Logs 'AD')
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'MARIN          ',		// Marin, CA (Court '62')
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'LAKE           ',		// Lake, FL (Court '63')
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'ECTOR          ',		// Ector, TX (Arrest 'AE')
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'MENDOCINO      ',		// Mendocino, CA (Court '64')
							'MENDACINO      ',
							'               ',
							'               ',
							'               ',
							'               ',
							'MARICOPA       ',		// Maricopa, AZ (Court '65')
							'MERICOPA       ',
							'MARRICOPA      ',
							'MARACOPA       ',
							'               ',
							'               ',
							'DUVAL          ',		// Duval, FL (Court '66')
							'DUVALL         ',
							'               ',
							'               ',
							'               ',
							'               ',
							'BERNALILLO     ',		// Bernalillo, NM (Arrests 'AF')
							'BERNALILO      ',
							'BERNALEO       ',
							'               ',
							'               ',
							'               ',
							'ALACHUA        ',		// Alachua, FL (Traffic '67')
							'ALLACHUA       ',
							'               ',
							'               ',
							'               ',
							'               ',
							'LOS ANGELES    ',		// Los Angeles
							'L.A.           ',
							'L. A.          ',
							'L A            ',
							'LA             ',
							'               ',
							'BEXAR          ',		// Bexar, TX
							'BEJAR          ',
							'BEHAR          ',
							'               ',
							'               ',
							'               ',
							'ORANGE         ',		// Orange, FL
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'FORT BEND      ',		// Ft Bend, TX
							'FT BEND        ',
							'FT. BEND       ',
							'               ',
							'               ',
							'               ',
							'PORTAGE        ',		// Portage, OH
							'PORTEGE        ',
							'               ',
							'               ',
							'               ',
							'               ',
							'JOHNSON        ',		// Johnson, TX
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'STANISLAUS     ',		// Stanislaus, CA
							'STANISLAS      ',
							'STANILAUS      ',
							'               ',
							'               ',
							'               ',
							'GREENE         ',		// Greene, OH
							'GREEN          ',
							'GRENE          ',
							'               ',
							'               ',
							'               ',
							'BROWARD        ',		// Broward, FL - Arrest log.
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'INDIAN RIVER   ',		// Indian River, FL.
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'LEE            ',		// Lee, FL.
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'COMAL          ',		// Comal, TX.
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'LAMAR          ',		// Lamar, TX.
							'LEMAR          ',
							'               ',
							'               ',
							'               ',
							'               ',
							'PARKER         ',		// Parker, TX.
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'TOM GREEN      ',		// Tom Green, TX.
							'TOMGREEN       ',
							'               ',
							'               ',
							'               ',
							'               ',
							'WAYNE          ',		// Wayne, MI.
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'JEFFERSON      ',		// Jefferson, AL. 
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'GWINNETT       ',		// Gwinnett, GA.
							'GWINNET        ',
							'GWINETT        ',
							'GWINET         ',
							'               ',
							'               ',
							'LUBBOCK        ',		// Lubbock, TX.
							'LUBBACK        ',
							'               ',
							'               ',
							'               ',
							'               ',
							'MARICOPA       ',		// Maricopa, AZ.
							'MERICOPA       ',
							'MARRICOPA      ',
							'MARACOPA       ',
							'               ',
							'               ',
							'SAN DIEGO      ',		// San Diego, CA.
							'SANDIEGO       ',
							'               ',
							'               ',
							'               ',
							'               ',
							'VENTURA        ',		// Ventura, CA.
							'               ',
							'               ',
							'               ',
							'               ',
							'               ',
							'HIGHLAND       ',		// Highlands, FL.
							'HIGHLANDS      ',
							'               ',
							'               ',
							'               ',
							'               ',
							'COLLINS        ',		// Collin, TX.
							'COLINS         ',
							'COLLIN         ',
							'COLIN          ',
							'               ',
							'               ',
							'MIDLAND        ',		// Midland, TX.
							'MIDLAN         ',
							'MID LAND       ',
							'               ',
							'               ',
							'               ',
							'DADE           ',		// MiamiDade, FL - Arrest log.
							'MIAMI-DADE     ',
							'MIAMI DADE     ',
							'               ',
							'               ',
							'               ',
							'PALM BEACH     ',		// Palm Beach, FL - Arrest log.
							'PALM BCH       ',
							'WEST PALM BEACH',
							'               ',
							'               ',
							'               '
						   ];
						   

integer lVendorIDToCountyIndex(string2 pVendorID)
 := map(pVendorID = '16' => 1,
		pVendorID = '17' => 2,
		pVendorID = '18' => 3,
		pVendorID = '19' => 4,
		pVendorID = '20' => 5,
		pVendorID = '21' => 6,
		pVendorID = '22' => 7,
		pVendorID = '23' => 8,
		pVendorID = '24' => 9,
		pVendorID = '25' => 10,
		pVendorID = '26' => 11,
		pVendorID = '27' => 12,
		pVendorID = '28' => 13,
		pVendorID = '29' => 14,
		pVendorID = '30' => 15,
		pVendorID = '32' => 16,
		pVendorID = '34' => 17,
		pVendorID = '35' => 18,
		pVendorID = '36' => 19,
		pVendorID = '38' => 20,
		pVendorID = 'A1' => 21,
		pVendorID = 'A2' => 22,
		pVendorID = 'A3' => 23,
		pVendorID = 'A4' => 24,
		pVendorID = 'A5' => 25,
		pVendorID = 'A6' => 26,
		pVendorID = 'A7' => 27,
		pVendorID = 'A8' => 28,
		pVendorID = 'A9' => 29,
		pVendorID = '40' => 30,		
		pVendorID = '42' => 31,		
		pVendorID = '43' => 32,		
		pVendorID = '44' => 33,		
		pVendorID = '45' => 34,
		pVendorID = '47' => 35,
		pVendorID = '49' => 36,
		pVendorID = '50' => 37,
		pVendorID = '51' => 38,
		pVendorID = 'AA' => 39,
		pVendorID = '52' => 40,
		pVendorID = '53' => 41,
		pVendorID = '54' => 42,
		pVendorID = '55' => 43,
		pVendorID = '56' => 44,
		pVendorID = '57' => 45,
		pVendorID = '58' => 46,
		pVendorID = '59' => 47,
		pVendorID = '60' => 48,
		pVendorID = 'AB' => 49,
		pVendorID = 'AC' => 50,
		pVendorID = 'AD' => 51,
		pVendorID = '62' => 52,
		pVendorID = '63' => 53,
		pVendorID = 'AE' => 54,
		pVendorID = '64' => 55,
		pVendorID = '65' => 56,
		pVendorID = '66' => 57,
		pVendorID = 'AF' => 58,
		pVendorID = '67' => 59,
		pVendorID = 'AG' => 60,
		pVendorID = 'AH' => 61,
		pVendorID = '68' => 62,
		pVendorID = '70' => 63,
		pVendorID = '71' => 64,
		pVendorID = '72' => 65,
		pVendorID = '73' => 66,
		pVendorID = '74' => 67,
		pVendorID = 'AI' => 68,
		pVendorID = '75' => 69,
		pVendorID = '76' => 70,
		pVendorID = '77' => 71,
		pVendorID = '78' => 72,
		pVendorID = '79' => 73,
		pVendorID = '80' => 74,
		pVendorID = '83' => 75,
		pVendorID = 'AJ' => 76,
		pVendorID = 'AN' => 77,
		pVendorID = 'AP' => 78,
		pVendorID = 'AQ' => 79,
		pVendorID = 'AS' => 80,
		pVendorID = '84' => 81,
		pVendorID = '85' => 82,
		pVendorID = '86' => 83,
		pVendorID = '87' => 84,
		pVendorID = 'AT' => 85,
		pVendorID = 'AM' => 86,
		0
	   )
 ;
 
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
	lMoxieFileForKeybuild.__filepos;
  end
 ;

rCountyKeysTableNormalizedRecord
 :=
  record
	string2		state_origin := '';
	string40	Case_Court	 := '';
	string45    LFMName   	 := '';
	lMoxieFileForKeybuild.__filepos;
  end
 ;

rCountyKeysTableRecord tCreateCountyNameRecord(lMoxieFileForKeybuild pInput)
 :=
  transform
	self.Case_Court_1 := lCountyNameStrings[1 + ((lVendorIDToCountyIndex(pInput.Vendor) - 1) * lElementsPerCounty)];
	self.Case_Court_2 := lCountyNameStrings[2 + ((lVendorIDToCountyIndex(pInput.Vendor) - 1) * lElementsPerCounty)];
	self.Case_Court_3 := lCountyNameStrings[3 + ((lVendorIDToCountyIndex(pInput.Vendor) - 1) * lElementsPerCounty)];
	self.Case_Court_4 := lCountyNameStrings[4 + ((lVendorIDToCountyIndex(pInput.Vendor) - 1) * lElementsPerCounty)];
	self.Case_Court_5 := lCountyNameStrings[5 + ((lVendorIDToCountyIndex(pInput.Vendor) - 1) * lElementsPerCounty)];
	self.Case_Court_6 := lCountyNameStrings[6 + ((lVendorIDToCountyIndex(pInput.Vendor) - 1) * lElementsPerCounty)];
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

lCountyKeysTableNamed		 := project(lMoxieFileForKeybuild(Vendor in lCountyVendorIDSet),tCreateCountyNameRecord(left));
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