EXPORT Core_Testing_Errors(String filetag_in) := FUNCTION

Import std, Scoring_Project_Macros;

// DateRan := Std.Date.Today();
// DateRan := '20170913';
// filetag := '1';

//*********************** NONFCRA ***************************************

Chase_BNK4_xml_outfile_name := '~ScoringQA::out::NONFCRA::BNK4_xml_chase_BD3605_0_' + filetag_in;
Chase_BNK4_batch_outFile_name := '~ScoringQA::out::NONFCRA::BNK4_batch_chase_BD3605_0_' + filetag_in;
Chase_PIO2_xml_outFile_name := '~ScoringQA::out::NONFCRA::PI02_xml_chase_FP3710_0_' + filetag_in;
Chase_PIO2_batch_outFile_name := '~ScoringQA::out::NONFCRA::PI02_batch_chase_FP3710_0_' + filetag_in;
Chase_CBBL_outfile_name := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_' + filetag_in;
// Chase_CBBL_outfile_name_FPScore_ONLY := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_FPScore_ONLY_' + filetag_in;
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3_' + filetag_in;
bbuy_outFile_Name := '~ScoringQA::out::NONFCRA::ChargebackDefender_xml_BestBuy_CDN1109_1_' + filetag_in;
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4_' + filetag_in;
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4_' + filetag_in;
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4_' + filetag_in;
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4_' + filetag_in;
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase_' + filetag_in;
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic_' + filetag_in;
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic_' + filetag_in;
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic_' + filetag_in;
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic_' + filetag_in;
// FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2_' + filetag_in;
// FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2_' + filetag_in;
FP_V2_XML_American_Express_FP1109_0_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_American_Express_fp1109_0_v201_' + filetag_in ;
FP_V3_XML_Generic_FP31505_0_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp31505_0_v3_flsd_' + filetag_in;
PB_capone_outfile_name := '~ScoringQA::out::NONFCRA::Profile_Booster_Batch_CapitalOne_attributes_v1_'+ filetag_in;

//********************** FCRA ******************************

Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3_' + filetag_in;
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3_' + filetag_in;
CapitalOne_RVAttributes_V3_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_' + filetag_in;
CapitalOne_RVAttributes_V2_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2_' + filetag_in;
CapitalOne_RVAttributes_V5_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v5_' + filetag_in;
CreditAcceptanceCorp_RV2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2_' + filetag_in;
T_Mobile_RVT1212_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4_' + filetag_in;
T_Mobile_RVT1210_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4_' + filetag_in;
Santander_RVA1304_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3_' + filetag_in;
Santander_RVA1304_2_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3_' + filetag_in;
RV_V3_ENOVA_XML_Scores_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4_' + filetag_in;
RV_Scores_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v4_' + filetag_in;
RV_Scores_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v3_' + filetag_in;
RV_Attributes_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4_' + filetag_in;
RV_Attributes_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3_' + filetag_in;
RV_Attributes_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3_' + filetag_in;
RV_Attributes_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4_' + filetag_in;
RV_Scores_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4_' + filetag_in;
RV_Scores_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3_' + filetag_in;
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4_' + filetag_in;
RV_Scores_Attributes_V5_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_attributes_v5_' + filetag_in;
// RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_attributes_v5_prescreen_' + filetag_in;  //removed in favor of Capone v5 prescreen


//************************ SHELLS ***************
																	
bocashell_41_fcra_outfile_name := '~scoringqa::out::bs_41_fcra_NO_EDINA_' + filetag_in;
bocashell_41_nonfcra_outfile_name := '~scoringqa::out::bs_41_nonfcra_NO_EDINA_' + filetag_in;
bocashell_50_fcra_outfile_name := '~scoringqa::out::bs_50_FCRA_NO_EDINA_' + filetag_in;
bocashell_50_nonfcra_outfile_name := '~scoringqa::out::bs_50_nonFCRA_NO_EDINA_' + filetag_in;

