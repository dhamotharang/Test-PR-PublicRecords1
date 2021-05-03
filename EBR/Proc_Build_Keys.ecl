import Promotesupers;

export Proc_Build_Keys(string filedate) := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add base superfile to _building superfile for use in keybuilding
//////////////////////////////////////////////////////////////////////////////////////////////
pre_0010_Header													:= Promotesupers.SF_MaintBuilding(FileName_0010_Header_Base);
pre_1000_Executive_Summary							:= Promotesupers.SF_MaintBuilding(FileName_1000_Executive_Summary_Base);
pre_2000_Trade													:= Promotesupers.SF_MaintBuilding(FileName_2000_Trade_Base);
pre_2015_Trade_Payment_Totals						:= Promotesupers.SF_MaintBuilding(FileName_2015_Trade_Payment_Totals_Base);
pre_2020_Trade_Payment_Trends						:= Promotesupers.SF_MaintBuilding(FileName_2020_Trade_Payment_Trends_Base);
pre_2025_Trade_Quarterly_Averages				:= Promotesupers.SF_MaintBuilding(FileName_2025_Trade_Quarterly_Averages_Base);
pre_4010_Bankruptcy											:= Promotesupers.SF_MaintBuilding(FileName_4010_Bankruptcy_Base);
pre_4020_Tax_Liens											:= Promotesupers.SF_MaintBuilding(FileName_4020_Tax_Liens_Base);
pre_4030_Judgement											:= Promotesupers.SF_MaintBuilding(FileName_4030_Judgement_Base);
pre_4035_Attachment_Lien								:= Promotesupers.SF_MaintBuilding(FileName_4035_Attachment_Lien_Base);
pre_4040_Bulk_Transfers									:= Promotesupers.SF_MaintBuilding(FileName_4040_Bulk_Transfers_Base);
pre_4500_Collateral_Accounts						:= Promotesupers.SF_MaintBuilding(FileName_4500_Collateral_Accounts_Base);
pre_4510_UCC_Filings										:= Promotesupers.SF_MaintBuilding(FileName_4510_UCC_Filings_Base);
pre_5000_Bank_Details										:= Promotesupers.SF_MaintBuilding(FileName_5000_Bank_Details_Base);
pre_5600_Demographic_Data								:= Promotesupers.SF_MaintBuilding(FileName_5600_Demographic_Data_Base);
pre_5610_Demographic_Data								:= Promotesupers.SF_MaintBuilding(FileName_5610_Demographic_Data_Base);
pre_6000_Inquiries											:= Promotesupers.SF_MaintBuilding(FileName_6000_Inquiries_Base);
pre_6500_Government_Trade								:= Promotesupers.SF_MaintBuilding(FileName_6500_Government_Trade_Base);
pre_6510_Government_Debarred_Contractor	:= Promotesupers.SF_MaintBuilding(FileName_6510_Government_Debarred_Contractor_Base);
pre_7000_SNP_Parent_Name_Address				:= Promotesupers.SF_MaintBuilding(FileName_7000_SNP_Parent_Name_Address_Base);
pre_7010_SNP_Data												:= Promotesupers.SF_MaintBuilding(FileName_7010_SNP_Data_Base);

