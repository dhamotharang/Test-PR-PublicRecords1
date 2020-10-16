import $, data_services, tools;

export keynames(boolean  pUseOtherEnvironment  = false)   := module

  shared lkeyTemplate      := $.Constants(pUseOtherEnvironment).OldkeyTemplate;
 
  export Name_0010_Header               := lkeyTemplate  + '_0010_Header.Delta_RID_qa'; 
  export Name_1000_Executive_Summary    := lkeyTemplate  + '_1000_Executive_Summary.Delta_RID_qa';
  export Name_2000_Trade                := lkeyTemplate  + '_2000_Trade.Delta_RID_qa';
  export Name_2015_Trade_Payment_Totals := lkeyTemplate  + '_2015_trade_payment_totals.Delta_RID_qa';
  export Name_2020_Trade_Payment_Trends := lkeyTemplate  + '_2020_trade_payment_trends.Delta_RID_qa';
  export Name_2025_Trade_Quarterly_Avg  := lkeyTemplate  + '_2025_trade_quarterly_averages.Delta_RID_qa';
  export Name_4010_Bankruptcy           := lkeyTemplate  + '_4010_bankruptcy.Delta_RID_qa';
  export Name_4020_Tax_Liens            := lkeyTemplate  + '_4020_tax_liens.Delta_RID_qa';
  export Name_4030_Judgement            := lkeyTemplate  + '_4030_judgement.Delta_RID_qa';
  export Name_4500_Collateral           := lkeyTemplate  + '_4500_collateral_accounts.Delta_RID_qa';
  export Name_4510_UCC_Filings          := lkeyTemplate  + '_4510_ucc_filings.Delta_RID_qa';
  export Name_5000_Bank_Details         := lkeyTemplate  + '_5000_bank_details.Delta_RID_qa';
  export Name_5600_Demographic_Data     := lkeyTemplate  + '_5600_demographic_data.Delta_RID_qa';
  export Name_5610_Demographic_Data     := lkeyTemplate  + '_5610_demographic_data.Delta_RID_qa';
  export Name_6000_Inquiries            := lkeyTemplate  + '_6000_inquiries.Delta_RID_qa';
  export Name_6500_Government_Trade     := lkeyTemplate  + '_6500_government_trade.Delta_RID_qa';
  export Name_6510_Government_Debarred  := lkeyTemplate  + '_6510_government_debarred_contractor.Delta_RID_qa';
  export Name_7010_SNP_Data             := lkeyTemplate  + '_7010_snp_data.Delta_RID_qa';
  export Name_Autokey                   := lkeyTemplate  + '_Autokey.Delta_RID_qa';
end;