AddressShell_Attributes_V1_BATCH_Generic_outfile := '~ScoringQA::out::AddressShell_V1_Batch_Generic_' + filetag_in;
BusinessShell_outfile_name := '~ScoringQA::out::NONFCRA::BusinessShell_xml_generic_attributes_v2_' + filetag_in;
PhoneShell_outfile_name := '~ScoringQA::out::phone_shell_' + filetag_in;



//**********************Layouts****************
//NonFCRA
Chase_BNK4_xml_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout;
Chase_BNK4_batch_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout;
Chase_PIO2_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout;
Chase_PIO2_batch_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout;
Chase_CBBL_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_CBBL_Global_Layout;
chase_BIID_batch_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_CHASE_BusinessInstantId_Global_Layout;
BIID_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;
BIID_batch_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;
instant_id_xml_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout;
instant_id_batch_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout;
CapitalOne_batch_ITA_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout;
LI_v4_scores_xml_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;
LI_v4_scores_batch_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;
LI_v4_attributes_xml_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;
LI_v4_attributes_batch_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;
// FP_ScoresAttributes_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout;
// FP_ScoresAttributes_BATCH_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout;
FP_AmericanExpress_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout;
FP_v3_ScoresAttributes_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout;
PB_capone_Lay := Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout;


//FCRA
CapitalOne_RVAttributes_V3_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V3_Global_Layout;
CapitalOne_RVAttributes_V5_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Capone_allflagships_Attributes_V5_Batch_Layout;
Experian_RVA_30_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout;
Experian_RVA_30_BATCH_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout;
RV_Attributes_V3_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout;
RV_Attributes_V3_BATCH_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout;
RV_Scores_V3_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout;
RV_Scores_V3_BATCH_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout;
RV_Attributes_V4_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout;
RV_Attributes_V4_BATCH_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Generic_Attributes_V4_Global_Layout;
RV_Scores_V4_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout;
RV_Scores_V4_BATCH_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout;
RV_Scores_Attributes_V5_XML_Lay := Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout;


//Shells
bocashell_41_nonfcra_Lay := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;
bocashell_50_nonfcra_Lay := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;
bocashell_41_fcra_Lay := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;
bocashell_50_fcra_Lay := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;

// PhoneShell_Lay := Scoring_Project_Macros.Global_Output_Layouts.;
BusinessShell_Lay := Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout;
AddressShell_Lay := Scoring_Project_Macros.Global_Output_Layouts.AddressShell_Attributes_V1_BATCH_Generic_Global_Layout;



//***************Datasets

