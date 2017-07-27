import doxie, tools;

export Keys(
	 string pversion = ''
  ,dataset(Layouts.Base.Main)		      pBaseMainlnpidBuilt		  =	Files(pversion).Base.Main.Built	
	,dataset(Layouts.Base.Credential)		pBaseCredentialBuilt		=	Files(pversion).Base.Credential.Built
	,dataset(Layouts.Base.Degree)				pBaseDegreeBuilt				=	Files(pversion).Base.Degree.Built
	,dataset(Layouts.Base.Specialty)		pBaseSpecialtyBuilt			=	Files(pversion).Base.Specialty.Built
	,dataset(Layouts.Base.StateLicense)	pBaseStateLicenseBuilt	=	Files(pversion).Base.StateLicense.Built
	,dataset(Layouts.Base.IDNumber)			pBaseIDNumberBuilt			=	Files(pversion).Base.IDNumber.Built
	,dataset(Layouts.Base.Affiliation)	pBaseAffiliationBuilt		=	Files(pversion).Base.Affiliation.Built
	,dataset(Layouts.Input.Code)				pUpdateCodeFile					=	Files().Input.Code.Using
) := module
 
  shared pBaseMainBuilt		:=	project (pBaseMainlnpidBuilt,Layouts.Base.Main_without_rid); 
	shared BaseMain := project(pBaseMainBuilt(AMS_ID != ''),Layouts.KeyBuild.Main);
	shared BaseMain_LNPID := dedup(sort(distribute(project(pBaseMainlnpidBuilt(lnpid>0),Layouts.KeyBuild.Main_Lnpid),lnpid),lnpid,ams_id,local),lnpid,ams_id,local);
	shared BaseMain_DID := BaseMain(DID != 0);
	shared BaseMain_BDID := BaseMain(BDID != 0);
	shared BaseMain_TaxID := BaseMain(rawdemographicsfields.TAX_ID != '');
	shared BaseCredential := project(pBaseCredentialBuilt(AMS_ID != ''),Layouts.KeyBuild.Credential);
	shared BaseDegree := project(pBaseDegreeBuilt(AMS_ID != ''),Layouts.KeyBuild.Degree);
	shared BaseSpecialty := project(pBaseSpecialtyBuilt(AMS_ID != ''),Layouts.KeyBuild.Specialty);
	shared BaseStateLicense := project(pBaseStateLicenseBuilt(AMS_ID != ''),Layouts.KeyBuild.StateLicense);
	shared BaseIDNumber := project(pBaseIDNumberBuilt(AMS_ID != ''),Layouts.KeyBuild.IDNumber);
	shared BaseAffiliation :=
		project(
			pBaseAffiliationBuilt(AMS_PARENT_ID != ''),
			transform(Layouts.KeyBuild.Affiliation,
				self.AMS_ID := left.AMS_PARENT_ID,
				self.isParent := true,
				self.AMS_OTHER_ID := left.AMS_CHILD_ID,
				self := left)) +
		project(
			pBaseAffiliationBuilt(AMS_CHILD_ID != ''),
			transform(Layouts.KeyBuild.Affiliation,
				self.AMS_ID := left.AMS_CHILD_ID,
				self.isParent := false,
				self.AMS_OTHER_ID := left.AMS_PARENT_ID,
				self := left));

	shared BaseMain_sorted := SORT(DISTRIBUTE(BaseMain, HASH(AMS_ID)),
													       RECORD,
													       LOCAL);
												
  ds_npi_code := pUpdateCodeFile(TRIM(CODE_NAME) = 'SRC_CD' AND TRIM(code_desc) = 'NPI');
  npi_code := TRIM(ds_npi_code[1].code_cd);  // There will be only 1 code for NPI

	ds_npi := BaseIDNumber(TRIM(rawfields.SRC_CD) = npi_code);
	ds_npi_sorted := SORT(DISTRIBUTE(ds_npi, HASH(AMS_ID)),
                        RECORD,
                        LOCAL);

	Layouts.Keybuild.Main_NPI add_npi(Layouts.KeyBuild.Main L, Layouts.KeyBuild.IDNumber R) := TRANSFORM
		SELF.NPI := R.rawfields.INDY_ID;
		SELF := L;
	END;

	shared BaseMain_NPI := DEDUP(JOIN(BaseMain_sorted, ds_npi_sorted,
															      LEFT.AMS_ID = RIGHT.AMS_ID,
															      add_npi(LEFT, RIGHT),
															      LOCAL),
															 RECORD,
															 LOCAL);

	shared Layouts.Keybuild.Main_License add_lic_info(Layouts.KeyBuild.Main L,
	                                                  Layouts.KeyBuild.StateLicense R) := TRANSFORM
		SELF.ST_LIC_NUM := R.rawfields.ST_LIC_NUM;
		SELF.ST_LIC_STATE := R.rawfields.ST_LIC_STATE;
		SELF := L;
	END;

	ds_licnum_state := BaseStateLicense(rawfields.ST_LIC_NUM != '' AND rawfields.ST_LIC_STATE != '');	
	ds_licnum_state_sorted := SORT(DISTRIBUTE(ds_licnum_state, HASH(AMS_ID)),
                                 RECORD,
                                 LOCAL);

  // With the addition of this key, we may not need the other 2 license keys.  Keeping them for now.
	shared BaseMain_LicenseNumberState := DEDUP(
	                                        SORT(
																					  JOIN(BaseMain_sorted, ds_licnum_state_sorted,
	                                               LEFT.AMS_ID = RIGHT.AMS_ID,
																				         add_lic_info(LEFT, RIGHT),
																				         LOCAL),
																						RECORD,
																						LOCAL),
																				  RECORD,
																				  LOCAL);

	ds_licnum := BaseStateLicense(rawfields.ST_LIC_NUM != '');	
	ds_licnum_sorted := SORT(DISTRIBUTE(ds_licnum, HASH(AMS_ID)),
                           RECORD,
                           LOCAL);

	shared BaseMain_LicenseNumber := DEDUP(
	                                   SORT(
																		   JOIN(BaseMain_sorted, ds_licnum_sorted,
	                                          LEFT.AMS_ID = RIGHT.AMS_ID,
																				    add_lic_info(LEFT, RIGHT),
																				    LOCAL),
																			 RECORD,
																			 LOCAL),
																		 RECORD,
																		 LOCAL);

	ds_licstate := BaseStateLicense(rawfields.ST_LIC_STATE != '');
	ds_licstate_sorted := SORT(DISTRIBUTE(ds_licstate, HASH(AMS_ID)),
                             RECORD,
                             LOCAL);
														 
	shared BaseMain_LicenseState := DEDUP(
	                                  SORT(
																		  JOIN(BaseMain_sorted, ds_licstate_sorted,
	                                         LEFT.AMS_ID = RIGHT.AMS_ID,
																			     add_lic_info(LEFT, RIGHT),
																			     LOCAL),
																			RECORD,
																			LOCAL),
																		RECORD,
																		LOCAL);

	export Main := module
		tools.mac_FilesIndex('BaseMain,{AMS_ID,record_type},{BaseMain}',KeyNames(pversion).Main.AMSID,AMSID);
		tools.mac_FilesIndex('BaseMain_LNPID,{lnpid},{AMS_ID}',KeyNames(pversion).Main.LNPID,LNPID);	
		tools.mac_FilesIndex('BaseMain_DID,{DID,AMS_ID},{BaseMain}',KeyNames(pversion).Main.DID,DID);
		tools.mac_FilesIndex('BaseMain_BDID,{BDID,AMS_ID},{BaseMain}',KeyNames(pversion).Main.BDID,BDID);
		tools.mac_FilesIndex('BaseMain_TaxID,{rawdemographicsfields.TAX_ID,AMS_ID},{BaseMain}',KeyNames(pversion).Main.TaxID,TaxID);
		tools.mac_FilesIndex('BaseMain_NPI,{NPI,AMS_ID},{BaseMain_NPI}',KeyNames(pversion).Main.NPI,NPI);
		tools.mac_FilesIndex('BaseMain_LicenseNumberState,{ST_LIC_NUM,ST_LIC_STATE,AMS_ID},{BaseMain_LicenseNumberState}',KeyNames(pversion).Main.LicenseNumberState,LicenseNumberState);
		tools.mac_FilesIndex('BaseMain_LicenseNumber,{ST_LIC_NUM,AMS_ID},{BaseMain_LicenseNumber}',KeyNames(pversion).Main.LicenseNumber,LicenseNumber);
		tools.mac_FilesIndex('BaseMain_LicenseState,{ST_LIC_STATE,AMS_ID},{BaseMain_LicenseState}',KeyNames(pversion).Main.LicenseState,LicenseState);
	end;
	export Credential := module
		tools.mac_FilesIndex('BaseCredential,{AMS_ID,record_type},{BaseCredential}',KeyNames(pversion).Credential.AMSID,AMSID);
	end;
	export Degree := module
		tools.mac_FilesIndex('BaseDegree,{AMS_ID,record_type},{BaseDegree}',KeyNames(pversion).Degree.AMSID,AMSID);
	end;
	export Specialty := module
		tools.mac_FilesIndex('BaseSpecialty,{AMS_ID,record_type},{BaseSpecialty}',KeyNames(pversion).Specialty.AMSID,AMSID);
	end;
	export StateLicense := module
		tools.mac_FilesIndex('BaseStateLicense,{AMS_ID,record_type},{BaseStateLicense}',KeyNames(pversion).StateLicense.AMSID,AMSID);
	end;
	export IDNumber := module
		tools.mac_FilesIndex('BaseIDNumber,{AMS_ID,record_type},{BaseIDNumber}',KeyNames(pversion).IDNumber.AMSID,AMSID);
	end;
	export Affiliation := module
		tools.mac_FilesIndex('BaseAffiliation,{AMS_ID,record_type,AMS_OTHER_ID},{BaseAffiliation}',KeyNames(pversion).Affiliation.AMSID,AMSID);
	end;

end;