import ut;
export Filenames :=
module

	export Templates :=
	module
		shared ebr_segments(string4 built_type) :=
		module
			shared root := ebr_thor + trim(built_type) + '::'	+ dataset_name + '::@version@::';
			
			export s0010_header                            := root + '0010_header';
			export s1000_executive_summary                 := root + '1000_executive_summary';
			export s2000_trade                             := root + '2000_trade';
			export s2015_trade_payment_totals              := root + '2015_trade_payment_totals';
			export s2020_trade_payment_trends              := root + '2020_trade_payment_trends';
			export s2025_trade_quarterly_averages          := root + '2025_trade_quarterly_averages';
			export s4010_bankruptcy                        := root + '4010_bankruptcy';
			export s4020_tax_liens                         := root + '4020_tax_liens';
			export s4030_judgement                         := root + '4030_judgement';
			export s4035_attachment_lien                   := root + '4035_attachment_lien';
			export s4040_bulk_transfers                    := root + '4040_bulk_transfers';
			export s4500_collateral_accounts               := root + '4500_collateral_accounts';
			export s4510_ucc_filings                       := root + '4510_ucc_filings';
			export s5000_bank_details                      := root + '5000_bank_details';
			export s5600_demographic_data                  := root + '5600_demographic_data';
			export s5610_demographic_data                  := root + '5610_demographic_data';
			export s6000_inquiries                         := root + '6000_inquiries';
			export s6500_government_trade                  := root + '6500_government_trade';
			export s6510_government_debarred_contractor    := root + '6510_government_debarred_contractor';
			export s7000_snp_parent_name_address           := root + '7000_snp_parent_name_address';
			export s7010_snp_data                          := root + '7010_snp_data';

			export dAll_templates := 
			dataset([

				 s0010_header                        
				,s1000_executive_summary             
				,s2000_trade                         
				,s2015_trade_payment_totals          
				,s2020_trade_payment_trends          
				,s2025_trade_quarterly_averages      
				,s4010_bankruptcy                    
				,s4020_tax_liens                     
				,s4030_judgement                     
				,s4035_attachment_lien               
				,s4040_bulk_transfers                
				,s4500_collateral_accounts           
				,s4510_ucc_filings                   
				,s5000_bank_details                  
				,s5600_demographic_data              
				,s5610_demographic_data              
				,s6000_inquiries                     
				,s6500_government_trade              
				,s6510_government_debarred_contractor
				,s7000_snp_parent_name_address       
				,s7010_snp_data                      
			
			], ut.Layout_Names);
		end;
		
		export Input	:= ebr_segments('in');
		export Base		:= ebr_segments('base');

	end;


	export Input := 
	module
		export s0010_header                        := ut.mInputfilenameversions(Templates.Input.s0010_header                        );
		export s1000_executive_summary             := ut.mInputfilenameversions(Templates.Input.s1000_executive_summary             );
		export s2000_trade                         := ut.mInputfilenameversions(Templates.Input.s2000_trade                         );
		export s2015_trade_payment_totals          := ut.mInputfilenameversions(Templates.Input.s2015_trade_payment_totals          );
		export s2020_trade_payment_trends          := ut.mInputfilenameversions(Templates.Input.s2020_trade_payment_trends          );
		export s2025_trade_quarterly_averages      := ut.mInputfilenameversions(Templates.Input.s2025_trade_quarterly_averages      );
		export s4010_bankruptcy                    := ut.mInputfilenameversions(Templates.Input.s4010_bankruptcy                    );
		export s4020_tax_liens                     := ut.mInputfilenameversions(Templates.Input.s4020_tax_liens                     );
		export s4030_judgement                     := ut.mInputfilenameversions(Templates.Input.s4030_judgement                     );
		export s4035_attachment_lien               := ut.mInputfilenameversions(Templates.Input.s4035_attachment_lien               );
		export s4040_bulk_transfers                := ut.mInputfilenameversions(Templates.Input.s4040_bulk_transfers                );
		export s4500_collateral_accounts           := ut.mInputfilenameversions(Templates.Input.s4500_collateral_accounts           );
		export s4510_ucc_filings                   := ut.mInputfilenameversions(Templates.Input.s4510_ucc_filings                   );
		export s5000_bank_details                  := ut.mInputfilenameversions(Templates.Input.s5000_bank_details                  );
		export s5600_demographic_data              := ut.mInputfilenameversions(Templates.Input.s5600_demographic_data              );
		export s5610_demographic_data              := ut.mInputfilenameversions(Templates.Input.s5610_demographic_data              );
		export s6000_inquiries                     := ut.mInputfilenameversions(Templates.Input.s6000_inquiries                     );
		export s6500_government_trade              := ut.mInputfilenameversions(Templates.Input.s6500_government_trade              );
		export s6510_government_debarred_contractor:= ut.mInputfilenameversions(Templates.Input.s6510_government_debarred_contractor);
		export s7000_snp_parent_name_address       := ut.mInputfilenameversions(Templates.Input.s7000_snp_parent_name_address       );
		export s7010_snp_data                      := ut.mInputfilenameversions(Templates.Input.s7010_snp_data                      );
		
		export dAll_superfilenames :=
			  s0010_header.dAll_superfilenames                     
			+ s1000_executive_summary.dAll_superfilenames    
			+ s2000_trade.dAll_superfilenames            
			+ s2015_trade_payment_totals.dAll_superfilenames     
			+ s2020_trade_payment_trends.dAll_superfilenames
			+ s2025_trade_quarterly_averages.dAll_superfilenames
			+ s4010_bankruptcy.dAll_superfilenames
			+ s4020_tax_liens.dAll_superfilenames
			+ s4030_judgement.dAll_superfilenames 
			+ s4035_attachment_lien.dAll_superfilenames
			+ s4040_bulk_transfers.dAll_superfilenames
			+ s4500_collateral_accounts.dAll_superfilenames
			+ s4510_ucc_filings.dAll_superfilenames
			+ s5000_bank_details.dAll_superfilenames
			+ s5600_demographic_data.dAll_superfilenames
			+ s5610_demographic_data.dAll_superfilenames
			+ s6000_inquiries.dAll_superfilenames
			+ s6500_government_trade.dAll_superfilenames 
			+ s6510_government_debarred_contractor.dAll_superfilenames
			+ s7000_snp_parent_name_address.dAll_superfilenames
			+ s7010_snp_data.dAll_superfilenames                       
			;


	end;                                                                        

	export Base := 
	module
		export s0010_header                        := ut.mBuildfilenameversions(Templates.Base.s0010_header,						version);
		export s1000_executive_summary             := ut.mBuildfilenameversions(Templates.Base.s1000_executive_summary, 			version);
		export s2000_trade                         := ut.mBuildfilenameversions(Templates.Base.s2000_trade, 						version);
		export s2015_trade_payment_totals          := ut.mBuildfilenameversions(Templates.Base.s2015_trade_payment_totals, 			version);
		export s2020_trade_payment_trends          := ut.mBuildfilenameversions(Templates.Base.s2020_trade_payment_trends, 			version);
		export s2025_trade_quarterly_averages      := ut.mBuildfilenameversions(Templates.Base.s2025_trade_quarterly_averages,		version);
		export s4010_bankruptcy                    := ut.mBuildfilenameversions(Templates.Base.s4010_bankruptcy,					version);
		export s4020_tax_liens                     := ut.mBuildfilenameversions(Templates.Base.s4020_tax_liens,						version);
		export s4030_judgement                     := ut.mBuildfilenameversions(Templates.Base.s4030_judgement,						version);
		export s4035_attachment_lien               := ut.mBuildfilenameversions(Templates.Base.s4035_attachment_lien,				version);
		export s4040_bulk_transfers                := ut.mBuildfilenameversions(Templates.Base.s4040_bulk_transfers,				version);
		export s4500_collateral_accounts           := ut.mBuildfilenameversions(Templates.Base.s4500_collateral_accounts,			version);
		export s4510_ucc_filings                   := ut.mBuildfilenameversions(Templates.Base.s4510_ucc_filings,					version);
		export s5000_bank_details                  := ut.mBuildfilenameversions(Templates.Base.s5000_bank_details,					version);
		export s5600_demographic_data              := ut.mBuildfilenameversions(Templates.Base.s5600_demographic_data,				version);
		export s5610_demographic_data              := ut.mBuildfilenameversions(Templates.Base.s5610_demographic_data,				version);
		export s6000_inquiries                     := ut.mBuildfilenameversions(Templates.Base.s6000_inquiries,						version);
		export s6500_government_trade              := ut.mBuildfilenameversions(Templates.Base.s6500_government_trade,				version);
		export s6510_government_debarred_contractor:= ut.mBuildfilenameversions(Templates.Base.s6510_government_debarred_contractor,version);
		export s7000_snp_parent_name_address       := ut.mBuildfilenameversions(Templates.Base.s7000_snp_parent_name_address,		version);
		export s7010_snp_data                      := ut.mBuildfilenameversions(Templates.Base.s7010_snp_data,						version);

		export dAll_superfilenames :=
			  s0010_header.dAll_superfilenames                     
			+ s1000_executive_summary.dAll_superfilenames    
			+ s2000_trade.dAll_superfilenames            
			+ s2015_trade_payment_totals.dAll_superfilenames     
			+ s2020_trade_payment_trends.dAll_superfilenames
			+ s2025_trade_quarterly_averages.dAll_superfilenames
			+ s4010_bankruptcy.dAll_superfilenames
			+ s4020_tax_liens.dAll_superfilenames
			+ s4030_judgement.dAll_superfilenames 
			+ s4035_attachment_lien.dAll_superfilenames
			+ s4040_bulk_transfers.dAll_superfilenames
			+ s4500_collateral_accounts.dAll_superfilenames
			+ s4510_ucc_filings.dAll_superfilenames
			+ s5000_bank_details.dAll_superfilenames
			+ s5600_demographic_data.dAll_superfilenames
			+ s5610_demographic_data.dAll_superfilenames
			+ s6000_inquiries.dAll_superfilenames
			+ s6500_government_trade.dAll_superfilenames 
			+ s6510_government_debarred_contractor.dAll_superfilenames
			+ s7000_snp_parent_name_address.dAll_superfilenames
			+ s7010_snp_data.dAll_superfilenames                       
			;
		end;                                                                        

	export dAll_superfilenames :=
		  Input.dAll_superfilenames                     
		+ Base.dAll_superfilenames    
		;

end;