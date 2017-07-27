/*--SOAP--
<message name="EBRkeys">
</message>
*/

export EBRKeys := macro

output(choosen(EBR.Key_0010_Header_BDID,10));
output(choosen(EBR.Key_0010_Header_FILE_NUMBER,10));
output(choosen(EBR.Key_1000_Executive_Summary_BDID,10));
output(choosen(EBR.Key_1000_Executive_Summary_FILE_NUMBER,10));
//output(choosen(EBR.Key_2000_Trade_BDID,10));
output(choosen(EBR.Key_2000_Trade_FILE_NUMBER,10));
//output(choosen(EBR.Key_2015_Trade_Payment_Totals_BDID,10));
output(choosen(EBR.Key_2015_Trade_Payment_Totals_FILE_NUMBER,10));
//output(choosen(EBR.Key_2020_Trade_Payment_Trends_BDID,10));
output(choosen(EBR.Key_2020_Trade_Payment_Trends_FILE_NUMBER,10));
//output(choosen(EBR.Key_2025_Trade_Quarterly_Averages_BDID,10));
output(choosen(EBR.Key_2025_Trade_Quarterly_Averages_FILE_NUMBER,10));
//output(choosen(EBR.Key_4010_Bankruptcy_BDID,10));
output(choosen(EBR.Key_4010_Bankruptcy_FILE_NUMBER,10));
output(choosen(EBR.Key_4020_Tax_Liens_BDID,10));
output(choosen(EBR.Key_4020_Tax_Liens_FILE_NUMBER,10));
output(choosen(EBR.Key_4030_Judgement_BDID,10));
output(choosen(EBR.Key_4030_Judgement_FILE_NUMBER,10));
//output(choosen(EBR.Key_4035_Attachment_Lien_BDID,10));
//output(choosen(EBR.Key_4035_Attachment_Lien_FILE_NUMBER,10));
//output(choosen(EBR.Key_4040_Bulk_Transfers_BDID,10));
//output(choosen(EBR.Key_4040_Bulk_Transfers_FILE_NUMBER,10));
//output(choosen(EBR.Key_4500_Collateral_Accounts_BDID,10));
output(choosen(EBR.Key_4500_Collateral_Accounts_FILE_NUMBER,10));
output(choosen(EBR.Key_4510_UCC_Filings_BDID,10));
output(choosen(EBR.Key_4510_UCC_Filings_FILE_NUMBER,10));
//output(choosen(EBR.Key_5000_Bank_Details_BDID,10));
output(choosen(EBR.Key_5000_Bank_Details_FILE_NUMBER,10));
output(choosen(EBR.Key_5600_Demographic_Data_BDID,10));
output(choosen(EBR.Key_5600_Demographic_Data_FILE_NUMBER,10));
//output(choosen(EBR.Key_5610_Demographic_Data_BDID,10));
//output(choosen(EBR.Key_5610_Demographic_Data_DID,10));
output(choosen(EBR.Key_5610_Demographic_Data_FILE_NUMBER,10));
//output(choosen(EBR.Key_5610_Demographic_Data_SSN,10));
//output(choosen(EBR.Key_6000_Inquiries_BDID,10));
output(choosen(EBR.Key_6000_Inquiries_FILE_NUMBER,10));
//output(choosen(EBR.Key_6500_Government_Trade_BDID,10));
output(choosen(EBR.Key_6500_Government_Trade_FILE_NUMBER,10));
//output(choosen(EBR.Key_6510_Government_Debarred_Contractor_BDID,10));
output(choosen(EBR.Key_6510_Government_Debarred_Contractor_FILE_NUMBER,10));
//output(choosen(EBR.Key_7000_SNP_Parent_Name_Address_BDID,10));
//output(choosen(EBR.Key_7000_SNP_Parent_Name_Address_FILE_NUMBER,10));
//output(choosen(EBR.Key_7010_SNP_Data_BDID,10));
output(choosen(EBR.Key_7010_SNP_Data_FILE_NUMBER,10));

output(choosen(AutokeyB.Key_Address(EBR.constants('00000000').Str_autokeyName),10));
output(choosen(AutoKeyB.Key_CityStName(EBR.constants('00000000').Str_autokeyName),10));
//output(choosen(AutoKeyB.Key_FEIN(EBR.constants('00000000').Str_autokeyName),10));
output(choosen(AutoKeyB.key_name(EBR.constants('00000000').Str_autokeyName),10));
output(choosen(AutoKeyB.Key_NameWords(EBR.constants('00000000').Str_autokeyName),10));
output(choosen(AutoKeyB.key_phone(EBR.constants('00000000').Str_autokeyName),10));
output(choosen(AutoKeyB.Key_StName(EBR.constants('00000000').Str_autokeyName),10));
output(choosen(AutoKeyB.Key_Zip(EBR.constants('00000000').Str_autokeyName),10));
output(choosen(EBR.Key_EBR_Autokeypayload,10));



endmacro;