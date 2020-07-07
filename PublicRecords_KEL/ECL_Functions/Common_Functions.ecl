IMPORT $.^.^.Business_Risk_BIP, $.^.^.MDR, $.^.^.ut, PublicRecords_KEL, BIPV2, Codes;

EXPORT Common_Functions := MODULE;
	
	EXPORT roll_list(dataset_to_roll, field_to_roll, delimiter) := FUNCTIONMACRO
		// cast the field we need to concatenate to a STRING so that it can be rolled up and preserve the same RECORD format.
		clean_dataset := PROJECT(dataset_to_roll, TRANSFORM({STRING roll_field},
			SELF.roll_field := (STRING)LEFT.field_to_roll));
	
			// Use ROLLUP to concatenate the dataset into a list	
			result := ROLLUP(clean_dataset, TRUE, TRANSFORM({string roll_field},
			SELF.roll_field := LEFT.roll_field + delimiter + RIGHT.roll_field));
		
		RETURN result[1].roll_field;
	ENDMACRO;
	
	EXPORT IsBadPhone(STRING InputPhone):=InputPhone IN ut.Set_BadPhones;
	EXPORT IsBadSSN(STRING InputSSN):=InputSSN IN ut.Set_BadSSN ;	

	// This is an adaption of Business_Risk_BIP.Common.GroupSources to take a STRING instead of a DATASET as input so the logic can be used in KEL. 
	// This function converts the raw business source codes into modeling friendly codes as specified by our modeling team.
	EXPORT SourceGroup(STRING RawSource) := MAP(
		RawSource IN MDR.SourceTools.set_Business_Registration			=> Business_Risk_BIP.Constants.Src_BusinessRegistration,
		RawSource IN MDR.SourceTools.set_CorpV2											=> Business_Risk_BIP.Constants.Src_CorpV2,
		RawSource IN MDR.SourceTools.set_Dunn_Bradstreet						=> Business_Risk_BIP.Constants.Src_DunnBradstreet,
		RawSource IN MDR.SourceTools.set_Dunn_Bradstreet_Fein				=> Business_Risk_BIP.Constants.Src_DunnBradstreetFEIN,
		RawSource IN MDR.SourceTools.set_EBR												=> Business_Risk_BIP.Constants.Src_Bureau,
		RawSource IN MDR.SourceTools.set_FBNv2											=> Business_Risk_BIP.Constants.Src_FBN,
		RawSource IN MDR.SourceTools.set_Frandx											=> Business_Risk_BIP.Constants.Src_Frandx,
		RawSource IN MDR.SourceTools.set_Liens											=> Business_Risk_BIP.Constants.Src_Liens,
		RawSource IN MDR.SourceTools.set_DCA												=> Business_Risk_BIP.Constants.Src_DCA,
		RawSource IN MDR.SourceTools.set_UCCS												=> Business_Risk_BIP.Constants.Src_UCC,
		RawSource IN MDR.SourceTools.set_Aircrafts									=> Business_Risk_BIP.Constants.Src_Aircrafts,
		RawSource IN MDR.SourceTools.set_Bk													=> Business_Risk_BIP.Constants.Src_Bankruptcy,
		RawSource IN MDR.SourceTools.set_BBB_Member									=> Business_Risk_BIP.Constants.Src_BBB_Member,
		RawSource IN MDR.SourceTools.set_BBB_Non_Member							=> Business_Risk_BIP.Constants.Src_BBB_Non_Member,
		RawSource IN MDR.SourceTools.set_Calbus											=> Business_Risk_BIP.Constants.Src_CalBus,
		RawSource IN MDR.SourceTools.set_Credit_Unions							=> Business_Risk_BIP.Constants.Src_CreditUnions,
		RawSource IN MDR.SourceTools.set_DEA												=> Business_Risk_BIP.Constants.Src_DEA,
		RawSource IN MDR.SourceTools.set_Experian_CRDB							=> Business_Risk_BIP.Constants.Src_ExperianCRDB,
		RawSource IN MDR.SourceTools.set_Experian_FEIN							=> Business_Risk_BIP.Constants.Src_ExperianFEIN,
		RawSource IN MDR.SourceTools.set_FDIC												=> Business_Risk_BIP.Constants.Src_FDIC,
		RawSource IN MDR.SourceTools.set_IRS_5500										=> Business_Risk_BIP.Constants.Src_IRS5500,
		RawSource IN MDR.SourceTools.set_IRS_Non_Profit							=> Business_Risk_BIP.Constants.Src_IRS_Non_Profit,
		RawSource IN MDR.SourceTools.set_Vehicles										=> Business_Risk_BIP.Constants.Src_Vehicles,
		RawSource IN MDR.SourceTools.set_OSHAIR											=> Business_Risk_BIP.Constants.Src_OSHA,
		RawSource IN MDR.SourceTools.set_Prolic											=> Business_Risk_BIP.Constants.Src_Prolic,
		RawSource IN MDR.SourceTools.set_Property										=> Business_Risk_BIP.Constants.Src_Property,
		RawSource IN MDR.SourceTools.set_SKA												=> Business_Risk_BIP.Constants.Src_SKA,
		RawSource IN MDR.SourceTools.set_TXBUS											=> Business_Risk_BIP.Constants.Src_TXBUS,
		RawSource IN MDR.SourceTools.set_INFOUSA_ABIUS_USABIZ				=> Business_Risk_BIP.Constants.Src_INFOUSA_ABIUS_USABIZ,
		RawSource IN MDR.SourceTools.set_WC													=> Business_Risk_BIP.Constants.Src_Watercraft,
		RawSource IN MDR.SourceTools.set_Yellow_Pages								=> Business_Risk_BIP.Constants.Src_Yellow_Pages,
		RawSource IN MDR.SourceTools.set_INFOUSA_DEAD_COMPANIES			=> Business_Risk_BIP.Constants.Src_INFOUSA_DEAD_COMPANIES,
		RawSource IN MDR.SourceTools.set_Diversity_Cert							=> Business_Risk_BIP.Constants.Src_Diversity_Cert,
		RawSource IN MDR.SourceTools.set_FCC_Radio_Licenses					=> Business_Risk_BIP.Constants.Src_FCC_Radio_Licenses,
		RawSource IN MDR.SourceTools.set_GSA												=> Business_Risk_BIP.Constants.Src_GSA,
		RawSource IN MDR.SourceTools.set_Gong												=> Business_Risk_BIP.Constants.Src_Gong,
		RawSource IN MDR.SourceTools.set_LaborActions_WHD						=> Business_Risk_BIP.Constants.Src_LaborActions_WHD,
		RawSource IN MDR.SourceTools.set_SEC_Broker_Dealer					=> Business_Risk_BIP.Constants.Src_SEC_Broker_Dealer,
		RawSource IN MDR.SourceTools.set_Workers_Compensation				=> Business_Risk_BIP.Constants.Src_Workers_Compensation,
		RawSource IN MDR.SourceTools.set_ACF												=> Business_Risk_BIP.Constants.Src_ACF,
		RawSource IN MDR.SourceTools.set_AMS												=> Business_Risk_BIP.Constants.Src_AMS,
		RawSource IN MDR.SourceTools.set_Atf												=> Business_Risk_BIP.Constants.Src_Atf,
		RawSource IN MDR.SourceTools.set_Bankruptcy_Attorney				=> Business_Risk_BIP.Constants.Src_Bankruptcy_Attorney,
		RawSource IN MDR.SourceTools.set_Ingenix_Sanctions					=> Business_Risk_BIP.Constants.Src_Ingenix_Sanctions,
		RawSource IN MDR.SourceTools.set_CA_Sales_Tax								=> Business_Risk_BIP.Constants.Src_CA_Sales_Tax,
		RawSource IN MDR.SourceTools.set_CLIA												=> Business_Risk_BIP.Constants.Src_CLIA,
		RawSource IN MDR.SourceTools.set_Edgar											=> Business_Risk_BIP.Constants.Src_Edgar,
		RawSource IN MDR.SourceTools.set_Employee_Directories				=> Business_Risk_BIP.Constants.Src_Employee_Directories,
		RawSource IN MDR.SourceTools.set_FDIC												=> Business_Risk_BIP.Constants.Src_FDIC,
		RawSource IN (MDR.SourceTools.set_Foreclosures + 
					MDR.SourceTools.set_Foreclosures_Delinquent)					=> Business_Risk_BIP.Constants.Src_Foreclosures,
		RawSource IN MDR.SourceTools.set_Garnishments								=> Business_Risk_BIP.Constants.Src_Garnishments,
		RawSource IN MDR.SourceTools.set_Insurance_Certification		=> Business_Risk_BIP.Constants.Src_Insurance_Certification,
		RawSource IN MDR.SourceTools.set_IA_Sales_Tax								=> Business_Risk_BIP.Constants.Src_IA_Sales_Tax,
		RawSource IN MDR.SourceTools.set_MartinDale_Hubbell					=> Business_Risk_BIP.Constants.Src_MartinDale_Hubbell,
		RawSource IN MDR.SourceTools.set_MS_Worker_Comp							=> Business_Risk_BIP.Constants.Src_MS_Worker_Comp,
		RawSource IN MDR.SourceTools.set_NaturalDisaster_Readiness	=> Business_Risk_BIP.Constants.Src_NaturalDisaster_Readiness,
		RawSource IN [MDR.SourceTools.src_NCPDP]										=> Business_Risk_BIP.Constants.Src_NCPDP,
		RawSource IN MDR.SourceTools.set_NPPES											=> Business_Risk_BIP.Constants.Src_NPPES,
		RawSource IN MDR.SourceTools.set_OIG												=> Business_Risk_BIP.Constants.Src_OIG,
		RawSource IN MDR.SourceTools.set_OR_Worker_Comp							=> Business_Risk_BIP.Constants.Src_OR_Worker_Comp,
		RawSource IN MDR.SourceTools.set_CrashCarrier								=> Business_Risk_BIP.Constants.Src_CrashCarrier,
		RawSource IN (MDR.SourceTools.set_SDAA + 
					MDR.SourceTools.set_SDA)															=> Business_Risk_BIP.Constants.Src_SDAA,
		RawSource IN MDR.SourceTools.set_Sheila_Greco								=> Business_Risk_BIP.Constants.Src_Sheila_Greco,
		RawSource IN MDR.SourceTools.set_Spoke											=> Business_Risk_BIP.Constants.Src_Spoke,
		RawSource  = MDR.SourceTools.src_Targus_Gateway							=> Business_Risk_BIP.Constants.Src_Targus_Gateway,
		RawSource IN MDR.SourceTools.set_Utility_sources						=> Business_Risk_BIP.Constants.Src_Utility_sources,
		RawSource IN MDR.SourceTools.set_Vickers										=> Business_Risk_BIP.Constants.Src_Vickers,
		RawSource IN MDR.SourceTools.set_Phones_Plus								=> Business_Risk_BIP.Constants.Src_PhonesPlus,
		RawSource IN MDR.SourceTools.set_Business_Credit						=> Business_Risk_BIP.Constants.Src_Business_Credit,
																																	 RawSource);
																																	 
	EXPORT GetLinkIDs(DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_FDC) shell) := FUNCTION
		
		BIPV2.IDlayouts.l_xlink_ids2 grabLinkIDs(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_FDC le) := TRANSFORM
			SELF.UniqueID		:= le.G_ProcBusUID;
			SELF.PowID			:= le.B_LexIDSite;
			SELF.PowScore		:= 0;
			SELF.PowWeight	:= 0;
			
			SELF.ProxID			:= le.B_LexIDLoc;
			SELF.ProxScore	:= 0;
			SELF.ProxWeight	:= 0;
			
			SELF.SeleID			:= le.B_LexIDLegal;
			SELF.SeleScore	:= 0;
			SELF.SeleWeight	:= 0;
			
			SELF.OrgID			:= le.B_LexIDOrg;
			SELF.OrgScore		:= 0;
			SELF.OrgWeight	:= 0;
	
			SELF.UltID			:= le.B_LexIDUlt;
			SELF.UltScore		:= 0;
			SELF.UltWeight	:= 0;
			
			SELF := []; // Don't populate DotID or EmpID
		END;
		
		linkIDsOnly := PROJECT(shell, grabLinkIDs(LEFT));
		
		RETURN linkIDsOnly;
	END;		
	
	EXPORT AppendSeq (RawData, RawShell, JoinResult, LinkSearchLevel) := MACRO
		JoinResult := JOIN(RawData, RawShell, LEFT.UltID = RIGHT.B_LexIDUlt AND // UltID should always match
																					(LEFT.OrgID= RIGHT.B_LexIDOrg OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltIDSet) AND // OrgID should match, OR we were doing an UltID only search
																					(LEFT.SeleID= RIGHT.B_LexIDLegal OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltOrgIDSet) AND // SeleID should match, OR we were doing an UltID/OrgID only search
																					(LEFT.ProxID = RIGHT.B_LexIDLoc OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltOrgSeleIDSet) AND // ProxID should match, OR we were doing an UltID/OrgID/SeleID/Default only search
																					(LEFT.PowID = RIGHT.B_LexIDSite OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltOrgSeleProxIDSet), // PowID should match, OR we were doing an UltID/OrgID/SeleID/Default/ProxID only search
									TRANSFORM({RECORDOF(LEFT), UNSIGNED4 UniqueID}, 
											SELF.UniqueID := RIGHT.uidappend; 
											SELF := LEFT), 
									FEW); // Can use FEW because the RIGHT side should contain < 10000 rows (100 only average in batch)
	ENDMACRO;		

	EXPORT AppendSeqAndLexID (RawData, RawShell, JoinResult, LinkSearchLevel) := MACRO
		JoinResult := JOIN(RawData, RawShell, LEFT.Contact_DID = RIGHT.P_LexID AND
																					LEFT.UltID = RIGHT.B_LexIDUlt AND // UltID should always match
																					(LEFT.OrgID= RIGHT.B_LexIDOrg OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltIDSet) AND // OrgID should match, OR we were doing an UltID only search
																					(LEFT.SeleID= RIGHT.B_LexIDLegal OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltOrgIDSet) AND // SeleID should match, OR we were doing an UltID/OrgID only search
																					(LEFT.ProxID = RIGHT.B_LexIDLoc OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltOrgSeleIDSet) AND // ProxID should match, OR we were doing an UltID/OrgID/SeleID/Default only search
																					(LEFT.PowID = RIGHT.B_LexIDSite OR LinkSearchLevel IN PublicRecords_KEL.ECL_Functions.Constants.UltOrgSeleProxIDSet), // PowID should match, OR we were doing an UltID/OrgID/SeleID/Default/ProxID only search
									TRANSFORM({RECORDOF(LEFT), UNSIGNED4 UniqueID /*, INTEGER7 P_LexID*/}, 
											SELF.UniqueID := RIGHT.UIDAppend; 
											// SELF.P_LexID := RIGHT.P_LexID;
											SELF := LEFT), 
									FEW); // Can use FEW because the RIGHT side should contain < 10000 rows (100 only average in batch)
	ENDMACRO;		
	
	EXPORT IsMarketingAllowedKey(string src, string st = '') := FUNCTION
			RETURN(EXISTS(Codes.Key_Codes_V3(KEYED(file_name = 'VENDOR_SOURCES') AND
			KEYED(field_name= 'DIRECTMARKETING') AND
			KEYED(field_name2 = 'SCODE') AND
			KEYED(code = src)
			AND NOT (src = MDR.sourceTools.src_LnPropV2_Lexis_Asrs
			AND st IN ['ID','IL','KS','NM','SC','WA', ''])
			AND NOT (src = MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs
			AND st IN ['ID','IL','KS','NM','SC','WA', '']))));
	END;
	
	
END;	