//NonFCRA
Chase_BNK4_xml_Outds := dataset(Chase_BNK4_xml_outfile_name, Chase_BNK4_xml_Lay, thor);
Chase_BNK4_batch_Outds := dataset(Chase_BNK4_batch_outfile_name, Chase_BNK4_batch_Lay, thor);
Chase_PIO2_XML_Outds := dataset(Chase_PIO2_XML_outfile_name, Chase_PIO2_XML_Lay, thor);
Chase_PIO2_batch_Outds := dataset(Chase_PIO2_batch_outfile_name, Chase_PIO2_batch_Lay, thor);
Chase_CBBL_Outds := dataset(Chase_CBBL_outfile_name, Chase_CBBL_Lay, thor);
chase_BIID_batch_Outds := dataset(chase_BIID_batch_outfile_name, chase_BIID_batch_Lay, thor);
BIID_XML_Outds := dataset(BIID_XML_outfile_name, BIID_XML_Lay, thor);
BIID_batch_Outds := dataset(BIID_batch_outfile_name, BIID_batch_Lay, thor);
instant_id_xml_Outds := dataset(iid_xml_outfile_name, instant_id_xml_Lay, thor);
instant_id_batch_Outds := dataset(iid_batch_outfile_name, instant_id_batch_Lay, thor);
CapitalOne_batch_ITA_Outds := dataset(CapitalOne_batch_outfile_name, CapitalOne_batch_ITA_Lay, thor);
LI_v4_scores_xml_Outds := dataset(LI_v4_scores_xml_outfile_name, LI_v4_scores_xml_Lay, thor);
LI_v4_scores_batch_Outds := dataset(LI_v4_scores_batch_outfile_name, LI_v4_scores_batch_Lay, thor);
LI_v4_attributes_xml_Outds := dataset(LI_v4_attributes_xml_outfile_name, LI_v4_attributes_xml_Lay, thor);
LI_v4_attributes_batch_Outds := dataset(LI_v4_attributes_batch_outfile_name, LI_v4_attributes_batch_Lay, thor);
// FP_ScoresAttributes_XML_Outds := dataset(FP_XML_outfile_name, FP_ScoresAttributes_XML_Lay, thor);
// FP_ScoresAttributes_BATCH_Outds := dataset(FP_batch_outfile_name, FP_ScoresAttributes_BATCH_Lay, thor);
FP_AmericanExpress_XML_Outds := dataset(FP_V2_XML_American_Express_FP1109_0_outfile_name, FP_AmericanExpress_XML_Lay, thor);
FP_v3_ScoresAttributes_XML_Outds := dataset(FP_V3_XML_Generic_FP31505_0_outfile_name, FP_v3_ScoresAttributes_XML_Lay, thor);
PB_capone_Outds := dataset(PB_capone_outfile_name, PB_capone_Lay, thor);


//FCRA
// CapitalOne_RVAttributes_V3_Outds := dataset(CapitalOne_RVAttributes_V3_outfile_name, CapitalOne_RVAttributes_V3_Lay, thor);
// CapitalOne_RVAttributes_V5_Outds := dataset(CapitalOne_RVAttributes_V5_outfile_name, CapitalOne_RVAttributes_V5_Lay, thor);
Experian_RVA_30_XML_Outds := dataset(Experian_RVA_30_XML_outfile_name, Experian_RVA_30_XML_Lay, thor);
Experian_RVA_30_BATCH_Outds := dataset(Experian_RVA_30_BATCH_outfile_name, Experian_RVA_30_BATCH_Lay, thor);
RV_Attributes_V3_XML_Outds := dataset(RV_Attributes_V3_XML_outfile_name, RV_Attributes_V3_XML_Lay, thor);
RV_Attributes_V3_BATCH_Outds := dataset(RV_Attributes_V3_BATCH_outfile_name, RV_Attributes_V3_BATCH_Lay, thor);
RV_Scores_V3_XML_Outds := dataset(RV_Scores_V3_XML_outfile_name, RV_Scores_V3_XML_Lay, thor);
RV_Scores_V3_BATCH_Outds := dataset(RV_Scores_V3_BATCH_outfile_name, RV_Scores_V3_BATCH_Lay, thor);
RV_Attributes_V4_XML_Outds := dataset(RV_Attributes_V4_XML_outfile_name, RV_Attributes_V4_XML_Lay, thor);
RV_Attributes_V4_BATCH_Outds := dataset(RV_Attributes_V4_BATCH_outfile_name, RV_Attributes_V4_BATCH_Lay, thor);
RV_Scores_V4_XML_Outds := dataset(RV_Scores_V4_XML_outfile_name, RV_Scores_V4_XML_Lay, thor);
RV_Scores_V4_BATCH_Outds := dataset(RV_Scores_V4_BATCH_outfile_name, RV_Scores_V4_BATCH_Lay, thor);
RV_Scores_Attributes_V5_XML_Outds := dataset(RV_Scores_Attributes_V5_XML_outfile_name, RV_Scores_Attributes_V5_XML_Lay, thor);


