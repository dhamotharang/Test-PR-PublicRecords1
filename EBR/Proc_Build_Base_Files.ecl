import ut;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Build 0010_Header and Executive Summary Base files
//////////////////////////////////////////////////////////////////////////////////////////////
ut.MAC_SF_BuildProcess(
   bdid_0010_Header,					FileName_0010_Header_Base_AID,						run_bdid_0010_Header_AID,						2);
ut.MAC_SF_BuildProcess(
   File_0010_Header_Base,			FileName_0010_Header_Base, create_old_0010_base,						2);
ut.MAC_SF_BuildProcess(
   bdid_1000_Executive_Summary,			FileName_1000_Executive_Summary_Base,				run_bdid_1000_Executive_Summary,				2);
ut.MAC_SF_BuildProcess(
   bdid_2000_Trade,						FileName_2000_Trade_Base,						run_bdid_2000_Trade,						2);
ut.MAC_SF_BuildProcess(
   bdid_2015_Trade_Payment_Totals,			FileName_2015_Trade_Payment_Totals_Base,			run_bdid_2015_Trade_Payment_Totals,			2);
ut.MAC_SF_BuildProcess(
   bdid_2020_Trade_Payment_Trends,			FileName_2020_Trade_Payment_Trends_Base,			run_bdid_2020_Trade_Payment_Trends,			2);
ut.MAC_SF_BuildProcess(
   bdid_2025_Trade_Quarterly_Averages,		FileName_2025_Trade_Quarterly_Averages_Base,			run_bdid_2025_Trade_Quarterly_Averages,			2);
ut.MAC_SF_BuildProcess(
   bdid_4010_Bankruptcy,					FileName_4010_Bankruptcy_Base,					run_bdid_4010_Bankruptcy,					2);
ut.MAC_SF_BuildProcess(
   bdid_4020_Tax_Liens,					FileName_4020_Tax_Liens_Base,						run_bdid_4020_Tax_Liens,						2);
ut.MAC_SF_BuildProcess(
   bdid_4030_Judgement,					FileName_4030_Judgement_Base,						run_bdid_4030_Judgement,						2);
ut.MAC_SF_BuildProcess(
   bdid_4035_Attachment_Lien,				FileName_4035_Attachment_Lien_Base,				run_bdid_4035_Attachment_Lien,				2);
ut.MAC_SF_BuildProcess(
   bdid_4040_Bulk_Transfers,				FileName_4040_Bulk_Transfers_Base,					run_bdid_4040_Bulk_Transfers,					2);
ut.MAC_SF_BuildProcess(
   bdid_4500_Collateral_Accounts,			FileName_4500_Collateral_Accounts_Base,				run_bdid_4500_Collateral_Accounts,				2);
ut.MAC_SF_BuildProcess(
   bdid_4510_UCC_Filings,				FileName_4510_UCC_Filings_Base,					run_bdid_4510_UCC_Filings,					2);
ut.MAC_SF_BuildProcess(
   bdid_5000_Bank_Details,				FileName_5000_Bank_Details_Base_AID,					run_bdid_5000_Bank_Details_AID,					2);	 
ut.MAC_SF_BuildProcess(
   File_5000_Bank_Details_Base,				FileName_5000_Bank_Details_Base,					create_old_5000_base,					2);
ut.MAC_SF_BuildProcess(
   bdid_5600_Demographic_Data,			FileName_5600_Demographic_Data_Base,				run_bdid_5600_Demographic_Data,				2);
ut.MAC_SF_BuildProcess(
   did_5610_Demographic_Data,				FileName_5610_Demographic_Data_Base,				run_did_5610_Demographic_Data,				2);
ut.MAC_SF_BuildProcess(
   bdid_6000_Inquiries,					FileName_6000_Inquiries_Base,						run_bdid_6000_Inquiries,						2);
ut.MAC_SF_BuildProcess(
   bdid_6500_Government_Trade,			FileName_6500_Government_Trade_Base,				run_bdid_6500_Government_Trade,				2);
ut.MAC_SF_BuildProcess(
   bdid_6510_Government_Debarred_Contractor,	FileName_6510_Government_Debarred_Contractor_Base_AID,	run_bdid_6510_Government_Debarred_Contractor_AID,	2);		 
