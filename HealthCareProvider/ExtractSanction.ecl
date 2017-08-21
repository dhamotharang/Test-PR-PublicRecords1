import Enclarity;
EXPORT ExtractSanction (DATASET (HealthCareProvider.Layouts.Sanction_Input) Input) := FUNCTION

	Vendor_DS := DEDUP(SORT (PROJECT (HealthCareProvider.Files.Provider_Header_DS (SRC = '64'),{UNSIGNED8 LNPID, STRING40 VENDOR_ID, BOOLEAN IS_STATE_SANCTION, BOOLEAN IS_OIG_SANCTION, BOOLEAN IS_OPM_SANCTION}),lnpid,vendor_id,MAP (IS_STATE_SANCTION or is_OIG_Sanction or is_OPM_Sanction => 1,2)),LNPID,LOCAL) : persist ('~thor::plugin::enclarity::lnpid::sanction');	

	Enclarity_Sanction_DS := HealthCareProvider.Files.Enclarity_Sanc_DS : persist ('~thor::enc::sanc', expire(10));

	Append_Vendor_ID := JOIN (Input,Vendor_DS,LEFT.LNPID = RIGHT.LNPID,TRANSFORM({UNSIGNED8 UniqueID, UNSIGNED8 LNPID, STRING40 Vendor_ID}, SELF.Vendor_ID := RIGHT.Vendor_ID; SELF := LEFT;), LEFT OUTER, HASH);
	
	RawData := JOIN(Append_Vendor_ID, Enclarity_Sanction_DS, LEFT.Vendor_ID = RIGHT.Group_Key AND RIGHT.Record_Type = 'C',TRANSFORM(HealthCareProvider.Layouts.Layout_Sanctions,
												 SELF.UniqueID:=LEFT.UniqueID;
													cleanCode := trim(right.sanc1_code,left,right);
													lastCharacter := cleanCode[length(cleanCode)];
													isReinstate := if(lastCharacter='R',true,false);
													SELF.isReinstatement := isReinstate;
													SELF.GROUP_KEY := LEFT.Vendor_ID;
													SELF	:= RIGHT;
													SELF 	:=[]),HASH); 

	UpdateLicenseStatus := DEDUP(SORT(JOIN(RawData,Append_Vendor_ID, LEFT.Group_Key	=	RIGHT.Vendor_ID,TRANSFORM(HealthCareProvider.Layouts.Layout_Sanctions,
																										// LicenseInfo := right.StateLicenses(LicenseState = left.sanc1_state and 
																																									// (LicenseNumber = left.sanc1_lic_num or LicenseNumberFmt = left.sanc1_lic_num));
																										self.LicenseStatus := ''; //if(exists(LicenseInfo),LicenseInfo[1].LicenseStatus,'');
																										SELF := LEFT),LEFT OUTER,HASH),RECORD),RECORD);

	Sanc_Cd := HealthCareProvider.Files.Enclarity_Sanc_Cd : persist ('~thor::enc::sanc::cd',expire(10));
	
	RawDataLookup1 := JOIN(UpdateLicenseStatus, Sanc_Cd,LEFT.sanc1_code = RIGHT.Sanc_Code,TRANSFORM(HealthCareProvider.Layouts.Layout_Sanctions,
																		SELF.Sanc_Desc := right.sanc_desc;
																		SELF := LEFT;
																		SELF :=[]),LEFT OUTER,HASH); 

	Prov_Type := HealthCareProvider.Files.Enclarity_Prov_Typ; 
	
	RawDataLookup2 := JOIN(RawDataLookup1, Prov_Type,
											LEFT.Sanc1_Prof_Type = RIGHT.Prov_Type_Code,TRANSFORM(HealthCareProvider.Layouts.Layout_Sanctions, 
											SELF.Prov_Type_Desc := IF(LEFT.sanc1_prof_type='MD','DOCTOR OF MEDICINE',RIGHT.prov_type_desc);
											SELF:=LEFT;
											SELF:=[]),LEFT OUTER,HASH); 

	RawDataLookup3 := JOIN(RawDataLookup2, Enclarity.LookupTables.dsSancLookup,LEFT.Sanc1_code = RIGHT.Code,TRANSFORM(HealthCareProvider.Layouts.Layout_Sanctions,
											SELF.SancCategory := RIGHT.Cat;
											SELF.SancLegacyType := MAP(LEFT.LicenseStatus='T' and LEFT.Sanc1_Code = '112DS' => RIGHT.LegacyType,
																								 LEFT.Sanc1_code = '112DS' => 'HISTORICAL CONDITIONS',
																								 RIGHT.LegacyType);
											SELF.FullDesc := right.desc;
											SELF.SancLevel := if(RIGHT.level='STATE','',RIGHT.level);
											SELF.StateOrFederal := if(RIGHT.level='STATE','STATE','FEDERAL');
											SELF.SancLossOfLic := if((integer)left.ln_derived_rein_date>0,'FALSE',right.LossOfLicense);
											SELF:=left;
											SELF:=[]),LEFT OUTER,HASH); 
	
	RawDataLookup4 := JOIN(RawDataLookup3, Enclarity.LookupTables.dsBoardInfo,LEFT.Sanc1_State = RIGHT.State AND LEFT.Prov_Type_Desc = RIGHT.ProviderType,
											TRANSFORM(HealthCareProvider.Layouts.Layout_Sanctions,
											SELF.RegulatingBoard := IF(RIGHT.RegulatingBoard <> '',RIGHT.RegulatingBoard,LEFT.RegulatingBoard);
											SELF:=LEFT;
											SELF:=[]),LEFT OUTER,HASH);
											
	GrpDate := DEDUP(SORT(rawdatalookup4,UniqueID,ProviderID,group_key,sanc1_state,sanc1_lic_num,-sanc1_date),UniqueID,ProviderID,group_key,sanc1_state,sanc1_lic_num);
							
	Sanctions_Final := join(rawdatalookup4,grpDate, left.UniqueID=right.UniqueID and LEFT.group_key=RIGHT.group_key and LEFT.ProviderID = RIGHT.ProviderID and
																	LEFT.sanc1_state=RIGHT.sanc1_state and LEFT.sanc1_lic_num=RIGHT.sanc1_lic_num,
																	TRANSFORM (HealthCareProvider.Layouts.Layout_Sanctions, SELF.GroupSancDate:=right.sanc1_date;self:=left;),HASH);

	FinalSort := DEDUP(SORT(GROUP(SORT(Sanctions_Final,UniqueID,ProviderID,group_key,-GroupSancDate,sanc1_state,sanc1_lic_num,-sanc1_date),UniqueID,ProviderID),RECORD),RECORD);
			
			
	HealthCareProvider.Layouts.Layout_Sanctions addSeq (HealthCareProvider.Layouts.Layout_Sanctions inp,INTEGER C) := TRANSFORM
		SELF.GroupSortOrder := C;
		SELF := inp;
	END;

	SetGrpSortOrder := project(finalSort,addSeq(left,counter));
	
	Final:= UNGROUP (SORT (SetGrpSortOrder,UniqueID,ProviderID,group_key,GroupSortOrder));

	AppendLookups := Final; 
	
	
	Layout_Child_Sanctions := RECORD	
		UNSIGNED8	UniqueID := 0;
		STRING40 	Group_Key :='';
		DATASET (HealthCareProvider.Layouts.Layout_Sanctions) childinfo;
	END;	

	Layout_child_sanctions doRollup(HealthCareProvider.Layouts.Layout_Sanctions L, dataset(HealthCareProvider.Layouts.Layout_Sanctions) R) := TRANSFORM
		SELF.UniqueID 	:= L.UniqueID;
		SELF.Group_key 	:= L.Group_Key;
		SELF.Childinfo 	:= R;
	END;

	//Group them by State and Lic, then group so they stay together, then sort to get the most recent record first.
	// grpSanc := group(sort(appendLookups,UniqueID,ProviderID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date),UniqueID,ProviderID,group_key,GroupSancDate,sanc1_state,sanc1_lic_num);
	
	GrpSanc := GROUP (SORT (AppendLookups,UniqueID,ProviderID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date),UniqueID,ProviderID,group_key);

	Sanctions_Rollup := ROLLUP (GrpSanc,group,doRollup(LEFT,ROWS(LEFT)));

	Results := JOIN (Input,Sanctions_Rollup,LEFT.UniqueID = RIGHT.UniqueID, TRANSFORM (HealthCareProvider.Layouts.Sanction_Combined, 
											SancRecs := SORT(RIGHT.childinfo,UniqueID,GroupSortOrder,Sanc1_State,Sanc1_Lic_Num,-Sanc1_Date);
											SELF.SanctionDate 					:=	SancRecs[1].Sanc1_Date;
											SELF.SanctionLicenseNumber	:=	SancRecs[1].sanc1_lic_num;
											SELF.SanctionLicenseState		:=	SancRecs[1].sanc1_state;
											SELF.SanctionCode						:=	SancRecs[1].sanc1_code;
											SELF.SanctionDescription		:=	SancRecs[1].FullDesc;
											SELF.ProfessionalType				:=	SancRecs[1].prov_type_desc;
											SELF.ReInstatementDate			:=	SancRecs[1].clean_sanc1_rein_date;
											SELF.Category								:=	SancRecs[1].sanccategory;
											SELF.Level									:=	SancRecs[1].level;
											SELF.LegacyType							:=	SancRecs[1].sanclegacytype;
											SELF.LossOfLicense					:=	IF (SancRecs[1].sanclossoflic = 'TRUE',TRUE,FALSE);
											SELF.StateORFederal					:=	SancRecs[1].stateorfederal;
											SELF.RegulatingBoard				:=	SancRecs[1].regulatingboard;
											SELF.SanctionLicenseStatus	:=	SancRecs[1].licensestatus;
											SELF.hasStateSanction				:=	EXISTS(SancRecs(stateorfederal='STATE'));
											SELF.hasOIGSanction					:=	EXISTS(SancRecs(stateorfederal='FEDERAL' and SancLevel = 'OIG'));
											SELF.hasOPMSanction					:=	EXISTS(SancRecs(stateorfederal='FEDERAL' and SancLevel = 'OPM'));
											SELF := LEFT;
							), LEFT OUTER, HASH);
	
	RETURN Results;
END;