//Shell ds
bocashell_41_nonfcra_Outds := dataset(bocashell_41_nonfcra_outfile_name, bocashell_41_nonfcra_Lay, thor);
bocashell_50_nonfcra_Outds := dataset(bocashell_50_nonfcra_outfile_name, bocashell_50_nonfcra_Lay, thor);
bocashell_41_fcra_Outds := dataset(bocashell_41_fcra_outfile_name, bocashell_41_fcra_Lay, thor);
bocashell_50_fcra_Outds := dataset(bocashell_50_fcra_outfile_name, bocashell_50_fcra_Lay, thor);
// PhoneShell_Outds := dataset(PhoneShell_outfile_name, PhoneShell_Lay, thor);
BusinessShell_Outds := dataset(BusinessShell_outfile_name, BusinessShell_Lay, thor);




//*******Transformed datasets

ReducedLay := Record
String Product;
String Errorcode;
integer RecordCount;
END;

ReducedLay mytrans(Chase_BNK4_xml_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans1(Chase_PIO2_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans2(Chase_CBBL_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans3(chase_BIID_batch_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans4(BIID_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans5(instant_id_xml_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans6(CapitalOne_batch_ITA_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans7(LI_v4_scores_xml_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans8(LI_v4_attributes_xml_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans9(FP_AmericanExpress_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans10(FP_v3_ScoresAttributes_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans11(PB_capone_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans12(bocashell_41_nonfcra_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;

ReducedLay mytrans13(BusinessShell_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;



// ReducedLay mytrans14(CapitalOne_RVAttributes_V3_Outds le, string P, integer c) := Transform
// self.product := P;
// self.Errorcode := le.Errorcode;
// self.RecordCount := c;
// END;
// ReducedLay mytrans15(CapitalOne_RVAttributes_V5_Outds le, string P, integer c) := Transform
// self.product := P;
// self.Errorcode := le.Errorcode;
// self.RecordCount := c;
// END;
ReducedLay mytrans16(Experian_RVA_30_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;
ReducedLay mytrans17(RV_Attributes_V3_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;
ReducedLay mytrans18(RV_Scores_V3_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;
ReducedLay mytrans19(RV_Attributes_V4_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;
ReducedLay mytrans20(RV_Attributes_V4_BATCH_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;
ReducedLay mytrans21(RV_Scores_V4_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;
ReducedLay mytrans22(RV_Scores_Attributes_V5_XML_Outds le, string P, integer c) := Transform
self.product := P;
self.Errorcode := le.Errorcode;
self.RecordCount := c;
END;


//*****************File Counters*************
//NonFCRA
Chase_BNK4_xml_counter := count(Chase_BNK4_xml_Outds);
Chase_BNK4_batch_counter := count(Chase_BNK4_batch_Outds);
Chase_PIO2_XML_counter := count(Chase_PIO2_XML_Outds);
Chase_PIO2_batch_counter := count(Chase_PIO2_batch_Outds);
Chase_CBBL_counter := count(Chase_CBBL_Outds);
chase_BIID_batch_counter := count(chase_BIID_batch_Outds);
BIID_XML_counter := count(BIID_XML_Outds);
BIID_batch_counter := count(BIID_batch_Outds);
instant_id_xml_counter := count(instant_id_xml_Outds);
instant_id_batch_counter := count(instant_id_batch_Outds);
CapitalOne_batch_ITA_counter := count(CapitalOne_batch_ITA_Outds);
LI_v4_scores_xml_counter := count(LI_v4_scores_xml_Outds);
LI_v4_scores_batch_counter := count(LI_v4_scores_batch_Outds);
LI_v4_attributes_xml_counter := count(LI_v4_attributes_xml_Outds);
LI_v4_attributes_batch_counter := count(LI_v4_attributes_batch_Outds);
// FP_ScoresAttributes_XML_counter := count(FP_ScoresAttributes_XML_Outds);
// FP_ScoresAttributes_BATCH_counter := count(FP_ScoresAttributes_BATCH_Outds);
FP_AmericanExpress_XML_counter := count(FP_AmericanExpress_XML_Outds);
FP_v3_ScoresAttributes_XML_counter := count(FP_v3_ScoresAttributes_XML_Outds);
PB_capone_counter := count(PB_capone_Outds);

//FCRA
// CapitalOne_RVAttributes_V3_counter := count(CapitalOne_RVAttributes_V3_Outds);
// CapitalOne_RVAttributes_V5_counter := count(CapitalOne_RVAttributes_V5_Outds);
Experian_RVA_30_XML_counter := count(Experian_RVA_30_XML_Outds);
Experian_RVA_30_BATCH_counter := count(Experian_RVA_30_BATCH_Outds);
RV_Attributes_V3_XML_counter := count(RV_Attributes_V3_XML_Outds);
RV_Attributes_V3_BATCH_counter := count(RV_Attributes_V3_BATCH_Outds);
RV_Scores_V3_XML_counter := count(RV_Scores_V3_XML_Outds);
RV_Scores_V3_BATCH_counter := count(RV_Scores_V3_BATCH_Outds);
RV_Attributes_V4_XML_counter := count(RV_Attributes_V4_XML_Outds);
RV_Attributes_V4_BATCH_counter := count(RV_Attributes_V4_BATCH_Outds);
RV_Scores_V4_XML_counter := count(RV_Scores_V4_XML_Outds);
RV_Scores_V4_BATCH_counter := count(RV_Scores_V4_BATCH_Outds);
RV_Scores_Attributes_V5_XML_counter := count(RV_Scores_Attributes_V5_XML_Outds);

//Shells
bocashell_41_nonfcra_counter := count(bocashell_41_nonfcra_Outds);
bocashell_50_nonfcra_counter := count(bocashell_50_nonfcra_Outds);
bocashell_41_fcra_counter := count(bocashell_41_fcra_Outds);
bocashell_50_fcra_counter := count(bocashell_50_fcra_Outds);
// PhoneShell_counter := count(PhoneShell_Outds);
BusinessShell_counter := count(BusinessShell_Outds);

//*****************Projections*****************
//NonFCRA
Chase_BNK4_xml_trans := project(Chase_BNK4_xml_Outds, mytrans(left, 'Chase_BNK4_xml', Chase_BNK4_xml_counter));
Chase_BNK4_batch_trans := project(Chase_BNK4_batch_Outds, mytrans(left, 'Chase_BNK4_batch', Chase_BNK4_batch_counter));
Chase_PIO2_XML_trans := project(Chase_PIO2_XML_Outds, mytrans1(left, 'Chase_PIO2_XML', Chase_PIO2_XML_counter));
Chase_PIO2_batch_trans := project(Chase_PIO2_batch_Outds, mytrans1(left, 'Chase_PIO2_batch', Chase_PIO2_batch_counter));
Chase_CBBL_trans := project(Chase_CBBL_Outds, mytrans2(left, 'Chase_CBBL', Chase_CBBL_counter));
chase_BIID_batch_trans := project(chase_BIID_batch_Outds, mytrans3(left, 'chase_BIID_batch', chase_BIID_batch_counter));
BIID_XML_trans := project(BIID_XML_Outds, mytrans4(left, 'BIID_XML', BIID_XML_counter));
BIID_batch_trans := project(BIID_batch_Outds, mytrans4(left, 'BIID_batch', BIID_batch_counter));
instant_id_xml_trans := project(instant_id_xml_Outds, mytrans5(left, 'instant_id_xml', instant_id_xml_counter));
instant_id_batch_trans := project(instant_id_batch_Outds, mytrans5(left, 'instant_id_batch', instant_id_batch_counter));
CapitalOne_batch_ITA_trans := project(CapitalOne_batch_ITA_Outds, mytrans6(left, 'CapitalOne_batch_ITA', CapitalOne_batch_ITA_counter));
LI_v4_scores_xml_trans := project(LI_v4_scores_xml_Outds, mytrans7(left, 'LI_v4_scores_xml', LI_v4_scores_xml_counter));
LI_v4_scores_batch_trans := project(LI_v4_scores_batch_Outds, mytrans7(left, 'LI_v4_scores_batch', LI_v4_scores_batch_counter));
LI_v4_attributes_xml_trans := project(LI_v4_attributes_xml_Outds, mytrans8(left, 'LI_v4_attributes_xml', LI_v4_attributes_xml_counter));
LI_v4_attributes_batch_trans := project(LI_v4_attributes_batch_Outds, mytrans8(left, 'LI_v4_attributes_batch', LI_v4_attributes_batch_counter));
// FP_ScoresAttributes_XML_trans := project(FP_ScoresAttributes_XML_Outds, mytrans(left, 'FP_ScoresAttributes_XML', FP_ScoresAttributes_XML_counter));
// FP_ScoresAttributes_BATCH_trans := project(FP_ScoresAttributes_BATCH_Outds, mytrans(left, 'FP_ScoresAttributes_BATCH', FP_ScoresAttributes_BATCH_counter));
FP_AmericanExpress_XML_trans := project(FP_AmericanExpress_XML_Outds, mytrans9(left, 'FP_AmericanExpress_XML', FP_AmericanExpress_XML_counter));
FP_v3_ScoresAttributes_XML_trans := project(FP_v3_ScoresAttributes_XML_Outds, mytrans10(left, 'FP_v3_ScoresAttributes_XML', FP_v3_ScoresAttributes_XML_counter));
PB_capone_trans := project(PB_capone_Outds, mytrans11(left, 'PB_capone', PB_capone_counter));

//FCRA
// CapitalOne_RVAttributes_V3_trans := project(CapitalOne_RVAttributes_V3_Outds, mytrans14(left, 'CapitalOne_RVAttributes_V3', CapitalOne_RVAttributes_V3_counter));
// CapitalOne_RVAttributes_V5_trans := project(CapitalOne_RVAttributes_V5_Outds, mytrans15(left, 'CapitalOne_RVAttributes_V5', CapitalOne_RVAttributes_V5_counter));
Experian_RVA_30_XML_trans := project(Experian_RVA_30_XML_Outds, mytrans16(left, 'Experian_RVA_30_XML', Experian_RVA_30_XML_counter));
Experian_RVA_30_BATCH_trans := project(Experian_RVA_30_BATCH_Outds, mytrans16(left, 'Experian_RVA_30_BATCH', Experian_RVA_30_BATCH_counter));
RV_Attributes_V3_XML_trans := project(RV_Attributes_V3_XML_Outds, mytrans17(left, 'RV_Attributes_V3_XML', RV_Attributes_V3_XML_counter));
RV_Attributes_V3_BATCH_trans := project(RV_Attributes_V3_BATCH_Outds, mytrans17(left, 'RV_Attributes_V3_BATCH', RV_Attributes_V3_BATCH_counter));
RV_Scores_V3_XML_trans := project(RV_Scores_V3_XML_Outds, mytrans18(left, 'RV_Scores_V3_XML', RV_Scores_V3_XML_counter));
RV_Scores_V3_BATCH_trans := project(RV_Scores_V3_BATCH_Outds, mytrans18(left, 'RV_Scores_V3_BATCH', RV_Scores_V3_BATCH_counter));
RV_Attributes_V4_XML_trans := project(RV_Attributes_V4_XML_Outds, mytrans19(left, 'RV_Attributes_V4_XML', RV_Attributes_V4_XML_counter));
RV_Attributes_V4_BATCH_trans := project(RV_Attributes_V4_BATCH_Outds, mytrans20(left, 'RV_Attributes_V4_BATCH', RV_Attributes_V4_BATCH_counter));
RV_Scores_V4_XML_trans := project(RV_Scores_V4_XML_Outds, mytrans21(left, 'RV_Scores_V4_XML', RV_Scores_V4_XML_counter));
RV_Scores_V4_BATCH_trans := project(RV_Scores_V4_BATCH_Outds, mytrans21(left, 'RV_Scores_V4_BATCH', RV_Scores_V4_BATCH_counter));
RV_Scores_Attributes_V5_XML_trans := project(RV_Scores_Attributes_V5_XML_Outds, mytrans22(left, 'RV_Scores_Attributes_V5_XML', RV_Scores_Attributes_V5_XML_counter));

//Shells
bocashell_41_nonfcra_trans := project(bocashell_41_nonfcra_Outds, mytrans12(left, 'bocashell_41_nonfcra', bocashell_41_nonfcra_counter));
bocashell_50_nonfcra_trans := project(bocashell_50_nonfcra_Outds, mytrans12(left, 'bocashell_50_nonfcra', bocashell_50_nonfcra_counter));
bocashell_41_fcra_trans := project(bocashell_41_fcra_Outds, mytrans12(left, 'bocashell_41_fcra', bocashell_41_fcra_counter));
bocashell_50_fcra_trans := project(bocashell_50_fcra_Outds, mytrans12(left, 'bocashell_50_fcra', bocashell_50_fcra_counter));
// PhoneShell_trans := project(PhoneShell_Outds, mytrans(left, 'PhoneShell', PhoneShell_counter));
BusinessShell_trans := project(BusinessShell_Outds, mytrans13(left, 'BusinessShell', BusinessShell_counter));



Appended_ds := 
Chase_BNK4_xml_trans +
Chase_BNK4_batch_trans +
Chase_PIO2_XML_trans +
Chase_PIO2_batch_trans +
Chase_CBBL_trans +
chase_BIID_batch_trans +
BIID_XML_trans +
BIID_batch_trans +
instant_id_xml_trans +
instant_id_batch_trans +
CapitalOne_batch_ITA_trans +
LI_v4_scores_xml_trans +
LI_v4_scores_batch_trans +
LI_v4_attributes_xml_trans +
LI_v4_attributes_batch_trans +
FP_AmericanExpress_XML_trans + 
FP_v3_ScoresAttributes_XML_trans +
PB_capone_trans +
bocashell_41_nonfcra_trans +
bocashell_50_nonfcra_trans +
// PhoneShell_trans +
BusinessShell_trans +
// CapitalOne_RVAttributes_V3_trans +
// CapitalOne_RVAttributes_V5_trans +
Experian_RVA_30_XML_trans +
Experian_RVA_30_BATCH_trans +
RV_Attributes_V3_XML_trans +
RV_Attributes_V3_BATCH_trans +
RV_Scores_V3_XML_trans +
RV_Scores_V3_BATCH_trans +
RV_Attributes_V4_XML_trans +
RV_Attributes_V4_BATCH_trans +
RV_Scores_V4_XML_trans +
RV_Scores_V4_BATCH_trans +
RV_Scores_Attributes_V5_XML_trans +
bocashell_41_fcra_trans +
bocashell_50_fcra_trans ;


Filtered_Appended_ds := Appended_ds(errorcode <> '');
Appended_Table := Output(choosen(table(Filtered_Appended_ds, {Product; RecordCount; ErrorCount := count(group); errorcode}, Product, errorcode), all), Named('Roxie_Errors'));

ds_results := FileServices.SendEmail('Bridgett.braaten@lexisnexis.com; Matthew.Ludewig@lexisnexisrisk.com ', 'Core testing error results', ThorLib.wuid());
// ds_results := FileServices.SendEmail('Bridgett.braaten@lexisnexis.com', 'Core testing error results', ThorLib.wuid());

Appended_Table;
// Output(choosen(Appended_Table, all));

Return ds_results;

END;