Prebuild_superfile_manipulation := sequential(
    pre_0010_Header
   ,pre_1000_Executive_Summary
   ,pre_2000_Trade
   ,pre_2015_Trade_Payment_Totals
   ,pre_2020_Trade_Payment_Trends
   ,pre_2025_Trade_Quarterly_Averages
   ,pre_4010_Bankruptcy
   ,pre_4020_Tax_Liens
   ,pre_4030_Judgement
// ,pre_4035_Attachment_Lien
// ,pre_4040_Bulk_Transfers
   ,pre_4500_Collateral_Accounts
   ,pre_4510_UCC_Filings
   ,pre_5000_Bank_Details
   ,pre_5600_Demographic_Data
   ,pre_5610_Demographic_Data
   ,pre_6000_Inquiries
   ,pre_6500_Government_Trade
   ,pre_6510_Government_Debarred_Contractor
// ,pre_7000_SNP_Parent_Name_Address
   ,pre_7010_SNP_Data
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add base superfile to _built superfile
//////////////////////////////////////////////////////////////////////////////////////////////
post_0010_Header													:= Promotesupers.SF_MaintBuilt(FileName_0010_Header_Base);
post_1000_Executive_Summary								:= Promotesupers.SF_MaintBuilt(FileName_1000_Executive_Summary_Base);
post_2000_Trade														:= Promotesupers.SF_MaintBuilt(FileName_2000_Trade_Base);
post_2015_Trade_Payment_Totals						:= Promotesupers.SF_MaintBuilt(FileName_2015_Trade_Payment_Totals_Base);
post_2020_Trade_Payment_Trends						:= Promotesupers.SF_MaintBuilt(FileName_2020_Trade_Payment_Trends_Base);
post_2025_Trade_Quarterly_Averages				:= Promotesupers.SF_MaintBuilt(FileName_2025_Trade_Quarterly_Averages_Base);
post_4010_Bankruptcy											:= Promotesupers.SF_MaintBuilt(FileName_4010_Bankruptcy_Base);
post_4020_Tax_Liens												:= Promotesupers.SF_MaintBuilt(FileName_4020_Tax_Liens_Base);
post_4030_Judgement												:= Promotesupers.SF_MaintBuilt(FileName_4030_Judgement_Base);
post_4035_Attachment_Lien									:= Promotesupers.SF_MaintBuilt(FileName_4035_Attachment_Lien_Base);
post_4040_Bulk_Transfers									:= Promotesupers.SF_MaintBuilt(FileName_4040_Bulk_Transfers_Base);
post_4500_Collateral_Accounts							:= Promotesupers.SF_MaintBuilt(FileName_4500_Collateral_Accounts_Base);
post_4510_UCC_Filings											:= Promotesupers.SF_MaintBuilt(FileName_4510_UCC_Filings_Base);
post_5000_Bank_Details										:= Promotesupers.SF_MaintBuilt(FileName_5000_Bank_Details_Base);
post_5600_Demographic_Data								:= Promotesupers.SF_MaintBuilt(FileName_5600_Demographic_Data_Base);
post_5610_Demographic_Data								:= Promotesupers.SF_MaintBuilt(FileName_5610_Demographic_Data_Base);
post_6000_Inquiries												:= Promotesupers.SF_MaintBuilt(FileName_6000_Inquiries_Base);
post_6500_Government_Trade								:= Promotesupers.SF_MaintBuilt(FileName_6500_Government_Trade_Base);
post_6510_Government_Debarred_Contractor	:= Promotesupers.SF_MaintBuilt(FileName_6510_Government_Debarred_Contractor_Base);
post_7000_SNP_Parent_Name_Address					:= Promotesupers.SF_MaintBuilt(FileName_7000_SNP_Parent_Name_Address_Base);
post_7010_SNP_Data												:= Promotesupers.SF_MaintBuilt(FileName_7010_SNP_Data_Base);

Postbuild_superfile_manipulation := sequential(
    post_0010_Header
   ,post_1000_Executive_Summary
   ,post_2000_Trade
   ,post_2015_Trade_Payment_Totals
   ,post_2020_Trade_Payment_Trends
   ,post_2025_Trade_Quarterly_Averages
   ,post_4010_Bankruptcy
   ,post_4020_Tax_Liens
   ,post_4030_Judgement
// ,post_4035_Attachment_Lien
// ,post_4040_Bulk_Transfers
   ,post_4500_Collateral_Accounts
   ,post_4510_UCC_Filings
   ,post_5000_Bank_Details
   ,post_5600_Demographic_Data
   ,post_5610_Demographic_Data
   ,post_6000_Inquiries
   ,post_6500_Government_Trade
   ,post_6510_Government_Debarred_Contractor
// ,post_7000_SNP_Parent_Name_Address
   ,post_7010_SNP_Data
);

Build_Keys_Bdid 			:= Proc_Build_Keys_bdid(filedate) 							: success(output('EBR Proc_Build_Keys_bdid Build Succeeded - ' + filedate));
Build_Keys_Linkids 		:= Proc_Build_Keys_Linkids(filedate)						: success(output('EBR Proc_Build_Keys_Linkids Build Succeeded - ' + filedate));
Build_Keys_Delta_RIDs	:= Proc_Build_Keys_Delta_Rids(filedate)					: success(output('EBR Proc_Build_Keys_Delta_Rids Build Succeeded - ' + filedate));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Execute all
//////////////////////////////////////////////////////////////////////////////////////////////
retval := sequential(
	 Prebuild_superfile_manipulation
	,Build_Keys_Bdid
	,Build_Keys_Linkids
	,Build_Keys_Delta_RIDs
	,Postbuild_superfile_manipulation
);

return retval;

end;
