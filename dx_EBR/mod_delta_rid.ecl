IMPORT $;

EXPORT mod_delta_rid := MODULE

  SHARED inFile := $.Layouts.Layout_Delta_Rid;
  
  EXPORT key_0010_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.keynames().Name_0010_Header_rid);
  EXPORT key_1000_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_1000_Executive_Summary_rid);
  EXPORT key_2000_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_2000_Trade_rid);
  EXPORT key_2015_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_2015_Trade_Payment_Totals_rid);
  EXPORT key_2020_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_2020_Trade_Payment_Trends_rid);
  EXPORT key_2025_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_2025_Trade_Quarterly_Avg_rid);
  EXPORT key_4010_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_4010_Bankruptcy_rid);
  EXPORT key_4020_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_4020_Tax_Liens_rid);
  EXPORT key_4030_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_4030_Judgement_rid);
  EXPORT key_4500_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_4500_Collateral_rid);
  EXPORT key_4510_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_4510_UCC_Filings_rid);
  EXPORT key_5000_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_5000_Bank_Details_rid);
  EXPORT key_5600_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_5600_Demographic_Data_rid);
  EXPORT key_5610_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_5610_Demographic_Data_rid);
  EXPORT key_6000_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_6000_Inquiries_rid);
  EXPORT key_6500_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_6500_Government_Trade_rid);
  EXPORT key_6510_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_6510_Government_Debarred_rid);
  EXPORT key_7010_delta_rid            := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_7010_SNP_Data_rid);
  EXPORT key_autokey_payload_delta_rid := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Name_Autokey_rid);
END;