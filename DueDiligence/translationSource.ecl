IMPORT MDR;

EXPORT translationSource := MODULE
 
    
    SHARED CATEGORY_BANKRUPTCY_FILING := 'Bankruptcy Filings';
    SHARED CATEGORY_CORPORATE_FILING := 'Corporate Filings';
    SHARED CATEGORY_BUSINESS_DIRECTORY := 'Business Directory';
    SHARED CATEGORY_CREDIT_REPORTING_DATABASE := 'Credit Reporting Database';
    SHARED CATEGORY_EXPERIAN_FEIN := 'Experian FEIN';
    SHARED CATEGORY_GOVERNMENT_AGENCY := 'Governmental Agency';
    SHARED CATEGORY_JUDGEMENT_LIEN_FILING := 'Judgments & Lien Filings';
    SHARED CATEGORY_OTHER_DIRECTORIES := 'Other Directories';
    SHARED CATEGORY_PERSONAL_PROPERTY := 'Personal Property';
    SHARED CATEGORY_REAL_PROPERTY := 'Real Property';
    SHARED CATEGORY_TELCO := 'Telco';
    SHARED CATEGORY_UCC_FILING := 'UCC Filings';
    
        
    SHARED RECORD_BBB_MEMBER := 'Better Business Bureau Member';
    SHARED RECORD_BBB_NON_MEMBER := 'Better Business Bureau Non-Member';
    SHARED RECORD_BOAT_REGISTRATION := 'Boat Registrations';
    SHARED RECORD_BUSINESS_DIRECTORY_2 := 'Business Directory 2';
    SHARED RECORD_BUSINESS_DIRECTORY_3 := 'Business Directory 3';
    SHARED RECORD_BUSINESS_PROFILE := 'Business Profile';
    SHARED RECORD_BUSINESS_REGISTRATION := 'Business Registration Records';
    SHARED RECORD_CA_BUSINESS_REGISTRATION := 'CA Business Registrations';
    SHARED RECORD_CREDIT_REPORTING_SOURCE_1 := 'Credit Reporting Source 1';
    SHARED RECORD_CREDIT_REPORTING_SOURCE_2 := 'Credit Reporting Source 2';
    SHARED RECORD_CREDIT_REPORTING_SOURCE_3 := 'Credit Reporting Source 3';
    SHARED RECORD_CREDIT_REPORTING_SOURCE_4 := 'Credit Reporting Source 4';
    SHARED RECORD_CREDIT_REPORTING_SOURCE_5 := 'Credit Reporting Source 5';
    SHARED RECORD_CREDIT_UNION := 'Credit Union Directory';
    SHARED RECORD_DEA := 'DEA Records';
    SHARED RECORD_DEED := 'Deed Records';
    SHARED RECORD_FAA_AIRCRAFT_REGISTRATION := 'FAA Aircraft Registrations';
    SHARED RECORD_FDIC := 'FDIC Record';
    SHARED RECORD_FICTITIOUS_BUSINESS := 'Fictitious Businesses';
    SHARED RECORD_IRS_5500 := 'IRS 5500 - Employee Benefit Plans';
    SHARED RECORD_IRS_NON_PROFIT := 'IRS 990 - Non-Profit';
    SHARED RECORD_MOTOR_VEHICLE_REGISTRATION := 'Motor Vehicle Registrations';
    SHARED RECORD_OSHA := 'OSHA Records';
    SHARED RECORD_TAX_ASSESSOR := 'Tax Assessor Records';
    SHARED RECORD_TX_BUSINESS_REGISTRATION := 'Texas Business Registration';
    SHARED RECORD_WORKERS_COMP := 'Workers Compensation Record';
    SHARED RECORD_YELLOW_PAGES := 'Yellow Page Records';
    
    
    
    SHARED Source := RECORD
      STRING2   code;
      STRING    category;
      STRING    recordType;
    END;
    
    SHARED sourceDS := DATASET([{MDR.SourceTools.src_Aircrafts,			  CATEGORY_PERSONAL_PROPERTY,	RECORD_FAA_AIRCRAFT_REGISTRATION},
                                {MDR.SourceTools.src_AK_Fishing_boats,CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_AK_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_AK_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_AK_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_AL_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_AL_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_AL_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_AR_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_AR_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_AR_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_AZ_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_AZ_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_AZ_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_Bankruptcy,		  CATEGORY_BANKRUPTCY_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_BBB_Member,		  CATEGORY_OTHER_DIRECTORIES,	RECORD_BBB_MEMBER},
                                {MDR.SourceTools.src_BBB_Non_Member,	CATEGORY_OTHER_DIRECTORIES,	RECORD_BBB_NON_MEMBER},
                                {MDR.SourceTools.src_Business_Credit,	CATEGORY_CREDIT_REPORTING_DATABASE,	RECORD_CREDIT_REPORTING_SOURCE_4},
                                {MDR.SourceTools.src_Business_Registration,		CATEGORY_OTHER_DIRECTORIES,	RECORD_BUSINESS_REGISTRATION},
                                {MDR.SourceTools.src_CA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_FBNV2_CA_San_Bernadino,	CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_CA_Sales_Tax,		CATEGORY_OTHER_DIRECTORIES,	RECORD_CA_BUSINESS_REGISTRATION},
                                {MDR.SourceTools.src_FBNV2_CA_Orange_county,	CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_FBNV2_CA_Ventura,	      CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_CO_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_CO_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_CO_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_CClue,				    CATEGORY_BUSINESS_DIRECTORY,	RECORD_BUSINESS_PROFILE},
                                {MDR.SourceTools.src_Cortera,			    CATEGORY_CREDIT_REPORTING_DATABASE,	RECORD_CREDIT_REPORTING_SOURCE_1},
                                {MDR.SourceTools.src_FBNV2_Hist_Choicepoint,	CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_Credit_Unions,		CATEGORY_OTHER_DIRECTORIES,	RECORD_CREDIT_UNION},
                                {MDR.SourceTools.src_FBNV2_CA_Santa_Clara,		CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_CT_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_CT_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_CT_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_DC_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_DC_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_DCA,				      CATEGORY_BUSINESS_DIRECTORY,	RECORD_BUSINESS_PROFILE},
                                {MDR.SourceTools.src_DE_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_DEA,				      CATEGORY_GOVERNMENT_AGENCY,	RECORD_DEA},
                                {MDR.SourceTools.src_Dunn_Bradstreet,	CATEGORY_BUSINESS_DIRECTORY,	RECORD_BUSINESS_PROFILE},
                                {MDR.SourceTools.src_Dunn_Bradstreet_Fein,		CATEGORY_CREDIT_REPORTING_DATABASE,	RECORD_CREDIT_REPORTING_SOURCE_5},
                                {MDR.SourceTools.src_FBNV2_Experian_Direct,		CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_EBR,				      CATEGORY_CREDIT_REPORTING_DATABASE,	RECORD_CREDIT_REPORTING_SOURCE_2},
                                {MDR.SourceTools.src_Experian_CRDB,		CATEGORY_CREDIT_REPORTING_DATABASE,	RECORD_CREDIT_REPORTING_SOURCE_3},
                                {MDR.SourceTools.src_Experian_FEIN_Rest,		CATEGORY_EXPERIAN_FEIN,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_Experian_FEIN_Unrest,		CATEGORY_EXPERIAN_FEIN,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_FDIC,				    CATEGORY_OTHER_DIRECTORIES,	RECORD_FDIC},
                                {MDR.SourceTools.src_FL_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_FL_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_FBNV2_FL,			  CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_FL_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_FL_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_Frandx,			    CATEGORY_OTHER_DIRECTORIES,	RECORD_BUSINESS_DIRECTORY_3},
                                {MDR.SourceTools.src_GA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_GA_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_GA_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_HI_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_IA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_IA_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_IA_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_ID_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_ID_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_ID_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_IL_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_IL_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_IL_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_IN_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_FBNV2_INF,			  CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_INFOUSA_ABIUS_USABIZ,		CATEGORY_OTHER_DIRECTORIES,	RECORD_BUSINESS_DIRECTORY_2},
                                {MDR.SourceTools.src_IRS_5500,			  CATEGORY_OTHER_DIRECTORIES,	RECORD_IRS_5500},
                                {MDR.SourceTools.src_IRS_Non_Profit,	CATEGORY_OTHER_DIRECTORIES,	RECORD_IRS_NON_PROFIT},
                                {MDR.SourceTools.src_KS_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_KS_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_KS_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_KY_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_KY_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_KY_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_KY_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_LA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_LA_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_Liens_v2,			  CATEGORY_JUDGEMENT_LIEN_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_LnPropV2_Fares_Asrs,		  CATEGORY_REAL_PROPERTY,	RECORD_TAX_ASSESSOR},
                                {MDR.SourceTools.src_LnPropV2_Fares_Deeds,		CATEGORY_REAL_PROPERTY,	RECORD_DEED},
                                {MDR.SourceTools.src_LnPropV2_Lexis_Asrs,		  CATEGORY_REAL_PROPERTY,	RECORD_TAX_ASSESSOR},
                                {MDR.SourceTools.src_LnPropV2_Lexis_Deeds_Mtgs,	CATEGORY_REAL_PROPERTY,	RECORD_DEED},
                                {MDR.SourceTools.src_MA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_MA_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MA_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_MD_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_MD_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MD_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_ME_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_ME_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_ME_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_ME_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_MI_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_MI_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MI_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_MN_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_MN_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MN_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MN_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_MO_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_MO_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MO_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MO_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_MS_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_MS_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MS_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MS_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_MT_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_MT_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MT_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_MT_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_FBNV2_New_York,	CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_NC_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_NC_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NC_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NC_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_ND_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_ND_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_ND_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_ND_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_NE_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_NE_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NE_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NE_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_NH_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_NH_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_NJ_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_NM_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_NM_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NM_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_NV_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_NV_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NV_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NV_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_NY_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_NY_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_NY_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_OH_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_OH_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_OH_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_OH_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_OK_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_OK_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_OR_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_OR_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_OSHAIR,			    CATEGORY_GOVERNMENT_AGENCY,	RECORD_OSHA},
                                {MDR.SourceTools.src_PA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_RI_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_RI_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_SC_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_SC_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_SC_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_SD_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_SD_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_TXBUS,				    CATEGORY_OTHER_DIRECTORIES,	RECORD_TX_BUSINESS_REGISTRATION},
                                {MDR.SourceTools.src_TN_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_TN_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_TN_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_TX_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_TX_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_TX_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_TX_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_FBNV2_TX_Dallas,	CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_FBNV2_TX_Harris,	CATEGORY_OTHER_DIRECTORIES,	RECORD_FICTITIOUS_BUSINESS},
                                {MDR.SourceTools.src_UCCV2,				    CATEGORY_UCC_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_US_Coastguard,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_UT_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_UT_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_UT_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_VA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_VA_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_VT_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_VT_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_WA_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_WA_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_WA_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_WI_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_WI_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_WI_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_WI_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_Workers_Compensation,		CATEGORY_GOVERNMENT_AGENCY,	RECORD_WORKERS_COMP},
                                {MDR.SourceTools.src_WV_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_WV_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_WY_Corporations,	CATEGORY_CORPORATE_FILING,	DueDiligence.Constants.EMPTY},
                                {MDR.SourceTools.src_WY_Experian_Veh,	CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_WY_Veh,			    CATEGORY_PERSONAL_PROPERTY,	RECORD_MOTOR_VEHICLE_REGISTRATION},
                                {MDR.SourceTools.src_WY_Watercraft,		CATEGORY_PERSONAL_PROPERTY,	RECORD_BOAT_REGISTRATION},
                                {MDR.SourceTools.src_Yellow_Pages,		CATEGORY_TELCO,	RECORD_YELLOW_PAGES}],Source);
                            
    
    SHARED sourceDCT := DICTIONARY(sourceDS, {code => sourceDS});                        


    

    EXPORT mapCategoryFromCode(STRING2 sourceCode) := sourceDCT[sourceCode].category;
    EXPORT mapRecordTypeFromCode(STRING2 sourceCode) := sourceDCT[sourceCode].recordType;
    EXPORT mapCategoryAndRecordTypeFromCode(STRING2 sourceCode) := sourceDCT[sourceCode];

END;