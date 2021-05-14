import ebr, dx_EBR, RoxieKeyBuild;

export Proc_Build_Keys_Delta_Rids(string filedate) := function

    RoxieKeybuild.MAC_build_logical(
                                    dx_EBR.mod_delta_rid.key_0010_delta_rid 
                                    ,DATASET([],EBR.Layout_0010_Header_Base_AID)
                                    ,dx_EBR.Keynames().Name_0010_Header_RID
                                    ,EBR.keynames(filedate).Versions.k0010_header_delta_rid.new
                                    ,Build0010Key
                                    );

    RoxieKeybuild.MAC_build_logical(
																		dx_EBR.mod_delta_rid.key_1000_delta_rid
																		,DATASET([],EBR.Layout_1000_Executive_Summary_Base)
																		,dx_EBR.Keynames().Name_1000_Executive_Summary_RID
                                    ,EBR.keynames(filedate).Versions.k1000_Executive_Summary_delta_rid.new
																		,Build1000Key
																		);
																		 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_2000_delta_rid
																		,DATASET([],EBR.Layout_2000_Trade_Base)
																		,dx_EBR.Keynames().Name_2000_Trade_RID
																		,EBR.Keynames(filedate).Versions.k2000_Trade_delta_rid.new
																		,Build2000Key);
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_2015_delta_rid
																		,DATASET([],EBR.Layout_2015_Trade_Payment_Totals_Base)
																		,dx_EBR.Keynames().Name_2015_Trade_Payment_Totals_RID
																		,EBR.Keynames(filedate).Versions.k2015_Trade_Payment_Totals_delta_rid.new
																		,Build2015Key);
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_2020_delta_rid
																		,DATASET([],EBR.Layout_2020_Trade_Payment_Trends_Base)
																		,dx_EBR.Keynames().Name_2020_Trade_Payment_Trends_RID
																		,EBR.Keynames(filedate).Versions.k2020_Trade_Payment_Trends_delta_rid.new
																		,Build2020Key);
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_2025_delta_rid
																		,DATASET([],EBR.Layout_2025_Trade_Quarterly_Averages_Base)
																		,dx_EBR.Keynames().Name_2025_Trade_Quarterly_Avg_RID
																		,EBR.Keynames(filedate).Versions.k2025_Trade_Quarterly_Averages_delta_rid.new
																		,Build2025Key);
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_4010_delta_rid
																		,DATASET([],EBR.Layout_4010_Bankruptcy_Base)
																		,dx_EBR.Keynames().Name_4010_Bankruptcy_RID
																		,EBR.Keynames(filedate).Versions.k4010_Bankruptcy_delta_rid.new
																		,Build4010Key);
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_4020_delta_rid
																		,DATASET([],EBR.Layout_4020_Tax_Liens_Base)
																		,dx_EBR.Keynames().Name_4020_Tax_Liens_RID
																		,EBR.Keynames(filedate).Versions.k4020_Tax_Liens_delta_rid.new
																		,Build4020Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_4030_delta_rid
																		,DATASET([],EBR.Layout_4030_Judgement_Base)
																		,dx_EBR.Keynames().Name_4030_Judgement_RID
																		,EBR.Keynames(filedate).Versions.k4030_Judgement_delta_rid.new
																		,Build4030Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_4500_delta_rid
																		,DATASET([],EBR.Layout_4500_Collateral_Accounts_Base)
																		,dx_EBR.Keynames().Name_4500_Collateral_RID
																		,EBR.Keynames(filedate).Versions.k4500_Collateral_Accounts_delta_rid.new
																		,Build4500Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_4510_delta_rid
																		,DATASET([],EBR.Layout_4510_UCC_Filings_Base)
																		,dx_EBR.Keynames().Name_4510_UCC_Filings_RID
																		,EBR.Keynames(filedate).Versions.k4510_UCC_Filings_delta_rid.new
																		,Build4510Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_5000_delta_rid
																		,DATASET([],EBR.Layout_5000_Bank_Details_Base_AID)
																		,dx_EBR.Keynames().Name_5000_Bank_Details_RID
																		,EBR.Keynames(filedate).Versions.k5000_Bank_Details_delta_rid.new
																		,Build5000Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_5600_delta_rid
																		,DATASET([],EBR.Layout_5600_demographic_data_Base)
																		,dx_EBR.Keynames().Name_5600_Demographic_Data_RID
																		,EBR.Keynames(filedate).Versions.k5600_demographic_data_delta_rid.new
																		,Build5600Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_5610_delta_rid
																		,DATASET([],EBR.Layout_5610_demographic_data_Base)
																		,dx_EBR.Keynames().Name_5610_Demographic_Data_RID
																		,EBR.Keynames(filedate).Versions.k5610_demographic_data_delta_rid.new
																		,Build5610Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_6000_delta_rid
																		,DATASET([],EBR.Layout_6000_Inquiries_Base)
																		,dx_EBR.Keynames().Name_6000_Inquiries_RID
																		,EBR.Keynames(filedate).Versions.k6000_Inquiries_delta_rid.new
																		,Build6000Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_6500_delta_rid
																		,DATASET([],EBR.Layout_6500_Government_Trade_Base)
																		,dx_EBR.Keynames().Name_6500_Government_Trade_RID
																		,EBR.Keynames(filedate).Versions.k6500_Government_Trade_delta_rid.new
																		,Build6500Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_6510_delta_rid
																		,DATASET([],EBR.Layout_6510_Government_Debarred_Contractor_Base_AID)
																		,dx_EBR.Keynames().Name_6510_Government_Debarred_RID
																		,EBR.Keynames(filedate).Versions.k6510_Government_Debarred_delta_rid.new
																		,Build6510Key); 
																							 
 		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_7010_delta_rid
																		,DATASET([],EBR.Layout_7010_SNP_Data_Base)
																		,dx_EBR.Keynames().Name_7010_SNP_Data_RID
																		,EBR.Keynames(filedate).Versions.k7010_SNP_Data_delta_rid.new
																		,Build7010Key);
																							 
		RoxieKeyBuild.MAC_build_logical(dx_EBR.mod_delta_rid.key_autokey_payload_delta_rid
																		,DATASET([],EBR.Layout_0010_Header_Base_AID)
																		,dx_EBR.Keynames().Name_Autokey_RID
																		,EBR.Keynames(filedate).Versions.kAutokey_delta_rid.new
																		,BuildAutoKey);
																		
		buildKeys	:=	parallel(
														Build0010Key
														,Build1000Key
														,Build2000Key
														,Build2015Key
														,Build2020Key
														,Build2025Key
														,Build4010Key
														,Build4020Key
														,Build4030Key
														,Build4500Key
														,Build4510Key
														,Build5000Key
														,Build5600Key
														,Build5610Key
														,Build6000Key
														,Build6500Key
														,Build6510Key
														,Build7010Key
														,BuildAutoKey
														);
														
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k0010_header_delta_rid.New									
																				,EBR.KeyName_0010_Header_Delta_Rid	
																				,Move_0010_Header_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k1000_Executive_Summary_delta_rid.New									
																				,EBR.KeyName_1000_Executive_Summary_Delta_Rid	
																				,Move_1000_Executive_Summary_Delta_rid_key 
																				,2);		
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k2000_Trade_delta_rid.New									
																				,EBR.KeyName_2000_Trade_Delta_Rid	
																				,Move_2000_Trade_Delta_rid_key 
																				,2);
	
			RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k2015_Trade_Payment_Totals_delta_rid.New									
																				,EBR.KeyName_2015_Trade_Payment_Totals_Delta_Rid	
																				,Move_2015_Trade_Payment_Totals_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k2020_trade_payment_trends_delta_rid.New									
																				,EBR.KeyName_2020_trade_payment_trends_Delta_Rid	
																				,Move_2020_trade_payment_trends_Delta_rid_key 
																				,2);		
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k2025_trade_quarterly_averages_delta_rid.New									
																				,EBR.KeyName_2025_trade_quarterly_averages_Delta_Rid	
																				,Move_2025_trade_quarterly_averages_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k4010_bankruptcy_delta_rid.New									
																				,EBR.KeyName_4010_bankruptcy_Delta_Rid	
																				,Move_4010_bankruptcy_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k4020_tax_liens_delta_rid.New									
																				,EBR.KeyName_4020_tax_liens_Delta_Rid	
																				,Move_4020_tax_liens_Delta_rid_key 
																				,2);		
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k4030_judgement_delta_rid.New									
																				,EBR.KeyName_4030_judgement_Delta_Rid	
																				,Move_4030_judgement_Delta_rid_key 
																				,2);	
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k4500_collateral_accounts_delta_rid.New									
																				,EBR.KeyName_4500_collateral_accounts_Delta_Rid	
																				,Move_4500_collateral_accounts_Delta_rid_key 
																				,2);		
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k4510_ucc_filings_delta_rid.New									
																				,EBR.KeyName_4510_ucc_filings_Delta_Rid	
																				,Move_4510_ucc_filings_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k5000_bank_details_delta_rid.New									
																				,EBR.KeyName_5000_bank_details_Delta_Rid	
																				,Move_5000_bank_details_Delta_rid_key 
																				,2);		
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k5600_demographic_data_delta_rid.New									
																				,EBR.KeyName_5600_demographic_data_Delta_Rid	
																				,Move_5600_demographic_data_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k5610_demographic_data_delta_rid.New									
																				,EBR.KeyName_5610_demographic_data_Delta_Rid	
																				,Move_5610_demographic_data_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k6000_inquiries_delta_rid.New									
																				,EBR.KeyName_6000_inquiries_Delta_Rid	
																				,Move_6000_inquiries_Delta_rid_key 
																				,2);		
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k6500_government_trade_delta_rid.New									
																				,EBR.KeyName_6500_government_trade_Delta_Rid	
																				,Move_6500_government_trade_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k6510_government_debarred_delta_rid.New									
																				,EBR.KeyName_6510_government_debarred_Delta_Rid	
																				,Move_6510_government_debarred_Delta_rid_key 
																				,2);	
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.k7010_snp_data_delta_rid.New									
																				,EBR.KeyName_7010_snp_data_Delta_Rid	
																				,Move_7010_snp_data_Delta_rid_key 
																				,2);
																				
		RoxieKeyBuild.Mac_SK_Move_To_Built(	ebr.keynames(filedate).Versions.kAutokey_delta_rid.New									
																				,EBR.KeyName_Autokey_Delta_rid	
																				,Move_Auokey_Delta_rid_key 
																				,2);																					
																				
		moveKeys	:=	sequential(																		
															Move_0010_Header_Delta_rid_key
															,Move_1000_Executive_Summary_Delta_rid_key
															,Move_2000_Trade_Delta_rid_key
															,Move_2015_Trade_Payment_Totals_Delta_rid_key
															,Move_2020_trade_payment_trends_Delta_rid_key
															,Move_2025_trade_quarterly_averages_Delta_rid_key
															,Move_4010_bankruptcy_Delta_rid_key
															,Move_4020_tax_liens_Delta_rid_key
															,Move_4030_judgement_Delta_rid_key
															,Move_4500_collateral_accounts_Delta_rid_key
															,Move_4510_ucc_filings_Delta_rid_key
															,Move_5000_bank_details_Delta_rid_key
															,Move_5600_demographic_data_Delta_rid_key
															,Move_5610_demographic_data_Delta_rid_key
															,Move_6000_inquiries_Delta_rid_key
															,Move_6500_government_trade_Delta_rid_key
															,Move_6510_government_debarred_Delta_rid_key
															,Move_7010_snp_data_Delta_rid_key
															,Move_Auokey_Delta_rid_key
														);
																							 
    all_seq :=  sequential(
														BuildKeys
														,MoveKeys
													 );
																						
    return all_seq;
end;