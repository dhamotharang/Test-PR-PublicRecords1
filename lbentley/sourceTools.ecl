import corp2,doxie,codes,_control;
// -- Please if you make a change to the source code dataset
// -- also make the change in the translatesource case statement
// -- it's temporary until have better solution
export sourceTools :=
MODULE
	// -----------------------------------------
	// -- Source Codes
	// -----------------------------------------
	export src_ACA                       := 'AC';
	export src_Accurint_Arrest_Log       := 'AL';
	export src_Accurint_Crim_Court       := 'CC';
	export src_Accurint_DOC              := 'DC';
	export src_Accurint_Sex_offender     := 'AS';
	export src_Accurint_Trade_Show       := 'AT';
	export src_ACF                       := 'CF';
	export src_Aircrafts                 := 'AR';
	export src_Airmen                    := 'AM';
	export src_AK_Busreg                 := 'AB';
	export src_AK_Fishing_boats          := '^W';
	export src_AK_Perm_Fund              := 'AK';
	export src_American_Students_List    := 'SL';
	export src_AMIDIR                    := 'ML';
	export src_Bankruptcy                := 'BA';
	export src_BBB_Member                := 'BM';
	export src_BBB_Non_Member            := 'BN';
	export src_Business_Registration     := 'BR';
	export src_Certegy                   := 'CY';
	export src_FL_CH                     := 'FC';
	export src_GA_CH                     := 'GC';
	export src_PA_CH                     := 'PC';
	export src_UT_CH                     := 'UC';
	export src_AK_Corporations           := 'C)';
	export src_AL_Corporations           := 'C(';
	export src_AR_Corporations           := 'C+';
	export src_AZ_Corporations           := 'C*';
	export src_CA_Corporations           := 'C,';
	export src_CO_Corporations           := 'C-';
	export src_CT_Corporations           := 'C.';
	export src_DC_Corporations           := 'C/';
	export src_FL_Corporations           := 'C0';
	export src_GA_Corporations           := 'C1';
	export src_HI_Corporations           := 'C2';
	export src_IA_Corporations           := 'C6';
	export src_ID_Corporations           := 'C3';
	export src_IL_Corporations           := 'C4';
	export src_IN_Corporations           := 'C5';
	export src_KS_Corporations           := 'C7';
	export src_KY_Corporations           := 'C8';
	export src_LA_Corporations           := 'C9';
	export src_MA_Corporations           := 'C<';
	export src_MD_Corporations           := 'C;';
	export src_ME_Corporations           := 'C:';
	export src_MI_Corporations           := 'C=';
	export src_MN_Corporations           := 'C>';
	export src_MO_Corporations           := 'C@';
	export src_MS_Corporations           := 'C?';
	export src_MT_Corporations           := 'C[';
	export src_NC_Corporations           := 'C|';
	export src_ND_Corporations           := 'C}';
	export src_NE_Corporations           := 'C\\';
	export src_NH_Corporations           := 'C^';
	export src_NJ_Corporations           := 'C_';
	export src_NM_Corporations           := 'C`';
	export src_NV_Corporations           := 'C]';
	export src_NY_Corporations           := 'C{';
	export src_OH_Corporations           := 'C~';
	export src_OK_Corporations           := 'CA';
	export src_OR_Corporations           := 'CB';
	export src_PA_Corporations           := 'CH';
	export src_RI_Corporations           := 'CI';
	export src_SC_Corporations           := 'CJ';
	export src_SD_Corporations           := 'CK';
	export src_TN_Corporations           := 'CM';
	export src_TX_Corporations           := 'CN';
	export src_UT_Corporations           := 'CP';
	export src_VA_Corporations           := 'CR';
	export src_VT_Corporations           := 'CQ';
	export src_WA_Corporations           := 'CS';
	export src_WI_Corporations           := 'CX';
	export src_WV_Corporations           := 'CV';
	export src_WY_Corporations           := 'CZ';
	export src_Credit_Unions             := 'CU';
	export src_DCA                       := 'DF';
	export src_DEA                       := 'DA';
	export src_Death_Master              := 'DE';
	export src_Death_State               := 'DS';
	export src_CT_DL                     := 'DD';
	export src_FL_DL                     := 'FD';
	export src_IA_DL                     := 'JD';
	export src_ID_DL                     := 'ID';
	export src_KY_DL                     := 'KD';
	export src_MA_DL                     := 'PD';
	export src_ME_DL                     := 'AD';
	export src_MI_DL                     := 'CD';
	export src_MN_DL                     := 'ND';
	export src_MO_DL                     := 'MD';
	export src_NM_DL                     := 'ED';
	export src_OH_DL                     := 'OD';
	export src_OR_DL                     := 'RD';
	export src_TN_DL                     := 'SD';
	export src_TX_DL                     := 'TD';
	export src_UT_DL                     := 'UD';
	export src_WI_DL                     := 'WD';
	export src_WV_DL                     := 'VD';
	export src_WY_DL                     := 'YD';
	export src_CO_Experian_DL            := '1X';
	export src_DE_Experian_DL            := '2X';
	export src_ID_Experian_DL            := '3X';
	export src_IL_Experian_DL            := '4X';
	export src_KY_Experian_DL            := '5X';
	export src_LA_Experian_DL            := '6X';
	export src_MD_Experian_DL            := '7X';
	export src_MS_Experian_DL            := '8X';
	export src_ND_Experian_DL            := '9X';
	export src_NH_Experian_DL            := 'ZX';
	export src_SC_Experian_DL            := 'XX';
	export src_WV_Experian_DL            := 'BX';
	export src_Dummy_Records             := 'DU';
	export src_Dunn_Bradstreet           := 'D ';
	export src_Dunn_Bradstreet_Fein      := 'DN';
	export src_EBR                       := 'ER';
	export src_Edgar                     := 'E ';
	export src_EMerge_Boat               := 'EB';
	export src_EMerge_CCW                := 'E3';
	export src_EMerge_Cens               := 'E4';
	export src_EMerge_Fish               := 'E2';
	export src_EMerge_Hunt               := 'E1';
	export src_EMerge_Master             := 'EM';
	export src_Employee_Directories      := 'EY';
	export src_Equifax                   := 'EQ';
	export src_Equifax_Quick             := 'QH';
	export src_Equifax_Weekly            := 'WH';
	export src_Eq_Employer               := 'QQ';
	export src_Experian_Credit_Header    := 'EN';
	export src_Fares_Deeds_from_Asrs     := 'FB';
	export src_FBNV2_CA_Orange_county    := 'GF';
	export src_FBNV2_CA_Santa_Clara      := 'ZF';
	export src_FBNV2_CA_San_Bernadino    := 'BF';
	export src_FBNV2_CA_San_Diego        := 'EF';
	export src_FBNV2_CA_Ventura          := 'VF';
	export src_FBNV2_Experian_Direct     := 'TF';
	export src_FBNV2_FL                  := 'WF';
	export src_FBNV2_Hist_Choicepoint    := 'PF';
	export src_FBNV2_INF                 := 'UF';
	export src_FBNV2_New_York            := 'YF';
	export src_FBNV2_TX_Dallas           := 'XF';
	export src_FBNV2_TX_Harris           := 'HF';
	export src_FCC_Radio_Licenses        := 'FK';
	export src_FCRA_Corrections_record   := 'CO';
	export src_FDIC                      := 'FI';
	export src_Federal_Explosives        := 'FE';
	export src_Federal_Firearms          := 'FF';
	export src_FL_FBN                    := 'FL';
	export src_FL_Non_Profit             := 'FN';
	export src_Foreclosures              := 'FR';
	export src_Foreclosures_Delinquent   := 'NT';
	export src_NJ_Gaming_Licenses        := 'NJ';
	export src_Gong_Business             := 'GB';
	export src_Gong_Government           := 'GG';
	export src_Gong_History              := 'GO';
	export src_Gong_phone_append         := 'PH';
	export src_INFOUSA_ABIUS_USABIZ      := 'IA';
	export src_INFOUSA_DEAD_COMPANIES    := 'IC';
	export src_INFOUSA_IDEXEC            := 'II';
	export src_Ingenix_Sanctions         := 'IP';
	export src_IRS_5500                  := 'I ';
	export src_IRS_Non_Profit            := 'IN';
	export src_Jigsaw                    := 'JI';
	export src_Lexis_Trans_Union         := 'LT';
	export src_Liens                     := 'LI';
	export src_Liens_and_Judgments       := 'LJ';
	export src_Liens_v2                  := 'L2';
	export src_Liens_v2_CA_Federal       := 'LF';
	export src_Liens_v2_Chicago_Law      := 'LC';
	export src_Liens_v2_Hogan            := 'LH';
	export src_Liens_v2_ILFDLN           := 'LD';
	export src_Liens_v2_MA               := 'LM';
	export src_Liens_v2_NYC              := 'LN';
	export src_Liens_v2_NYFDLN           := 'LY';
	export src_Liens_v2_Service_Abstract := 'LS';
	export src_Liens_v2_Superior_Party   := 'LU';
	export src_CA_Liquor_Licenses        := 'CL';
	export src_CT_Liquor_Licenses        := 'CT';
	export src_IN_Liquor_Licenses        := 'IL';
	export src_LA_Liquor_Licenses        := 'LL';
	export src_OH_Liquor_Licenses        := 'OL';
	export src_PA_Liquor_Licenses        := 'PI';
	export src_TX_Liquor_Licenses        := 'TL';
	export src_LnPropV2_Fares_Asrs       := 'FA';
	export src_LnPropV2_Fares_Deeds      := 'FP';
	export src_LnPropV2_Lexis_Asrs       := 'LA';
	export src_LnPropV2_Lexis_Deeds_Mtgs := 'LP';
	export src_Lobbyists                 := 'LB';
	export src_MartinDale_Hubbell        := 'MH';
	export src_Miscellaneous             := 'PQ';
	export src_Mixed_DPPA                := 'MA';
	export src_Mixed_Non_DPPA            := 'MI';
	export src_Mixed_Probation           := 'MC';
	export src_Mixed_Utilities           := 'MU';
	export src_NCOA                      := 'NC';
	export src_OSHAIR                    := 'OS';
	export src_Phones_Plus               := 'PP';
	export src_Professional_License      := 'PL';
	export src_Redbooks                  := 'RB';
	export src_CA_Sales_Tax              := 'FT';
	export src_IA_Sales_Tax              := 'IT';
	export src_SDA                       := 'SA';
	export src_SDAA                      := 'AA';
	export src_SEC_Broker_Dealer         := 'SB';
	export src_Sheila_Greco              := 'SG';
	export src_SKA                       := 'SK';
	export src_FL_SO                     := 'FS';
	export src_GA_SO                     := 'GS';
	export src_MI_SO                     := 'MS';
	export src_PA_SO                     := 'PS';
	export src_UT_SO                     := 'US';
	export src_Spoke                     := 'SP';
	export src_Targus_White_pages        := 'WP';
	export src_Tax_practitioner          := 'TP';
	export src_TCOA_After_Address        := 'TC';
	export src_TCOA_Before_Address       := 'TB';
	export src_TransUnion                := 'TU';
	export src_TUCS_Ptrack               := 'TS';
	export src_TXBUS                     := 'TX';
	export src_UCC                       := 'U ';
	export src_UCCV2                     := 'U2';
	export src_US_Coastguard             := 'CG';
	export src_Utilities                 := 'UT';
	export src_Util_Work_Phone           := 'UW';
	export src_FL_Veh                    := 'FV';
	export src_ID_Veh                    := 'IV';
	export src_KY_Veh                    := 'KV';
	export src_ME_Veh                    := 'AV';
	export src_MN_Veh                    := 'NV';
	export src_MO_Veh                    := 'SV';
	export src_MS_Veh                    := 'MV';
	export src_MT_Veh                    := 'LV';
	export src_NC_Veh                    := 'RV';
	export src_ND_Veh                    := 'PV';
	export src_NE_Veh                    := 'EV';
	export src_NM_Veh                    := 'XV';
	export src_NV_Veh                    := 'QV';
	export src_OH_Veh                    := 'OV';
	export src_TX_Veh                    := 'TV';
	export src_UT_Veh                    := 'UV';
	export src_WI_Veh                    := 'WV';
	export src_WY_Veh                    := 'YV';
	export src_AK_Experian_Veh           := 'AE';
	export src_AL_Experian_Veh           := 'BE';
	export src_CO_Experian_Veh           := 'EE';
	export src_CT_Experian_Veh           := 'CE';
	export src_DC_Experian_Veh           := '&E';
	export src_DE_Experian_Veh           := '$E';
	export src_FL_Experian_Veh           := 'GE';
	export src_ID_Experian_Veh           := 'JE';
	export src_IL_Experian_Veh           := 'IE';
	export src_KY_Experian_Veh           := 'KE';
	export src_LA_Experian_Veh           := 'LE';
	export src_MA_Experian_Veh           := 'NE';
	export src_MD_Experian_Veh           := 'ME';
	export src_ME_Experian_Veh           := 'RE';
	export src_MI_Experian_Veh           := 'PE';
	export src_MN_Experian_Veh           := 'VE';
	export src_MO_Experian_Veh           := 'YE';
	export src_MS_Experian_Veh           := 'XE';
	export src_MT_Experian_Veh           := 'ZE';
	export src_ND_Experian_Veh           := '@E';
	export src_NE_Experian_Veh           := 'HE';
	export src_NM_Experian_Veh           := '+E';
	export src_NV_Experian_Veh           := '?E';
	export src_NY_Experian_Veh           := 'QE';
	export src_OH_Experian_Veh           := '!E';
	export src_OK_Experian_Veh           := 'OE';
	export src_OR_Experian_Veh           := '=E';
	export src_SC_Experian_Veh           := 'SE';
	export src_TN_Experian_Veh           := 'TE';
	export src_TX_Experian_Veh           := '.E';
	export src_UT_Experian_Veh           := 'UE';
	export src_WI_Experian_Veh           := 'WE';
	export src_WY_Experian_Veh           := '#E';
	export src_Vickers                   := 'V ';
	export src_Voters_v2                 := 'VO';
	export src_AK_Watercraft             := '#W';
	export src_AL_Watercraft             := 'LW';
	export src_AR_Watercraft             := 'RW';
	export src_AZ_Watercraft             := 'ZW';
	export src_CO_Watercraft             := 'CW';
	export src_CT_Watercraft             := 'EW';
	export src_FL_Watercraft             := 'FW';
	export src_GA_Watercraft             := 'GW';
	export src_IA_Watercraft             := 'IW';
	export src_IL_Watercraft             := 'PW';
	export src_KS_Watercraft             := 'HW';
	export src_KY_Watercraft             := 'KW';
	export src_MA_Watercraft             := 'JW';
	export src_MD_Watercraft             := 'DW';
	export src_ME_Watercraft             := 'QW';
	export src_MI_Watercraft             := 'XW';
	export src_MN_Watercraft             := '1W';
	export src_MO_Watercraft             := 'BW';
	export src_MS_Watercraft             := '2W';
	export src_MT_Watercraft             := '3W';
	export src_NC_Watercraft             := 'NW';
	export src_ND_Watercraft             := '4W';
	export src_NE_Watercraft             := '5W';
	export src_NH_Watercraft             := '6W';
	export src_NV_Watercraft             := '7W';
	export src_NY_Watercraft             := 'YW';
	export src_OH_Watercraft             := 'OW';
	export src_OR_Watercraft             := '8W';
	export src_SC_Watercraft             := 'SW';
	export src_TN_Watercraft             := 'TW';
	export src_TX_Watercraft             := '[W';
	export src_UT_Watercraft             := '9W';
	export src_VA_Watercraft             := 'VW';
	export src_WI_Watercraft             := 'WW';
	export src_WV_Watercraft             := '!W';
	export src_WY_Watercraft             := '@W';
	export src_FL_Watercraft_LN          := '(W';
	export src_KY_Watercraft_LN          := '$W';
	export src_MO_Watercraft_LN          := ')W';
	export src_Whois_domains             := 'W ';
	export src_Wither_and_Die            := 'WT';
	export src_MS_Worker_Comp            := 'MW';
	export src_OR_Worker_Comp            := 'WC';
	export src_Yellow_Pages              := 'Y ';
	export src_ZOOM                      := 'ZM';
	export WH_src                        := 'WH';


	// -----------------------------------------
	// -- Sets of Multiple Source Codes
	// -----------------------------------------
	export set_Atf                        := [
		 src_Federal_Explosives        ,src_Federal_Firearms          
	];

	export set_BBB                        := [
		 src_BBB_Member                ,src_BBB_Non_Member            
	];

	export set_Bk                         := [
		 src_Bankruptcy                
	];

	export set_Business_contacts          := [
		 src_Accurint_Trade_Show       ,src_ACF                       ,src_Aircrafts                 ,src_Airmen                    
		,src_AK_Busreg                 ,src_AK_Fishing_boats          ,src_AK_Perm_Fund              ,src_American_Students_List    
		,src_AMIDIR                    ,src_Bankruptcy                ,src_Business_Registration     ,src_Certegy                   
		,src_AK_Corporations           ,src_AL_Corporations           ,src_AR_Corporations           ,src_AZ_Corporations           
		,src_CA_Corporations           ,src_CO_Corporations           ,src_CT_Corporations           ,src_FL_Corporations           
		,src_GA_Corporations           ,src_HI_Corporations           ,src_IA_Corporations           ,src_ID_Corporations           
		,src_IL_Corporations           ,src_IN_Corporations           ,src_KS_Corporations           ,src_KY_Corporations           
		,src_LA_Corporations           ,src_MA_Corporations           ,src_MD_Corporations           ,src_ME_Corporations           
		,src_MI_Corporations           ,src_MN_Corporations           ,src_MS_Corporations           ,src_MT_Corporations           
		,src_NC_Corporations           ,src_ND_Corporations           ,src_NE_Corporations           ,src_NH_Corporations           
		,src_NM_Corporations           ,src_NV_Corporations           ,src_NY_Corporations           ,src_OH_Corporations           
		,src_OK_Corporations           ,src_OR_Corporations           ,src_PA_Corporations           ,src_RI_Corporations           
		,src_SD_Corporations           ,src_TX_Corporations           ,src_UT_Corporations           ,src_VA_Corporations           
		,src_VT_Corporations           ,src_WA_Corporations           ,src_WI_Corporations           ,src_WV_Corporations           
		,src_WY_Corporations           ,src_Credit_Unions             ,src_DCA                       ,src_DEA                       
		,src_Death_Master              ,src_Death_State               ,src_CT_DL                     ,src_FL_DL                     
		,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     
		,src_MI_DL                     ,src_MN_DL                     ,src_NM_DL                     ,src_OH_DL                     
		,src_TN_DL                     ,src_TX_DL                     ,src_WI_DL                     ,src_WV_DL                     
		,src_WY_DL                     ,src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            
		,src_IL_Experian_DL            ,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            
		,src_MS_Experian_DL            ,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            
		,src_WV_Experian_DL            ,src_Dummy_Records             ,src_Dunn_Bradstreet           ,src_Dunn_Bradstreet_Fein      
		,src_EBR                       ,src_Edgar                     ,src_EMerge_Boat               ,src_EMerge_CCW                
		,src_EMerge_Cens               ,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             
		,src_Employee_Directories      ,src_Equifax                   ,src_Eq_Employer               ,src_Fares_Deeds_from_Asrs     
		,src_FBNV2_CA_Orange_county    ,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    ,src_FBNV2_CA_San_Diego        
		,src_FBNV2_CA_Ventura          ,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  ,src_FBNV2_Hist_Choicepoint    
		,src_FBNV2_INF                 ,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           ,src_FBNV2_TX_Harris           
		,src_FCC_Radio_Licenses        ,src_Federal_Explosives        ,src_Federal_Firearms          ,src_FL_FBN                    
		,src_FL_Non_Profit             ,src_Foreclosures              ,src_NJ_Gaming_Licenses        ,src_Gong_Business             
		,src_Gong_Government           ,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            
		,src_IRS_5500                  ,src_IRS_Non_Profit            ,src_Jigsaw                    ,src_Liens                     
		,src_Liens_v2                  ,src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        ,src_IN_Liquor_Licenses        
		,src_LA_Liquor_Licenses        ,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        ,src_TX_Liquor_Licenses        
		,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs 
		,src_Lobbyists                 ,src_MartinDale_Hubbell        ,src_Miscellaneous             ,src_Phones_Plus               
		,src_Professional_License      ,src_Redbooks                  ,src_CA_Sales_Tax              ,src_IA_Sales_Tax              
		,src_SDA                       ,src_SDAA                      ,src_SEC_Broker_Dealer         ,src_Sheila_Greco              
		,src_SKA                       ,src_Spoke                     ,src_Targus_White_pages        ,src_Tax_practitioner          
		,src_TUCS_Ptrack               ,src_TXBUS                     ,src_US_Coastguard             ,src_Utilities                 
		,src_Util_Work_Phone           ,src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    
		,src_ME_Veh                    ,src_MN_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    
		,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    
		,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    ,src_WI_Veh                    
		,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_CO_Experian_Veh           
		,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh           ,src_FL_Experian_Veh           
		,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh           
		,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh           
		,src_MN_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh           ,src_ND_Experian_Veh           
		,src_NE_Experian_Veh           ,src_NM_Experian_Veh           ,src_NV_Experian_Veh           ,src_NY_Experian_Veh           
		,src_OH_Experian_Veh           ,src_OK_Experian_Veh           ,src_SC_Experian_Veh           ,src_TN_Experian_Veh           
		,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh           
		,src_Vickers                   ,src_Voters_v2                 ,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             
		,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             
		,src_NH_Watercraft             ,src_NV_Watercraft             ,src_NY_Watercraft             ,src_OH_Watercraft             
		,src_SC_Watercraft             ,src_TN_Watercraft             ,src_TX_Watercraft             ,src_UT_Watercraft             
		,src_VA_Watercraft             ,src_WI_Watercraft             ,src_WV_Watercraft             ,src_WY_Watercraft             
		,src_Whois_domains             ,src_Wither_and_Die            ,src_MS_Worker_Comp            ,src_OR_Worker_Comp            
		,src_Yellow_Pages              ,src_ZOOM                      
	];

	export set_Business_header            := [
		 src_Accurint_Trade_Show       ,src_ACF                       ,src_Aircrafts                 ,src_AK_Busreg                 
		,src_AK_Fishing_boats          ,src_AMIDIR                    ,src_Bankruptcy                ,src_BBB_Member                
		,src_BBB_Non_Member            ,src_Business_Registration     ,src_AK_Corporations           ,src_AL_Corporations           
		,src_AR_Corporations           ,src_AZ_Corporations           ,src_CA_Corporations           ,src_CO_Corporations           
		,src_CT_Corporations           ,src_DC_Corporations           ,src_FL_Corporations           ,src_GA_Corporations           
		,src_HI_Corporations           ,src_IA_Corporations           ,src_ID_Corporations           ,src_IL_Corporations           
		,src_IN_Corporations           ,src_KS_Corporations           ,src_KY_Corporations           ,src_LA_Corporations           
		,src_MA_Corporations           ,src_MD_Corporations           ,src_ME_Corporations           ,src_MI_Corporations           
		,src_MN_Corporations           ,src_MO_Corporations           ,src_MS_Corporations           ,src_MT_Corporations           
		,src_NC_Corporations           ,src_ND_Corporations           ,src_NE_Corporations           ,src_NH_Corporations           
		,src_NJ_Corporations           ,src_NM_Corporations           ,src_NV_Corporations           ,src_NY_Corporations           
		,src_OH_Corporations           ,src_OK_Corporations           ,src_OR_Corporations           ,src_PA_Corporations           
		,src_RI_Corporations           ,src_SC_Corporations           ,src_SD_Corporations           ,src_TN_Corporations           
		,src_TX_Corporations           ,src_UT_Corporations           ,src_VA_Corporations           ,src_VT_Corporations           
		,src_WA_Corporations           ,src_WI_Corporations           ,src_WV_Corporations           ,src_WY_Corporations           
		,src_Credit_Unions             ,src_DCA                       ,src_DEA                       ,src_Dummy_Records             
		,src_Dunn_Bradstreet           ,src_Dunn_Bradstreet_Fein      ,src_EBR                       ,src_Edgar                     
		,src_Employee_Directories      ,src_FBNV2_CA_Orange_county    ,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    
		,src_FBNV2_CA_San_Diego        ,src_FBNV2_CA_Ventura          ,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  
		,src_FBNV2_Hist_Choicepoint    ,src_FBNV2_INF                 ,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           
		,src_FBNV2_TX_Harris           ,src_FCC_Radio_Licenses        ,src_FDIC                      ,src_Federal_Explosives        
		,src_Federal_Firearms          ,src_FL_FBN                    ,src_FL_Non_Profit             ,src_NJ_Gaming_Licenses        
		,src_Gong_Business             ,src_Gong_Government           ,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    
		,src_INFOUSA_IDEXEC            ,src_IRS_5500                  ,src_IRS_Non_Profit            ,src_Jigsaw                    
		,src_Liens_and_Judgments       ,src_Liens_v2                  ,src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        
		,src_IN_Liquor_Licenses        ,src_LA_Liquor_Licenses        ,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        
		,src_TX_Liquor_Licenses        ,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       
		,src_LnPropV2_Lexis_Deeds_Mtgs ,src_Lobbyists                 ,src_MartinDale_Hubbell        ,src_OSHAIR                    
		,src_Professional_License      ,src_Redbooks                  ,src_CA_Sales_Tax              ,src_IA_Sales_Tax              
		,src_SDA                       ,src_SDAA                      ,src_SEC_Broker_Dealer         ,src_Sheila_Greco              
		,src_SKA                       ,src_Spoke                     ,src_Tax_practitioner          ,src_TXBUS                     
		,src_UCC                       ,src_UCCV2                     ,src_US_Coastguard             ,src_FL_Veh                    
		,src_ID_Veh                    ,src_KY_Veh                    ,src_ME_Veh                    ,src_MN_Veh                    
		,src_MS_Veh                    ,src_MT_Veh                    ,src_NC_Veh                    ,src_ND_Veh                    
		,src_NE_Veh                    ,src_NM_Veh                    ,src_NV_Veh                    ,src_OH_Veh                    
		,src_TX_Veh                    ,src_UT_Veh                    ,src_WI_Veh                    ,src_WY_Veh                    
		,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_CO_Experian_Veh           ,src_CT_Experian_Veh           
		,src_DC_Experian_Veh           ,src_DE_Experian_Veh           ,src_FL_Experian_Veh           ,src_ID_Experian_Veh           
		,src_IL_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh           ,src_MA_Experian_Veh           
		,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh           ,src_MN_Experian_Veh           
		,src_MS_Experian_Veh           ,src_MT_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh           
		,src_NM_Experian_Veh           ,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh           
		,src_OK_Experian_Veh           ,src_OR_Experian_Veh           ,src_SC_Experian_Veh           ,src_TN_Experian_Veh           
		,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh           
		,src_Vickers                   ,src_AK_Watercraft             ,src_AL_Watercraft             ,src_AR_Watercraft             
		,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             ,src_FL_Watercraft             
		,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             ,src_KS_Watercraft             
		,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             ,src_ME_Watercraft             
		,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             ,src_MT_Watercraft             
		,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             ,src_NH_Watercraft             
		,src_NV_Watercraft             ,src_NY_Watercraft             ,src_OH_Watercraft             ,src_SC_Watercraft             
		,src_TN_Watercraft             ,src_TX_Watercraft             ,src_UT_Watercraft             ,src_VA_Watercraft             
		,src_WI_Watercraft             ,src_WV_Watercraft             ,src_WY_Watercraft             ,src_Whois_domains             
		,src_Wither_and_Die            ,src_MS_Worker_Comp            ,src_OR_Worker_Comp            ,src_Yellow_Pages              
		,src_ZOOM                      
	];

	export set_CorpV2                     := [
		 src_AK_Corporations           ,src_AL_Corporations           ,src_AR_Corporations           ,src_AZ_Corporations           
		,src_CA_Corporations           ,src_CO_Corporations           ,src_CT_Corporations           ,src_DC_Corporations           
		,src_FL_Corporations           ,src_GA_Corporations           ,src_HI_Corporations           ,src_IA_Corporations           
		,src_ID_Corporations           ,src_IL_Corporations           ,src_IN_Corporations           ,src_KS_Corporations           
		,src_KY_Corporations           ,src_LA_Corporations           ,src_MA_Corporations           ,src_MD_Corporations           
		,src_ME_Corporations           ,src_MI_Corporations           ,src_MN_Corporations           ,src_MO_Corporations           
		,src_MS_Corporations           ,src_MT_Corporations           ,src_NC_Corporations           ,src_ND_Corporations           
		,src_NE_Corporations           ,src_NH_Corporations           ,src_NJ_Corporations           ,src_NM_Corporations           
		,src_NV_Corporations           ,src_NY_Corporations           ,src_OH_Corporations           ,src_OK_Corporations           
		,src_OR_Corporations           ,src_PA_Corporations           ,src_RI_Corporations           ,src_SC_Corporations           
		,src_SD_Corporations           ,src_TN_Corporations           ,src_TX_Corporations           ,src_UT_Corporations           
		,src_VA_Corporations           ,src_VT_Corporations           ,src_WA_Corporations           ,src_WI_Corporations           
		,src_WV_Corporations           ,src_WY_Corporations           
	];

	export set_Criminal_History           := [
		 src_FL_CH                     ,src_GA_CH                     ,src_PA_CH                     ,src_UT_CH                     
		
	];

	export set_Dea                        := [
		 src_DEA                       
	];

	export set_Death                      := [
		 src_Death_Master              ,src_Death_State               
	];

	export set_Direct_dl                  := [
		 src_CT_DL                     ,src_FL_DL                     ,src_IA_DL                     ,src_ID_DL                     
		,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     ,src_MI_DL                     
		,src_MN_DL                     ,src_MO_DL                     ,src_NM_DL                     ,src_OH_DL                     
		,src_OR_DL                     ,src_TN_DL                     ,src_TX_DL                     ,src_UT_DL                     
		,src_WI_DL                     ,src_WV_DL                     ,src_WY_DL                     
	];

	export set_Direct_vehicles            := [
		 src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_ME_Veh                    
		,src_MN_Veh                    ,src_MO_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    
		,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    
		,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    ,src_UT_Veh                    
		,src_WI_Veh                    ,src_WY_Veh                    
	];

	export set_DL                         := [
		 src_CT_DL                     ,src_FL_DL                     ,src_IA_DL                     ,src_ID_DL                     
		,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     ,src_MI_DL                     
		,src_MN_DL                     ,src_MO_DL                     ,src_NM_DL                     ,src_OH_DL                     
		,src_OR_DL                     ,src_TN_DL                     ,src_TX_DL                     ,src_UT_DL                     
		,src_WI_DL                     ,src_WV_DL                     ,src_WY_DL                     ,src_CO_Experian_DL            
		,src_DE_Experian_DL            ,src_ID_Experian_DL            ,src_IL_Experian_DL            ,src_KY_Experian_DL            
		,src_LA_Experian_DL            ,src_MD_Experian_DL            ,src_MS_Experian_DL            ,src_ND_Experian_DL            
		,src_NH_Experian_DL            ,src_SC_Experian_DL            ,src_WV_Experian_DL            
	];

	export set_DPPA_Probation_sources     := [
		 
	];

	export set_DPPA_sources               := [
		 src_AK_Fishing_boats          ,src_CT_DL                     ,src_FL_DL                     ,src_IA_DL                     
		,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     
		,src_MI_DL                     ,src_MN_DL                     ,src_MO_DL                     ,src_NM_DL                     
		,src_OH_DL                     ,src_OR_DL                     ,src_TN_DL                     ,src_TX_DL                     
		,src_WI_DL                     ,src_WV_DL                     ,src_WY_DL                     ,src_CO_Experian_DL            
		,src_DE_Experian_DL            ,src_ID_Experian_DL            ,src_IL_Experian_DL            ,src_KY_Experian_DL            
		,src_LA_Experian_DL            ,src_MD_Experian_DL            ,src_MS_Experian_DL            ,src_ND_Experian_DL            
		,src_NH_Experian_DL            ,src_SC_Experian_DL            ,src_WV_Experian_DL            ,src_Mixed_DPPA                
		,src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_ME_Veh                    
		,src_MN_Veh                    ,src_MO_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    
		,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    
		,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    ,src_WI_Veh                    
		,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_CO_Experian_Veh           
		,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh           ,src_FL_Experian_Veh           
		,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh           
		,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh           
		,src_MN_Experian_Veh           ,src_MO_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh           
		,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh           ,src_NV_Experian_Veh           
		,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh           ,src_OR_Experian_Veh           
		,src_SC_Experian_Veh           ,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh           
		,src_WI_Experian_Veh           ,src_WY_Experian_Veh           ,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MO_Watercraft             
		,src_MS_Watercraft             ,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             
		,src_NE_Watercraft             ,src_NH_Watercraft             ,src_NV_Watercraft             ,src_NY_Watercraft             
		,src_OH_Watercraft             ,src_OR_Watercraft             ,src_SC_Watercraft             ,src_TN_Watercraft             
		,src_TX_Watercraft             ,src_UT_Watercraft             ,src_VA_Watercraft             ,src_WI_Watercraft             
		,src_WV_Watercraft             ,src_WY_Watercraft             ,src_FL_Watercraft_LN          ,src_KY_Watercraft_LN          
		,src_MO_Watercraft_LN          
	];

	export set_Emerges                    := [
		 src_EMerge_Boat               ,src_EMerge_CCW                ,src_EMerge_Cens               ,src_EMerge_Fish               
		,src_EMerge_Hunt               ,src_EMerge_Master             
	];

	export set_Equifax                    := [
		 src_Equifax                   ,src_Equifax_Quick             ,src_Equifax_Weekly            ,src_Eq_Employer               
		
	];

	export set_Experian_dl                := [
		 src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            ,src_IL_Experian_DL            
		,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            ,src_MS_Experian_DL            
		,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            ,src_WV_Experian_DL            
		
	];

	export set_Experian_vehicles          := [
		 src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_CO_Experian_Veh           ,src_CT_Experian_Veh           
		,src_DC_Experian_Veh           ,src_DE_Experian_Veh           ,src_FL_Experian_Veh           ,src_ID_Experian_Veh           
		,src_IL_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh           ,src_MA_Experian_Veh           
		,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh           ,src_MN_Experian_Veh           
		,src_MO_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh           ,src_ND_Experian_Veh           
		,src_NE_Experian_Veh           ,src_NM_Experian_Veh           ,src_NV_Experian_Veh           ,src_NY_Experian_Veh           
		,src_OH_Experian_Veh           ,src_OK_Experian_Veh           ,src_OR_Experian_Veh           ,src_SC_Experian_Veh           
		,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_WI_Experian_Veh           
		,src_WY_Experian_Veh           
	];

	export set_FAA                        := [
		 src_Aircrafts                 ,src_Airmen                    
	];

	export set_Fbnv2                      := [
		 src_FBNV2_CA_Orange_county    ,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    ,src_FBNV2_CA_San_Diego        
		,src_FBNV2_CA_Ventura          ,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  ,src_FBNV2_Hist_Choicepoint    
		,src_FBNV2_INF                 ,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           ,src_FBNV2_TX_Harris           
		
	];

	export set_FCRA_Probation_sources     := [
		 src_Accurint_Arrest_Log       ,src_Accurint_Crim_Court       ,src_Accurint_DOC              
	];

	export set_FCRA_sources               := [
		 src_Bankruptcy                ,src_Liens                     ,src_MS_Worker_Comp            
	];

	export set_GLB                        := [
		 src_Equifax                   ,src_Experian_Credit_Header    
	];

	export set_Gong                       := [
		 src_Gong_Business             ,src_Gong_Government           ,src_Gong_History              
	];

	export set_Header                     := [
		 src_Aircrafts                 ,src_Airmen                    ,src_AK_Fishing_boats          ,src_AK_Perm_Fund              
		,src_American_Students_List    ,src_Bankruptcy                ,src_Certegy                   ,src_DEA                       
		,src_Death_Master              ,src_Death_State               ,src_CT_DL                     ,src_FL_DL                     
		,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     
		,src_MI_DL                     ,src_MN_DL                     ,src_NM_DL                     ,src_OH_DL                     
		,src_TN_DL                     ,src_TX_DL                     ,src_WI_DL                     ,src_WV_DL                     
		,src_WY_DL                     ,src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            
		,src_IL_Experian_DL            ,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            
		,src_MS_Experian_DL            ,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            
		,src_WV_Experian_DL            ,src_Dummy_Records             ,src_EMerge_Boat               ,src_EMerge_CCW                
		,src_EMerge_Cens               ,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             
		,src_Equifax                   ,src_Fares_Deeds_from_Asrs     ,src_Federal_Explosives        ,src_Federal_Firearms          
		,src_Foreclosures              ,src_Liens                     ,src_Liens_v2                  ,src_LnPropV2_Fares_Asrs       
		,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs ,src_Miscellaneous             
		,src_Professional_License      ,src_Targus_White_pages        ,src_TUCS_Ptrack               ,src_US_Coastguard             
		,src_Utilities                 ,src_Util_Work_Phone           ,src_FL_Veh                    ,src_ID_Veh                    
		,src_KY_Veh                    ,src_ME_Veh                    ,src_MN_Veh                    ,src_MS_Veh                    
		,src_MT_Veh                    ,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    
		,src_NM_Veh                    ,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    
		,src_WI_Veh                    ,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           
		,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh           
		,src_FL_Experian_Veh           ,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KY_Experian_Veh           
		,src_LA_Experian_Veh           ,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           
		,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MS_Experian_Veh           ,src_MT_Experian_Veh           
		,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh           ,src_NV_Experian_Veh           
		,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh           ,src_SC_Experian_Veh           
		,src_TN_Experian_Veh           ,src_TX_Experian_Veh           ,src_UT_Experian_Veh           ,src_WI_Experian_Veh           
		,src_WY_Experian_Veh           ,src_Voters_v2                 ,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             
		,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             
		,src_NH_Watercraft             ,src_NV_Watercraft             ,src_NY_Watercraft             ,src_OH_Watercraft             
		,src_SC_Watercraft             ,src_TN_Watercraft             ,src_TX_Watercraft             ,src_UT_Watercraft             
		,src_VA_Watercraft             ,src_WI_Watercraft             ,src_WV_Watercraft             ,src_WY_Watercraft             
		,src_MS_Worker_Comp            
	];

	export set_Infousa                    := [
		 src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            
	];

	export set_Liens                      := [
		 src_Liens                     ,src_Liens_v2_CA_Federal       ,src_Liens_v2_Chicago_Law      ,src_Liens_v2_Hogan            
		,src_Liens_v2_ILFDLN           ,src_Liens_v2_MA               ,src_Liens_v2_NYC              ,src_Liens_v2_NYFDLN           
		,src_Liens_v2_Service_Abstract ,src_Liens_v2_Superior_Party   
	];

	export set_Liquor_Licenses            := [
		 src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        ,src_IN_Liquor_Licenses        ,src_LA_Liquor_Licenses        
		,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        ,src_TX_Liquor_Licenses        
	];

	export set_LNOnly                     := [
		 
	];

	export set_LnPropertyV2               := [
		 src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs 
		
	];

	export set_NoMix                      := [
		 src_Accurint_Arrest_Log       ,src_Accurint_Crim_Court       ,src_Accurint_DOC              
	];

	export set_NonDPPA_sources            := [
		 src_Aircrafts                 ,src_Airmen                    ,src_AK_Perm_Fund              ,src_American_Students_List    
		,src_Certegy                   ,src_DEA                       ,src_Death_Master              ,src_Death_State               
		,src_Dummy_Records             ,src_EMerge_Boat               ,src_EMerge_CCW                ,src_EMerge_Cens               
		,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             ,src_Equifax                   
		,src_Equifax_Quick             ,src_Equifax_Weekly            ,src_Experian_Credit_Header    ,src_Fares_Deeds_from_Asrs     
		,src_Federal_Explosives        ,src_Federal_Firearms          ,src_Foreclosures              ,src_Foreclosures_Delinquent   
		,src_Gong_History              ,src_Gong_phone_append         ,src_Lexis_Trans_Union         ,src_Liens_v2                  
		,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs 
		,src_Miscellaneous             ,src_Mixed_Non_DPPA            ,src_NCOA                      ,src_Professional_License      
		,src_Targus_White_pages        ,src_TCOA_After_Address        ,src_TCOA_Before_Address       ,src_TransUnion                
		,src_TUCS_Ptrack               ,src_US_Coastguard             ,src_Voters_v2                 
	];

	export set_NonUpdatingSrc             := [
		 src_Accurint_Trade_Show       ,src_AMIDIR                    ,src_Credit_Unions             ,src_Edgar                     
		,src_Employee_Directories      ,src_Eq_Employer               ,src_FL_Non_Profit             ,src_INFOUSA_ABIUS_USABIZ      
		,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            ,src_Liens_and_Judgments       ,src_Lobbyists                 
		,src_Tax_practitioner          ,src_UCC                       ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           
		,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh           
		,src_FL_Experian_Veh           ,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KY_Experian_Veh           
		,src_LA_Experian_Veh           ,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           
		,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MO_Experian_Veh           ,src_MS_Experian_Veh           
		,src_MT_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh           
		,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh           
		,src_OR_Experian_Veh           ,src_SC_Experian_Veh           ,src_TN_Experian_Veh           ,src_TX_Experian_Veh           
		,src_UT_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh           ,src_Whois_domains             
		,src_Wither_and_Die            
	];

	export set_Paw                        := [
		 src_Accurint_Trade_Show       ,src_ACF                       ,src_Aircrafts                 ,src_Airmen                    
		,src_AK_Busreg                 ,src_AK_Fishing_boats          ,src_AK_Perm_Fund              ,src_American_Students_List    
		,src_AMIDIR                    ,src_Bankruptcy                ,src_Business_Registration     ,src_Certegy                   
		,src_AK_Corporations           ,src_AL_Corporations           ,src_AR_Corporations           ,src_AZ_Corporations           
		,src_CA_Corporations           ,src_CO_Corporations           ,src_CT_Corporations           ,src_FL_Corporations           
		,src_GA_Corporations           ,src_HI_Corporations           ,src_IA_Corporations           ,src_ID_Corporations           
		,src_IL_Corporations           ,src_IN_Corporations           ,src_KS_Corporations           ,src_KY_Corporations           
		,src_LA_Corporations           ,src_MA_Corporations           ,src_MD_Corporations           ,src_ME_Corporations           
		,src_MI_Corporations           ,src_MN_Corporations           ,src_MS_Corporations           ,src_MT_Corporations           
		,src_NC_Corporations           ,src_ND_Corporations           ,src_NE_Corporations           ,src_NH_Corporations           
		,src_NM_Corporations           ,src_NV_Corporations           ,src_NY_Corporations           ,src_OH_Corporations           
		,src_OK_Corporations           ,src_OR_Corporations           ,src_PA_Corporations           ,src_RI_Corporations           
		,src_SD_Corporations           ,src_TX_Corporations           ,src_UT_Corporations           ,src_VA_Corporations           
		,src_VT_Corporations           ,src_WA_Corporations           ,src_WI_Corporations           ,src_WV_Corporations           
		,src_WY_Corporations           ,src_Credit_Unions             ,src_DCA                       ,src_DEA                       
		,src_Death_Master              ,src_Death_State               ,src_CT_DL                     ,src_FL_DL                     
		,src_ID_DL                     ,src_KY_DL                     ,src_MA_DL                     ,src_ME_DL                     
		,src_MI_DL                     ,src_MN_DL                     ,src_NM_DL                     ,src_OH_DL                     
		,src_TN_DL                     ,src_TX_DL                     ,src_WI_DL                     ,src_WV_DL                     
		,src_WY_DL                     ,src_CO_Experian_DL            ,src_DE_Experian_DL            ,src_ID_Experian_DL            
		,src_IL_Experian_DL            ,src_KY_Experian_DL            ,src_LA_Experian_DL            ,src_MD_Experian_DL            
		,src_MS_Experian_DL            ,src_ND_Experian_DL            ,src_NH_Experian_DL            ,src_SC_Experian_DL            
		,src_WV_Experian_DL            ,src_Dummy_Records             ,src_Dunn_Bradstreet           ,src_Dunn_Bradstreet_Fein      
		,src_Edgar                     ,src_EMerge_Boat               ,src_EMerge_CCW                ,src_EMerge_Cens               
		,src_EMerge_Fish               ,src_EMerge_Hunt               ,src_EMerge_Master             ,src_Employee_Directories      
		,src_Equifax                   ,src_Eq_Employer               ,src_Fares_Deeds_from_Asrs     ,src_FBNV2_CA_Orange_county    
		,src_FBNV2_CA_Santa_Clara      ,src_FBNV2_CA_San_Bernadino    ,src_FBNV2_CA_San_Diego        ,src_FBNV2_CA_Ventura          
		,src_FBNV2_Experian_Direct     ,src_FBNV2_FL                  ,src_FBNV2_Hist_Choicepoint    ,src_FBNV2_INF                 
		,src_FBNV2_New_York            ,src_FBNV2_TX_Dallas           ,src_FBNV2_TX_Harris           ,src_FCC_Radio_Licenses        
		,src_Federal_Explosives        ,src_Federal_Firearms          ,src_FL_FBN                    ,src_FL_Non_Profit             
		,src_Foreclosures              ,src_NJ_Gaming_Licenses        ,src_Gong_Business             ,src_Gong_Government           
		,src_INFOUSA_ABIUS_USABIZ      ,src_INFOUSA_DEAD_COMPANIES    ,src_INFOUSA_IDEXEC            ,src_IRS_5500                  
		,src_IRS_Non_Profit            ,src_Jigsaw                    ,src_Liens                     ,src_Liens_v2                  
		,src_CA_Liquor_Licenses        ,src_CT_Liquor_Licenses        ,src_IN_Liquor_Licenses        ,src_LA_Liquor_Licenses        
		,src_OH_Liquor_Licenses        ,src_PA_Liquor_Licenses        ,src_TX_Liquor_Licenses        ,src_LnPropV2_Fares_Asrs       
		,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       ,src_LnPropV2_Lexis_Deeds_Mtgs ,src_Lobbyists                 
		,src_MartinDale_Hubbell        ,src_Miscellaneous             ,src_Phones_Plus               ,src_Professional_License      
		,src_Redbooks                  ,src_CA_Sales_Tax              ,src_IA_Sales_Tax              ,src_SDA                       
		,src_SDAA                      ,src_SEC_Broker_Dealer         ,src_Sheila_Greco              ,src_SKA                       
		,src_Spoke                     ,src_Targus_White_pages        ,src_Tax_practitioner          ,src_TUCS_Ptrack               
		,src_TXBUS                     ,src_US_Coastguard             ,src_Utilities                 ,src_Util_Work_Phone           
		,src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_ME_Veh                    
		,src_MN_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    ,src_NC_Veh                    
		,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    ,src_NV_Veh                    
		,src_OH_Veh                    ,src_TX_Veh                    ,src_WI_Veh                    ,src_WY_Veh                    
		,src_AK_Experian_Veh           ,src_AL_Experian_Veh           ,src_CO_Experian_Veh           ,src_CT_Experian_Veh           
		,src_DC_Experian_Veh           ,src_DE_Experian_Veh           ,src_FL_Experian_Veh           ,src_ID_Experian_Veh           
		,src_IL_Experian_Veh           ,src_KY_Experian_Veh           ,src_LA_Experian_Veh           ,src_MA_Experian_Veh           
		,src_MD_Experian_Veh           ,src_ME_Experian_Veh           ,src_MI_Experian_Veh           ,src_MN_Experian_Veh           
		,src_MS_Experian_Veh           ,src_MT_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh           
		,src_NM_Experian_Veh           ,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh           
		,src_OK_Experian_Veh           ,src_SC_Experian_Veh           ,src_TN_Experian_Veh           ,src_TX_Experian_Veh           
		,src_UT_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh           ,src_Vickers                   
		,src_Voters_v2                 ,src_AK_Watercraft             ,src_AL_Watercraft             ,src_AR_Watercraft             
		,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             ,src_FL_Watercraft             
		,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             ,src_KS_Watercraft             
		,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             ,src_ME_Watercraft             
		,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MS_Watercraft             ,src_MT_Watercraft             
		,src_NC_Watercraft             ,src_ND_Watercraft             ,src_NE_Watercraft             ,src_NH_Watercraft             
		,src_NV_Watercraft             ,src_NY_Watercraft             ,src_OH_Watercraft             ,src_SC_Watercraft             
		,src_TN_Watercraft             ,src_TX_Watercraft             ,src_UT_Watercraft             ,src_VA_Watercraft             
		,src_WI_Watercraft             ,src_WV_Watercraft             ,src_WY_Watercraft             ,src_Whois_domains             
		,src_Wither_and_Die            ,src_MS_Worker_Comp            ,src_OR_Worker_Comp            ,src_Yellow_Pages              
		,src_ZOOM                      
	];

	export set_Property                   := [
		 src_Fares_Deeds_from_Asrs     ,src_LnPropV2_Fares_Asrs       ,src_LnPropV2_Fares_Deeds      ,src_LnPropV2_Lexis_Asrs       
		,src_LnPropV2_Lexis_Deeds_Mtgs 
	];

	export set_Sex_Offender               := [
		 src_Accurint_Sex_offender     ,src_FL_SO                     ,src_GA_SO                     ,src_MI_SO                     
		,src_PA_SO                     ,src_UT_SO                     
	];

	export set_State_Sales_Tax            := [
		 src_CA_Sales_Tax              ,src_IA_Sales_Tax              
	];

	export set_TCOA                       := [
		 src_TCOA_After_Address        ,src_TCOA_Before_Address       
	];

	export set_TEMP_Probation_sources     := [
		 src_Experian_Credit_Header    ,src_TUCS_Ptrack               
	];

	export set_Transunion                 := [
		 src_Lexis_Trans_Union         ,src_TransUnion                
	];

	export set_UCCS                       := [
		 src_UCC                       ,src_UCCV2                     
	];

	export set_Utility_sources            := [
		 src_Mixed_Utilities           ,src_Utilities                 ,src_Util_Work_Phone           
	];

	export set_Vehicles                   := [
		 src_FL_Veh                    ,src_ID_Veh                    ,src_KY_Veh                    ,src_ME_Veh                    
		,src_MN_Veh                    ,src_MO_Veh                    ,src_MS_Veh                    ,src_MT_Veh                    
		,src_NC_Veh                    ,src_ND_Veh                    ,src_NE_Veh                    ,src_NM_Veh                    
		,src_NV_Veh                    ,src_OH_Veh                    ,src_TX_Veh                    ,src_UT_Veh                    
		,src_WI_Veh                    ,src_WY_Veh                    ,src_AK_Experian_Veh           ,src_AL_Experian_Veh           
		,src_CO_Experian_Veh           ,src_CT_Experian_Veh           ,src_DC_Experian_Veh           ,src_DE_Experian_Veh           
		,src_FL_Experian_Veh           ,src_ID_Experian_Veh           ,src_IL_Experian_Veh           ,src_KY_Experian_Veh           
		,src_LA_Experian_Veh           ,src_MA_Experian_Veh           ,src_MD_Experian_Veh           ,src_ME_Experian_Veh           
		,src_MI_Experian_Veh           ,src_MN_Experian_Veh           ,src_MO_Experian_Veh           ,src_MS_Experian_Veh           
		,src_MT_Experian_Veh           ,src_ND_Experian_Veh           ,src_NE_Experian_Veh           ,src_NM_Experian_Veh           
		,src_NV_Experian_Veh           ,src_NY_Experian_Veh           ,src_OH_Experian_Veh           ,src_OK_Experian_Veh           
		,src_OR_Experian_Veh           ,src_SC_Experian_Veh           ,src_TN_Experian_Veh           ,src_TX_Experian_Veh           
		,src_UT_Experian_Veh           ,src_WI_Experian_Veh           ,src_WY_Experian_Veh           
	];

	export set_WC                         := [
		 src_AK_Fishing_boats          ,src_US_Coastguard             ,src_AK_Watercraft             ,src_AL_Watercraft             
		,src_AR_Watercraft             ,src_AZ_Watercraft             ,src_CO_Watercraft             ,src_CT_Watercraft             
		,src_FL_Watercraft             ,src_GA_Watercraft             ,src_IA_Watercraft             ,src_IL_Watercraft             
		,src_KS_Watercraft             ,src_KY_Watercraft             ,src_MA_Watercraft             ,src_MD_Watercraft             
		,src_ME_Watercraft             ,src_MI_Watercraft             ,src_MN_Watercraft             ,src_MO_Watercraft             
		,src_MS_Watercraft             ,src_MT_Watercraft             ,src_NC_Watercraft             ,src_ND_Watercraft             
		,src_NE_Watercraft             ,src_NH_Watercraft             ,src_NV_Watercraft             ,src_NY_Watercraft             
		,src_OH_Watercraft             ,src_SC_Watercraft             ,src_TN_Watercraft             ,src_TX_Watercraft             
		,src_UT_Watercraft             ,src_VA_Watercraft             ,src_WI_Watercraft             ,src_WV_Watercraft             
		,src_WY_Watercraft             
	];

	export set_Workmans_Comp              := [
		 src_MS_Worker_Comp            ,src_OR_Worker_Comp            
	];



	// -----------------------------------------
	// -- Sets of Individual Source Codes
	// -----------------------------------------
	export set_ACA                       := [src_ACA                       ];
	export set_Accurint_Arrest_Log       := [src_Accurint_Arrest_Log       ];
	export set_Accurint_Crim_Court       := [src_Accurint_Crim_Court       ];
	export set_Accurint_DOC              := [src_Accurint_DOC              ];
	export set_Accurint_Sex_offender     := [src_Accurint_Sex_offender     ];
	export set_Accurint_Trade_Show       := [src_Accurint_Trade_Show       ];
	export set_ACF                       := [src_ACF                       ];
	export set_Aircrafts                 := [src_Aircrafts                 ];
	export set_Airmen                    := [src_Airmen                    ];
	export set_AK_Busreg                 := [src_AK_Busreg                 ];
	export set_AK_Fishing_boats          := [src_AK_Fishing_boats          ];
	export set_AK_Perm_Fund              := [src_AK_Perm_Fund              ];
	export set_American_Students_List    := [src_American_Students_List    ];
	export set_AMIDIR                    := [src_AMIDIR                    ];
	export set_BBB_Member                := [src_BBB_Member                ];
	export set_BBB_Non_Member            := [src_BBB_Non_Member            ];
	export set_Business_Registration     := [src_Business_Registration     ];
	export set_Certegy                   := [src_Certegy                   ];
	export set_FL_CH                     := [src_FL_CH                     ];
	export set_GA_CH                     := [src_GA_CH                     ];
	export set_PA_CH                     := [src_PA_CH                     ];
	export set_UT_CH                     := [src_UT_CH                     ];
	export set_AK_Corporations           := [src_AK_Corporations           ];
	export set_AL_Corporations           := [src_AL_Corporations           ];
	export set_AR_Corporations           := [src_AR_Corporations           ];
	export set_AZ_Corporations           := [src_AZ_Corporations           ];
	export set_CA_Corporations           := [src_CA_Corporations           ];
	export set_CO_Corporations           := [src_CO_Corporations           ];
	export set_CT_Corporations           := [src_CT_Corporations           ];
	export set_DC_Corporations           := [src_DC_Corporations           ];
	export set_FL_Corporations           := [src_FL_Corporations           ];
	export set_GA_Corporations           := [src_GA_Corporations           ];
	export set_HI_Corporations           := [src_HI_Corporations           ];
	export set_IA_Corporations           := [src_IA_Corporations           ];
	export set_ID_Corporations           := [src_ID_Corporations           ];
	export set_IL_Corporations           := [src_IL_Corporations           ];
	export set_IN_Corporations           := [src_IN_Corporations           ];
	export set_KS_Corporations           := [src_KS_Corporations           ];
	export set_KY_Corporations           := [src_KY_Corporations           ];
	export set_LA_Corporations           := [src_LA_Corporations           ];
	export set_MA_Corporations           := [src_MA_Corporations           ];
	export set_MD_Corporations           := [src_MD_Corporations           ];
	export set_ME_Corporations           := [src_ME_Corporations           ];
	export set_MI_Corporations           := [src_MI_Corporations           ];
	export set_MN_Corporations           := [src_MN_Corporations           ];
	export set_MO_Corporations           := [src_MO_Corporations           ];
	export set_MS_Corporations           := [src_MS_Corporations           ];
	export set_MT_Corporations           := [src_MT_Corporations           ];
	export set_NC_Corporations           := [src_NC_Corporations           ];
	export set_ND_Corporations           := [src_ND_Corporations           ];
	export set_NE_Corporations           := [src_NE_Corporations           ];
	export set_NH_Corporations           := [src_NH_Corporations           ];
	export set_NJ_Corporations           := [src_NJ_Corporations           ];
	export set_NM_Corporations           := [src_NM_Corporations           ];
	export set_NV_Corporations           := [src_NV_Corporations           ];
	export set_NY_Corporations           := [src_NY_Corporations           ];
	export set_OH_Corporations           := [src_OH_Corporations           ];
	export set_OK_Corporations           := [src_OK_Corporations           ];
	export set_OR_Corporations           := [src_OR_Corporations           ];
	export set_PA_Corporations           := [src_PA_Corporations           ];
	export set_RI_Corporations           := [src_RI_Corporations           ];
	export set_SC_Corporations           := [src_SC_Corporations           ];
	export set_SD_Corporations           := [src_SD_Corporations           ];
	export set_TN_Corporations           := [src_TN_Corporations           ];
	export set_TX_Corporations           := [src_TX_Corporations           ];
	export set_UT_Corporations           := [src_UT_Corporations           ];
	export set_VA_Corporations           := [src_VA_Corporations           ];
	export set_VT_Corporations           := [src_VT_Corporations           ];
	export set_WA_Corporations           := [src_WA_Corporations           ];
	export set_WI_Corporations           := [src_WI_Corporations           ];
	export set_WV_Corporations           := [src_WV_Corporations           ];
	export set_WY_Corporations           := [src_WY_Corporations           ];
	export set_Credit_Unions             := [src_Credit_Unions             ];
	export set_DCA                       := [src_DCA                       ];
	export set_Death_Master              := [src_Death_Master              ];
	export set_Death_State               := [src_Death_State               ];
	export set_CT_DL                     := [src_CT_DL                     ];
	export set_FL_DL                     := [src_FL_DL                     ];
	export set_IA_DL                     := [src_IA_DL                     ];
	export set_ID_DL                     := [src_ID_DL                     ];
	export set_KY_DL                     := [src_KY_DL                     ];
	export set_MA_DL                     := [src_MA_DL                     ];
	export set_ME_DL                     := [src_ME_DL                     ];
	export set_MI_DL                     := [src_MI_DL                     ];
	export set_MN_DL                     := [src_MN_DL                     ];
	export set_MO_DL                     := [src_MO_DL                     ];
	export set_NM_DL                     := [src_NM_DL                     ];
	export set_OH_DL                     := [src_OH_DL                     ];
	export set_OR_DL                     := [src_OR_DL                     ];
	export set_TN_DL                     := [src_TN_DL                     ];
	export set_TX_DL                     := [src_TX_DL                     ];
	export set_UT_DL                     := [src_UT_DL                     ];
	export set_WI_DL                     := [src_WI_DL                     ];
	export set_WV_DL                     := [src_WV_DL                     ];
	export set_WY_DL                     := [src_WY_DL                     ];
	export set_CO_Experian_DL            := [src_CO_Experian_DL            ];
	export set_DE_Experian_DL            := [src_DE_Experian_DL            ];
	export set_ID_Experian_DL            := [src_ID_Experian_DL            ];
	export set_IL_Experian_DL            := [src_IL_Experian_DL            ];
	export set_KY_Experian_DL            := [src_KY_Experian_DL            ];
	export set_LA_Experian_DL            := [src_LA_Experian_DL            ];
	export set_MD_Experian_DL            := [src_MD_Experian_DL            ];
	export set_MS_Experian_DL            := [src_MS_Experian_DL            ];
	export set_ND_Experian_DL            := [src_ND_Experian_DL            ];
	export set_NH_Experian_DL            := [src_NH_Experian_DL            ];
	export set_SC_Experian_DL            := [src_SC_Experian_DL            ];
	export set_WV_Experian_DL            := [src_WV_Experian_DL            ];
	export set_Dummy_Records             := [src_Dummy_Records             ];
	export set_Dunn_Bradstreet           := [src_Dunn_Bradstreet           ];
	export set_Dunn_Bradstreet_Fein      := [src_Dunn_Bradstreet_Fein      ];
	export set_EBR                       := [src_EBR                       ];
	export set_Edgar                     := [src_Edgar                     ];
	export set_EMerge_Boat               := [src_EMerge_Boat               ];
	export set_EMerge_CCW                := [src_EMerge_CCW                ];
	export set_EMerge_Cens               := [src_EMerge_Cens               ];
	export set_EMerge_Fish               := [src_EMerge_Fish               ];
	export set_EMerge_Hunt               := [src_EMerge_Hunt               ];
	export set_EMerge_Master             := [src_EMerge_Master             ];
	export set_Employee_Directories      := [src_Employee_Directories      ];
	export set_Equifax_Direct            := [src_Equifax                   ];
	export set_Equifax_Quick             := [src_Equifax_Quick             ];
	export set_Equifax_Weekly            := [src_Equifax_Weekly            ];
	export set_Eq_Employer               := [src_Eq_Employer               ];
	export set_Experian_Credit_Header    := [src_Experian_Credit_Header    ];
	export set_Fares_Deeds_from_Asrs     := [src_Fares_Deeds_from_Asrs     ];
	export set_FBNV2_CA_Orange_county    := [src_FBNV2_CA_Orange_county    ];
	export set_FBNV2_CA_Santa_Clara      := [src_FBNV2_CA_Santa_Clara      ];
	export set_FBNV2_CA_San_Bernadino    := [src_FBNV2_CA_San_Bernadino    ];
	export set_FBNV2_CA_San_Diego        := [src_FBNV2_CA_San_Diego        ];
	export set_FBNV2_CA_Ventura          := [src_FBNV2_CA_Ventura          ];
	export set_FBNV2_Experian_Direct     := [src_FBNV2_Experian_Direct     ];
	export set_FBNV2_FL                  := [src_FBNV2_FL                  ];
	export set_FBNV2_Hist_Choicepoint    := [src_FBNV2_Hist_Choicepoint    ];
	export set_FBNV2_INF                 := [src_FBNV2_INF                 ];
	export set_FBNV2_New_York            := [src_FBNV2_New_York            ];
	export set_FBNV2_TX_Dallas           := [src_FBNV2_TX_Dallas           ];
	export set_FBNV2_TX_Harris           := [src_FBNV2_TX_Harris           ];
	export set_FCC_Radio_Licenses        := [src_FCC_Radio_Licenses        ];
	export set_FCRA_Corrections_record   := [src_FCRA_Corrections_record   ];
	export set_FDIC                      := [src_FDIC                      ];
	export set_Federal_Explosives        := [src_Federal_Explosives        ];
	export set_Federal_Firearms          := [src_Federal_Firearms          ];
	export set_FL_FBN                    := [src_FL_FBN                    ];
	export set_FL_Non_Profit             := [src_FL_Non_Profit             ];
	export set_Foreclosures              := [src_Foreclosures              ];
	export set_Foreclosures_Delinquent   := [src_Foreclosures_Delinquent   ];
	export set_NJ_Gaming_Licenses        := [src_NJ_Gaming_Licenses        ];
	export set_Gong_Business             := [src_Gong_Business             ];
	export set_Gong_Government           := [src_Gong_Government           ];
	export set_Gong_History              := [src_Gong_History              ];
	export set_Gong_phone_append         := [src_Gong_phone_append         ];
	export set_INFOUSA_ABIUS_USABIZ      := [src_INFOUSA_ABIUS_USABIZ      ];
	export set_INFOUSA_DEAD_COMPANIES    := [src_INFOUSA_DEAD_COMPANIES    ];
	export set_INFOUSA_IDEXEC            := [src_INFOUSA_IDEXEC            ];
	export set_Ingenix_Sanctions         := [src_Ingenix_Sanctions         ];
	export set_IRS_5500                  := [src_IRS_5500                  ];
	export set_IRS_Non_Profit            := [src_IRS_Non_Profit            ];
	export set_Jigsaw                    := [src_Jigsaw                    ];
	export set_Lexis_Trans_Union         := [src_Lexis_Trans_Union         ];
	export set_LiensV1                   := [src_Liens                     ];
	export set_Liens_and_Judgments       := [src_Liens_and_Judgments       ];
	export set_Liens_v2                  := [src_Liens_v2                  ];
	export set_Liens_v2_CA_Federal       := [src_Liens_v2_CA_Federal       ];
	export set_Liens_v2_Chicago_Law      := [src_Liens_v2_Chicago_Law      ];
	export set_Liens_v2_Hogan            := [src_Liens_v2_Hogan            ];
	export set_Liens_v2_ILFDLN           := [src_Liens_v2_ILFDLN           ];
	export set_Liens_v2_MA               := [src_Liens_v2_MA               ];
	export set_Liens_v2_NYC              := [src_Liens_v2_NYC              ];
	export set_Liens_v2_NYFDLN           := [src_Liens_v2_NYFDLN           ];
	export set_Liens_v2_Service_Abstract := [src_Liens_v2_Service_Abstract ];
	export set_Liens_v2_Superior_Party   := [src_Liens_v2_Superior_Party   ];
	export set_CA_Liquor_Licenses        := [src_CA_Liquor_Licenses        ];
	export set_CT_Liquor_Licenses        := [src_CT_Liquor_Licenses        ];
	export set_IN_Liquor_Licenses        := [src_IN_Liquor_Licenses        ];
	export set_LA_Liquor_Licenses        := [src_LA_Liquor_Licenses        ];
	export set_OH_Liquor_Licenses        := [src_OH_Liquor_Licenses        ];
	export set_PA_Liquor_Licenses        := [src_PA_Liquor_Licenses        ];
	export set_TX_Liquor_Licenses        := [src_TX_Liquor_Licenses        ];
	export set_LnPropV2_Fares_Asrs       := [src_LnPropV2_Fares_Asrs       ];
	export set_LnPropV2_Fares_Deeds      := [src_LnPropV2_Fares_Deeds      ];
	export set_LnPropV2_Lexis_Asrs       := [src_LnPropV2_Lexis_Asrs       ];
	export set_LnPropV2_Lexis_Deeds_Mtgs := [src_LnPropV2_Lexis_Deeds_Mtgs ];
	export set_Lobbyists                 := [src_Lobbyists                 ];
	export set_MartinDale_Hubbell        := [src_MartinDale_Hubbell        ];
	export set_Miscellaneous             := [src_Miscellaneous             ];
	export set_Mixed_DPPA                := [src_Mixed_DPPA                ];
	export set_Mixed_Non_DPPA            := [src_Mixed_Non_DPPA            ];
	export set_Mixed_Probation           := [src_Mixed_Probation           ];
	export set_Mixed_Utilities           := [src_Mixed_Utilities           ];
	export set_NCOA                      := [src_NCOA                      ];
	export set_OSHAIR                    := [src_OSHAIR                    ];
	export set_Phones_Plus               := [src_Phones_Plus               ];
	export set_Professional_License      := [src_Professional_License      ];
	export set_Redbooks                  := [src_Redbooks                  ];
	export set_CA_Sales_Tax              := [src_CA_Sales_Tax              ];
	export set_IA_Sales_Tax              := [src_IA_Sales_Tax              ];
	export set_SDA                       := [src_SDA                       ];
	export set_SDAA                      := [src_SDAA                      ];
	export set_SEC_Broker_Dealer         := [src_SEC_Broker_Dealer         ];
	export set_Sheila_Greco              := [src_Sheila_Greco              ];
	export set_SKA                       := [src_SKA                       ];
	export set_FL_SO                     := [src_FL_SO                     ];
	export set_GA_SO                     := [src_GA_SO                     ];
	export set_MI_SO                     := [src_MI_SO                     ];
	export set_PA_SO                     := [src_PA_SO                     ];
	export set_UT_SO                     := [src_UT_SO                     ];
	export set_Spoke                     := [src_Spoke                     ];
	export set_Targus_White_pages        := [src_Targus_White_pages        ];
	export set_Tax_practitioner          := [src_Tax_practitioner          ];
	export set_TCOA_After_Address        := [src_TCOA_After_Address        ];
	export set_TCOA_Before_Address       := [src_TCOA_Before_Address       ];
	export set_TransUnion_Direct         := [src_TransUnion                ];
	export set_TUCS_Ptrack               := [src_TUCS_Ptrack               ];
	export set_TXBUS                     := [src_TXBUS                     ];
	export set_UCC                       := [src_UCC                       ];
	export set_UCCV2                     := [src_UCCV2                     ];
	export set_US_Coastguard             := [src_US_Coastguard             ];
	export set_Utilities                 := [src_Utilities                 ];
	export set_Util_Work_Phone           := [src_Util_Work_Phone           ];
	export set_FL_Veh                    := [src_FL_Veh                    ];
	export set_ID_Veh                    := [src_ID_Veh                    ];
	export set_KY_Veh                    := [src_KY_Veh                    ];
	export set_ME_Veh                    := [src_ME_Veh                    ];
	export set_MN_Veh                    := [src_MN_Veh                    ];
	export set_MO_Veh                    := [src_MO_Veh                    ];
	export set_MS_Veh                    := [src_MS_Veh                    ];
	export set_MT_Veh                    := [src_MT_Veh                    ];
	export set_NC_Veh                    := [src_NC_Veh                    ];
	export set_ND_Veh                    := [src_ND_Veh                    ];
	export set_NE_Veh                    := [src_NE_Veh                    ];
	export set_NM_Veh                    := [src_NM_Veh                    ];
	export set_NV_Veh                    := [src_NV_Veh                    ];
	export set_OH_Veh                    := [src_OH_Veh                    ];
	export set_TX_Veh                    := [src_TX_Veh                    ];
	export set_UT_Veh                    := [src_UT_Veh                    ];
	export set_WI_Veh                    := [src_WI_Veh                    ];
	export set_WY_Veh                    := [src_WY_Veh                    ];
	export set_AK_Experian_Veh           := [src_AK_Experian_Veh           ];
	export set_AL_Experian_Veh           := [src_AL_Experian_Veh           ];
	export set_CO_Experian_Veh           := [src_CO_Experian_Veh           ];
	export set_CT_Experian_Veh           := [src_CT_Experian_Veh           ];
	export set_DC_Experian_Veh           := [src_DC_Experian_Veh           ];
	export set_DE_Experian_Veh           := [src_DE_Experian_Veh           ];
	export set_FL_Experian_Veh           := [src_FL_Experian_Veh           ];
	export set_ID_Experian_Veh           := [src_ID_Experian_Veh           ];
	export set_IL_Experian_Veh           := [src_IL_Experian_Veh           ];
	export set_KY_Experian_Veh           := [src_KY_Experian_Veh           ];
	export set_LA_Experian_Veh           := [src_LA_Experian_Veh           ];
	export set_MA_Experian_Veh           := [src_MA_Experian_Veh           ];
	export set_MD_Experian_Veh           := [src_MD_Experian_Veh           ];
	export set_ME_Experian_Veh           := [src_ME_Experian_Veh           ];
	export set_MI_Experian_Veh           := [src_MI_Experian_Veh           ];
	export set_MN_Experian_Veh           := [src_MN_Experian_Veh           ];
	export set_MO_Experian_Veh           := [src_MO_Experian_Veh           ];
	export set_MS_Experian_Veh           := [src_MS_Experian_Veh           ];
	export set_MT_Experian_Veh           := [src_MT_Experian_Veh           ];
	export set_ND_Experian_Veh           := [src_ND_Experian_Veh           ];
	export set_NE_Experian_Veh           := [src_NE_Experian_Veh           ];
	export set_NM_Experian_Veh           := [src_NM_Experian_Veh           ];
	export set_NV_Experian_Veh           := [src_NV_Experian_Veh           ];
	export set_NY_Experian_Veh           := [src_NY_Experian_Veh           ];
	export set_OH_Experian_Veh           := [src_OH_Experian_Veh           ];
	export set_OK_Experian_Veh           := [src_OK_Experian_Veh           ];
	export set_OR_Experian_Veh           := [src_OR_Experian_Veh           ];
	export set_SC_Experian_Veh           := [src_SC_Experian_Veh           ];
	export set_TN_Experian_Veh           := [src_TN_Experian_Veh           ];
	export set_TX_Experian_Veh           := [src_TX_Experian_Veh           ];
	export set_UT_Experian_Veh           := [src_UT_Experian_Veh           ];
	export set_WI_Experian_Veh           := [src_WI_Experian_Veh           ];
	export set_WY_Experian_Veh           := [src_WY_Experian_Veh           ];
	export set_Vickers                   := [src_Vickers                   ];
	export set_Voters_v2                 := [src_Voters_v2                 ];
	export set_AK_Watercraft             := [src_AK_Watercraft             ];
	export set_AL_Watercraft             := [src_AL_Watercraft             ];
	export set_AR_Watercraft             := [src_AR_Watercraft             ];
	export set_AZ_Watercraft             := [src_AZ_Watercraft             ];
	export set_CO_Watercraft             := [src_CO_Watercraft             ];
	export set_CT_Watercraft             := [src_CT_Watercraft             ];
	export set_FL_Watercraft             := [src_FL_Watercraft             ];
	export set_GA_Watercraft             := [src_GA_Watercraft             ];
	export set_IA_Watercraft             := [src_IA_Watercraft             ];
	export set_IL_Watercraft             := [src_IL_Watercraft             ];
	export set_KS_Watercraft             := [src_KS_Watercraft             ];
	export set_KY_Watercraft             := [src_KY_Watercraft             ];
	export set_MA_Watercraft             := [src_MA_Watercraft             ];
	export set_MD_Watercraft             := [src_MD_Watercraft             ];
	export set_ME_Watercraft             := [src_ME_Watercraft             ];
	export set_MI_Watercraft             := [src_MI_Watercraft             ];
	export set_MN_Watercraft             := [src_MN_Watercraft             ];
	export set_MO_Watercraft             := [src_MO_Watercraft             ];
	export set_MS_Watercraft             := [src_MS_Watercraft             ];
	export set_MT_Watercraft             := [src_MT_Watercraft             ];
	export set_NC_Watercraft             := [src_NC_Watercraft             ];
	export set_ND_Watercraft             := [src_ND_Watercraft             ];
	export set_NE_Watercraft             := [src_NE_Watercraft             ];
	export set_NH_Watercraft             := [src_NH_Watercraft             ];
	export set_NV_Watercraft             := [src_NV_Watercraft             ];
	export set_NY_Watercraft             := [src_NY_Watercraft             ];
	export set_OH_Watercraft             := [src_OH_Watercraft             ];
	export set_OR_Watercraft             := [src_OR_Watercraft             ];
	export set_SC_Watercraft             := [src_SC_Watercraft             ];
	export set_TN_Watercraft             := [src_TN_Watercraft             ];
	export set_TX_Watercraft             := [src_TX_Watercraft             ];
	export set_UT_Watercraft             := [src_UT_Watercraft             ];
	export set_VA_Watercraft             := [src_VA_Watercraft             ];
	export set_WI_Watercraft             := [src_WI_Watercraft             ];
	export set_WV_Watercraft             := [src_WV_Watercraft             ];
	export set_WY_Watercraft             := [src_WY_Watercraft             ];
	export set_FL_Watercraft_LN          := [src_FL_Watercraft_LN          ];
	export set_KY_Watercraft_LN          := [src_KY_Watercraft_LN          ];
	export set_MO_Watercraft_LN          := [src_MO_Watercraft_LN          ];
	export set_Whois_domains             := [src_Whois_domains             ];
	export set_Wither_and_Die            := [src_Wither_and_Die            ];
	export set_MS_Worker_Comp            := [src_MS_Worker_Comp            ];
	export set_OR_Worker_Comp            := [src_OR_Worker_Comp            ];
	export set_Yellow_Pages              := [src_Yellow_Pages              ];
	export set_ZOOM                      := [src_ZOOM                      ];


	// -----------------------------------------
	// -- Permissioning of Source Codes
	// -----------------------------------------
	export str_DPPA 						:= 'A';
	export str_DPPA_Probation		:= 'B';
	export str_NonDPPA 					:= ' ';
	export str_Utility					:= 'U';
	export str_FCRA 						:= 'D';
	export str_FCRA_Probation 	:= 'E';
	export str_Other_Probation 	:= 'C';


	export set_FCRA   					:= [str_FCRA, str_FCRA_Probation];
	export set_DPPA   					:= [str_DPPA, str_DPPA_Probation];
	export set_Probation   			:= [str_DPPA_Probation, str_FCRA_Probation, str_Other_Probation];


	export SourceGroup(string2 sr) := 
		MAP( 
			 sr in set_TEMP_Probation_sources	=> str_Other_Probation
			,sr in set_DPPA_Probation_sources	=> str_DPPA_Probation
			,sr in set_DPPA_sources 			 		=> str_DPPA 			 
			,sr in set_NonDPPA_sources				=> str_NonDPPA 
			,sr in set_Utility_sources		 		=> str_Utility 
			,sr in set_FCRA_sources			 			=> str_FCRA 
			,sr in set_FCRA_Probation_sources => str_FCRA_Probation
			,																		 str_Other_Probation
		 ); 


	// -----------------------------------------
	// -- Source Tests
	// -----------------------------------------
	export SourceIsACA                        (string  sr) := sr               in set_ACA                        ;
	export SourceIsAccurint_Arrest_Log        (string  sr) := sr               in set_Accurint_Arrest_Log        ;
	export SourceIsAccurint_Crim_Court        (string  sr) := sr               in set_Accurint_Crim_Court        ;
	export SourceIsAccurint_DOC               (string  sr) := sr               in set_Accurint_DOC               ;
	export SourceIsAccurint_Sex_offender      (string  sr) := sr               in set_Accurint_Sex_offender      ;
	export SourceIsAccurint_Trade_Show        (string  sr) := sr               in set_Accurint_Trade_Show        ;
	export SourceIsACF                        (string  sr) := sr               in set_ACF                        ;
	export SourceIsAircrafts                  (string  sr) := sr               in set_Aircrafts                  ;
	export SourceIsAirmen                     (string  sr) := sr               in set_Airmen                     ;
	export SourceIsAK_Busreg                  (string  sr) := sr               in set_AK_Busreg                  ;
	export SourceIsAK_Fishing_boats           (string  sr) := sr               in set_AK_Fishing_boats           ;
	export SourceIsAK_Perm_Fund               (string  sr) := sr               in set_AK_Perm_Fund               ;
	export SourceIsAmerican_Students_List     (string  sr) := sr               in set_American_Students_List     ;
	export SourceIsAMIDIR                     (string  sr) := sr               in set_AMIDIR                     ;
	export SourceIsATF                        (string  sr) := sr               in set_atf                        ;
	export SourceIsBankruptcy                 (string  sr) := sr               in set_bk                         ;
	export SourceIsBBB                        (string  sr) := sr               in set_BBB                        ;
	export SourceIsBBB_Member                 (string  sr) := sr               in set_BBB_Member                 ;
	export SourceIsBBB_Non_Member             (string  sr) := sr               in set_BBB_Non_Member             ;
	export SourceIsBusinessHeader             (string  sr) := sr               in set_business_header            ;
	export SourceIsBusiness_contacts          (string  sr) := sr               in set_Business_contacts          ;
	export SourceIsBusiness_Registration      (string  sr) := sr               in set_Business_Registration      ;
	export SourceIsCertegy                    (string  sr) := sr               in set_Certegy                    ;
	export SourceIsFL_CH                      (string  sr) := sr               in set_FL_CH                      ;
	export SourceIsGA_CH                      (string  sr) := sr               in set_GA_CH                      ;
	export SourceIsPA_CH                      (string  sr) := sr               in set_PA_CH                      ;
	export SourceIsUT_CH                      (string  sr) := sr               in set_UT_CH                      ;
	export SourceIsAK_Corporations            (string  sr) := sr               in set_AK_Corporations            ;
	export SourceIsAL_Corporations            (string  sr) := sr               in set_AL_Corporations            ;
	export SourceIsAR_Corporations            (string  sr) := sr               in set_AR_Corporations            ;
	export SourceIsAZ_Corporations            (string  sr) := sr               in set_AZ_Corporations            ;
	export SourceIsCA_Corporations            (string  sr) := sr               in set_CA_Corporations            ;
	export SourceIsCO_Corporations            (string  sr) := sr               in set_CO_Corporations            ;
	export SourceIsCT_Corporations            (string  sr) := sr               in set_CT_Corporations            ;
	export SourceIsDC_Corporations            (string  sr) := sr               in set_DC_Corporations            ;
	export SourceIsFL_Corporations            (string  sr) := sr               in set_FL_Corporations            ;
	export SourceIsGA_Corporations            (string  sr) := sr               in set_GA_Corporations            ;
	export SourceIsHI_Corporations            (string  sr) := sr               in set_HI_Corporations            ;
	export SourceIsIA_Corporations            (string  sr) := sr               in set_IA_Corporations            ;
	export SourceIsID_Corporations            (string  sr) := sr               in set_ID_Corporations            ;
	export SourceIsIL_Corporations            (string  sr) := sr               in set_IL_Corporations            ;
	export SourceIsIN_Corporations            (string  sr) := sr               in set_IN_Corporations            ;
	export SourceIsKS_Corporations            (string  sr) := sr               in set_KS_Corporations            ;
	export SourceIsKY_Corporations            (string  sr) := sr               in set_KY_Corporations            ;
	export SourceIsLA_Corporations            (string  sr) := sr               in set_LA_Corporations            ;
	export SourceIsMA_Corporations            (string  sr) := sr               in set_MA_Corporations            ;
	export SourceIsMD_Corporations            (string  sr) := sr               in set_MD_Corporations            ;
	export SourceIsME_Corporations            (string  sr) := sr               in set_ME_Corporations            ;
	export SourceIsMI_Corporations            (string  sr) := sr               in set_MI_Corporations            ;
	export SourceIsMN_Corporations            (string  sr) := sr               in set_MN_Corporations            ;
	export SourceIsMO_Corporations            (string  sr) := sr               in set_MO_Corporations            ;
	export SourceIsMS_Corporations            (string  sr) := sr               in set_MS_Corporations            ;
	export SourceIsMT_Corporations            (string  sr) := sr               in set_MT_Corporations            ;
	export SourceIsNC_Corporations            (string  sr) := sr               in set_NC_Corporations            ;
	export SourceIsND_Corporations            (string  sr) := sr               in set_ND_Corporations            ;
	export SourceIsNE_Corporations            (string  sr) := sr               in set_NE_Corporations            ;
	export SourceIsNH_Corporations            (string  sr) := sr               in set_NH_Corporations            ;
	export SourceIsNJ_Corporations            (string  sr) := sr               in set_NJ_Corporations            ;
	export SourceIsNM_Corporations            (string  sr) := sr               in set_NM_Corporations            ;
	export SourceIsNV_Corporations            (string  sr) := sr               in set_NV_Corporations            ;
	export SourceIsNY_Corporations            (string  sr) := sr               in set_NY_Corporations            ;
	export SourceIsOH_Corporations            (string  sr) := sr               in set_OH_Corporations            ;
	export SourceIsOK_Corporations            (string  sr) := sr               in set_OK_Corporations            ;
	export SourceIsOR_Corporations            (string  sr) := sr               in set_OR_Corporations            ;
	export SourceIsPA_Corporations            (string  sr) := sr               in set_PA_Corporations            ;
	export SourceIsRI_Corporations            (string  sr) := sr               in set_RI_Corporations            ;
	export SourceIsSC_Corporations            (string  sr) := sr               in set_SC_Corporations            ;
	export SourceIsSD_Corporations            (string  sr) := sr               in set_SD_Corporations            ;
	export SourceIsTN_Corporations            (string  sr) := sr               in set_TN_Corporations            ;
	export SourceIsTX_Corporations            (string  sr) := sr               in set_TX_Corporations            ;
	export SourceIsUT_Corporations            (string  sr) := sr               in set_UT_Corporations            ;
	export SourceIsVA_Corporations            (string  sr) := sr               in set_VA_Corporations            ;
	export SourceIsVT_Corporations            (string  sr) := sr               in set_VT_Corporations            ;
	export SourceIsWA_Corporations            (string  sr) := sr               in set_WA_Corporations            ;
	export SourceIsWI_Corporations            (string  sr) := sr               in set_WI_Corporations            ;
	export SourceIsWV_Corporations            (string  sr) := sr               in set_WV_Corporations            ;
	export SourceIsWY_Corporations            (string  sr) := sr               in set_WY_Corporations            ;
	export SourceIsCorpV2                     (string  sr) := sr               in set_CorpV2                     ;
	export SourceIsCredit_Unions              (string  sr) := sr               in set_Credit_Unions              ;
	export SourceIsCriminal_History           (string  sr) := sr               in set_Criminal_History           ;
	export SourceIsDCA                        (string  sr) := sr               in set_DCA                        ;
	export SourceIsDea                        (string  sr) := sr               in set_Dea                        ;
	export SourceIsDeath                      (string  sr) := sr               in set_Death                      ;
	export SourceIsDeath_Master               (string  sr) := sr               in set_Death_Master               ;
	export SourceIsDeath_State                (string  sr) := sr               in set_Death_State                ;
	export SourceIsDirectDL                   (string  sr) := sr               in set_direct_dl                  ;
	export SourceIsDirectVehicle              (string  sr) := sr               in set_direct_vehicles            ;
	export SourceIsDL                         (string  sr) := sr               in set_dl                         ;
	export SourceIsCT_DL                      (string  sr) := sr               in set_CT_DL                      ;
	export SourceIsFL_DL                      (string  sr) := sr               in set_FL_DL                      ;
	export SourceIsIA_DL                      (string  sr) := sr               in set_IA_DL                      ;
	export SourceIsID_DL                      (string  sr) := sr               in set_ID_DL                      ;
	export SourceIsKY_DL                      (string  sr) := sr               in set_KY_DL                      ;
	export SourceIsMA_DL                      (string  sr) := sr               in set_MA_DL                      ;
	export SourceIsME_DL                      (string  sr) := sr               in set_ME_DL                      ;
	export SourceIsMI_DL                      (string  sr) := sr               in set_MI_DL                      ;
	export SourceIsMN_DL                      (string  sr) := sr               in set_MN_DL                      ;
	export SourceIsMO_DL                      (string  sr) := sr               in set_MO_DL                      ;
	export SourceIsNM_DL                      (string  sr) := sr               in set_NM_DL                      ;
	export SourceIsOH_DL                      (string  sr) := sr               in set_OH_DL                      ;
	export SourceIsOR_DL                      (string  sr) := sr               in set_OR_DL                      ;
	export SourceIsTN_DL                      (string  sr) := sr               in set_TN_DL                      ;
	export SourceIsTX_DL                      (string  sr) := sr               in set_TX_DL                      ;
	export SourceIsUT_DL                      (string  sr) := sr               in set_UT_DL                      ;
	export SourceIsWI_DL                      (string  sr) := sr               in set_WI_DL                      ;
	export SourceIsWV_DL                      (string  sr) := sr               in set_WV_DL                      ;
	export SourceIsWY_DL                      (string  sr) := sr               in set_WY_DL                      ;
	export SourceIsCO_Experian_DL             (string  sr) := sr               in set_CO_Experian_DL             ;
	export SourceIsDE_Experian_DL             (string  sr) := sr               in set_DE_Experian_DL             ;
	export SourceIsID_Experian_DL             (string  sr) := sr               in set_ID_Experian_DL             ;
	export SourceIsIL_Experian_DL             (string  sr) := sr               in set_IL_Experian_DL             ;
	export SourceIsKY_Experian_DL             (string  sr) := sr               in set_KY_Experian_DL             ;
	export SourceIsLA_Experian_DL             (string  sr) := sr               in set_LA_Experian_DL             ;
	export SourceIsMD_Experian_DL             (string  sr) := sr               in set_MD_Experian_DL             ;
	export SourceIsMS_Experian_DL             (string  sr) := sr               in set_MS_Experian_DL             ;
	export SourceIsND_Experian_DL             (string  sr) := sr               in set_ND_Experian_DL             ;
	export SourceIsNH_Experian_DL             (string  sr) := sr               in set_NH_Experian_DL             ;
	export SourceIsSC_Experian_DL             (string  sr) := sr               in set_SC_Experian_DL             ;
	export SourceIsWV_Experian_DL             (string  sr) := sr               in set_WV_Experian_DL             ;
	export SourceIsDPPA                       (string2 sr) := SourceGroup(sr)  in set_DPPA                       ;
	export SourceIsDummy_Records              (string  sr) := sr               in set_Dummy_Records              ;
	export SourceIsDunn_Bradstreet            (string  sr) := sr               in set_Dunn_Bradstreet            ;
	export SourceIsDunn_Bradstreet_Fein       (string  sr) := sr               in set_Dunn_Bradstreet_Fein       ;
	export SourceIsEBR                        (string  sr) := sr               in set_EBR                        ;
	export SourceIsEdgar                      (string  sr) := sr               in set_Edgar                      ;
	export SourceIsEmerges                    (string  sr) := sr               in set_Emerges                    ;
	export SourceIsEMerge_Boat                (string  sr) := sr               in set_EMerge_Boat                ;
	export SourceIsEMerge_CCW                 (string  sr) := sr               in set_EMerge_CCW                 ;
	export SourceIsEMerge_Cens                (string  sr) := sr               in set_EMerge_Cens                ;
	export SourceIsEMerge_Fish                (string  sr) := sr               in set_EMerge_Fish                ;
	export SourceIsEMerge_Hunt                (string  sr) := sr               in set_EMerge_Hunt                ;
	export SourceIsEMerge_Master              (string  sr) := sr               in set_EMerge_Master              ;
	export SourceIsEmployee_Directories       (string  sr) := sr               in set_Employee_Directories       ;
	export SourceIsEquifax                    (string  sr) := sr               in set_Equifax                    ;
	export SourceIsEquifax_Direct             (string  sr) := sr               in set_Equifax_Direct             ;
	export SourceIsEquifax_Quick              (string  sr) := sr               in set_Equifax_Quick              ;
	export SourceIsEquifax_Weekly             (string  sr) := sr               in set_Equifax_Weekly             ;
	export SourceIsEq_Employer                (string  sr) := sr               in set_Eq_Employer                ;
	export SourceIsExperianDL                 (string  sr) := sr               in set_experian_dl                ;
	export SourceIsExperianVehicle            (string  sr) := sr               in set_experian_vehicles          ;
	export SourceIsExperian_Credit_Header     (string  sr) := sr               in set_Experian_Credit_Header     ;
	export SourceIsFAA                        (string  sr) := sr               in set_FAA                        ;
	export SourceIsFares_Deeds_from_Asrs      (string  sr) := sr               in set_Fares_Deeds_from_Asrs      ;
	export SourceIsFBNV2                      (string  sr) := sr               in set_fbnv2                      ;
	export SourceIsFBNV2_CA_Orange_county     (string  sr) := sr               in set_FBNV2_CA_Orange_county     ;
	export SourceIsFBNV2_CA_Santa_Clara       (string  sr) := sr               in set_FBNV2_CA_Santa_Clara       ;
	export SourceIsFBNV2_CA_San_Bernadino     (string  sr) := sr               in set_FBNV2_CA_San_Bernadino     ;
	export SourceIsFBNV2_CA_San_Diego         (string  sr) := sr               in set_FBNV2_CA_San_Diego         ;
	export SourceIsFBNV2_CA_Ventura           (string  sr) := sr               in set_FBNV2_CA_Ventura           ;
	export SourceIsFBNV2_Experian_Direct      (string  sr) := sr               in set_FBNV2_Experian_Direct      ;
	export SourceIsFBNV2_FL                   (string  sr) := sr               in set_FBNV2_FL                   ;
	export SourceIsFBNV2_Hist_Choicepoint     (string  sr) := sr               in set_FBNV2_Hist_Choicepoint     ;
	export SourceIsFBNV2_INF                  (string  sr) := sr               in set_FBNV2_INF                  ;
	export SourceIsFBNV2_New_York             (string  sr) := sr               in set_FBNV2_New_York             ;
	export SourceIsFBNV2_TX_Dallas            (string  sr) := sr               in set_FBNV2_TX_Dallas            ;
	export SourceIsFBNV2_TX_Harris            (string  sr) := sr               in set_FBNV2_TX_Harris            ;
	export SourceIsFCC_Radio_Licenses         (string  sr) := sr               in set_FCC_Radio_Licenses         ;
	export SourceIsFCRA                       (string2 sr) := SourceGroup(sr)  in set_FCRA                       ;
	export SourceIsFCRA_Corrections_record    (string  sr) := sr               in set_FCRA_Corrections_record    ;
	export SourceIsFDIC                       (string  sr) := sr               in set_FDIC                       ;
	export SourceIsFederal_Explosives         (string  sr) := sr               in set_Federal_Explosives         ;
	export SourceIsFederal_Firearms           (string  sr) := sr               in set_Federal_Firearms           ;
	export SourceIsFL_FBN                     (string  sr) := sr               in set_FL_FBN                     ;
	export SourceIsFL_Non_Profit              (string  sr) := sr               in set_FL_Non_Profit              ;
	export SourceIsForeclosures               (string  sr) := sr               in set_Foreclosures               ;
	export SourceIsForeclosures_Delinquent    (string  sr) := sr               in set_Foreclosures_Delinquent    ;
	export SourceIsNJ_Gaming_Licenses         (string  sr) := sr               in set_NJ_Gaming_Licenses         ;
	export SourceIsGLB                        (string2 sr) := sr               in set_GLB                        ;
	export SourceIsGong                       (string  sr) := sr               in set_Gong                       ;
	export SourceIsGong_Business              (string  sr) := sr               in set_Gong_Business              ;
	export SourceIsGong_Government            (string  sr) := sr               in set_Gong_Government            ;
	export SourceIsGong_History               (string  sr) := sr               in set_Gong_History               ;
	export SourceIsGong_phone_append          (string  sr) := sr               in set_Gong_phone_append          ;
	export SourceIsInfousa                    (string  sr) := sr               in set_Infousa                    ;
	export SourceIsINFOUSA_ABIUS_USABIZ       (string  sr) := sr               in set_INFOUSA_ABIUS_USABIZ       ;
	export SourceIsINFOUSA_DEAD_COMPANIES     (string  sr) := sr               in set_INFOUSA_DEAD_COMPANIES     ;
	export SourceIsINFOUSA_IDEXEC             (string  sr) := sr               in set_INFOUSA_IDEXEC             ;
	export SourceIsIngenix_Sanctions          (string  sr) := sr               in set_Ingenix_Sanctions          ;
	export SourceIsIRS_5500                   (string  sr) := sr               in set_IRS_5500                   ;
	export SourceIsIRS_Non_Profit             (string  sr) := sr               in set_IRS_Non_Profit             ;
	export SourceIsJigsaw                     (string  sr) := sr               in set_Jigsaw                     ;
	export SourceIsLexis_Trans_Union          (string  sr) := sr               in set_Lexis_Trans_Union          ;
	export SourceIsLiens                      (string  sr) := sr               in set_liens                      ;
	export SourceIsLiensV1                    (string  sr) := sr               in set_LiensV1                    ;
	export SourceIsLiens_and_Judgments        (string  sr) := sr               in set_Liens_and_Judgments        ;
	export SourceIsLiens_v2                   (string  sr) := sr               in set_Liens_v2                   ;
	export SourceIsLiens_v2_CA_Federal        (string  sr) := sr               in set_Liens_v2_CA_Federal        ;
	export SourceIsLiens_v2_Chicago_Law       (string  sr) := sr               in set_Liens_v2_Chicago_Law       ;
	export SourceIsLiens_v2_Hogan             (string  sr) := sr               in set_Liens_v2_Hogan             ;
	export SourceIsLiens_v2_ILFDLN            (string  sr) := sr               in set_Liens_v2_ILFDLN            ;
	export SourceIsLiens_v2_MA                (string  sr) := sr               in set_Liens_v2_MA                ;
	export SourceIsLiens_v2_NYC               (string  sr) := sr               in set_Liens_v2_NYC               ;
	export SourceIsLiens_v2_NYFDLN            (string  sr) := sr               in set_Liens_v2_NYFDLN            ;
	export SourceIsLiens_v2_Service_Abstract  (string  sr) := sr               in set_Liens_v2_Service_Abstract  ;
	export SourceIsLiens_v2_Superior_Party    (string  sr) := sr               in set_Liens_v2_Superior_Party    ;
	export SourceIsLiquor_Licenses            (string  sr) := sr               in set_Liquor_Licenses            ;
	export SourceIsCA_Liquor_Licenses         (string  sr) := sr               in set_CA_Liquor_Licenses         ;
	export SourceIsCT_Liquor_Licenses         (string  sr) := sr               in set_CT_Liquor_Licenses         ;
	export SourceIsIN_Liquor_Licenses         (string  sr) := sr               in set_IN_Liquor_Licenses         ;
	export SourceIsLA_Liquor_Licenses         (string  sr) := sr               in set_LA_Liquor_Licenses         ;
	export SourceIsOH_Liquor_Licenses         (string  sr) := sr               in set_OH_Liquor_Licenses         ;
	export SourceIsPA_Liquor_Licenses         (string  sr) := sr               in set_PA_Liquor_Licenses         ;
	export SourceIsTX_Liquor_Licenses         (string  sr) := sr               in set_TX_Liquor_Licenses         ;
	export SourceIsLnPropertyV2               (string  sr) := sr               in set_lnpropertyV2               ;
	export SourceIsLnPropV2_Fares_Asrs        (string  sr) := sr               in set_LnPropV2_Fares_Asrs        ;
	export SourceIsLnPropV2_Fares_Deeds       (string  sr) := sr               in set_LnPropV2_Fares_Deeds       ;
	export SourceIsLnPropV2_Lexis_Asrs        (string  sr) := sr               in set_LnPropV2_Lexis_Asrs        ;
	export SourceIsLnPropV2_Lexis_Deeds_Mtgs  (string  sr) := sr               in set_LnPropV2_Lexis_Deeds_Mtgs  ;
	export SourceIsLobbyists                  (string  sr) := sr               in set_Lobbyists                  ;
	export SourceIsMartinDale_Hubbell         (string  sr) := sr               in set_MartinDale_Hubbell         ;
	export SourceIsMiscellaneous              (string  sr) := sr               in set_Miscellaneous              ;
	export SourceIsMixed_DPPA                 (string  sr) := sr               in set_Mixed_DPPA                 ;
	export SourceIsMixed_Non_DPPA             (string  sr) := sr               in set_Mixed_Non_DPPA             ;
	export SourceIsMixed_Probation            (string  sr) := sr               in set_Mixed_Probation            ;
	export SourceIsMixed_Utilities            (string  sr) := sr               in set_Mixed_Utilities            ;
	export SourceIsNCOA                       (string  sr) := sr               in set_NCOA                       ;
	export SourceIsNonUpdatingSrc             (string  sr) := sr               in set_NonUpdatingSrc             ;
	#if(_Control.ThisEnvironment.IsPlatformThor = true)
		export SourceIsOnProbation                (string  sr) := SourceGroup(sr)  in set_Probation                  ;
	#else
		export SourceIsOnProbation                (string  sr) := codes.KeyCodes('HEADER_MASTER_V5','PROBATION',,sr)<>'';
	#end
	export SourceIsOSHAIR                     (string  sr) := sr               in set_OSHAIR                     ;
	export SourceIsPaw                        (string  sr) := sr               in set_paw                        ;
	export SourceIsPeopleHeader               (string  sr) := sr               in set_header                     ;
	export SourceIsPhones_Plus                (string  sr) := sr               in set_Phones_Plus                ;
	export SourceIsProfessional_License       (string  sr) := sr               in set_Professional_License       ;
	export SourceIsProperty                   (string  sr) := sr               in set_property                   ;
	export SourceIsRedbooks                   (string  sr) := sr               in set_Redbooks                   ;
	export SourceIsCA_Sales_Tax               (string  sr) := sr               in set_CA_Sales_Tax               ;
	export SourceIsIA_Sales_Tax               (string  sr) := sr               in set_IA_Sales_Tax               ;
	export SourceIsState_Sales_Tax            (string  sr) := sr               in set_State_Sales_Tax            ;
	export SourceIsSDA                        (string  sr) := sr               in set_SDA                        ;
	export SourceIsSDAA                       (string  sr) := sr               in set_SDAA                       ;
	export SourceIsSEC_Broker_Dealer          (string  sr) := sr               in set_SEC_Broker_Dealer          ;
	export SourceIsSex_Offender               (string  sr) := sr               in set_Sex_Offender               ;
	export SourceIsSheila_Greco               (string  sr) := sr               in set_Sheila_Greco               ;
	export SourceIsSKA                        (string  sr) := sr               in set_SKA                        ;
	export SourceIsFL_SO                      (string  sr) := sr               in set_FL_SO                      ;
	export SourceIsGA_SO                      (string  sr) := sr               in set_GA_SO                      ;
	export SourceIsMI_SO                      (string  sr) := sr               in set_MI_SO                      ;
	export SourceIsPA_SO                      (string  sr) := sr               in set_PA_SO                      ;
	export SourceIsUT_SO                      (string  sr) := sr               in set_UT_SO                      ;
	export SourceIsSpoke                      (string  sr) := sr               in set_Spoke                      ;
	export SourceIsTargus_White_pages         (string  sr) := sr               in set_Targus_White_pages         ;
	export SourceIsTax_practitioner           (string  sr) := sr               in set_Tax_practitioner           ;
	export SourceIsTCOA                       (string  sr) := sr               in set_TCOA                       ;
	export SourceIsTCOA_After_Address         (string  sr) := sr               in set_TCOA_After_Address         ;
	export SourceIsTCOA_Before_Address        (string  sr) := sr               in set_TCOA_Before_Address        ;
	export SourceIsTransUnion                 (string  sr) := sr               in set_transunion                 ;
	export SourceIsTransUnion_Direct          (string  sr) := sr               in set_TransUnion_Direct          ;
	export SourceIsTUCS_Ptrack                (string  sr) := sr               in set_TUCS_Ptrack                ;
	export SourceIsTXBUS                      (string  sr) := sr               in set_TXBUS                      ;
	export SourceIsUCC                        (string  sr) := sr               in set_UCC                        ;
	export SourceIsUCCS                       (string  sr) := sr               in set_UCCS                       ;
	export SourceIsUCCV2                      (string  sr) := sr               in set_UCCV2                      ;
	export SourceIsUS_Coastguard              (string  sr) := sr               in set_US_Coastguard              ;
	export SourceIsUtilities                  (string  sr) := sr               in set_Utilities                  ;
	export SourceIsUtility                    (string  sr) := SourceGroup(sr)  =  str_Utility                    ;
	export SourceIsUtil_Work_Phone            (string  sr) := sr               in set_Util_Work_Phone            ;
	export SourceIsFL_Veh                     (string  sr) := sr               in set_FL_Veh                     ;
	export SourceIsID_Veh                     (string  sr) := sr               in set_ID_Veh                     ;
	export SourceIsKY_Veh                     (string  sr) := sr               in set_KY_Veh                     ;
	export SourceIsME_Veh                     (string  sr) := sr               in set_ME_Veh                     ;
	export SourceIsMN_Veh                     (string  sr) := sr               in set_MN_Veh                     ;
	export SourceIsMO_Veh                     (string  sr) := sr               in set_MO_Veh                     ;
	export SourceIsMS_Veh                     (string  sr) := sr               in set_MS_Veh                     ;
	export SourceIsMT_Veh                     (string  sr) := sr               in set_MT_Veh                     ;
	export SourceIsNC_Veh                     (string  sr) := sr               in set_NC_Veh                     ;
	export SourceIsND_Veh                     (string  sr) := sr               in set_ND_Veh                     ;
	export SourceIsNE_Veh                     (string  sr) := sr               in set_NE_Veh                     ;
	export SourceIsNM_Veh                     (string  sr) := sr               in set_NM_Veh                     ;
	export SourceIsNV_Veh                     (string  sr) := sr               in set_NV_Veh                     ;
	export SourceIsOH_Veh                     (string  sr) := sr               in set_OH_Veh                     ;
	export SourceIsTX_Veh                     (string  sr) := sr               in set_TX_Veh                     ;
	export SourceIsUT_Veh                     (string  sr) := sr               in set_UT_Veh                     ;
	export SourceIsWI_Veh                     (string  sr) := sr               in set_WI_Veh                     ;
	export SourceIsWY_Veh                     (string  sr) := sr               in set_WY_Veh                     ;
	export SourceIsVehicle                    (string  sr) := sr               in set_vehicles                   ;
	export SourceIsAK_Experian_Veh            (string  sr) := sr               in set_AK_Experian_Veh            ;
	export SourceIsAL_Experian_Veh            (string  sr) := sr               in set_AL_Experian_Veh            ;
	export SourceIsCO_Experian_Veh            (string  sr) := sr               in set_CO_Experian_Veh            ;
	export SourceIsCT_Experian_Veh            (string  sr) := sr               in set_CT_Experian_Veh            ;
	export SourceIsDC_Experian_Veh            (string  sr) := sr               in set_DC_Experian_Veh            ;
	export SourceIsDE_Experian_Veh            (string  sr) := sr               in set_DE_Experian_Veh            ;
	export SourceIsFL_Experian_Veh            (string  sr) := sr               in set_FL_Experian_Veh            ;
	export SourceIsID_Experian_Veh            (string  sr) := sr               in set_ID_Experian_Veh            ;
	export SourceIsIL_Experian_Veh            (string  sr) := sr               in set_IL_Experian_Veh            ;
	export SourceIsKY_Experian_Veh            (string  sr) := sr               in set_KY_Experian_Veh            ;
	export SourceIsLA_Experian_Veh            (string  sr) := sr               in set_LA_Experian_Veh            ;
	export SourceIsMA_Experian_Veh            (string  sr) := sr               in set_MA_Experian_Veh            ;
	export SourceIsMD_Experian_Veh            (string  sr) := sr               in set_MD_Experian_Veh            ;
	export SourceIsME_Experian_Veh            (string  sr) := sr               in set_ME_Experian_Veh            ;
	export SourceIsMI_Experian_Veh            (string  sr) := sr               in set_MI_Experian_Veh            ;
	export SourceIsMN_Experian_Veh            (string  sr) := sr               in set_MN_Experian_Veh            ;
	export SourceIsMO_Experian_Veh            (string  sr) := sr               in set_MO_Experian_Veh            ;
	export SourceIsMS_Experian_Veh            (string  sr) := sr               in set_MS_Experian_Veh            ;
	export SourceIsMT_Experian_Veh            (string  sr) := sr               in set_MT_Experian_Veh            ;
	export SourceIsND_Experian_Veh            (string  sr) := sr               in set_ND_Experian_Veh            ;
	export SourceIsNE_Experian_Veh            (string  sr) := sr               in set_NE_Experian_Veh            ;
	export SourceIsNM_Experian_Veh            (string  sr) := sr               in set_NM_Experian_Veh            ;
	export SourceIsNV_Experian_Veh            (string  sr) := sr               in set_NV_Experian_Veh            ;
	export SourceIsNY_Experian_Veh            (string  sr) := sr               in set_NY_Experian_Veh            ;
	export SourceIsOH_Experian_Veh            (string  sr) := sr               in set_OH_Experian_Veh            ;
	export SourceIsOK_Experian_Veh            (string  sr) := sr               in set_OK_Experian_Veh            ;
	export SourceIsOR_Experian_Veh            (string  sr) := sr               in set_OR_Experian_Veh            ;
	export SourceIsSC_Experian_Veh            (string  sr) := sr               in set_SC_Experian_Veh            ;
	export SourceIsTN_Experian_Veh            (string  sr) := sr               in set_TN_Experian_Veh            ;
	export SourceIsTX_Experian_Veh            (string  sr) := sr               in set_TX_Experian_Veh            ;
	export SourceIsUT_Experian_Veh            (string  sr) := sr               in set_UT_Experian_Veh            ;
	export SourceIsWI_Experian_Veh            (string  sr) := sr               in set_WI_Experian_Veh            ;
	export SourceIsWY_Experian_Veh            (string  sr) := sr               in set_WY_Experian_Veh            ;
	export SourceIsVickers                    (string  sr) := sr               in set_Vickers                    ;
	export SourceIsVoters_v2                  (string  sr) := sr               in set_Voters_v2                  ;
	export SourceIsAK_Watercraft              (string  sr) := sr               in set_AK_Watercraft              ;
	export SourceIsAL_Watercraft              (string  sr) := sr               in set_AL_Watercraft              ;
	export SourceIsAR_Watercraft              (string  sr) := sr               in set_AR_Watercraft              ;
	export SourceIsAZ_Watercraft              (string  sr) := sr               in set_AZ_Watercraft              ;
	export SourceIsCO_Watercraft              (string  sr) := sr               in set_CO_Watercraft              ;
	export SourceIsCT_Watercraft              (string  sr) := sr               in set_CT_Watercraft              ;
	export SourceIsFL_Watercraft              (string  sr) := sr               in set_FL_Watercraft              ;
	export SourceIsGA_Watercraft              (string  sr) := sr               in set_GA_Watercraft              ;
	export SourceIsIA_Watercraft              (string  sr) := sr               in set_IA_Watercraft              ;
	export SourceIsIL_Watercraft              (string  sr) := sr               in set_IL_Watercraft              ;
	export SourceIsKS_Watercraft              (string  sr) := sr               in set_KS_Watercraft              ;
	export SourceIsKY_Watercraft              (string  sr) := sr               in set_KY_Watercraft              ;
	export SourceIsMA_Watercraft              (string  sr) := sr               in set_MA_Watercraft              ;
	export SourceIsMD_Watercraft              (string  sr) := sr               in set_MD_Watercraft              ;
	export SourceIsME_Watercraft              (string  sr) := sr               in set_ME_Watercraft              ;
	export SourceIsMI_Watercraft              (string  sr) := sr               in set_MI_Watercraft              ;
	export SourceIsMN_Watercraft              (string  sr) := sr               in set_MN_Watercraft              ;
	export SourceIsMO_Watercraft              (string  sr) := sr               in set_MO_Watercraft              ;
	export SourceIsMS_Watercraft              (string  sr) := sr               in set_MS_Watercraft              ;
	export SourceIsMT_Watercraft              (string  sr) := sr               in set_MT_Watercraft              ;
	export SourceIsNC_Watercraft              (string  sr) := sr               in set_NC_Watercraft              ;
	export SourceIsND_Watercraft              (string  sr) := sr               in set_ND_Watercraft              ;
	export SourceIsNE_Watercraft              (string  sr) := sr               in set_NE_Watercraft              ;
	export SourceIsNH_Watercraft              (string  sr) := sr               in set_NH_Watercraft              ;
	export SourceIsNV_Watercraft              (string  sr) := sr               in set_NV_Watercraft              ;
	export SourceIsNY_Watercraft              (string  sr) := sr               in set_NY_Watercraft              ;
	export SourceIsOH_Watercraft              (string  sr) := sr               in set_OH_Watercraft              ;
	export SourceIsOR_Watercraft              (string  sr) := sr               in set_OR_Watercraft              ;
	export SourceIsSC_Watercraft              (string  sr) := sr               in set_SC_Watercraft              ;
	export SourceIsTN_Watercraft              (string  sr) := sr               in set_TN_Watercraft              ;
	export SourceIsTX_Watercraft              (string  sr) := sr               in set_TX_Watercraft              ;
	export SourceIsUT_Watercraft              (string  sr) := sr               in set_UT_Watercraft              ;
	export SourceIsVA_Watercraft              (string  sr) := sr               in set_VA_Watercraft              ;
	export SourceIsWI_Watercraft              (string  sr) := sr               in set_WI_Watercraft              ;
	export SourceIsWV_Watercraft              (string  sr) := sr               in set_WV_Watercraft              ;
	export SourceIsWY_Watercraft              (string  sr) := sr               in set_WY_Watercraft              ;
	export SourceIsFL_Watercraft_LN           (string  sr) := sr               in set_FL_Watercraft_LN           ;
	export SourceIsKY_Watercraft_LN           (string  sr) := sr               in set_KY_Watercraft_LN           ;
	export SourceIsMO_Watercraft_LN           (string  sr) := sr               in set_MO_Watercraft_LN           ;
	export SourceIsWC                         (string  sr) := sr               in set_WC                         ;
	export SourceIsWeeklyHeader               (string  sr) := sr               =  src_Equifax_Weekly             ;
	export SourceIsWhois_domains              (string  sr) := sr               in set_Whois_domains              ;
	export SourceIsWither_and_Die             (string  sr) := sr               in set_Wither_and_Die             ;
	export SourceIsMS_Worker_Comp             (string  sr) := sr               in set_MS_Worker_Comp             ;
	export SourceIsOR_Worker_Comp             (string  sr) := sr               in set_OR_Worker_Comp             ;
	export SourceIsWorkmans_Comp              (string  sr) := sr               in set_Workmans_Comp              ;
	export SourceIsYellow_Pages               (string  sr) := sr               in set_Yellow_Pages               ;
	export SourceIsZOOM                       (string  sr) := sr               in set_ZOOM                       ;
	export SourceNot4Despray                  (string2 sr) := SourceGroup(sr)  in ['none']                       ;


	// -----------------------------------------
	// -- Dataset of Source Codes + Descriptions
	// -----------------------------------------
	export layout_description :=
	RECORD
		STRING2		code												        ;
		STRING100	description									        ;
		boolean		IsBusinessHeaderSource		:= false	;
		boolean		IsPeopleHeaderSource			:= false	;
		boolean		IsBusinessContactsSource	:= false	;
		boolean		IsPawSource								:= false	;
		boolean		IsFCRA										:= false	;
		boolean		IsDPPA										:= false	;
		boolean		IsUtility									:= false	;
		boolean		IsOnProbation							:= false	;
		boolean		IsDeath 									:= false	;
		boolean		IsDL 											:= false	;
		boolean		IsWC											:= false	;
		boolean		IsProperty								:= false	;
		boolean		IsTransUnion							:= false	;
		boolean		isWeeklyHeader						:= false	;
		boolean		isVehicle									:= false	;
		boolean		isLiens										:= false	;
		boolean		isBankruptcy							:= false	;
		boolean		isCorpV2									:= false	;
		boolean		isUpdating								:= true		;
	END;																			
	export dSource_Codes := DATASET([
		 {src_ACA                       ,'American Correctional Association'                         }
		,{src_Accurint_Arrest_Log       ,'Accurint Arrest Log'                                       }
		,{src_Accurint_Crim_Court       ,'Accurint Crim Court'                                       }
		,{src_Accurint_DOC              ,'Accurint DOC'                                              }
		,{src_Accurint_Sex_offender     ,'Accurint Sex offender'                                     }
		,{src_Accurint_Trade_Show       ,'Accurint Trade Show'                                       }
		,{src_ACF                       ,'ACF - America\'s Corporate Financial Directory'            }
		,{src_Aircrafts                 ,'Aircrafts'                                                 }
		,{src_Airmen                    ,'Airmen'                                                    }
		,{src_AK_Busreg                 ,'Alaska Business Registrations'                             }
		,{src_AK_Fishing_boats          ,'AK Commercial Fishing Vessels'                             }
		,{src_AK_Perm_Fund              ,'AK Perm Fund'                                              }
		,{src_American_Students_List    ,'American Students List'                                    }
		,{src_AMIDIR                    ,'Medical Information Directory'                             }
		,{src_Bankruptcy                ,'Bankruptcy'                                                }
		,{src_BBB_Member                ,'Better Business Bureau Member'                             }
		,{src_BBB_Non_Member            ,'Better Business Bureau Non-Member'                         }
		,{src_Business_Registration     ,'Business Registration'                                     }
		,{src_Certegy                   ,'Certegy'                                                   }
		,{src_FL_CH                     ,'FL CH'                                                     }
		,{src_GA_CH                     ,'GA CH'                                                     }
		,{src_PA_CH                     ,'PA CH'                                                     }
		,{src_UT_CH                     ,'UT CH'                                                     }
		,{src_AK_Corporations           ,'AK Corporations'                                           }
		,{src_AL_Corporations           ,'AL Corporations'                                           }
		,{src_AR_Corporations           ,'AR Corporations'                                           }
		,{src_AZ_Corporations           ,'AZ Corporations'                                           }
		,{src_CA_Corporations           ,'CA Corporations'                                           }
		,{src_CO_Corporations           ,'CO Corporations'                                           }
		,{src_CT_Corporations           ,'CT Corporations'                                           }
		,{src_DC_Corporations           ,'DC Corporations'                                           }
		,{src_FL_Corporations           ,'FL Corporations'                                           }
		,{src_GA_Corporations           ,'GA Corporations'                                           }
		,{src_HI_Corporations           ,'HI Corporations'                                           }
		,{src_IA_Corporations           ,'IA Corporations'                                           }
		,{src_ID_Corporations           ,'ID Corporations'                                           }
		,{src_IL_Corporations           ,'IL Corporations'                                           }
		,{src_IN_Corporations           ,'IN Corporations'                                           }
		,{src_KS_Corporations           ,'KS Corporations'                                           }
		,{src_KY_Corporations           ,'KY Corporations'                                           }
		,{src_LA_Corporations           ,'LA Corporations'                                           }
		,{src_MA_Corporations           ,'MA Corporations'                                           }
		,{src_MD_Corporations           ,'MD Corporations'                                           }
		,{src_ME_Corporations           ,'ME Corporations'                                           }
		,{src_MI_Corporations           ,'MI Corporations'                                           }
		,{src_MN_Corporations           ,'MN Corporations'                                           }
		,{src_MO_Corporations           ,'MO Corporations'                                           }
		,{src_MS_Corporations           ,'MS Corporations'                                           }
		,{src_MT_Corporations           ,'MT Corporations'                                           }
		,{src_NC_Corporations           ,'NC Corporations'                                           }
		,{src_ND_Corporations           ,'ND Corporations'                                           }
		,{src_NE_Corporations           ,'NE Corporations'                                           }
		,{src_NH_Corporations           ,'NH Corporations'                                           }
		,{src_NJ_Corporations           ,'NJ Corporations'                                           }
		,{src_NM_Corporations           ,'NM Corporations'                                           }
		,{src_NV_Corporations           ,'NV Corporations'                                           }
		,{src_NY_Corporations           ,'NY Corporations'                                           }
		,{src_OH_Corporations           ,'OH Corporations'                                           }
		,{src_OK_Corporations           ,'OK Corporations'                                           }
		,{src_OR_Corporations           ,'OR Corporations'                                           }
		,{src_PA_Corporations           ,'PA Corporations'                                           }
		,{src_RI_Corporations           ,'RI Corporations'                                           }
		,{src_SC_Corporations           ,'SC Corporations'                                           }
		,{src_SD_Corporations           ,'SD Corporations'                                           }
		,{src_TN_Corporations           ,'TN Corporations'                                           }
		,{src_TX_Corporations           ,'TX Corporations'                                           }
		,{src_UT_Corporations           ,'UT Corporations'                                           }
		,{src_VA_Corporations           ,'VA Corporations'                                           }
		,{src_VT_Corporations           ,'VT Corporations'                                           }
		,{src_WA_Corporations           ,'WA Corporations'                                           }
		,{src_WI_Corporations           ,'WI Corporations'                                           }
		,{src_WV_Corporations           ,'WV Corporations'                                           }
		,{src_WY_Corporations           ,'WY Corporations'                                           }
		,{src_Credit_Unions             ,'Credit Unions'                                             }
		,{src_DCA                       ,'DCA'                                                       }
		,{src_DEA                       ,'DEA'                                                       }
		,{src_Death_Master              ,'Death Master'                                              }
		,{src_Death_State               ,'Death State'                                               }
		,{src_CT_DL                     ,'CT DL'                                                     }
		,{src_FL_DL                     ,'FL DL'                                                     }
		,{src_IA_DL                     ,'IA DL'                                                     }
		,{src_ID_DL                     ,'ID DL'                                                     }
		,{src_KY_DL                     ,'KY DL'                                                     }
		,{src_MA_DL                     ,'MA DL'                                                     }
		,{src_ME_DL                     ,'ME DL'                                                     }
		,{src_MI_DL                     ,'MI DL'                                                     }
		,{src_MN_DL                     ,'MN DL'                                                     }
		,{src_MO_DL                     ,'MO DL'                                                     }
		,{src_NM_DL                     ,'NM DL'                                                     }
		,{src_OH_DL                     ,'OH DL'                                                     }
		,{src_OR_DL                     ,'OR DL'                                                     }
		,{src_TN_DL                     ,'TN DL'                                                     }
		,{src_TX_DL                     ,'TX DL'                                                     }
		,{src_UT_DL                     ,'UT DL'                                                     }
		,{src_WI_DL                     ,'WI DL'                                                     }
		,{src_WV_DL                     ,'WV DL'                                                     }
		,{src_WY_DL                     ,'WY DL'                                                     }
		,{src_CO_Experian_DL            ,'CO Experian DL'                                            }
		,{src_DE_Experian_DL            ,'DE Experian DL'                                            }
		,{src_ID_Experian_DL            ,'ID Experian DL'                                            }
		,{src_IL_Experian_DL            ,'IL Experian DL'                                            }
		,{src_KY_Experian_DL            ,'KY Experian DL'                                            }
		,{src_LA_Experian_DL            ,'LA Experian DL'                                            }
		,{src_MD_Experian_DL            ,'MD Experian DL'                                            }
		,{src_MS_Experian_DL            ,'MS Experian DL'                                            }
		,{src_ND_Experian_DL            ,'ND Experian DL'                                            }
		,{src_NH_Experian_DL            ,'NH Experian DL'                                            }
		,{src_SC_Experian_DL            ,'SC Experian DL'                                            }
		,{src_WV_Experian_DL            ,'WV Experian DL'                                            }
		,{src_Dummy_Records             ,'Dummy Records'                                             }
		,{src_Dunn_Bradstreet           ,'Dunn & Bradstreet'                                         }
		,{src_Dunn_Bradstreet_Fein      ,'Dunn & Bradstreet Fein'                                    }
		,{src_EBR                       ,'Experian Business Reports'                                 }
		,{src_Edgar                     ,'Edgar'                                                     }
		,{src_EMerge_Boat               ,'EMerge Boat'                                               }
		,{src_EMerge_CCW                ,'EMerge CCW'                                                }
		,{src_EMerge_Cens               ,'EMerge Cens'                                               }
		,{src_EMerge_Fish               ,'EMerge Fish'                                               }
		,{src_EMerge_Hunt               ,'EMerge Hunt'                                               }
		,{src_EMerge_Master             ,'EMerge Master'                                             }
		,{src_Employee_Directories      ,'Employee Directories'                                      }
		,{src_Equifax                   ,'Equifax'                                                   }
		,{src_Equifax_Quick             ,'Equifax Quick'                                             }
		,{src_Equifax_Weekly            ,'Equifax Weekly'                                            }
		,{src_Eq_Employer               ,'Eq Employer'                                               }
		,{src_Experian_Credit_Header    ,'Experian Credit Header'                                    }
		,{src_Fares_Deeds_from_Asrs     ,'Fares Deeds from Assessors'                                }
		,{src_FBNV2_CA_Orange_county    ,'CAO FBNV2 California Orange county'                        }
		,{src_FBNV2_CA_Santa_Clara      ,'CSC FBNV2 California Santa Clara'                          }
		,{src_FBNV2_CA_San_Bernadino    ,'CAB FBNV2 California San Bernadino'                        }
		,{src_FBNV2_CA_San_Diego        ,'CAS FBNV2 California San Diego'                            }
		,{src_FBNV2_CA_Ventura          ,'CAV FBNV2 California Ventura'                              }
		,{src_FBNV2_Experian_Direct     ,'EXP FBNV2 Experian Direct'                                 }
		,{src_FBNV2_FL                  ,'FL  FBNV2 Florida'                                         }
		,{src_FBNV2_Hist_Choicepoint    ,'CP  FBNV2 Historical Choicepoint'                          }
		,{src_FBNV2_INF                 ,'INF FBNV2 Infousa'                                         }
		,{src_FBNV2_New_York            ,'NBX,NYN,NKI,NQU,NRI FBNV2 New York'                        }
		,{src_FBNV2_TX_Dallas           ,'TXD FBNV2 Texas Dallas'                                    }
		,{src_FBNV2_TX_Harris           ,'TXH FBNV2 Texas Harris'                                    }
		,{src_FCC_Radio_Licenses        ,'FCC Radio Licenses'                                        }
		,{src_FCRA_Corrections_record   ,'A corrections/override (used in FCRA products) record'     }
		,{src_FDIC                      ,'FDIC'                                                      }
		,{src_Federal_Explosives        ,'Federal Explosives'                                        }
		,{src_Federal_Firearms          ,'Federal Firearms'                                          }
		,{src_FL_FBN                    ,'Florida FBN'                                               }
		,{src_FL_Non_Profit             ,'Florida Non-Profit'                                        }
		,{src_Foreclosures              ,'Foreclosures'                                              }
		,{src_Foreclosures_Delinquent   ,'Foreclosures - Notice of Delinquency'                      }
		,{src_NJ_Gaming_Licenses        ,'New Jersey Gaming Licenses'                                }
		,{src_Gong_Business             ,'Gong Business'                                             }
		,{src_Gong_Government           ,'Gong Government'                                           }
		,{src_Gong_History              ,'Gong History'                                              }
		,{src_Gong_phone_append         ,'Appended phone from gong file'                             }
		,{src_INFOUSA_ABIUS_USABIZ      ,'INFOUSA ABIUS(USABIZ)'                                     }
		,{src_INFOUSA_DEAD_COMPANIES    ,'INFOUSA DEAD COMPANIES'                                    }
		,{src_INFOUSA_IDEXEC            ,'INFOUSA IDEXEC'                                            }
		,{src_Ingenix_Sanctions         ,'Ingenix National Provider Sanctions'                       }
		,{src_IRS_5500                  ,'IRS 5500'                                                  }
		,{src_IRS_Non_Profit            ,'IRS Non-Profit'                                            }
		,{src_Jigsaw                    ,'Jigsaw'                                                    }
		,{src_Lexis_Trans_Union         ,'Lexis Trans Union'                                         }
		,{src_Liens                     ,'Liens'                                                     }
		,{src_Liens_and_Judgments       ,'Liens and Judgments'                                       }
		,{src_Liens_v2                  ,'Liens v2'                                                  }
		,{src_Liens_v2_CA_Federal       ,'CA Liens v2 CA Federal'                                    }
		,{src_Liens_v2_Chicago_Law      ,'CL,CJ Liens v2 Chicago Law'                                }
		,{src_Liens_v2_Hogan            ,'HG Liens v2 Hogan'                                         }
		,{src_Liens_v2_ILFDLN           ,'IL Liens v2 ILFDLN'                                        }
		,{src_Liens_v2_MA               ,'MA Liens v2 MA'                                            }
		,{src_Liens_v2_NYC              ,'NYC Liens v2 NYC'                                          }
		,{src_Liens_v2_NYFDLN           ,'NY Liens v2 NYFDLN'                                        }
		,{src_Liens_v2_Service_Abstract ,'SA Liens v2 Service Abstract'                              }
		,{src_Liens_v2_Superior_Party   ,'SU Liens v2 Superior Party'                                }
		,{src_CA_Liquor_Licenses        ,'California Liquor Licenses'                                }
		,{src_CT_Liquor_Licenses        ,'Conneticut Liquor Licenses'                                }
		,{src_IN_Liquor_Licenses        ,'Indiana Liquor Licenses'                                   }
		,{src_LA_Liquor_Licenses        ,'Louisana Liquor Licenses'                                  }
		,{src_OH_Liquor_Licenses        ,'Ohio Liquor Licenses'                                      }
		,{src_PA_Liquor_Licenses        ,'Pennsylvania Liquor Licenses'                              }
		,{src_TX_Liquor_Licenses        ,'Texas Liquor Licenses'                                     }
		,{src_LnPropV2_Fares_Asrs       ,'LN_Propertyv2 Fares Assessors'                             }
		,{src_LnPropV2_Fares_Deeds      ,'LN_Propertyv2 Fares Deeds'                                 }
		,{src_LnPropV2_Lexis_Asrs       ,'LN_Propertyv2 Lexis Assessors'                             }
		,{src_LnPropV2_Lexis_Deeds_Mtgs ,'LN_Propertyv2 Lexis Deeds and Mortgages'                   }
		,{src_Lobbyists                 ,'Lobbyists'                                                 }
		,{src_MartinDale_Hubbell        ,'MartinDale Hubbell'                                        }
		,{src_Miscellaneous             ,'Miscellaneous'                                             }
		,{src_Mixed_DPPA                ,'Mixed DPPA'                                                }
		,{src_Mixed_Non_DPPA            ,'Mixed Non-DPPA'                                            }
		,{src_Mixed_Probation           ,'Mixed Probation'                                           }
		,{src_Mixed_Utilities           ,'Mixed Utilities'                                           }
		,{src_NCOA                      ,'NCOA'                                                      }
		,{src_OSHAIR                    ,'OSHAIR'                                                    }
		,{src_Phones_Plus               ,'Phones Plus'                                               }
		,{src_Professional_License      ,'Professional License'                                      }
		,{src_Redbooks                  ,'Redbooks International Advertisers'                        }
		,{src_CA_Sales_Tax              ,'California Sales Tax'                                      }
		,{src_IA_Sales_Tax              ,'Iowa Sales Tax'                                            }
		,{src_SDA                       ,'SDA - Standard Directory of Advertisers'                   }
		,{src_SDAA                      ,'SDAA - Standard Directory of Ad Agencies'                  }
		,{src_SEC_Broker_Dealer         ,'SEC Broker/Dealer'                                         }
		,{src_Sheila_Greco              ,'Sheila Greco'                                              }
		,{src_SKA                       ,'SK&A Medical Professionals'                                }
		,{src_FL_SO                     ,'FL SO'                                                     }
		,{src_GA_SO                     ,'GA SO'                                                     }
		,{src_MI_SO                     ,'MI SO'                                                     }
		,{src_PA_SO                     ,'PA SO'                                                     }
		,{src_UT_SO                     ,'UT SO'                                                     }
		,{src_Spoke                     ,'Spoke'                                                     }
		,{src_Targus_White_pages        ,'Targus White pages'                                        }
		,{src_Tax_practitioner          ,'Tax practitioner'                                          }
		,{src_TCOA_After_Address        ,'TCOA After Address'                                        }
		,{src_TCOA_Before_Address       ,'TCOA Before Address'                                       }
		,{src_TransUnion                ,'TransUnion'                                                }
		,{src_TUCS_Ptrack               ,'TUCS_Ptrack'                                               }
		,{src_TXBUS                     ,'Texas Sales Tax Registrations(TXBUS)'                      }
		,{src_UCC                       ,'UCC'                                                       }
		,{src_UCCV2                     ,'UCCV2'                                                     }
		,{src_US_Coastguard             ,'US Coastguard'                                             }
		,{src_Utilities                 ,'Utilities'                                                 }
		,{src_Util_Work_Phone           ,'Util Work Phone'                                           }
		,{src_FL_Veh                    ,'FL Veh'                                                    }
		,{src_ID_Veh                    ,'ID Veh'                                                    }
		,{src_KY_Veh                    ,'KY Veh'                                                    }
		,{src_ME_Veh                    ,'ME Veh'                                                    }
		,{src_MN_Veh                    ,'MN Veh'                                                    }
		,{src_MO_Veh                    ,'MO Veh'                                                    }
		,{src_MS_Veh                    ,'MS Veh'                                                    }
		,{src_MT_Veh                    ,'MT Veh'                                                    }
		,{src_NC_Veh                    ,'NC Veh'                                                    }
		,{src_ND_Veh                    ,'ND Veh'                                                    }
		,{src_NE_Veh                    ,'NE Veh'                                                    }
		,{src_NM_Veh                    ,'NM Veh'                                                    }
		,{src_NV_Veh                    ,'NV Veh'                                                    }
		,{src_OH_Veh                    ,'OH Veh'                                                    }
		,{src_TX_Veh                    ,'TX Veh'                                                    }
		,{src_UT_Veh                    ,'UT Veh'                                                    }
		,{src_WI_Veh                    ,'WI Veh'                                                    }
		,{src_WY_Veh                    ,'WY Veh'                                                    }
		,{src_AK_Experian_Veh           ,'AK Experian Veh'                                           }
		,{src_AL_Experian_Veh           ,'AL Experian Veh'                                           }
		,{src_CO_Experian_Veh           ,'CO Experian Veh'                                           }
		,{src_CT_Experian_Veh           ,'CT Experian Veh'                                           }
		,{src_DC_Experian_Veh           ,'DC Experian Veh'                                           }
		,{src_DE_Experian_Veh           ,'DE Experian Veh'                                           }
		,{src_FL_Experian_Veh           ,'FL Experian Veh'                                           }
		,{src_ID_Experian_Veh           ,'ID Experian Veh'                                           }
		,{src_IL_Experian_Veh           ,'IL Experian Veh'                                           }
		,{src_KY_Experian_Veh           ,'KY Experian Veh'                                           }
		,{src_LA_Experian_Veh           ,'LA Experian Veh'                                           }
		,{src_MA_Experian_Veh           ,'MA Experian Veh'                                           }
		,{src_MD_Experian_Veh           ,'MD Experian Veh'                                           }
		,{src_ME_Experian_Veh           ,'ME Experian Veh'                                           }
		,{src_MI_Experian_Veh           ,'MI Experian Veh'                                           }
		,{src_MN_Experian_Veh           ,'MN Experian Veh'                                           }
		,{src_MO_Experian_Veh           ,'MO Experian Veh'                                           }
		,{src_MS_Experian_Veh           ,'MS Experian Veh'                                           }
		,{src_MT_Experian_Veh           ,'MT Experian Veh'                                           }
		,{src_ND_Experian_Veh           ,'ND Experian Veh'                                           }
		,{src_NE_Experian_Veh           ,'NE Experian Veh'                                           }
		,{src_NM_Experian_Veh           ,'NM Experian Veh'                                           }
		,{src_NV_Experian_Veh           ,'NV Experian Veh'                                           }
		,{src_NY_Experian_Veh           ,'NY Experian Veh'                                           }
		,{src_OH_Experian_Veh           ,'OH Experian Veh'                                           }
		,{src_OK_Experian_Veh           ,'OK Experian Veh'                                           }
		,{src_OR_Experian_Veh           ,'OR Experian Veh'                                           }
		,{src_SC_Experian_Veh           ,'SC Experian Veh'                                           }
		,{src_TN_Experian_Veh           ,'TN Experian Veh'                                           }
		,{src_TX_Experian_Veh           ,'TX Experian Veh'                                           }
		,{src_UT_Experian_Veh           ,'UT Experian Veh'                                           }
		,{src_WI_Experian_Veh           ,'WI Experian Veh'                                           }
		,{src_WY_Experian_Veh           ,'WY Experian Veh'                                           }
		,{src_Vickers                   ,'Vickers'                                                   }
		,{src_Voters_v2                 ,'Voters v2'                                                 }
		,{src_AK_Watercraft             ,'AK Watercraft'                                             }
		,{src_AL_Watercraft             ,'AL Watercraft'                                             }
		,{src_AR_Watercraft             ,'AR Watercraft'                                             }
		,{src_AZ_Watercraft             ,'AZ Watercraft'                                             }
		,{src_CO_Watercraft             ,'CO Watercraft'                                             }
		,{src_CT_Watercraft             ,'CT Watercraft'                                             }
		,{src_FL_Watercraft             ,'FL Watercraft'                                             }
		,{src_GA_Watercraft             ,'GA Watercraft'                                             }
		,{src_IA_Watercraft             ,'IA Watercraft'                                             }
		,{src_IL_Watercraft             ,'IL Watercraft'                                             }
		,{src_KS_Watercraft             ,'KS Watercraft'                                             }
		,{src_KY_Watercraft             ,'KY Watercraft'                                             }
		,{src_MA_Watercraft             ,'MA Watercraft'                                             }
		,{src_MD_Watercraft             ,'MD Watercraft'                                             }
		,{src_ME_Watercraft             ,'ME Watercraft'                                             }
		,{src_MI_Watercraft             ,'MI Watercraft'                                             }
		,{src_MN_Watercraft             ,'MN Watercraft'                                             }
		,{src_MO_Watercraft             ,'MO Watercraft'                                             }
		,{src_MS_Watercraft             ,'MS Watercraft'                                             }
		,{src_MT_Watercraft             ,'MT Watercraft'                                             }
		,{src_NC_Watercraft             ,'NC Watercraft'                                             }
		,{src_ND_Watercraft             ,'ND Watercraft'                                             }
		,{src_NE_Watercraft             ,'NE Watercraft'                                             }
		,{src_NH_Watercraft             ,'NH Watercraft'                                             }
		,{src_NV_Watercraft             ,'NV Watercraft'                                             }
		,{src_NY_Watercraft             ,'NY Watercraft'                                             }
		,{src_OH_Watercraft             ,'OH Watercraft'                                             }
		,{src_OR_Watercraft             ,'OR Watercraft'                                             }
		,{src_SC_Watercraft             ,'SC Watercraft'                                             }
		,{src_TN_Watercraft             ,'TN Watercraft'                                             }
		,{src_TX_Watercraft             ,'TX Watercraft'                                             }
		,{src_UT_Watercraft             ,'UT Watercraft'                                             }
		,{src_VA_Watercraft             ,'VA Watercraft'                                             }
		,{src_WI_Watercraft             ,'WI Watercraft'                                             }
		,{src_WV_Watercraft             ,'WV Watercraft'                                             }
		,{src_WY_Watercraft             ,'WY Watercraft'                                             }
		,{src_FL_Watercraft_LN          ,'FL Watercraft (LN)'                                        }
		,{src_KY_Watercraft_LN          ,'KY Watercraft (LN)'                                        }
		,{src_MO_Watercraft_LN          ,'MO Watercraft (LN)'                                        }
		,{src_Whois_domains             ,'Domain Registrations (WHOIS)'                              }
		,{src_Wither_and_Die            ,'Wither and Die'                                            }
		,{src_MS_Worker_Comp            ,'MS Worker Comp'                                            }
		,{src_OR_Worker_Comp            ,'OR Worker Comp'                                            }
		,{src_Yellow_Pages              ,'Yellow Pages'                                              }
		,{src_ZOOM                      ,'ZOOM'                                                      }
	], layout_description);

	layout_description tSetSources(layout_description l) :=
	transform
		self.IsBusinessHeaderSource	  := SourceIsBusinessHeader	   (l.code);
		self.IsPeopleHeaderSource		  := SourceIsPeopleHeader			 (l.code);
		self.IsBusinessContactsSource := SourceIsBusiness_contacts (l.code);
		self.IsPawSource							:= SourceIsPaw							 (l.code);
		self.IsFCRA						 		 		:= SourceIsFCRA							 (l.code);
		self.IsDPPA						 		 		:= SourceIsDPPA							 (l.code);
		self.IsUtility				 		 		:= SourceIsUtility					 (l.code);
		self.IsOnProbation						:= SourceIsOnProbation			 (l.code);
		self.IsDeath 									:= SourceIsDeath 						 (l.code);
		self.IsDL 										:= SourceIsDL 							 (l.code);
		self.IsWC											:= sourceIsWC								 (l.code);
		self.IsProperty								:= SourceIsProperty					 (l.code);
		self.IsTransUnion							:= SourceIsTransUnion				 (l.code);
		self.isWeeklyHeader						:= sourceisWeeklyHeader			 (l.code);
		self.isVehicle								:= sourceisVehicle					 (l.code);
		self.isLiens									:= sourceisLiens						 (l.code);
		self.isBankruptcy							:= sourceisBankruptcy				 (l.code);
		self.isCorpV2									:= sourceisCorpV2						 (l.code);
		self.isUpdating								:= not SourceIsNonUpdatingSrc(l.code);
		self													:= l                                 ;
	end;

	export dSource_Codes_proj := project(dSource_Codes, tSetSources(left));

	export fTranslateSource(string pSource) :=
	function
		lcode := dSource_Codes_proj.code;
		source_filter 		:= 	(		trim(pSource,left,right) = trim(lcode,left,right)
																);
		dsource 					:= dSource_Codes_proj(source_filter		)[1].description;
		returnDescription := dsource;
		return if(returnDescription != '', returnDescription, '?' + pSource);
	end;

	export TranslateSource(string2 pSource) :=
	case(pSource
		,src_ACA                       => 'American Correctional Association'                         
		,src_Accurint_Arrest_Log       => 'Accurint Arrest Log'                                       
		,src_Accurint_Crim_Court       => 'Accurint Crim Court'                                       
		,src_Accurint_DOC              => 'Accurint DOC'                                              
		,src_Accurint_Sex_offender     => 'Accurint Sex offender'                                     
		,src_Accurint_Trade_Show       => 'Accurint Trade Show'                                       
		,src_ACF                       => 'ACF - America\'s Corporate Financial Directory'            
		,src_Aircrafts                 => 'Aircrafts'                                                 
		,src_Airmen                    => 'Airmen'                                                    
		,src_AK_Busreg                 => 'Alaska Business Registrations'                             
		,src_AK_Fishing_boats          => 'AK Commercial Fishing Vessels'                             
		,src_AK_Perm_Fund              => 'AK Perm Fund'                                              
		,src_American_Students_List    => 'American Students List'                                    
		,src_AMIDIR                    => 'Medical Information Directory'                             
		,src_Bankruptcy                => 'Bankruptcy'                                                
		,src_BBB_Member                => 'Better Business Bureau Member'                             
		,src_BBB_Non_Member            => 'Better Business Bureau Non-Member'                         
		,src_Business_Registration     => 'Business Registration'                                     
		,src_Certegy                   => 'Certegy'                                                   
		,src_FL_CH                     => 'FL CH'                                                     
		,src_GA_CH                     => 'GA CH'                                                     
		,src_PA_CH                     => 'PA CH'                                                     
		,src_UT_CH                     => 'UT CH'                                                     
		,src_AK_Corporations           => 'AK Corporations'                                           
		,src_AL_Corporations           => 'AL Corporations'                                           
		,src_AR_Corporations           => 'AR Corporations'                                           
		,src_AZ_Corporations           => 'AZ Corporations'                                           
		,src_CA_Corporations           => 'CA Corporations'                                           
		,src_CO_Corporations           => 'CO Corporations'                                           
		,src_CT_Corporations           => 'CT Corporations'                                           
		,src_DC_Corporations           => 'DC Corporations'                                           
		,src_FL_Corporations           => 'FL Corporations'                                           
		,src_GA_Corporations           => 'GA Corporations'                                           
		,src_HI_Corporations           => 'HI Corporations'                                           
		,src_IA_Corporations           => 'IA Corporations'                                           
		,src_ID_Corporations           => 'ID Corporations'                                           
		,src_IL_Corporations           => 'IL Corporations'                                           
		,src_IN_Corporations           => 'IN Corporations'                                           
		,src_KS_Corporations           => 'KS Corporations'                                           
		,src_KY_Corporations           => 'KY Corporations'                                           
		,src_LA_Corporations           => 'LA Corporations'                                           
		,src_MA_Corporations           => 'MA Corporations'                                           
		,src_MD_Corporations           => 'MD Corporations'                                           
		,src_ME_Corporations           => 'ME Corporations'                                           
		,src_MI_Corporations           => 'MI Corporations'                                           
		,src_MN_Corporations           => 'MN Corporations'                                           
		,src_MO_Corporations           => 'MO Corporations'                                           
		,src_MS_Corporations           => 'MS Corporations'                                           
		,src_MT_Corporations           => 'MT Corporations'                                           
		,src_NC_Corporations           => 'NC Corporations'                                           
		,src_ND_Corporations           => 'ND Corporations'                                           
		,src_NE_Corporations           => 'NE Corporations'                                           
		,src_NH_Corporations           => 'NH Corporations'                                           
		,src_NJ_Corporations           => 'NJ Corporations'                                           
		,src_NM_Corporations           => 'NM Corporations'                                           
		,src_NV_Corporations           => 'NV Corporations'                                           
		,src_NY_Corporations           => 'NY Corporations'                                           
		,src_OH_Corporations           => 'OH Corporations'                                           
		,src_OK_Corporations           => 'OK Corporations'                                           
		,src_OR_Corporations           => 'OR Corporations'                                           
		,src_PA_Corporations           => 'PA Corporations'                                           
		,src_RI_Corporations           => 'RI Corporations'                                           
		,src_SC_Corporations           => 'SC Corporations'                                           
		,src_SD_Corporations           => 'SD Corporations'                                           
		,src_TN_Corporations           => 'TN Corporations'                                           
		,src_TX_Corporations           => 'TX Corporations'                                           
		,src_UT_Corporations           => 'UT Corporations'                                           
		,src_VA_Corporations           => 'VA Corporations'                                           
		,src_VT_Corporations           => 'VT Corporations'                                           
		,src_WA_Corporations           => 'WA Corporations'                                           
		,src_WI_Corporations           => 'WI Corporations'                                           
		,src_WV_Corporations           => 'WV Corporations'                                           
		,src_WY_Corporations           => 'WY Corporations'                                           
		,src_Credit_Unions             => 'Credit Unions'                                             
		,src_DCA                       => 'DCA'                                                       
		,src_DEA                       => 'DEA'                                                       
		,src_Death_Master              => 'Death Master'                                              
		,src_Death_State               => 'Death State'                                               
		,src_CT_DL                     => 'CT DL'                                                     
		,src_FL_DL                     => 'FL DL'                                                     
		,src_IA_DL                     => 'IA DL'                                                     
		,src_ID_DL                     => 'ID DL'                                                     
		,src_KY_DL                     => 'KY DL'                                                     
		,src_MA_DL                     => 'MA DL'                                                     
		,src_ME_DL                     => 'ME DL'                                                     
		,src_MI_DL                     => 'MI DL'                                                     
		,src_MN_DL                     => 'MN DL'                                                     
		,src_MO_DL                     => 'MO DL'                                                     
		,src_NM_DL                     => 'NM DL'                                                     
		,src_OH_DL                     => 'OH DL'                                                     
		,src_OR_DL                     => 'OR DL'                                                     
		,src_TN_DL                     => 'TN DL'                                                     
		,src_TX_DL                     => 'TX DL'                                                     
		,src_UT_DL                     => 'UT DL'                                                     
		,src_WI_DL                     => 'WI DL'                                                     
		,src_WV_DL                     => 'WV DL'                                                     
		,src_WY_DL                     => 'WY DL'                                                     
		,src_CO_Experian_DL            => 'CO Experian DL'                                            
		,src_DE_Experian_DL            => 'DE Experian DL'                                            
		,src_ID_Experian_DL            => 'ID Experian DL'                                            
		,src_IL_Experian_DL            => 'IL Experian DL'                                            
		,src_KY_Experian_DL            => 'KY Experian DL'                                            
		,src_LA_Experian_DL            => 'LA Experian DL'                                            
		,src_MD_Experian_DL            => 'MD Experian DL'                                            
		,src_MS_Experian_DL            => 'MS Experian DL'                                            
		,src_ND_Experian_DL            => 'ND Experian DL'                                            
		,src_NH_Experian_DL            => 'NH Experian DL'                                            
		,src_SC_Experian_DL            => 'SC Experian DL'                                            
		,src_WV_Experian_DL            => 'WV Experian DL'                                            
		,src_Dummy_Records             => 'Dummy Records'                                             
		,src_Dunn_Bradstreet           => 'Dunn & Bradstreet'                                         
		,src_Dunn_Bradstreet_Fein      => 'Dunn & Bradstreet Fein'                                    
		,src_EBR                       => 'Experian Business Reports'                                 
		,src_Edgar                     => 'Edgar'                                                     
		,src_EMerge_Boat               => 'EMerge Boat'                                               
		,src_EMerge_CCW                => 'EMerge CCW'                                                
		,src_EMerge_Cens               => 'EMerge Cens'                                               
		,src_EMerge_Fish               => 'EMerge Fish'                                               
		,src_EMerge_Hunt               => 'EMerge Hunt'                                               
		,src_EMerge_Master             => 'EMerge Master'                                             
		,src_Employee_Directories      => 'Employee Directories'                                      
		,src_Equifax                   => 'Equifax'                                                   
		,src_Equifax_Quick             => 'Equifax Quick'                                             
		,src_Equifax_Weekly            => 'Equifax Weekly'                                            
		,src_Eq_Employer               => 'Eq Employer'                                               
		,src_Experian_Credit_Header    => 'Experian Credit Header'                                    
		,src_Fares_Deeds_from_Asrs     => 'Fares Deeds from Assessors'                                
		,src_FBNV2_CA_Orange_county    => 'CAO FBNV2 California Orange county'                        
		,src_FBNV2_CA_Santa_Clara      => 'CSC FBNV2 California Santa Clara'                          
		,src_FBNV2_CA_San_Bernadino    => 'CAB FBNV2 California San Bernadino'                        
		,src_FBNV2_CA_San_Diego        => 'CAS FBNV2 California San Diego'                            
		,src_FBNV2_CA_Ventura          => 'CAV FBNV2 California Ventura'                              
		,src_FBNV2_Experian_Direct     => 'EXP FBNV2 Experian Direct'                                 
		,src_FBNV2_FL                  => 'FL  FBNV2 Florida'                                         
		,src_FBNV2_Hist_Choicepoint    => 'CP  FBNV2 Historical Choicepoint'                          
		,src_FBNV2_INF                 => 'INF FBNV2 Infousa'                                         
		,src_FBNV2_New_York            => 'NBX,NYN,NKI,NQU,NRI FBNV2 New York'                        
		,src_FBNV2_TX_Dallas           => 'TXD FBNV2 Texas Dallas'                                    
		,src_FBNV2_TX_Harris           => 'TXH FBNV2 Texas Harris'                                    
		,src_FCC_Radio_Licenses        => 'FCC Radio Licenses'                                        
		,src_FCRA_Corrections_record   => 'A corrections/override (used in FCRA products) record'     
		,src_FDIC                      => 'FDIC'                                                      
		,src_Federal_Explosives        => 'Federal Explosives'                                        
		,src_Federal_Firearms          => 'Federal Firearms'                                          
		,src_FL_FBN                    => 'Florida FBN'                                               
		,src_FL_Non_Profit             => 'Florida Non-Profit'                                        
		,src_Foreclosures              => 'Foreclosures'                                              
		,src_Foreclosures_Delinquent   => 'Foreclosures - Notice of Delinquency'                      
		,src_NJ_Gaming_Licenses        => 'New Jersey Gaming Licenses'                                
		,src_Gong_Business             => 'Gong Business'                                             
		,src_Gong_Government           => 'Gong Government'                                           
		,src_Gong_History              => 'Gong History'                                              
		,src_Gong_phone_append         => 'Appended phone from gong file'                             
		,src_INFOUSA_ABIUS_USABIZ      => 'INFOUSA ABIUS(USABIZ)'                                     
		,src_INFOUSA_DEAD_COMPANIES    => 'INFOUSA DEAD COMPANIES'                                    
		,src_INFOUSA_IDEXEC            => 'INFOUSA IDEXEC'                                            
		,src_Ingenix_Sanctions         => 'Ingenix National Provider Sanctions'                       
		,src_IRS_5500                  => 'IRS 5500'                                                  
		,src_IRS_Non_Profit            => 'IRS Non-Profit'                                            
		,src_Jigsaw                    => 'Jigsaw'                                                    
		,src_Lexis_Trans_Union         => 'Lexis Trans Union'                                         
		,src_Liens                     => 'Liens'                                                     
		,src_Liens_and_Judgments       => 'Liens and Judgments'                                       
		,src_Liens_v2                  => 'Liens v2'                                                  
		,src_Liens_v2_CA_Federal       => 'CA Liens v2 CA Federal'                                    
		,src_Liens_v2_Chicago_Law      => 'CL,CJ Liens v2 Chicago Law'                                
		,src_Liens_v2_Hogan            => 'HG Liens v2 Hogan'                                         
		,src_Liens_v2_ILFDLN           => 'IL Liens v2 ILFDLN'                                        
		,src_Liens_v2_MA               => 'MA Liens v2 MA'                                            
		,src_Liens_v2_NYC              => 'NYC Liens v2 NYC'                                          
		,src_Liens_v2_NYFDLN           => 'NY Liens v2 NYFDLN'                                        
		,src_Liens_v2_Service_Abstract => 'SA Liens v2 Service Abstract'                              
		,src_Liens_v2_Superior_Party   => 'SU Liens v2 Superior Party'                                
		,src_CA_Liquor_Licenses        => 'California Liquor Licenses'                                
		,src_CT_Liquor_Licenses        => 'Conneticut Liquor Licenses'                                
		,src_IN_Liquor_Licenses        => 'Indiana Liquor Licenses'                                   
		,src_LA_Liquor_Licenses        => 'Louisana Liquor Licenses'                                  
		,src_OH_Liquor_Licenses        => 'Ohio Liquor Licenses'                                      
		,src_PA_Liquor_Licenses        => 'Pennsylvania Liquor Licenses'                              
		,src_TX_Liquor_Licenses        => 'Texas Liquor Licenses'                                     
		,src_LnPropV2_Fares_Asrs       => 'LN_Propertyv2 Fares Assessors'                             
		,src_LnPropV2_Fares_Deeds      => 'LN_Propertyv2 Fares Deeds'                                 
		,src_LnPropV2_Lexis_Asrs       => 'LN_Propertyv2 Lexis Assessors'                             
		,src_LnPropV2_Lexis_Deeds_Mtgs => 'LN_Propertyv2 Lexis Deeds and Mortgages'                   
		,src_Lobbyists                 => 'Lobbyists'                                                 
		,src_MartinDale_Hubbell        => 'MartinDale Hubbell'                                        
		,src_Miscellaneous             => 'Miscellaneous'                                             
		,src_Mixed_DPPA                => 'Mixed DPPA'                                                
		,src_Mixed_Non_DPPA            => 'Mixed Non-DPPA'                                            
		,src_Mixed_Probation           => 'Mixed Probation'                                           
		,src_Mixed_Utilities           => 'Mixed Utilities'                                           
		,src_NCOA                      => 'NCOA'                                                      
		,src_OSHAIR                    => 'OSHAIR'                                                    
		,src_Phones_Plus               => 'Phones Plus'                                               
		,src_Professional_License      => 'Professional License'                                      
		,src_Redbooks                  => 'Redbooks International Advertisers'                        
		,src_CA_Sales_Tax              => 'California Sales Tax'                                      
		,src_IA_Sales_Tax              => 'Iowa Sales Tax'                                            
		,src_SDA                       => 'SDA - Standard Directory of Advertisers'                   
		,src_SDAA                      => 'SDAA - Standard Directory of Ad Agencies'                  
		,src_SEC_Broker_Dealer         => 'SEC Broker/Dealer'                                         
		,src_Sheila_Greco              => 'Sheila Greco'                                              
		,src_SKA                       => 'SK&A Medical Professionals'                                
		,src_FL_SO                     => 'FL SO'                                                     
		,src_GA_SO                     => 'GA SO'                                                     
		,src_MI_SO                     => 'MI SO'                                                     
		,src_PA_SO                     => 'PA SO'                                                     
		,src_UT_SO                     => 'UT SO'                                                     
		,src_Spoke                     => 'Spoke'                                                     
		,src_Targus_White_pages        => 'Targus White pages'                                        
		,src_Tax_practitioner          => 'Tax practitioner'                                          
		,src_TCOA_After_Address        => 'TCOA After Address'                                        
		,src_TCOA_Before_Address       => 'TCOA Before Address'                                       
		,src_TransUnion                => 'TransUnion'                                                
		,src_TUCS_Ptrack               => 'TUCS_Ptrack'                                               
		,src_TXBUS                     => 'Texas Sales Tax Registrations(TXBUS)'                      
		,src_UCC                       => 'UCC'                                                       
		,src_UCCV2                     => 'UCCV2'                                                     
		,src_US_Coastguard             => 'US Coastguard'                                             
		,src_Utilities                 => 'Utilities'                                                 
		,src_Util_Work_Phone           => 'Util Work Phone'                                           
		,src_FL_Veh                    => 'FL Veh'                                                    
		,src_ID_Veh                    => 'ID Veh'                                                    
		,src_KY_Veh                    => 'KY Veh'                                                    
		,src_ME_Veh                    => 'ME Veh'                                                    
		,src_MN_Veh                    => 'MN Veh'                                                    
		,src_MO_Veh                    => 'MO Veh'                                                    
		,src_MS_Veh                    => 'MS Veh'                                                    
		,src_MT_Veh                    => 'MT Veh'                                                    
		,src_NC_Veh                    => 'NC Veh'                                                    
		,src_ND_Veh                    => 'ND Veh'                                                    
		,src_NE_Veh                    => 'NE Veh'                                                    
		,src_NM_Veh                    => 'NM Veh'                                                    
		,src_NV_Veh                    => 'NV Veh'                                                    
		,src_OH_Veh                    => 'OH Veh'                                                    
		,src_TX_Veh                    => 'TX Veh'                                                    
		,src_UT_Veh                    => 'UT Veh'                                                    
		,src_WI_Veh                    => 'WI Veh'                                                    
		,src_WY_Veh                    => 'WY Veh'                                                    
		,src_AK_Experian_Veh           => 'AK Experian Veh'                                           
		,src_AL_Experian_Veh           => 'AL Experian Veh'                                           
		,src_CO_Experian_Veh           => 'CO Experian Veh'                                           
		,src_CT_Experian_Veh           => 'CT Experian Veh'                                           
		,src_DC_Experian_Veh           => 'DC Experian Veh'                                           
		,src_DE_Experian_Veh           => 'DE Experian Veh'                                           
		,src_FL_Experian_Veh           => 'FL Experian Veh'                                           
		,src_ID_Experian_Veh           => 'ID Experian Veh'                                           
		,src_IL_Experian_Veh           => 'IL Experian Veh'                                           
		,src_KY_Experian_Veh           => 'KY Experian Veh'                                           
		,src_LA_Experian_Veh           => 'LA Experian Veh'                                           
		,src_MA_Experian_Veh           => 'MA Experian Veh'                                           
		,src_MD_Experian_Veh           => 'MD Experian Veh'                                           
		,src_ME_Experian_Veh           => 'ME Experian Veh'                                           
		,src_MI_Experian_Veh           => 'MI Experian Veh'                                           
		,src_MN_Experian_Veh           => 'MN Experian Veh'                                           
		,src_MO_Experian_Veh           => 'MO Experian Veh'                                           
		,src_MS_Experian_Veh           => 'MS Experian Veh'                                           
		,src_MT_Experian_Veh           => 'MT Experian Veh'                                           
		,src_ND_Experian_Veh           => 'ND Experian Veh'                                           
		,src_NE_Experian_Veh           => 'NE Experian Veh'                                           
		,src_NM_Experian_Veh           => 'NM Experian Veh'                                           
		,src_NV_Experian_Veh           => 'NV Experian Veh'                                           
		,src_NY_Experian_Veh           => 'NY Experian Veh'                                           
		,src_OH_Experian_Veh           => 'OH Experian Veh'                                           
		,src_OK_Experian_Veh           => 'OK Experian Veh'                                           
		,src_OR_Experian_Veh           => 'OR Experian Veh'                                           
		,src_SC_Experian_Veh           => 'SC Experian Veh'                                           
		,src_TN_Experian_Veh           => 'TN Experian Veh'                                           
		,src_TX_Experian_Veh           => 'TX Experian Veh'                                           
		,src_UT_Experian_Veh           => 'UT Experian Veh'                                           
		,src_WI_Experian_Veh           => 'WI Experian Veh'                                           
		,src_WY_Experian_Veh           => 'WY Experian Veh'                                           
		,src_Vickers                   => 'Vickers'                                                   
		,src_Voters_v2                 => 'Voters v2'                                                 
		,src_AK_Watercraft             => 'AK Watercraft'                                             
		,src_AL_Watercraft             => 'AL Watercraft'                                             
		,src_AR_Watercraft             => 'AR Watercraft'                                             
		,src_AZ_Watercraft             => 'AZ Watercraft'                                             
		,src_CO_Watercraft             => 'CO Watercraft'                                             
		,src_CT_Watercraft             => 'CT Watercraft'                                             
		,src_FL_Watercraft             => 'FL Watercraft'                                             
		,src_GA_Watercraft             => 'GA Watercraft'                                             
		,src_IA_Watercraft             => 'IA Watercraft'                                             
		,src_IL_Watercraft             => 'IL Watercraft'                                             
		,src_KS_Watercraft             => 'KS Watercraft'                                             
		,src_KY_Watercraft             => 'KY Watercraft'                                             
		,src_MA_Watercraft             => 'MA Watercraft'                                             
		,src_MD_Watercraft             => 'MD Watercraft'                                             
		,src_ME_Watercraft             => 'ME Watercraft'                                             
		,src_MI_Watercraft             => 'MI Watercraft'                                             
		,src_MN_Watercraft             => 'MN Watercraft'                                             
		,src_MO_Watercraft             => 'MO Watercraft'                                             
		,src_MS_Watercraft             => 'MS Watercraft'                                             
		,src_MT_Watercraft             => 'MT Watercraft'                                             
		,src_NC_Watercraft             => 'NC Watercraft'                                             
		,src_ND_Watercraft             => 'ND Watercraft'                                             
		,src_NE_Watercraft             => 'NE Watercraft'                                             
		,src_NH_Watercraft             => 'NH Watercraft'                                             
		,src_NV_Watercraft             => 'NV Watercraft'                                             
		,src_NY_Watercraft             => 'NY Watercraft'                                             
		,src_OH_Watercraft             => 'OH Watercraft'                                             
		,src_OR_Watercraft             => 'OR Watercraft'                                             
		,src_SC_Watercraft             => 'SC Watercraft'                                             
		,src_TN_Watercraft             => 'TN Watercraft'                                             
		,src_TX_Watercraft             => 'TX Watercraft'                                             
		,src_UT_Watercraft             => 'UT Watercraft'                                             
		,src_VA_Watercraft             => 'VA Watercraft'                                             
		,src_WI_Watercraft             => 'WI Watercraft'                                             
		,src_WV_Watercraft             => 'WV Watercraft'                                             
		,src_WY_Watercraft             => 'WY Watercraft'                                             
		,src_FL_Watercraft_LN          => 'FL Watercraft (LN)'                                        
		,src_KY_Watercraft_LN          => 'KY Watercraft (LN)'                                        
		,src_MO_Watercraft_LN          => 'MO Watercraft (LN)'                                        
		,src_Whois_domains             => 'Domain Registrations (WHOIS)'                              
		,src_Wither_and_Die            => 'Wither and Die'                                            
		,src_MS_Worker_Comp            => 'MS Worker Comp'                                            
		,src_OR_Worker_Comp            => 'OR Worker Comp'                                            
		,src_Yellow_Pages              => 'Yellow Pages'                                              
		,src_ZOOM                      => 'ZOOM'                                                      
		,'?' + pSource
	);

	shared dSource_Codes_proj_FBNV2					:= dSource_Codes_proj(regexfind('FBNV2'												,Description	,nocase)) : global;
	shared dSource_Codes_proj_CorpV2				:= dSource_Codes_proj(regexfind('Corporations'								,Description	,nocase)) : global;
	shared dSource_Codes_proj_fLiensV2			:= dSource_Codes_proj(regexfind('liens'												,Description	,nocase)) : global;
	shared dSource_Codes_proj_fProperty			:= dSource_Codes_proj(regexfind('LN_Propertyv2'								,Description	,nocase)) : global;
	shared dSource_Codes_proj_Experian_DL		:= dSource_Codes_proj(regexfind('^(?=.*?Experian.*).*?DL.*$'	,Description	,nocase)) : global;
	shared dSource_Codes_proj_Direct_DL			:= dSource_Codes_proj(regexfind('^(?!.*?Experian.*).*?DL.*$'	,Description	,nocase)) : global;
	shared dSource_Codes_proj_Experian_Veh	:= dSource_Codes_proj(regexfind('^(?=.*?Experian.*).*?Veh.*$'	,Description	,nocase)) : global;
	shared dSource_Codes_proj_Direct_Veh		:= dSource_Codes_proj(regexfind('^(?!.*?Experian.*).*?Veh.*$'	,Description	,nocase)) : global;
	shared dSource_Codes_proj_Watercraft		:= dSource_Codes_proj(regexfind('Watercraft'									,Description	,nocase)) : global;

	export fSourceCodeSpecific(string pStateFilter = '',dataset(layout_description) psource_codes = dSource_Codes_proj) :=
	function
		State_filter				:= if(pStateFilter != ''
														,regexfind(pStateFilter, psource_codes.Description, nocase)
														,true
												);
		
		dCodes := psource_codes(State_filter);
		
		returncode := dCodes[1].code;
		return returncode;
	end;																																																									
	// --------------------------------------------------------------------------------
	// -- Functions to figure out source codes for builds with multiple source codes
	// -- pass in data to figure out which source code to use
	// --------------------------------------------------------------------------------
	export fSourceCode(string pDescriptionFilter, string pStateFilter = '') :=
	function
		Description_filter	:= regexfind(pDescriptionFilter	, dSource_Codes_proj.Description, nocase);
		State_filter				:= if(pStateFilter != ''
														,regexfind(pStateFilter, dSource_Codes_proj.Description, nocase)
														,true
												);
		
		dCodes := dSource_Codes_proj(Description_filter,State_filter);
		
		returncode := dCodes[1].code;
		return returncode;
	end;

	export fFBNV2(string pTmsid) := 
		case(trim(pTmsid[1..2])
			,'CP'	=>	src_FBNV2_FL
			,'FL'	=>	src_Liens_v2_Chicago_Law
			,case(trim(pTmsid[1..3])
				,'CAO'	=>	src_FBNV2_CA_Orange_county
				,'CSC'	=>	src_FBNV2_CA_Santa_Clara  
				,'CAB'	=>	src_FBNV2_CA_San_Bernadino
				,'CAS'	=>	src_FBNV2_CA_San_Diego    
				,'CAV'	=>	src_FBNV2_CA_Ventura      
				,'EXP'	=>	src_FBNV2_Experian_Direct 
				,'INF'	=>	src_FBNV2_INF       
				,'NBX'	=>	src_FBNV2_New_York  
				,'NYN'	=>	src_FBNV2_New_York
				,'NKI'	=>	src_FBNV2_New_York
				,'NQU'	=>	src_FBNV2_New_York
				,'NRI'	=>	src_FBNV2_New_York
				,'TXD'	=>	src_FBNV2_TX_Dallas
				,'TXH'	=>	src_FBNV2_TX_Harris  
				,						''												
		));
	export fCorpV2(string pCorpKey	,string pstate = '') := 
	function
		stateabbr := if(trim(pcorpkey) != '', Corp2.fStateCodetoStateAbbr(trim(pcorpkey)[1..2]), trim(pstate));
		return
		fSourceCodeSpecific('^' + stateabbr + '.*$',dSource_Codes_proj_CorpV2);
	end;

	/* -- Not broken out yet.  Future enhancement
	export fLiensV2(string pTmsid) := 
	if(pTmsid[1..3] = 'NYC'	,	src_Liens_v2_NYC
		,case(trim(pTmsid[1..2])
		,'CA'	=>	src_Liens_v2_CA_Federal
		,'CL'	=>	src_Liens_v2_Chicago_Law
		,'CJ'	=>	src_Liens_v2_Chicago_Law
		,'HG'	=>	src_Liens_v2_Hogan
		,'IL'	=>	src_Liens_v2_ILFDLN
		,'MA'	=>	src_Liens_v2_MA    
		,'NY'	=>	src_Liens_v2_NYFDLN
		,'SA'	=>	src_Liens_v2_Service_Abstract
		,'SU'	=>	src_Liens_v2_Superior_Party  
		,					''													
		));
	*/
	export fProperty(string pln_fares_id) := 
	map(
		pln_fares_id[2]  = ''  and pln_fares_id[1] =''  => ''
		,pln_fares_id[2] != 'A' and pln_fares_id[1] ='R' => src_LnPropV2_Fares_Deeds
		,pln_fares_id[2] != 'A' and pln_fares_id[1]!='R' => src_LnPropV2_Lexis_Deeds_Mtgs
		,pln_fares_id[2]  = 'A' and pln_fares_id[1] ='R' => src_LnPropV2_Fares_Asrs
		,pln_fares_id[2]  = 'A' and pln_fares_id[1]!='R' => src_LnPropV2_Lexis_Asrs
		,																										''
	);

	// compare to Drivers.header_src
	export fDLs(string2 pSource, string2 pState) := 
		if(pSource <> 'AX'
			,case(pState			//non-Experian
				,'MO' => src_MO_DL
				,'MN' => src_MN_DL
				,'FL' => src_FL_DL
				,'OH' => src_OH_DL
				,'TX' => src_TX_DL
				,'NM' => src_NM_DL
				,'WI' => src_WI_DL
				,'ID' => src_ID_DL
				,'OR' => src_OR_DL
				,'ME' => src_ME_DL
				,'WV' => src_WV_DL
				,'MI' => src_MI_DL
				,'UT' => src_UT_DL
				,'IA' => src_IA_DL
				,'MA' => src_MA_DL
				,'TN' => src_TN_DL
				,'WY' => src_WY_DL
				,'KY' => src_KY_DL
				,'CT' => src_CT_DL
				,''             
			)
			,case(pState			//Experian
				,'CO' => src_CO_Experian_DL
				,'DE' => src_DE_Experian_DL
				,'ID' => src_ID_Experian_DL
				,'IL' => src_IL_Experian_DL
				,'KY' => src_KY_Experian_DL
				,'LA' => src_LA_Experian_DL
				,'MD' => src_MD_Experian_DL
				,'MS' => src_MS_Experian_DL
				,'ND' => src_ND_Experian_DL
				,'NH' => src_NH_Experian_DL
				,'SC' => src_SC_Experian_DL
				,'WV' => src_WV_Experian_DL
				,''
			)
		);

	// compare to VehLic.Header_Src
	export fVehicles(string2 pState_Origin, string2 pSource_code) := 
		if(pSource_code!='AE'
			,case(pState_Origin
				,'FL' => src_FL_Veh
				,'TX' => src_TX_Veh
				,'MS' => src_MS_Veh
				,'WI' => src_WI_Veh
				,'OH' => src_OH_Veh
				,'MO' => src_MO_Veh
				,'MN' => src_MN_Veh
				,'ME' => src_ME_Veh
				,'NC' => src_NC_Veh
				,'NM' => src_NM_Veh
				,'NE' => src_NE_Veh
				,'ID' => src_ID_Veh
				,'UT' => src_UT_Veh
				,'ND' => src_ND_Veh
				,'MT' => src_MT_Veh
				,'WY' => src_WY_Veh
				,'NV' => src_NV_Veh
				,'KY' => src_KY_Veh
				,''
			) 
									
			//Experian Vehicles
			,case(pState_Origin
				,'AK' => src_AK_Experian_Veh
				,'CT' => src_CT_Experian_Veh
				,'DE' => src_DE_Experian_Veh
				,'MD' => src_MD_Experian_Veh
				,'OK' => src_OK_Experian_Veh
				,'SC' => src_SC_Experian_Veh
				,'AL' => src_AL_Experian_Veh
				,'CO' => src_CO_Experian_Veh
				,'DC' => src_DC_Experian_Veh
				,'IL' => src_IL_Experian_Veh
				,'LA' => src_LA_Experian_Veh
				,'MA' => src_MA_Experian_Veh
				,'MI' => src_MI_Experian_Veh
				,'NY' => src_NY_Experian_Veh
				,'TN' => src_TN_Experian_Veh
				,'UT' => src_UT_Experian_Veh
				,'FL' => src_FL_Experian_Veh
				,'ID' => src_ID_Experian_Veh
				,'KY' => src_KY_Experian_Veh
				,'ME' => src_ME_Experian_Veh
				,'MN' => src_MN_Experian_Veh
				,'MS' => src_MS_Experian_Veh
				,'MO' => src_MO_Experian_Veh
				,'MT' => src_MT_Experian_Veh
				,'NE' => src_NE_Experian_Veh
				,'NV' => src_NV_Experian_Veh
				,'ND' => src_ND_Experian_Veh
				,'OH' => src_OH_Experian_Veh
				,'TX' => src_TX_Experian_Veh
				,'WI' => src_WI_Experian_Veh
				,'WY' => src_WY_Experian_Veh
				,'NM' => src_NM_Experian_Veh
				,'OR' => src_OR_Experian_Veh
				,''
			)
		);

	// compare to watercraft.Header_Source_Code
	export fWatercraft(string2 pSource, string2 pState) :=
		if(pSource='CG'
			,src_US_Coastguard
			,case(pState
				,'AK'	=> src_AK_Watercraft
				,'AL'	=> src_AL_Watercraft
				,'AR'	=> src_AR_Watercraft
				,'AZ'	=> src_AZ_Watercraft
				,'CO'	=> src_CO_Watercraft
				,'CT'	=> src_CT_Watercraft
				,'GA'	=> src_GA_Watercraft
				,'IA'	=> src_IA_Watercraft
				,'IL'	=> src_IL_Watercraft
				,'KS'	=> src_KS_Watercraft
				,'MA'	=> src_MA_Watercraft
				,'MD'	=> src_MD_Watercraft
				,'ME'	=> src_ME_Watercraft
				,'MI'	=> src_MI_Watercraft
				,'MN'	=> src_MN_Watercraft
				,'MS'	=> src_MS_Watercraft
				,'MT'	=> src_MT_Watercraft
				,'NC'	=> src_NC_Watercraft
				,'ND'	=> src_ND_Watercraft
				,'NE'	=> src_NE_Watercraft
				,'NH'	=> src_NH_Watercraft
				,'NV'	=> src_NV_Watercraft
				,'NY'	=> src_NY_Watercraft
				,'OH'	=> src_OH_Watercraft
				,'OR'	=> src_OR_Watercraft
				,'SC'	=> src_SC_Watercraft
				,'TN'	=> src_TN_Watercraft
				,'TX'	=> src_TX_Watercraft
				,'UT'	=> src_UT_Watercraft
				,'VA'	=> src_VA_Watercraft
				,'WI'	=> src_WI_Watercraft
				,'WV'	=> src_WV_Watercraft
				,'WY'	=> src_WY_Watercraft
				,'FL'	=> src_FL_Watercraft
				,'MO'	=> src_MO_Watercraft
				,'KY'	=> src_KY_Watercraft
				,'FV'	=> src_AK_Fishing_boats
				,''
			)
		);

	// ---------------------------------------------------------------
	// -- Translate Weekly Indicators
	// -- in a normalized record 1, 3, 4, and 7 should never be valid
	// ---------------------------------------------------------------
	export TranslateWeeklyInd(string1 pIn) := 
	case(pIn
		,'W' => 'New'
		,'1' => 'Name Chg,Addr Chg,SSN Chg,Former Name Chg'
		,'2' => 'Name Chg,Addr Chg,SSN Chg'
		,'3' => 'Name Chg,SSN Chg,Former Name Chg'
		,'4' => 'Name Chg,Addr Chg,Former Name Chg'
		,'5' => 'Name Chg,Addr Chg'
		,'6' => 'Name Chg,SSN Chg'
		,'7' => 'Name Chg,Former Name Chg'
		,'N' => 'Name Chg'
		,'8' => 'Addr Chg,SSN Chg,Former Name Chg'
		,'9' => 'Addr Chg,SSN Chg'
		,'Y' => 'Addr Chg,Former Name Chg'
		,'A' => 'Addr Chg'
		,'Z' => 'SSN Chg,Former Name Chg'
		,'S' => 'SSN Chg'
		,'F' => 'Former Name Chg'
		,'-' => 'No Relevant Information'
		,pIn
	);

	//convert multiple sources for source match usage
	export str_convert_property := 'PP';
	export str_convert_utility  := 'UU';
	export str_convert_ATF      := 'AF';
	export str_convert_DL       := 'DR';
	export str_convert_vehicle  := 'VV';
	export str_convert_WC       := 'WC';
	export str_convert_infutor  := 'IF';
	export filter_from_moxie              := [
		 src_Certegy                   ,src_Experian_Credit_Header    ,src_TUCS_Ptrack               
	];

end;
