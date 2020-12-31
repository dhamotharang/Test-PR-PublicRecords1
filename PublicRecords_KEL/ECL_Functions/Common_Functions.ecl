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
	EXPORT IsFcra(STRING FunctionDescription) := FunctionDescription IN AccLogs_Constants.FCRA_Functions;
	EXPORT IsNonFcra(STRING FunctionDescription) := FunctionDescription IN AccLogs_Constants.nonFCRA_Functions;
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

	// Ideally we would roll this ConsumerSourceGroup function into the SourceGroup logic above that is used for source groupings from 
	// the BIP Header. However, since there are some differences in the source roll-up groupings between business and consumer,
	// we'll keep them separate.
	EXPORT ConsumerSourceGroup(STRING RawSource) := CASE(RawSource,
		MDR.sourceTools.src_AK_Perm_Fund => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_AK_Perm_Fund,
		MDR.sourceTools.src_Airmen => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Airmen,
		MDR.sourceTools.src_Aircrafts => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Aircrafts,
		MDR.sourceTools.src_Bankruptcy => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Bankruptcy,
		MDR.sourceTools.src_US_Coastguard => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_US_Coastguard,
		MDR.sourceTools.src_Certegy => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Certegy,
		MDR.sourceTools.src_DE_Experian_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_ID_Experian_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_IL_Experian_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_KY_Experian_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_MS_Experian_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_ME_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_MI_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_FL_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_ID_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_KY_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_MO_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_MN_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_OH_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_MA_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_NC_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_TN_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_TX_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_WI_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_SC_Experian_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_WY_DL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DL,
		MDR.sourceTools.src_DEA => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_DEA,
		MDR.sourceTools.src_Death_NV => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_VA => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_CA => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_FL => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_GA => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_MI => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_MT => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_OH => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_Master => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_State => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_Obituary => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_OKC_Probate => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_Death_Tributes => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Death,
		MDR.sourceTools.src_EMerge_Boat => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_EMerge_Boat,
		MDR.sourceTools.src_Experian_Phones => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Experian_Phones,
		MDR.sourceTools.src_EMerge_Hunt => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_EMerge,
		MDR.sourceTools.src_EMerge_Fish => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_EMerge,
		MDR.sourceTools.src_EMerge_CCW => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_EMerge,
		MDR.sourceTools.src_EMerge_Cens => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_EMerge,
		MDR.sourceTools.src_EMerge_Master => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_EMerge,
		MDR.sourceTools.src_Experian_Credit_Header => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Experian_Credit_Header,
		MDR.sourceTools.src_Equifax => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Equifax,
		MDR.sourceTools.src_Equifax_Quick => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Equifax,
		MDR.sourceTools.src_Equifax_Weekly => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Equifax,
		MDR.sourceTools.src_Federal_Explosives => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Federal_Explosives,
		MDR.sourceTools.src_Federal_Firearms => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Federal_Firearms,
		MDR.sourceTools.src_Foreclosures => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Foreclosures,
		MDR.sourceTools.src_Liens_v2 => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Liens_v2,
		MDR.sourceTools.src_Liens => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Liens_v2,
		MDR.sourceTools.src_MS_Worker_Comp => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_MS_Worker_Comp,
		MDR.sourceTools.src_Foreclosures_Delinquent => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Foreclosures_Delinquent,
		MDR.sourceTools.src_LnPropV2_Fares_Asrs => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_LnPropV2,
		MDR.sourceTools.src_LnPropV2_Fares_Deeds => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_LnPropV2,
		MDR.sourceTools.src_LnPropV2_Lexis_Asrs => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_LnPropV2,
		MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_LnPropV2,
		MDR.sourceTools.src_Fares_Deeds_from_Asrs => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_LnPropV2,
		MDR.sourceTools.src_AlloyMedia_student_list => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_StudentList,
		MDR.sourceTools.src_American_Students_List => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_StudentList,
		MDR.sourceTools.src_OKC_Students_List => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_OKC_Students_List,
		MDR.sourceTools.src_TU_CreditHeader => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_TU_CreditHeader,
		MDR.sourceTools.src_TUCS_Ptrack => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_TUCS_Ptrack,
		MDR.sourceTools.src_Lexis_Trans_Union => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_TransUnion,
		MDR.sourceTools.src_TransUnion => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_TransUnion,
		MDR.sourceTools.src_Mixed_Utilities => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Utilities,
		MDR.sourceTools.src_Utilities => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Utilities,
		MDR.sourceTools.src_Util_Work_Phone => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Utilities,
		MDR.sourceTools.src_ZUtil_Work_Phone => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Utilities,
		MDR.sourceTools.src_ZUtilities => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Utilities,
		MDR.sourceTools.src_OH_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_WY_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_DE_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_DC_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_TX_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_SD_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_AR_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_AZ_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_IA_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_KS_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_NC_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_RI_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_VT_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_ND_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_AK_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_ME_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_AL_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_CO_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_NE_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_FL_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_FL_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_NE_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_IL_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_ID_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_ID_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_KY_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_KY_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_LA_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MT_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_GA_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle, 
		MDR.sourceTools.src_MD_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MS_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MA_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MN_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_OK_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_OH_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MI_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_NY_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_ME_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_NC_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_SC_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MO_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_TN_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_TX_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_UT_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MN_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_WI_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_WI_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MS_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MO_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_WY_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_MT_Experian_Veh => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Vehicle,
		MDR.sourceTools.src_Voters_v2 => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Voters_v2,
		MDR.sourceTools.src_AK_Fishing_boats => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_AK_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_WA_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_MN_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_MS_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_MT_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_NE_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_UT_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_WY_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_MO_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_FL_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_GA_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_KS_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_MA_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_KY_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_AL_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_NC_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_OH_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_IL_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_ME_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_AR_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_SC_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_TN_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_WI_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_MI_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_NY_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_AZ_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_TX_Watercraft => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Watercraft,
		MDR.sourceTools.src_Targus_White_pages => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Targus_White_pages,
		MDR.sourceTools.src_Professional_License => PublicRecords_KEL.ECL_Functions.Constants.SourceGroup_Professional_License,
		'');

	EXPORT GetLinkIDs(DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_FDC) shell) := FUNCTION
		
		BIPV2.IDlayouts.l_xlink_ids2 grabLinkIDs(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_FDC le) := TRANSFORM
			SELF.UniqueID		:= le.UIDAppend;
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
	
SHARED marketinglay := record
Codes.layout_codes_v3-long_flag;
end;	

SHARED marketinglayout := record
string2 code;
end;	

SHARED marketingtemp := dataset([{'VENDOR_SOURCES','DIRECTMARKETING','SCODE','',''}],marketinglay);	
	
SHARED getmarketing := join(marketingtemp,	Codes.Key_Codes_V3,
							keyed(left.file_name = right.file_name and 
										left.field_name = right.field_name and 
										left.field_name2 = right.field_name2),
										Transform(marketinglayout,
											self.code := right.code,
											self := []));

SHARED s1_daily := set(getmarketing, (string)code);

EXPORT IsMarketingAllowedKey(string src, string st = '') := FUNCTION
			
			RETURN(((src IN s1_daily)
			AND NOT (src = MDR.sourceTools.src_LnPropV2_Lexis_Asrs
			AND st IN ['ID','IL','KS','NM','SC','WA', ''])
			AND NOT (src = MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs
			AND st IN ['ID','IL','KS','NM','SC','WA', ''])));
			
end;			
	
END;	