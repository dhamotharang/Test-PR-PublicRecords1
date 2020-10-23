import $, data_services, tools;

export keynames(boolean  pUseOtherEnvironment  = false)   := module

  shared lkeyTemplate      := $.Constants(pUseOtherEnvironment).OldkeyTemplate;
 
  export Name_0010_Header_RID               := lkeyTemplate  + '_0010_Header.Delta_RID_qa'; 
  export Name_1000_Executive_Summary_RID    := lkeyTemplate  + '_1000_Executive_Summary.Delta_RID_qa';
  export Name_2000_Trade_RID                := lkeyTemplate  + '_2000_Trade.Delta_RID_qa';
  export Name_2015_Trade_Payment_Totals_RID := lkeyTemplate  + '_2015_trade_payment_totals.Delta_RID_qa';
  export Name_2020_Trade_Payment_Trends_RID := lkeyTemplate  + '_2020_trade_payment_trends.Delta_RID_qa';
  export Name_2025_Trade_Quarterly_Avg_RID  := lkeyTemplate  + '_2025_trade_quarterly_averages.Delta_RID_qa';
  export Name_4010_Bankruptcy_RID           := lkeyTemplate  + '_4010_bankruptcy.Delta_RID_qa';
  export Name_4020_Tax_Liens_RID            := lkeyTemplate  + '_4020_tax_liens.Delta_RID_qa';
  export Name_4030_Judgement_RID            := lkeyTemplate  + '_4030_judgement.Delta_RID_qa';
  export Name_4500_Collateral_RID           := lkeyTemplate  + '_4500_collateral_accounts.Delta_RID_qa';
  export Name_4510_UCC_Filings_RID          := lkeyTemplate  + '_4510_ucc_filings.Delta_RID_qa';
  export Name_5000_Bank_Details_RID         := lkeyTemplate  + '_5000_bank_details.Delta_RID_qa';
  export Name_5600_Demographic_Data_RID     := lkeyTemplate  + '_5600_demographic_data.Delta_RID_qa';
  export Name_5610_Demographic_Data_RID     := lkeyTemplate  + '_5610_demographic_data.Delta_RID_qa';
  export Name_6000_Inquiries_RID            := lkeyTemplate  + '_6000_inquiries.Delta_RID_qa';
  export Name_6500_Government_Trade_RID     := lkeyTemplate  + '_6500_government_trade.Delta_RID_qa';
  export Name_6510_Government_Debarred_RID  := lkeyTemplate  + '_6510_government_debarred_contractor.Delta_RID_qa';
  export Name_7010_SNP_Data_RID             := lkeyTemplate  + '_7010_snp_data.Delta_RID_qa';
  export Name_Autokey_RID                   := lkeyTemplate  + '_Autokey.Delta_RID_qa';
end;