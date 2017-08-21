IMPORT LiensV2_preprocess, LiensV2, ut, STD, Address, VersionControl;

EXPORT ProcessCA_Federal := FUNCTION

	process_date := (string)STD.Date.Today();

	//Process Filing file - filter out filing types: 1, 2, 3, 4
	fFilingIn	:= LiensV2_Preprocess.Files.CA_Filing(initial_filing_type not in ['1','2','3','4']);
	
	LiensV2.Layout_Liens_CA_Federal_Filing_Info xfrmFiling(LiensV2_Preprocess.Layouts_CA_Federal.Filing L) := TRANSFORM
		PadLength	:= 14 - length(L.Initial_Filing_Number);
		self.TMSID := 'CA' + (string)INTFORMAT((integer)L.Initial_Filing_Number,14,1);
		self.RMSID := 'CR' + (string)INTFORMAT((integer)L.Initial_Filing_Number,14,1);
		self.process_date := process_date;
		self.static_value := ut.rmv_ld_zeros(L.static_value);
		self.Initial_Filing_type := ut.CleanSpacesAndUpper(L.Initial_Filing_type);
		self.Filing_Status	:= ut.CleanSpacesAndUpper(L.Filing_Status);
		self.Initial_Filing_type_desc := LiensV2_preprocess.Code_lkps.CA_FileType(self.Initial_Filing_type);
		self.filing_status_desc	:= LiensV2_preprocess.Code_lkps.CA_FileStatus(self.Filing_Status);
		self := L;
		self := [];
	END;
	
	AddIDFiling := PROJECT(fFilingIn(Initial_Filing_Number != 'st Floor'), xfrmFiling(left));
	
	filing_out	:= output(AddIDFiling,,LiensV2_preprocess.root + process_date +'::caf::filings',overwrite);
	
	AKA_ATTN_Pattern	:= '(.*)(DBA |AKA |FKA |C/O |ATTN |T/A )(.*)';
	//Join filing to Business Debtor to get TMSID/RMSID
	LiensV2.Layout_liens_CA_Federal_Business_Debtor xfrmBusDebtor(LiensV2_Preprocess.Files.CA_BusDebt L, AddIDFiling R) := TRANSFORM
		self.process_date		:= R.process_date;
		self.TMSID					:= R.TMSID;
		self.RMSID					:= R.RMSID;
		self.Static_Value		:= ut.rmv_ld_zeros(L.static_value);
		self.Business_Debtor_Name		:= ut.CleanSpacesAndUpper(L.Business_Debtor_Name);
		self.Business_Debtor_Street_Address	:= ut.CleanSpacesAndUpper(L.Business_Debtor_Street_Address);
		self.Business_Debtor_City			:= ut.CleanSpacesAndUpper(L.Business_Debtor_City);
		self.Business_Debtor_State		:= ut.CleanSpacesAndUpper(L.Business_Debtor_State);
		self.Business_Debtor_Zip_Code	:= TRIM(L.Business_Debtor_Zip_Code);
		self.Business_Debtor_ZipCode_Extension	:= TRIM(L.Business_Debtor_ZipCode_Extension);
		self.Business_Debtor_Country_Code	:= ut.CleanSpacesAndUpper(L.Business_Debtor_Country_Code); 
		self.clean_Business_debtor_addr	:= Address.CleanAddress182(trim(L.Business_Debtor_Street_Address,left,right),trim(L.Business_Debtor_City,left,right) + ', '+
																															 trim(L.Business_Debtor_State,left,right) +' '+ trim(L.Business_Debtor_Zip_Code,left,right)+ 
																															 trim(L.Business_Debtor_ZipCode_Extension,left,right));
		self.clean_Business_cname		:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^(DBA |AKA |FKA |C/O |ATTN |T/A )',L.Business_Debtor_Name),
																															REGEXREPLACE('^(DBA |AKA |FKA |C/O |ATTN |T/A )',L.Business_Debtor_Name,'',NOCASE),
																															IF(REGEXFIND(AKA_ATTN_Pattern,L.Business_Debtor_Name),
																																REGEXFIND(AKA_ATTN_Pattern,TRIM(L.Business_Debtor_Name,left,right),1,NOCASE),L.Business_Debtor_Name)));
		self.Filing_Jurisdiction		:= 'CA';
		self	:= L;
	END;
	
	jBusDebt_Filing	:= JOIN(LiensV2_Preprocess.Files.CA_BusDebt,
													AddIDFiling,
													TRIM(left.Initial_Filing_Number) = TRIM(right.Initial_Filing_Number),
													xfrmBusDebtor(left,right));
												
	BusDebt_out	:= output(jBusDebt_Filing,,LiensV2_preprocess.root + process_date +'::caf::busdtor',overwrite);
	
	//Join filing to Person Debtor to get TMSID/RMSID
	LiensV2.Layout_Liens_CA_Fedral_Person_Debtor xfrmPersDebtor(LiensV2_Preprocess.Files.CA_PersDebt L, AddIDFiling R) := TRANSFORM
		self.process_date		:= R.process_date;
		self.TMSID					:= R.TMSID;
		self.RMSID					:= R.RMSID;
		self.Static					:= ut.rmv_ld_zeros(L.static);
		self.Personal_Debtor_Last_Name		:= ut.CleanSpacesAndUpper(L.Personal_Debtor_Last_Name);
		self.Personal_Debtor_First_Name		:= ut.CleanSpacesAndUpper(L.Personal_Debtor_First_Name);
		self.Personal_Debtor_Middle_Name	:= ut.CleanSpacesAndUpper(L.Personal_Debtor_Middle_Name);
		self.Personal_Debtor_Suffix				:= ut.CleanSpacesAndUpper(L.Personal_Debtor_Suffix);
		self.Personal_Debtor_Street_Address	:= ut.CleanSpacesAndUpper(L.Personal_Debtor_Street_Address);
		self.Personal_Debtor_City			:= ut.CleanSpacesAndUpper(L.Personal_Debtor_City);
		self.Personal_Debtor_State		:= ut.CleanSpacesAndUpper(L.Personal_Debtor_State);
		self.Personal_Debtor_Zip_Code	:= TRIM(L.Personal_Debtor_Zip_Code);
		self.Personal_Debtor_Zip_Code_Extension	:= TRIM(L.Personal_Debtor_Zip_Code_Extension);
		self.Personal_Debtor_Country_Code	:= ut.CleanSpacesAndUpper(L.Personal_Debtor_Country_Code); 
		self.clean_Person_debtor_addr	:= Address.CleanAddress182(trim(L.Personal_Debtor_Street_Address,left,right),trim(L.Personal_Debtor_City,left,right) + ', '+
																															 trim(L.Personal_Debtor_State,left,right) +' '+ trim(L.Personal_Debtor_Zip_Code,left,right)+ 
																															 trim(L.Personal_Debtor_Zip_Code_Extension,left,right));
		self.clean_person_debtor_pname		:= Address.CleanPersonFML73(ut.CleanSpacesAndUpper(L.Personal_Debtor_First_Name)
																																	+' '+ut.CleanSpacesAndUpper(L.Personal_Debtor_Middle_Name)
																																	+' '+ut.CleanSpacesAndUpper(L.Personal_Debtor_Last_Name)
																																	+' '+ut.CleanSpacesAndUpper(L.Personal_Debtor_Suffix));
		self.Filing_Jurisdiction		:= 'CA';
		self	:= L;
	END;
	
	jPersDebt_Filing	:= JOIN(LiensV2_Preprocess.Files.CA_PersDebt,
														AddIDFiling,
														TRIM(left.Initial_Filing_Number) = TRIM(right.Initial_Filing_Number),
														xfrmPersDebtor(left,right));
	
	PersDebt_out	:= output(jPersDebt_Filing,,LiensV2_preprocess.root + process_date +'::caf::perdtor',overwrite);
	
	//Join filing to Business Secure Party to get TMSID/RMSID
	LiensV2.Layout_Liens_CA_Fedral_Business_secured_party xfrmBusSecPrty(LiensV2_Preprocess.Files.CA_BusSecParty L, AddIDFiling R) := TRANSFORM
		self.process_date		:= R.process_date;
		self.TMSID					:= R.TMSID;
		self.RMSID					:= R.RMSID;
		self.Static					:= ut.rmv_ld_zeros(L.static_value);
		self.Business_Secured_Party_Name			:= ut.CleanSpacesAndUpper(L.Business_Secured_Party_Name);
		self.Business_Secured_Party_Street_Address	:= ut.CleanSpacesAndUpper(L.Business_Secured_Party_Street_Address);
		self.Business_Secured_Party_City			:= ut.CleanSpacesAndUpper(L.Business_Secured_Party_City);
		self.Business_Secured_Party_State			:= ut.CleanSpacesAndUpper(L.Business_Secured_Party_State);
		self.Business_Secured_Party_Zip_Code	:= TRIM(L.Business_Secured_Party_Zip_Code);
		self.Business_Secured_Party_Zip_Code_Extension	:= TRIM(L.Business_Secured_Party_Zip_Code_Extension);
		self.Business_Secured_Party_Country_Code	:= ut.CleanSpacesAndUpper(L.Business_Secured_Party_Country_Code);
		TempCleanSecureParty							:= ut.CleanSpacesAndUpper(IF(REGEXFIND('^(DBA |AKA |FKA |C/O |ATTN |T/A )',L.Business_Secured_Party_Name),
																															REGEXREPLACE('^(DBA |AKA |FKA |C/O |ATTN |T/A )',L.Business_Secured_Party_Name,'',NOCASE),
																															IF(REGEXFIND(AKA_ATTN_Pattern,L.Business_Secured_Party_Name),
																																REGEXFIND(AKA_ATTN_Pattern,TRIM(L.Business_Secured_Party_Name,left,right),1,NOCASE),L.Business_Secured_Party_Name)));
		self.clean_secured_party_cname		:= REGEXREPLACE('[,]$',IF(REGEXFIND(AKA_ATTN_Pattern,TempCleanSecureParty),
																																REGEXFIND(AKA_ATTN_Pattern,TempCleanSecureParty,1,NOCASE),TempCleanSecureParty),
																												''); //secondary check added as name contained combo AKA and C/O name and only one was cleaned
		self.Clean_Business_Secured_Party_address	:= Address.CleanAddress182(trim(L.Business_Secured_Party_Street_Address,left,right),trim(L.Business_Secured_Party_City,left,right) + ', '+
																															 trim(L.Business_Secured_Party_State,left,right) +' '+ trim(L.Business_Secured_Party_Zip_Code,left,right)+ 
																															 trim(L.Business_Secured_Party_Zip_Code_Extension,left,right));
		self.Filing_Jurisdiction		:= 'CA';
		self	:= L;
	END;
	
	jBusSecPrty_Filing	:= JOIN(LiensV2_Preprocess.Files.CA_BusSecParty,
														AddIDFiling,
														TRIM(left.Initial_Filing_Number) = TRIM(right.Initial_Filing_Number),
														 xfrmBusSecPrty(left,right));
	
	BusSecParty_out	:= output(jBusSecPrty_Filing,,LiensV2_preprocess.root + process_date +'::caf::bussecp',overwrite);
	
	//Join filing to Person Secure Party to get TMSID/RMSID
		LiensV2.Layout_Liens_CA_Fedral_Person_Secured_party xfrmPersSecPrty(LiensV2_Preprocess.Files.CA_PersSecParty L, AddIDFiling R) := TRANSFORM
		self.process_date		:= R.process_date;
		self.TMSID					:= R.TMSID;
		self.RMSID					:= R.RMSID;
		self.Static					:= ut.rmv_ld_zeros(L.static_value);
		self.Personal_Secured_Party_Last_Name		:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Last_Name);
		self.Personal_Secured_Party_First_Name		:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_First_Name);
		self.Personal_Secured_Party_Middle_Name	:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Middle_Name);
		self.Personal_Secured_Party_Suffix				:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Suffix);
		self.Personal_Secured_Party_Street_Address	:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Street_Address);
		self.Personal_Secured_Party_City			:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_City);
		self.Personal_Secured_Party_State		:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_State);
		self.Personal_Secured_Party_Zip_Code	:= TRIM(L.Personal_Secured_Party_Zip_Code);
		self.Personal_Secured_Party_Zip_Code_Extension	:= TRIM(L.Personal_Secured_Party_Zip_Code_Extension);
		self.Personal_Secured_Party_Country_Code	:= ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Country_Code); 
		self.clean_secured_party_addr	:= Address.CleanAddress182(trim(L.Personal_Secured_Party_Street_Address,left,right),trim(L.Personal_Secured_Party_City,left,right) + ', '+
																															 trim(L.Personal_Secured_Party_State,left,right) +' '+ trim(L.Personal_Secured_Party_Zip_Code,left,right)+ 
																															 trim(L.Personal_Secured_Party_Zip_Code_Extension,left,right));
		self.clean_secured_party_pname		:= Address.CleanPersonFML73(ut.CleanSpacesAndUpper(L.Personal_Secured_Party_First_Name)
																																	+' '+ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Middle_Name)
																																	+' '+ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Last_Name)
																																	+' '+ut.CleanSpacesAndUpper(L.Personal_Secured_Party_Suffix));
		self.Filing_Jurisdiction		:= 'CA';
		self	:= L;
	END;
	
	jPersSecPrty_Filing	:= JOIN(LiensV2_Preprocess.Files.CA_PersSecParty,
														AddIDFiling,
														TRIM(left.Initial_Filing_Number) = TRIM(right.Initial_Filing_Number),
														xfrmPersSecPrty(left,right));
														
	PersSecParty_out	:= output(jPersSecPrty_Filing,,LiensV2_preprocess.root + process_date +'::caf::persecp',overwrite);
	
	//Join filing to Change Filing to get TMSID/RMSID
	LiensV2.Layout_Liens_CA_Fedral_Change_Filing xfrmChangeFiling(LiensV2_Preprocess.Files.CA_ChngFiling L, AddIDFiling R) := TRANSFORM
		self.process_date		:= R.process_date;
		self.TMSID					:= R.TMSID;
		self.RMSID					:= R.RMSID;
		self.Change_Filing_Type	:= ut.CleanSpacesAndUpper(L.Change_Filing_Type);
		self	:= L;
		self	:= [];
	END;
	
	jChangeFiling_Filing	:= JOIN(LiensV2_Preprocess.Files.CA_ChngFiling,
																AddIDFiling,
																TRIM(left.Initial_Filing_Number) = TRIM(right.Initial_Filing_Number),
																xfrmChangeFiling(left,right));
																
	//Lookup Change filing type code
	ChngFilingType_lkp	:= LiensV2_preprocess.Files_lkp.change_filing;
	
	LiensV2.Layout_Liens_CA_Fedral_Change_Filing AddChngFilingDesc(jChangeFiling_Filing L, ChngFilingType_lkp R) := TRANSFORM
		self.Change_Filing_Type_desc := ut.CleanSpacesAndUpper(R.change_filing_desc);
		self := L;
  END;
	
	lkpChngFilingDesc	:= JOIN(jChangeFiling_Filing,
														ChngFilingType_lkp,
														trim(left.Change_Filing_Type) = trim(right.change_filing_cd),
														AddChngFilingDesc(left,right),left outer, lookup);
																
	ChangeFiling_out	:= output(lkpChngFilingDesc,,LiensV2_preprocess.root + process_date +'::caf::chgfilg',overwrite);
	
	//Join filing to Collateral to get TMSID/RMSID
	LiensV2.Layout_Liens_CA_Fedral_Collateral xfrmCollateral(LiensV2_Preprocess.Files.CA_Collateral L, AddIDFiling R) := TRANSFORM
		self.process_date		:= R.process_date;
		self.TMSID					:= R.TMSID;
		self.RMSID					:= R.RMSID;
		self.Static					:= ut.rmv_ld_zeros(L.static_value);
		self.Collateral_Description	:= ut.CleanSpacesAndUpper(L.Collateral_Description);
		self	:= L;
		self	:= [];
	END;
	
	jCollateral_Filing	:= JOIN(LiensV2_Preprocess.Files.CA_Collateral,
																AddIDFiling,
																TRIM(left.Initial_Filing_Number) = TRIM(right.Initial_Filing_Number),
																xfrmCollateral(left,right));
																
	Collateral_out	:= output(jCollateral_Filing,,LiensV2_preprocess.root + process_date +'::caf::colatrl',overwrite); //this file should be blank
	
	//Add to superfiles
	build_super 	:= sequential(
										 FileServices.StartSuperFileTransaction(),
										 FileServices.ClearSuperFile(LiensV2_preprocess.root + 'caf::filings'),
										 FileServices.AddSuperFile(LiensV2_preprocess.root+'caf::filings',LiensV2_preprocess.root + process_date +'::caf::filings'),
										 FileServices.ClearSuperFile(LiensV2_preprocess.root + 'caf::busdtor'),
										 FileServices.AddSuperFile(LiensV2_preprocess.root + 'caf::busdtor',LiensV2_preprocess.root + process_date +'::caf::busdtor'),
										 FileServices.ClearSuperFile(LiensV2_preprocess.root + 'caf::perdtor'),
										 FileServices.AddSuperFile(LiensV2_preprocess.root + 'caf::perdtor',LiensV2_preprocess.root + process_date +'::caf::perdtor'),
										 FileServices.ClearSuperFile(LiensV2_preprocess.root + 'caf::bussecp'),
										 FileServices.AddSuperFile(LiensV2_preprocess.root + 'caf::bussecp',LiensV2_preprocess.root + process_date +'::caf::bussecp'),
										 FileServices.ClearSuperFile(LiensV2_preprocess.root + 'caf::persecp'),
										 FileServices.AddSuperFile(LiensV2_preprocess.root + 'caf::persecp',LiensV2_preprocess.root + process_date +'::caf::persecp'),
										 FileServices.ClearSuperFile(LiensV2_preprocess.root + 'caf::chgfilg'),
										 FileServices.AddSuperFile(LiensV2_preprocess.root + 'caf::chgfilg',LiensV2_preprocess.root + process_date +'::caf::chgfilg'),
										 FileServices.FinishSuperFileTransaction()
												);
	
	RETURN sequential(filing_out,BusDebt_out, PersDebt_out, BusSecParty_out, PersSecParty_out, ChangeFiling_out, Collateral_out, build_super);
										
	END;