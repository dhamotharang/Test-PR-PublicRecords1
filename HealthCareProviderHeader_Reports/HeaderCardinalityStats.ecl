import HealthCareProvider, SALT28;
EXPORT HeaderCardinalityStats (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Header_DS = HealthCareProvider.Files.Provider_Header_DS) := FUNCTION

	SALT28.MAC_Character_Counts.X_Data_Layout Into(Header_DS le,unsigned C) := TRANSFORM
		SELF.id := le.LNPID;
		SELF.Src := le.SRC;
		SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT28.StrType)le.RID),
															TRIM((SALT28.StrType)le.LNPID), 			
															TRIM((SALT28.StrType)le.DID), 			
															TRIM((SALT28.StrType)le.BDID), 			
															TRIM((SALT28.StrType)le.DOTID), 			
															TRIM((SALT28.StrType)le.EMPID), 			
															TRIM((SALT28.StrType)le.POWID), 			
															TRIM((SALT28.StrType)le.PROXID), 			
															TRIM((SALT28.StrType)le.SELEID), 			
															TRIM((SALT28.StrType)le.ORGID), 			
															TRIM((SALT28.StrType)le.ULTID), 			
															TRIM((SALT28.StrType)le.SRC), 			
															TRIM((SALT28.StrType)le.SOURCE_RID), 		
															TRIM((SALT28.StrType)le.DT_FIRST_SEEN), 		
															TRIM((SALT28.StrType)le.DT_LAST_SEEN), 		
															TRIM((SALT28.StrType)le.DT_VENDOR_FIRST_REPORTED), 
															TRIM((SALT28.StrType)le.DT_VENDOR_LAST_REPORTED), 
															TRIM((SALT28.StrType)le.DT_LIC_BEGIN), 		
															TRIM((SALT28.StrType)le.DT_LIC_EXPIRATION), 	
															TRIM((SALT28.StrType)le.DT_DEA_EXPIRATION), 	
															TRIM((SALT28.StrType)le.DT_NPI_DEACT), 	
															TRIM((SALT28.StrType)le.DT_ADDRESS_VERIFIED), 	
															TRIM((SALT28.StrType)le.DT_BUS_INCORPORATED), 	
															TRIM((SALT28.StrType)le.SUPPRESS_ADDRESS), 	
															TRIM((SALT28.StrType)le.ENTITY_TYPE), 	
															TRIM((SALT28.StrType)le.IS_STATE_SANCTION), 	
															TRIM((SALT28.StrType)le.IS_OIG_SANCTION), 	
															TRIM((SALT28.StrType)le.IS_OPM_SANCTION), 	
															TRIM((SALT28.StrType)le.IS_PUBLIC_PRIVATE_COMP), 	
															TRIM((SALT28.StrType)le.IS_PROFIT_NONPROFIT_COMP), 																						
															TRIM((SALT28.StrType)le.SSN), 			
															TRIM((SALT28.StrType)le.CNSMR_SSN), 																								
															TRIM((SALT28.StrType)le.DOB), 
															TRIM((SALT28.StrType)le.CNSMR_DOB), 																					
															TRIM((SALT28.StrType)le.PHONE), 			
															TRIM((SALT28.StrType)le.FAX), 			
															TRIM((SALT28.StrType)le.LIC_NBR), 		
															TRIM((SALT28.StrType)le.C_LIC_NBR), 		
															TRIM((SALT28.StrType)le.LIC_STATE), 		
															TRIM((SALT28.StrType)le.LIC_TYPE), 		
															TRIM((SALT28.StrType)le.LIC_STATUS), 		
															TRIM((SALT28.StrType)le.TITLE), 			
															TRIM((SALT28.StrType)le.FNAME), 			
															TRIM((SALT28.StrType)le.MNAME), 			
															TRIM((SALT28.StrType)le.LNAME), 			
															TRIM((SALT28.StrType)le.SNAME), 			
															TRIM((SALT28.StrType)le.CNAME), 			
															TRIM((SALT28.StrType)le.CNP_NAME), 			
															TRIM((SALT28.StrType)le.CNP_NUMBER), 			
															TRIM((SALT28.StrType)le.CNP_STORE_NUMBER), 																								
															TRIM((SALT28.StrType)le.CNP_BTYPE), 																								
															TRIM((SALT28.StrType)le.CNP_LOWV), 																																													
															TRIM((SALT28.StrType)le.SIC_CODE), 		
															TRIM((SALT28.StrType)le.GENDER), 			
															TRIM((SALT28.StrType)le.DERIVED_GENDER), 		
															TRIM((SALT28.StrType)le.ADDRESS_ID),
															TRIM((SALT28.StrType)le.ADDRESS_CLASSIFICATION),
															TRIM((SALT28.StrType)le.PRIM_RANGE),
															TRIM((SALT28.StrType)le.PRIM_NAME),
															TRIM((SALT28.StrType)le.SEC_RANGE), 		
															TRIM((SALT28.StrType)le.V_CITY_NAME), 		
															TRIM((SALT28.StrType)le.ST), 			
															TRIM((SALT28.StrType)le.ZIP),
															TRIM((SALT28.StrType)le.DEATH_IND),
															TRIM((SALT28.StrType)le.DOD),
															TRIM((SALT28.StrType)le.TAX_ID),
															TRIM((SALT28.StrType)le.BILLING_TAX_ID),
															TRIM((SALT28.StrType)le.FEIN),
															TRIM((SALT28.StrType)le.DERIVED_FEIN),
															TRIM((SALT28.StrType)le.UPIN), 			
															TRIM((SALT28.StrType)le.NPI_NUMBER),
															TRIM((SALT28.StrType)le.BILLING_NPI_NUMBER),
															TRIM((SALT28.StrType)le.DEA_BUS_ACT_IND), 																							
															TRIM((SALT28.StrType)le.DEA_NUMBER), 		
															TRIM((SALT28.StrType)le.CLIA_NUMBER), 		
															TRIM((SALT28.StrType)le.TAXONOMY), 		
															TRIM((SALT28.StrType)le.MEDICARE_FACILITY_NUMBER), 
															TRIM((SALT28.StrType)le.MEDICAID_NUMBER), 
															TRIM((SALT28.StrType)le.NCPDP_NUMBER), 	
															TRIM((SALT28.StrType)le.SPECIALITY_CODE), 																					
															TRIM((SALT28.StrType)le.PROVIDER_STATUS), 																					
															TRIM((SALT28.StrType)le.VENDOR_ID)));
		SELF.FldNo := C;
	END;

	FldInv0 := NORMALIZE(Header_DS,71,Into(LEFT,COUNTER));


	FldIds := DATASET([
				 {1, 'RID'} 			
				,{2, 'LNPID'} 			
				,{3, 'DID'} 			
				,{4, 'BDID'} 			
				,{5, 'DOTID'} 			
				,{6, 'EMPID'} 			
				,{7, 'POWID'} 			
				,{8, 'PROXID'} 			
				,{9, 'SELEID'} 			
				,{10,'ORGID'} 			
				,{11,'ULTID'} 			
				,{12,'SRC'} 			
				,{13,'SOURCE_RID'} 		
				,{14,'DT_FIRST_SEEN'} 		
				,{15,'DT_LAST_SEEN'} 		
				,{16,'DT_VENDOR_FIRST_REPORTED'} 	
				,{17,'DT_VENDOR_LAST_REPORTED'} 	
				,{18,'DT_LIC_BEGIN'} 		
				,{19,'DT_LIC_EXPIRATION'} 		
				,{20,'DT_DEA_EXPIRATION'} 		
				,{21,'DT_NPI_DEACT'} 		
				,{22,'DT_ADDRESS_VERIFIED'} 	
				,{23,'DT_BUS_INCORPORATED'} 	
				,{24,'SUPPRESS_ADDRESS'} 		
				,{25,'ENTITY_TYPE'} 		
				,{26,'IS_STATE_SANCTION'} 		
				,{27,'IS_OIG_SANCTION'} 		
				,{28,'IS_OPM_SANCTION'} 	
				,{29,'IS_PUBLIC_PRIVATE_COMP'} 	
				,{30,'IS_PROFIT_NONPROFIT_COMP'} 	
				,{31,'SSN'} 			
				,{32,'CNSMR_SSN'} 							
				,{33,'DOB'} 
				,{34,'CNSMR_DOB'} 
				,{35,'PHONE'} 			
				,{36,'FAX'} 			
				,{37,'LIC_NBR'} 			
				,{38,'C_LIC_NBR'} 			
				,{39,'LIC_STATE'} 			
				,{40,'LIC_TYPE'} 			
				,{41,'LIC_STATUS'} 		
				,{42,'TITLE'} 			
				,{43,'FNAME'} 			
				,{44,'MNAME'} 			
				,{45,'LNAME'} 			
				,{46,'SNAME'} 			
				,{47,'CNAME'} 			
				,{48,'CNP_NAME'} 			
				,{49,'CNP_NUMBER'} 			
				,{50,'CNP_STORE_NUMBER'} 			
				,{51,'CNP_BTYPE'} 			
				,{52,'CNP_LOWV'} 			
				,{53,'SIC_CODE'} 			
				,{54,'GENDER'} 			
				,{55,'DERIVED_GENDER'} 		
				,{56,'ADDRESS_ID'}
				,{57,'ADDRESS_CLASSIFICATION'}
				,{58,'PRIM_RANGE'}
				,{59,'PRIM_NAME'}
				,{60,'SEC_RANGE'} 			
				,{61,'V_CITY_NAME'} 		
				,{62,'ST'} 			
				,{63,'ZIP'}
				,{64,'DEATH_IND'}
				,{65,'DOD'}
				,{66,'TAX_ID'} 			
				,{67,'BILLING_TAX_ID'} 			
				,{68,'FEIN'}
				,{69,'DERIVED_FEIN'}
				,{70,'UPIN'} 			
				,{71,'NPI_NUMBER'}
				,{72,'BILLING_NPI_NUMBER'}
				,{73,'DEA_BUS_ACT_IND'} 		
				,{74,'DEA_NUMBER'} 		
				,{75,'CLIA_NUMBER'} 		
				,{76,'TAXONOMY'} 			
				,{77,'MEDICARE_FACILITY_NUMBER'} 		
				,{78,'MEDICAID_NUMBER'} 		
				,{79,'NCPDP_NUMBER'} 		
				,{80,'SPECIALITY_CODE'} 		
				,{81,'PROVIDER_STATUS'} 		
				,{82,'VENDOR_ID'}			
				],SALT28.MAC_Character_Counts.Field_Identification);

	AllProfiles  := SALT28.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
	
	HealthCareProviderHeader_Reports.Layouts.Header_Report_Count XFM () := TRANSFORM
			SELF.SRC														:= 'AL';
			SELF.RID_COUNT											:= IF((INTEGER)AllProfiles[1].cardinality - 1 > 0,(INTEGER)AllProfiles[1].cardinality - 1,0); 
			SELF.LNPID_COUNT										:= IF((INTEGER)AllProfiles[2].cardinality - 1 > 0,(INTEGER)AllProfiles[2].cardinality - 1,0); 
			SELF.DID_COUNT											:= IF((INTEGER)AllProfiles[3].cardinality - 1 > 0,(INTEGER)AllProfiles[3].cardinality - 1,0); 
			SELF.BDID_COUNT											:= IF((INTEGER)AllProfiles[4].cardinality - 1 > 0,(INTEGER)AllProfiles[4].cardinality - 1,0);
			SELF.DOTID_COUNT										:= IF((INTEGER)AllProfiles[5].cardinality - 1 > 0,(INTEGER)AllProfiles[5].cardinality - 1,0);
			SELF.EMPID_COUNT										:= IF((INTEGER)AllProfiles[6].cardinality - 1 > 0,(INTEGER)AllProfiles[6].cardinality - 1,0);
			SELF.POWID_COUNT										:= IF((INTEGER)AllProfiles[7].cardinality - 1 > 0,(INTEGER)AllProfiles[7].cardinality - 1,0);
			SELF.PROXID_COUNT										:= IF((INTEGER)AllProfiles[8].cardinality - 1 > 0,(INTEGER)AllProfiles[8].cardinality - 1,0);
			SELF.SELEID_COUNT										:= IF((INTEGER)AllProfiles[9].cardinality - 1 > 0,(INTEGER)AllProfiles[9].cardinality - 1,0);
			SELF.ORGID_COUNT										:= IF((INTEGER)AllProfiles[10].cardinality - 1 > 0,(INTEGER)AllProfiles[10].cardinality - 1,0);
			SELF.ULTID_COUNT										:= IF((INTEGER)AllProfiles[11].cardinality - 1 > 0,(INTEGER)AllProfiles[11].cardinality - 1,0);

			SELF.SRC_COUNT											:= IF((INTEGER)AllProfiles[12].cardinality - 1 > 0,(INTEGER)AllProfiles[12].cardinality - 1,0);
			SELF.SOURCE_RID_COUNT								:= IF((INTEGER)AllProfiles[13].cardinality - 1 > 0,(INTEGER)AllProfiles[13].cardinality - 1,0);
			SELF.DT_FIRST_SEEN_COUNT						:= IF((INTEGER)AllProfiles[14].cardinality - 1 > 0,(INTEGER)AllProfiles[14].cardinality - 1,0);
			SELF.DT_LAST_SEEN_COUNT							:= IF((INTEGER)AllProfiles[15].cardinality - 1 > 0,(INTEGER)AllProfiles[15].cardinality - 1,0);
			SELF.DT_VENDOR_FIRST_REPORTED_COUNT	:= IF((INTEGER)AllProfiles[16].cardinality - 1 > 0,(INTEGER)AllProfiles[16].cardinality - 1,0);
			SELF.DT_VENDOR_LAST_REPORTED_COUNT	:= IF((INTEGER)AllProfiles[17].cardinality - 1 > 0,(INTEGER)AllProfiles[17].cardinality - 1,0);
			SELF.DT_LIC_BEGIN_COUNT							:= IF((INTEGER)AllProfiles[18].cardinality - 1 > 0,(INTEGER)AllProfiles[18].cardinality - 1,0);
			SELF.DT_LIC_EXPIRATION_COUNT				:= IF((INTEGER)AllProfiles[19].cardinality - 1 > 0,(INTEGER)AllProfiles[19].cardinality - 1,0);
			SELF.DT_DEA_EXPIRATION_COUNT				:= IF((INTEGER)AllProfiles[20].cardinality - 1 > 0,(INTEGER)AllProfiles[20].cardinality - 1,0);
			SELF.DT_NPI_DEACT_COUNT							:= IF((INTEGER)AllProfiles[21].cardinality - 1 > 0,(INTEGER)AllProfiles[21].cardinality - 1,0);
			SELF.DT_ADDRESS_VERIFIED_COUNT			:= IF((INTEGER)AllProfiles[22].cardinality - 1 > 0,(INTEGER)AllProfiles[22].cardinality - 1,0);
			SELF.DT_BUS_INCORPORATED_COUNT			:= IF((INTEGER)AllProfiles[23].cardinality - 1 > 0,(INTEGER)AllProfiles[23].cardinality - 1,0);
			
			SELF.SUPPRESS_ADDRESS_COUNT					:= IF((INTEGER)AllProfiles[24].cardinality - 1 > 0,(INTEGER)AllProfiles[24].cardinality - 1,0);
			SELF.ENTITY_TYPE_COUNT							:= IF((INTEGER)AllProfiles[25].cardinality - 1 > 0,(INTEGER)AllProfiles[25].cardinality - 1,0);
			SELF.IS_STATE_SANCTION_COUNT				:= IF((INTEGER)AllProfiles[26].cardinality - 1 > 0,(INTEGER)AllProfiles[26].cardinality - 1,0);
			SELF.IS_OIG_SANCTION_COUNT					:= IF((INTEGER)AllProfiles[27].cardinality - 1 > 0,(INTEGER)AllProfiles[27].cardinality - 1,0);
			SELF.IS_OPM_SANCTION_COUNT					:= IF((INTEGER)AllProfiles[28].cardinality - 1 > 0,(INTEGER)AllProfiles[28].cardinality - 1,0);
			SELF.IS_PUBLIC_PRIVATE_COMP_COUNT		:= IF((INTEGER)AllProfiles[29].cardinality - 1 > 0,(INTEGER)AllProfiles[29].cardinality - 1,0);
			SELF.IS_PROFIT_NONPROFIT_COMP_COUNT	:= IF((INTEGER)AllProfiles[30].cardinality - 1 > 0,(INTEGER)AllProfiles[30].cardinality - 1,0);
			SELF.SSN_COUNT											:= IF((INTEGER)AllProfiles[31].cardinality - 1 > 0,(INTEGER)AllProfiles[31].cardinality - 1,0);
			SELF.CNSMR_SSN_COUNT								:= IF((INTEGER)AllProfiles[32].cardinality - 1 > 0,(INTEGER)AllProfiles[32].cardinality - 1,0);
			SELF.DOB_COUNT											:= IF((INTEGER)AllProfiles[33].cardinality - 1 > 0,(INTEGER)AllProfiles[33].cardinality - 1,0);
			SELF.CNSMR_DOB_COUNT		  					:= IF((INTEGER)AllProfiles[34].cardinality - 1 > 0,(INTEGER)AllProfiles[34].cardinality - 1,0);
			SELF.PHONE_COUNT										:= IF((INTEGER)AllProfiles[35].cardinality - 1 > 0,(INTEGER)AllProfiles[35].cardinality - 1,0);
			SELF.FAX_COUNT											:= IF((INTEGER)AllProfiles[36].cardinality - 1 > 0,(INTEGER)AllProfiles[36].cardinality - 1,0);
			
			SELF.LIC_NBR_COUNT									:= IF((INTEGER)AllProfiles[37].cardinality - 1 > 0,(INTEGER)AllProfiles[37].cardinality - 1,0);
			SELF.C_LIC_NBR_COUNT								:= IF((INTEGER)AllProfiles[38].cardinality - 1 > 0,(INTEGER)AllProfiles[38].cardinality - 1,0);
			SELF.LIC_STATE_COUNT								:= IF((INTEGER)AllProfiles[39].cardinality - 1 > 0,(INTEGER)AllProfiles[39].cardinality - 1,0);
			SELF.LIC_TYPE_COUNT									:= IF((INTEGER)AllProfiles[40].cardinality - 1 > 0,(INTEGER)AllProfiles[40].cardinality - 1,0);
			SELF.LIC_STATUS_COUNT								:= IF((INTEGER)AllProfiles[41].cardinality - 1 > 0,(INTEGER)AllProfiles[41].cardinality - 1,0);

			SELF.TITLE_COUNT										:= IF((INTEGER)AllProfiles[42].cardinality - 1 > 0,(INTEGER)AllProfiles[42].cardinality - 1,0);
			SELF.FNAME_COUNT										:= IF((INTEGER)AllProfiles[43].cardinality - 1 > 0,(INTEGER)AllProfiles[43].cardinality - 1,0);
			SELF.MNAME_COUNT										:= IF((INTEGER)AllProfiles[44].cardinality - 1 > 0,(INTEGER)AllProfiles[44].cardinality - 1,0);
			SELF.LNAME_COUNT										:= IF((INTEGER)AllProfiles[45].cardinality - 1 > 0,(INTEGER)AllProfiles[45].cardinality - 1,0);
			SELF.SNAME_COUNT										:= IF((INTEGER)AllProfiles[46].cardinality - 1 > 0,(INTEGER)AllProfiles[46].cardinality - 1,0);
			SELF.CNAME_COUNT										:= IF((INTEGER)AllProfiles[47].cardinality - 1 > 0,(INTEGER)AllProfiles[47].cardinality - 1,0);
			SELF.CNP_NAME_COUNT									:= IF((INTEGER)AllProfiles[48].cardinality - 1 > 0,(INTEGER)AllProfiles[48].cardinality - 1,0);
			SELF.CNP_NUMBER_COUNT								:= IF((INTEGER)AllProfiles[49].cardinality - 1 > 0,(INTEGER)AllProfiles[49].cardinality - 1,0);
			SELF.CNP_STORE_NUMBER_COUNT					:= IF((INTEGER)AllProfiles[50].cardinality - 1 > 0,(INTEGER)AllProfiles[50].cardinality - 1,0);
			SELF.CNP_BTYPE_COUNT								:= IF((INTEGER)AllProfiles[51].cardinality - 1 > 0,(INTEGER)AllProfiles[51].cardinality - 1,0);
			SELF.CNP_LOWV_COUNT									:= IF((INTEGER)AllProfiles[52].cardinality - 1 > 0,(INTEGER)AllProfiles[52].cardinality - 1,0);

			SELF.SIC_CODE_COUNT									:= IF((INTEGER)AllProfiles[53].cardinality - 1 > 0,(INTEGER)AllProfiles[53].cardinality - 1,0);
			SELF.GENDER_COUNT										:= IF((INTEGER)AllProfiles[54].cardinality - 1 > 0,(INTEGER)AllProfiles[54].cardinality - 1,0);
			SELF.DERIVED_GENDER_COUNT						:= IF((INTEGER)AllProfiles[55].cardinality - 1 > 0,(INTEGER)AllProfiles[55].cardinality - 1,0);

			SELF.ADDRESS_ID_COUNT								:= IF((INTEGER)AllProfiles[56].cardinality - 1 > 0,(INTEGER)AllProfiles[56].cardinality - 1,0);
			SELF.ADDRESS_CLASSIFICATION_COUNT		:= IF((INTEGER)AllProfiles[57].cardinality - 1 > 0,(INTEGER)AllProfiles[57].cardinality - 1,0);

			SELF.PRIM_RANGE_COUNT								:= IF((INTEGER)AllProfiles[58].cardinality - 1 > 0,(INTEGER)AllProfiles[58].cardinality - 1,0);
			SELF.PRIM_NAME_COUNT								:= IF((INTEGER)AllProfiles[59].cardinality - 1 > 0,(INTEGER)AllProfiles[59].cardinality - 1,0);
			SELF.SEC_RANGE_COUNT								:= IF((INTEGER)AllProfiles[60].cardinality - 1 > 0,(INTEGER)AllProfiles[60].cardinality - 1,0);
			SELF.V_CITY_NAME_COUNT							:= IF((INTEGER)AllProfiles[61].cardinality - 1 > 0,(INTEGER)AllProfiles[61].cardinality - 1,0);
			SELF.ST_COUNT												:= IF((INTEGER)AllProfiles[62].cardinality - 1 > 0,(INTEGER)AllProfiles[62].cardinality - 1,0);
			SELF.ZIP_COUNT											:= IF((INTEGER)AllProfiles[63].cardinality - 1 > 0,(INTEGER)AllProfiles[63].cardinality - 1,0);

			SELF.DEATH_IND_COUNT								:= IF((INTEGER)AllProfiles[64].cardinality - 1 > 0,(INTEGER)AllProfiles[64].cardinality - 1,0);
			SELF.DOD_COUNT											:= IF((INTEGER)AllProfiles[65].cardinality - 1 > 0,(INTEGER)AllProfiles[65].cardinality - 1,0);

			SELF.TAX_ID_COUNT										:= IF((INTEGER)AllProfiles[66].cardinality - 1 > 0,(INTEGER)AllProfiles[66].cardinality - 1,0);
			SELF.BILLING_TAX_ID_COUNT						:= IF((INTEGER)AllProfiles[67].cardinality - 1 > 0,(INTEGER)AllProfiles[67].cardinality - 1,0);
			SELF.FEIN_COUNT											:= IF((INTEGER)AllProfiles[68].cardinality - 1 > 0,(INTEGER)AllProfiles[68].cardinality - 1,0);
			SELF.DERIVED_FEIN_COUNT							:= IF((INTEGER)AllProfiles[69].cardinality - 1 > 0,(INTEGER)AllProfiles[69].cardinality - 1,0);
			SELF.UPIN_COUNT											:= IF((INTEGER)AllProfiles[70].cardinality - 1 > 0,(INTEGER)AllProfiles[70].cardinality - 1,0);
			SELF.NPI_NUMBER_COUNT								:= IF((INTEGER)AllProfiles[71].cardinality - 1 > 0,(INTEGER)AllProfiles[71].cardinality - 1,0);
			SELF.BILLING_NPI_NUMBER_COUNT				:= IF((INTEGER)AllProfiles[72].cardinality - 1 > 0,(INTEGER)AllProfiles[72].cardinality - 1,0);
			SELF.DEA_BUS_ACT_IND_COUNT					:= IF((INTEGER)AllProfiles[73].cardinality - 1 > 0,(INTEGER)AllProfiles[73].cardinality - 1,0);
			SELF.DEA_NUMBER_COUNT								:= IF((INTEGER)AllProfiles[74].cardinality - 1 > 0,(INTEGER)AllProfiles[74].cardinality - 1,0);
			SELF.CLIA_NUMBER_COUNT							:= IF((INTEGER)AllProfiles[75].cardinality - 1 > 0,(INTEGER)AllProfiles[75].cardinality - 1,0);
			SELF.TAXONOMY_COUNT									:= IF((INTEGER)AllProfiles[76].cardinality - 1 > 0,(INTEGER)AllProfiles[76].cardinality - 1,0);
			SELF.MEDICARE_FACILITY_COUNT				:= IF((INTEGER)AllProfiles[77].cardinality - 1 > 0,(INTEGER)AllProfiles[77].cardinality - 1,0);
			SELF.MEDICAID_NUMBER_COUNT					:= IF((INTEGER)AllProfiles[78].cardinality - 1 > 0,(INTEGER)AllProfiles[78].cardinality - 1,0);
			SELF.NCPDP_NUMBER_COUNT							:= IF((INTEGER)AllProfiles[79].cardinality - 1 > 0,(INTEGER)AllProfiles[79].cardinality - 1,0);
			SELF.SPECIALITY_CODE_COUNT					:= IF((INTEGER)AllProfiles[80].cardinality - 1 > 0,(INTEGER)AllProfiles[80].cardinality - 1,0);
			SELF.PROVIDER_STATUS_COUNT					:= IF((INTEGER)AllProfiles[81].cardinality - 1 > 0,(INTEGER)AllProfiles[81].cardinality - 1,0);
			SELF.VENDOR_ID_COUNT								:= IF((INTEGER)AllProfiles[82].cardinality - 1 > 0,(INTEGER)AllProfiles[82].cardinality - 1,0);
	END;

	SRC_Stats					   := DATASET ([XFM()]);
	
	RETURN SRC_Stats;
END;