ut.MAC_SF_BuildProcess(
   EBR.File_6510_Government_Debarred_Contractor_Base,	FileName_6510_Government_Debarred_Contractor_Base,	create_old_6510_Base,	2);
ut.MAC_SF_BuildProcess(
   bdid_7000_SNP_Parent_Name_Address,		FileName_7000_SNP_Parent_Name_Address_Base,			run_bdid_7000_SNP_Parent_Name_Address,			2);
ut.MAC_SF_BuildProcess(
   bdid_7010_SNP_Data,					FileName_7010_SNP_Data_Base,						run_bdid_7010_SNP_Data,						2);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add outputs to build processes to make sure they are done in order
//////////////////////////////////////////////////////////////////////////////////////////////
bdid_0010_Header_success													:= sequential(
																																run_bdid_0010_Header_AID,
																																create_old_0010_base
																															): success(output('BDID of 0010 Header Records completed successfully'));
bdid_1000_Executive_Summary_success								:= run_bdid_1000_Executive_Summary				;
bdid_2000_Trade_success														:= run_bdid_2000_Trade 						;
bdid_2015_Trade_Payment_Totals_success						:= run_bdid_2015_Trade_Payment_Totals 			;
bdid_2020_Trade_Payment_Trends_success						:= run_bdid_2020_Trade_Payment_Trends 			;
bdid_2025_Trade_Quarterly_Averages_success				:= run_bdid_2025_Trade_Quarterly_Averages 		;
bdid_4010_Bankruptcy_success											:= run_bdid_4010_Bankruptcy					;
bdid_4020_Tax_Liens_success												:= run_bdid_4020_Tax_Liens 					;
bdid_4030_Judgement_success												:= run_bdid_4030_Judgement 					;
bdid_4035_Attachment_Lien_success									:= run_bdid_4035_Attachment_Lien				;
bdid_4040_Bulk_Transfers_success									:= run_bdid_4040_Bulk_Transfers				;
bdid_4500_Collateral_Accounts_success							:= run_bdid_4500_Collateral_Accounts			;
bdid_4510_UCC_Filings_success											:= run_bdid_4510_UCC_Filings 					;
bdid_5000_Bank_Details_success										:= sequential(
																																run_bdid_5000_Bank_Details_AID,
																																create_old_5000_base
																																);
bdid_5600_Demographic_Data_success								:= run_bdid_5600_Demographic_Data				;
did_5610_Demographic_Data_success									:= run_did_5610_Demographic_Data	 			;
bdid_6000_Inquiries_success												:= run_bdid_6000_Inquiries 					;
bdid_6500_Government_Trade_success								:= run_bdid_6500_Government_Trade 				;
bdid_6510_Government_Debarred_Contractor_success	:= sequential(
																																run_bdid_6510_Government_Debarred_Contractor_AID,
																																create_old_6510_Base
																																);
bdid_7000_SNP_Parent_Name_Address_success 				:= run_bdid_7000_SNP_Parent_Name_Address 		;
bdid_7010_SNP_Data_success 												:= run_bdid_7010_SNP_Data 					;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Modified the build base file sequential process to parallel inorder to decrease the run time
   // -- BUG POSTED 26970
//////////////////////////////////////////////////////////////////////////////////////////////
export Proc_Build_Base_Files := sequential(	
		bdid_0010_Header_success,parallel(
		bdid_1000_Executive_Summary_success
		,bdid_2000_Trade_success
		,bdid_2015_Trade_Payment_Totals_success
		,bdid_2020_Trade_Payment_Trends_success
		,bdid_2025_Trade_Quarterly_Averages_success
		,bdid_4010_Bankruptcy_success
		,bdid_4020_Tax_Liens_success
		,bdid_4030_Judgement_success
//	,bdid_4035_Attachment_Lien_success
//	,bdid_4040_Bulk_Transfers_success
		,bdid_4500_Collateral_Accounts_success
		,bdid_4510_UCC_Filings_success
		,bdid_5000_Bank_Details_success
		,bdid_5600_Demographic_Data_success
		,did_5610_Demographic_Data_success
		,bdid_6000_Inquiries_success
		,bdid_6500_Government_Trade_success
		,bdid_6510_Government_Debarred_Contractor_success
//	,bdid_7000_SNP_Parent_Name_Address_success
		,bdid_7010_SNP_Data_success) 
);