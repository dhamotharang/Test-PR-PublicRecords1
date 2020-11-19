IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::1000_executive_summary::delta_rid','~prte::key::ebr::' + current_version + '::1000_executive_summary::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::2000_trade::delta_rid','~prte::key::ebr::' + current_version + '::2000_trade::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::2015_trade_payment_totals::delta_rid','~prte::key::ebr::' + current_version + '::2015_trade_payment_totals::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::2020_trade_payment_trends::delta_rid','~prte::key::ebr::' + current_version + '::2020_trade_payment_trends::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::2025_trade_quarterly_averages::delta_rid','~prte::key::ebr::' + current_version + '::2025_trade_quarterly_averages::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::4010_bankruptcy::delta_rid','~prte::key::ebr::' + current_version + '::4010_bankruptcy::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::4020_tax_liens::delta_rid','~prte::key::ebr::' + current_version + '::4020_tax_liens::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::4030_judgement::delta_rid','~prte::key::ebr::' + current_version + '::4030_judgement::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::4500_collateral_accounts::delta_rid','~prte::key::ebr::' + current_version + '::4500_collateral_accounts::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::4510_ucc_filings::delta_rid','~prte::key::ebr::' + current_version + '::4510_ucc_filings::delta_rid',dest_cluster); 
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::5000_bank_details::delta_rid','~prte::key::ebr::' + current_version + '::5000_bank_details::delta_rid',dest_cluster);   
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::5600_demographic_data::delta_rid','~prte::key::ebr::' + current_version + '::5600_demographic_data::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::5610_demographic_data::delta_rid','~prte::key::ebr::' + current_version + '::5610_demographic_data::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::6000_inquiries::delta_rid','~prte::key::ebr::' + current_version + '::6000_inquiries::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::6500_government_trade::delta_rid','~prte::key::ebr::' + current_version + '::6500_government_trade::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::6510_government_debarred::delta_rid','~prte::key::ebr::' + current_version + '::6510_government_debarred::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::7010_snp_data::delta_rid','~prte::key::ebr::' + current_version + '::7010_snp_data::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::autokey::delta_rid','~prte::key::ebr::' + current_version + '::autokey::delta_rid',dest_cluster);
CopyFiles1(data_services.foreign_prod + 'prte::key::ebr::protected::0010_header::delta_rid','~prte::key::ebr::' + current_version + '::0010_header::delta_rid',dest_cluster); 

                                                                                 
 RETURN 'Success';	
	END;
END;