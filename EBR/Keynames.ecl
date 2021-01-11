import tools;
export Keynames(string filedate) :=
module

	export Templates :=
	module
		shared root := ebr_thor + 'key::'	+ dataset_name + '::@version@::';
		
    export s0010_header_bdid                                   :=  root + '0010_header::bdid';
    export s0010_header_file_number                            :=  root + '0010_header::file_number';
    export s0010_header_delta_rid                              :=  root + '0010_header::delta_rid';
    export s1000_executive_summary_bdid                        :=  root + '1000_executive_summary::bdid';
    export s1000_executive_summary_file_number                 :=  root + '1000_executive_summary::file_number';
    export s1000_executive_summary_delta_rid                   :=  root + '1000_executive_summary::delta_rid';
    export s2000_trade_bdid                                    :=  root + '2000_trade::bdid';
    export s2000_trade_file_number                             :=  root + '2000_trade::file_number';
    export s2000_trade_delta_rid                               :=  root + '2000_trade::delta_rid';
    export s2015_trade_payment_totals_bdid                     :=  root + '2015_trade_payment_totals::bdid';
    export s2015_trade_payment_totals_file_number              :=  root + '2015_trade_payment_totals::file_number';
    export s2015_trade_payment_totals_delta_rid                :=  root + '2015_trade_payment_totals::delta_rid';
    export s2020_trade_payment_trends_bdid                     :=  root + '2020_trade_payment_trends::bdid';
    export s2020_trade_payment_trends_file_number              :=  root + '2020_trade_payment_trends::file_number';
    export s2020_trade_payment_trends_delta_rid                :=  root + '2020_trade_payment_trends::delta_rid';
    export s2025_trade_quarterly_averages_bdid                 :=  root + '2025_trade_quarterly_averages::bdid';
    export s2025_trade_quarterly_averages_file_number          :=  root + '2025_trade_quarterly_averages::file_number';
    export s2025_trade_quarterly_averages_delta_rid            :=  root + '2025_trade_quarterly_averages::delta_rid';
    export s4010_bankruptcy_bdid                               :=  root + '4010_bankruptcy::bdid';
    export s4010_bankruptcy_file_number                        :=  root + '4010_bankruptcy::file_number';
    export s4010_bankruptcy_delta_rid                          :=  root + '4010_bankruptcy::delta_rid';
    export s4020_tax_liens_bdid                                :=  root + '4020_tax_liens::bdid';
    export s4020_tax_liens_file_number                         :=  root + '4020_tax_liens::file_number';
    export s4020_tax_liens_delta_rid                           :=  root + '4020_tax_liens::delta_rid';
    export s4030_judgement_bdid                                :=  root + '4030_judgement::bdid';
    export s4030_judgement_file_number                         :=  root + '4030_judgement::file_number';
    export s4030_judgement_delta_rid                           :=  root + '4030_judgement::delta_rid';
    export s4035_attachment_lien_bdid                          :=  root + '4035_attachment_lien::bdid';
    export s4035_attachment_lien_file_number                   :=  root + '4035_attachment_lien::file_number';
    export s4040_bulk_transfers_bdid                           :=  root + '4040_bulk_transfers::bdid';
    export s4040_bulk_transfers_file_number                    :=  root + '4040_bulk_transfers::file_number';
    export s4500_collateral_accounts_bdid                      :=  root + '4500_collateral_accounts::bdid';
    export s4500_collateral_accounts_file_number               :=  root + '4500_collateral_accounts::file_number';
    export s4500_collateral_accounts_delta_rid                 :=  root + '4500_collateral_accounts::delta_rid';
    export s4510_ucc_filings_bdid                              :=  root + '4510_ucc_filings::bdid';
    export s4510_ucc_filings_file_number                       :=  root + '4510_ucc_filings::file_number';
    export s4510_ucc_filings_delta_rid                         :=  root + '4510_ucc_filings::delta_rid';
    export s5000_bank_details_bdid                             :=  root + '5000_bank_details::bdid';
    export s5000_bank_details_file_number                      :=  root + '5000_bank_details::file_number';
    export s5000_bank_details_delta_rid                        :=  root + '5000_bank_details::delta_rid';
    export s5600_demographic_data_bdid                         :=  root + '5600_demographic_data::bdid';
    export s5600_demographic_data_file_number                  :=  root + '5600_demographic_data::file_number';
    export s5600_demographic_data_delta_rid                    :=  root + '5600_demographic_data::delta_rid';
    export s5610_demographic_data_bdid                         :=  root + '5610_demographic_data::bdid';
    export s5610_demographic_data_did                          :=  root + '5610_demographic_data::did';
    export s5610_demographic_data_file_number                  :=  root + '5610_demographic_data::file_number';
    export s5610_demographic_data_ssn                          :=  root + '5610_demographic_data::ssn';
    export s5610_demographic_data_delta_rid                    :=  root + '5610_demographic_data::delta_rid';
    export s6000_inquiries_bdid                                :=  root + '6000_inquiries::bdid';
    export s6000_inquiries_file_number                         :=  root + '6000_inquiries::file_number';
    export s6000_inquiries_delta_rid                           :=  root + '6000_inquiries::delta_rid';
    export s6500_government_trade_bdid                         :=  root + '6500_government_trade::bdid';
    export s6500_government_trade_file_number                  :=  root + '6500_government_trade::file_number';
    export s6500_government_trade_delta_rid                    :=  root + '6500_government_trade::delta_rid';
    export s6510_government_debarred_contractor_bdid           :=  root + '6510_government_debarred_contractor::bdid';
    export s6510_government_debarred_contractor_file_number    :=  root + '6510_government_debarred_contractor::file_number';
    export s6510_government_debarred_delta_rid                 :=  root + '6510_government_debarred::delta_rid';
    export s7000_snp_parent_name_address_bdid                  :=  root + '7000_snp_parent_name_address::bdid';
    export s7000_snp_parent_name_address_file_number           :=  root + '7000_snp_parent_name_address::file_number';
    export s7010_snp_data_bdid                                 :=  root + '7010_snp_data::bdid';
    export s7010_snp_data_file_number                          :=  root + '7010_snp_data::file_number';
    export s7010_snp_data_delta_rid                            :=  root + '7010_snp_data::delta_rid';
    export sAutokey_delta_rid                                  :=  root + 'Autokey::delta_rid';


		export dAll_templates := 
		dataset([

	     s0010_header_bdid
      ,s0010_header_file_number
      ,s0010_header_delta_rid
      ,s1000_executive_summary_bdid
      ,s1000_executive_summary_file_number
      ,s1000_executive_summary_delta_rid
      ,s2000_trade_bdid
      ,s2000_trade_file_number
      ,s2000_trade_delta_rid
      ,s2015_trade_payment_totals_bdid
      ,s2015_trade_payment_totals_file_number
      ,s2015_trade_payment_totals_delta_rid
      ,s2020_trade_payment_trends_bdid
      ,s2020_trade_payment_trends_file_number
      ,s2020_trade_payment_trends_delta_rid
      ,s2025_trade_quarterly_averages_bdid
      ,s2025_trade_quarterly_averages_file_number
      ,s2025_trade_quarterly_averages_delta_rid
      ,s4010_bankruptcy_bdid
      ,s4010_bankruptcy_file_number
      ,s4010_bankruptcy_delta_rid
      ,s4020_tax_liens_bdid
      ,s4020_tax_liens_file_number
      ,s4020_tax_liens_delta_rid
      ,s4030_judgement_bdid
      ,s4030_judgement_file_number
      ,s4030_judgement_delta_rid
      ,s4035_attachment_lien_bdid
      ,s4035_attachment_lien_file_number
      ,s4040_bulk_transfers_bdid
      ,s4040_bulk_transfers_file_number
      ,s4500_collateral_accounts_bdid
      ,s4500_collateral_accounts_file_number
      ,s4500_collateral_accounts_delta_rid
      ,s4510_ucc_filings_bdid
      ,s4510_ucc_filings_file_number
      ,s4510_ucc_filings_delta_rid
      ,s5000_bank_details_bdid
      ,s5000_bank_details_file_number
      ,s5000_bank_details_delta_rid
      ,s5600_demographic_data_bdid
      ,s5600_demographic_data_file_number
      ,s5600_demographic_data_delta_rid
      ,s5610_demographic_data_bdid
      ,s5610_demographic_data_did
      ,s5610_demographic_data_file_number
      ,s5610_demographic_data_ssn
      ,s5610_demographic_data_delta_rid
      ,s6000_inquiries_bdid
      ,s6000_inquiries_file_number
      ,s6000_inquiries_delta_rid
      ,s6500_government_trade_bdid
      ,s6500_government_trade_file_number
      ,s6500_government_trade_delta_rid
      ,s6510_government_debarred_contractor_bdid
      ,s6510_government_debarred_contractor_file_number
      ,s6510_government_debarred_delta_rid
      ,s7000_snp_parent_name_address_bdid
      ,s7000_snp_parent_name_address_file_number
      ,s7010_snp_data_bdid
      ,s7010_snp_data_file_number
      ,s7010_snp_data_delta_rid
      ,sAutokey_delta_rid

		
		], tools.Layout_Names);

	end;


	//////////////////////////////////////////////////////////////////
	// -- Member Key Filenames
	//////////////////////////////////////////////////////////////////
  export Versions  := 
  module
    export k0010_header_bdid                                   :=  tools.mod_FilenamesBuild(Templates.s0010_header_bdid,filedate);
    export k0010_header_file_number                            :=  tools.mod_FilenamesBuild(Templates.s0010_header_file_number,filedate);
    export k0010_header_delta_rid                              :=  tools.mod_FilenamesBuild(Templates.s0010_header_delta_rid,filedate);
    export k1000_executive_summary_bdid                        :=  tools.mod_FilenamesBuild(Templates.s1000_executive_summary_bdid,filedate);
    export k1000_executive_summary_file_number                 :=  tools.mod_FilenamesBuild(Templates.s1000_executive_summary_file_number,filedate);
    export k1000_executive_summary_delta_rid                   :=  tools.mod_FilenamesBuild(Templates.s1000_executive_summary_delta_rid,filedate);
    export k2000_trade_bdid                                    :=  tools.mod_FilenamesBuild(Templates.s2000_trade_bdid,filedate);
    export k2000_trade_file_number                             :=  tools.mod_FilenamesBuild(Templates.s2000_trade_file_number,filedate);
    export k2000_trade_delta_rid                               :=  tools.mod_FilenamesBuild(Templates.s2000_trade_delta_rid,filedate);
    export k2015_trade_payment_totals_bdid                     :=  tools.mod_FilenamesBuild(Templates.s2015_trade_payment_totals_bdid,filedate);
    export k2015_trade_payment_totals_file_number              :=  tools.mod_FilenamesBuild(Templates.s2015_trade_payment_totals_file_number,filedate);
    export k2015_trade_payment_totals_delta_rid                :=  tools.mod_FilenamesBuild(Templates.s2015_trade_payment_totals_delta_rid,filedate);
    export k2020_trade_payment_trends_bdid                     :=  tools.mod_FilenamesBuild(Templates.s2020_trade_payment_trends_bdid,filedate);
    export k2020_trade_payment_trends_file_number              :=  tools.mod_FilenamesBuild(Templates.s2020_trade_payment_trends_file_number,filedate);
    export k2020_trade_payment_trends_delta_rid                :=  tools.mod_FilenamesBuild(Templates.s2020_trade_payment_trends_delta_rid,filedate);
    export k2025_trade_quarterly_averages_bdid                 :=  tools.mod_FilenamesBuild(Templates.s2025_trade_quarterly_averages_bdid,filedate);
    export k2025_trade_quarterly_averages_file_number          :=  tools.mod_FilenamesBuild(Templates.s2025_trade_quarterly_averages_file_number,filedate);
    export k2025_trade_quarterly_averages_delta_rid            :=  tools.mod_FilenamesBuild(Templates.s2025_trade_quarterly_averages_delta_rid,filedate);
    export k4010_bankruptcy_bdid                               :=  tools.mod_FilenamesBuild(Templates.s4010_bankruptcy_bdid,filedate);
    export k4010_bankruptcy_file_number                        :=  tools.mod_FilenamesBuild(Templates.s4010_bankruptcy_file_number,filedate);
    export k4010_bankruptcy_delta_rid                          :=  tools.mod_FilenamesBuild(Templates.s4010_bankruptcy_delta_rid,filedate);
    export k4020_tax_liens_bdid                                :=  tools.mod_FilenamesBuild(Templates.s4020_tax_liens_bdid,filedate);
    export k4020_tax_liens_file_number                         :=  tools.mod_FilenamesBuild(Templates.s4020_tax_liens_file_number,filedate);
    export k4020_tax_liens_delta_rid                           :=  tools.mod_FilenamesBuild(Templates.s4020_tax_liens_delta_rid,filedate);
    export k4030_judgement_bdid                                :=  tools.mod_FilenamesBuild(Templates.s4030_judgement_bdid,filedate);
    export k4030_judgement_file_number                         :=  tools.mod_FilenamesBuild(Templates.s4030_judgement_file_number,filedate);
    export k4030_judgement_delta_rid                           :=  tools.mod_FilenamesBuild(Templates.s4030_judgement_delta_rid,filedate);
    export k4035_attachment_lien_bdid                          :=  tools.mod_FilenamesBuild(Templates.s4035_attachment_lien_bdid,filedate);
    export k4035_attachment_lien_file_number                   :=  tools.mod_FilenamesBuild(Templates.s4035_attachment_lien_file_number,filedate);
    export k4040_bulk_transfers_bdid                           :=  tools.mod_FilenamesBuild(Templates.s4040_bulk_transfers_bdid,filedate);
    export k4040_bulk_transfers_file_number                    :=  tools.mod_FilenamesBuild(Templates.s4040_bulk_transfers_file_number,filedate);
    export k4500_collateral_accounts_bdid                      :=  tools.mod_FilenamesBuild(Templates.s4500_collateral_accounts_bdid,filedate);
    export k4500_collateral_accounts_file_number               :=  tools.mod_FilenamesBuild(Templates.s4500_collateral_accounts_file_number,filedate);
    export k4500_collateral_accounts_delta_rid                 :=  tools.mod_FilenamesBuild(Templates.s4500_collateral_accounts_delta_rid,filedate);
    export k4510_ucc_filings_bdid                              :=  tools.mod_FilenamesBuild(Templates.s4510_ucc_filings_bdid,filedate);
    export k4510_ucc_filings_file_number                       :=  tools.mod_FilenamesBuild(Templates.s4510_ucc_filings_file_number,filedate);
    export k4510_ucc_filings_delta_rid                         :=  tools.mod_FilenamesBuild(Templates.s4510_ucc_filings_delta_rid,filedate);
    export k5000_bank_details_bdid                             :=  tools.mod_FilenamesBuild(Templates.s5000_bank_details_bdid,filedate);
    export k5000_bank_details_file_number                      :=  tools.mod_FilenamesBuild(Templates.s5000_bank_details_file_number,filedate);
    export k5000_bank_details_delta_rid                        :=  tools.mod_FilenamesBuild(Templates.s5000_bank_details_delta_rid,filedate);
    export k5600_demographic_data_bdid                         :=  tools.mod_FilenamesBuild(Templates.s5600_demographic_data_bdid,filedate);
    export k5600_demographic_data_file_number                  :=  tools.mod_FilenamesBuild(Templates.s5600_demographic_data_file_number,filedate);
    export k5600_demographic_data_delta_rid                    :=  tools.mod_FilenamesBuild(Templates.s5600_demographic_data_delta_rid,filedate);
    export k5610_demographic_data_bdid                         :=  tools.mod_FilenamesBuild(Templates.s5610_demographic_data_bdid,filedate);
    export k5610_demographic_data_did                          :=  tools.mod_FilenamesBuild(Templates.s5610_demographic_data_did,filedate);
    export k5610_demographic_data_file_number                  :=  tools.mod_FilenamesBuild(Templates.s5610_demographic_data_file_number,filedate);
    export k5610_demographic_data_ssn                          :=  tools.mod_FilenamesBuild(Templates.s5610_demographic_data_ssn,filedate);
    export k5610_demographic_data_delta_rid                    :=  tools.mod_FilenamesBuild(Templates.s5610_demographic_data_delta_rid,filedate);
    export k6000_inquiries_bdid                                :=  tools.mod_FilenamesBuild(Templates.s6000_inquiries_bdid,filedate);
    export k6000_inquiries_file_number                         :=  tools.mod_FilenamesBuild(Templates.s6000_inquiries_file_number,filedate);
    export k6000_inquiries_delta_rid                           :=  tools.mod_FilenamesBuild(Templates.s6000_inquiries_delta_rid,filedate);
    export k6500_government_trade_bdid                         :=  tools.mod_FilenamesBuild(Templates.s6500_government_trade_bdid,filedate);
    export k6500_government_trade_file_number                  :=  tools.mod_FilenamesBuild(Templates.s6500_government_trade_file_number,filedate);
    export k6500_government_trade_delta_rid                    :=  tools.mod_FilenamesBuild(Templates.s6500_government_trade_delta_rid,filedate);
    export k6510_government_debarred_contractor_bdid           :=  tools.mod_FilenamesBuild(Templates.s6510_government_debarred_contractor_bdid,filedate);
    export k6510_government_debarred_contractor_file_number    :=  tools.mod_FilenamesBuild(Templates.s6510_government_debarred_contractor_file_number,filedate);
    export k6510_government_debarred_delta_rid                 :=  tools.mod_FilenamesBuild(Templates.s6510_government_debarred_delta_rid,filedate);
    export k7000_snp_parent_name_address_bdid                  :=  tools.mod_FilenamesBuild(Templates.s7000_snp_parent_name_address_bdid,filedate);
    export k7000_snp_parent_name_address_file_number           :=  tools.mod_FilenamesBuild(Templates.s7000_snp_parent_name_address_file_number,filedate);
    export k7010_snp_data_bdid                                 :=  tools.mod_FilenamesBuild(Templates.s7010_snp_data_bdid,filedate);
    export k7010_snp_data_file_number                          :=  tools.mod_FilenamesBuild(Templates.s7010_snp_data_file_number,filedate);
    export k7010_snp_data_delta_rid                            :=  tools.mod_FilenamesBuild(Templates.s7010_snp_data_delta_rid,filedate);
    export kAutokey_delta_rid                                  :=  tools.mod_FilenamesBuild(Templates.sAutokey_delta_rid,filedate);
	end;
	
	export dAll_superfilenames :=
      versions.k0010_header_bdid.dAll_superfilenames
    + versions.k0010_header_file_number.dAll_superfilenames
    + versions.k0010_header_delta_rid.dAll_superfilenames
    + versions.k1000_executive_summary_bdid.dAll_superfilenames
    + versions.k1000_executive_summary_file_number.dAll_superfilenames
    + versions.k1000_executive_summary_delta_rid.dAll_superfilenames
    + versions.k2000_trade_bdid.dAll_superfilenames
    + versions.k2000_trade_file_number.dAll_superfilenames
    + versions.k2000_trade_delta_rid.dAll_superfilenames
    + versions.k2015_trade_payment_totals_bdid.dAll_superfilenames
    + versions.k2015_trade_payment_totals_file_number.dAll_superfilenames
    + versions.k2015_trade_payment_totals_delta_rid.dAll_superfilenames
    + versions.k2020_trade_payment_trends_bdid.dAll_superfilenames
    + versions.k2020_trade_payment_trends_file_number.dAll_superfilenames
    + versions.k2020_trade_payment_trends_delta_rid.dAll_superfilenames
    + versions.k2025_trade_quarterly_averages_bdid.dAll_superfilenames
    + versions.k2025_trade_quarterly_averages_file_number.dAll_superfilenames
    + versions.k2025_trade_quarterly_averages_delta_rid.dAll_superfilenames
    + versions.k4010_bankruptcy_bdid.dAll_superfilenames
    + versions.k4010_bankruptcy_file_number.dAll_superfilenames
    + versions.k4010_bankruptcy_delta_rid.dAll_superfilenames
    + versions.k4020_tax_liens_file_number.dAll_superfilenames
    + versions.k4020_tax_liens_delta_rid.dAll_superfilenames
    + versions.k4030_judgement_bdid.dAll_superfilenames
    + versions.k4030_judgement_file_number.dAll_superfilenames
    + versions.k4030_judgement_delta_rid.dAll_superfilenames
    + versions.k4035_attachment_lien_bdid.dAll_superfilenames
    + versions.k4035_attachment_lien_file_number.dAll_superfilenames
    + versions.k4040_bulk_transfers_bdid.dAll_superfilenames
    + versions.k4040_bulk_transfers_file_number.dAll_superfilenames
    + versions.k4500_collateral_accounts_bdid.dAll_superfilenames
    + versions.k4500_collateral_accounts_file_number.dAll_superfilenames
    + versions.k4500_collateral_accounts_delta_rid.dAll_superfilenames
    + versions.k4510_ucc_filings_bdid.dAll_superfilenames
    + versions.k4510_ucc_filings_file_number.dAll_superfilenames
    + versions.k4510_ucc_filings_delta_rid.dAll_superfilenames
    + versions.k5000_bank_details_bdid.dAll_superfilenames
    + versions.k5000_bank_details_file_number.dAll_superfilenames
    + versions.k5000_bank_details_delta_rid.dAll_superfilenames
    + versions.k5600_demographic_data_bdid.dAll_superfilenames
    + versions.k5600_demographic_data_file_number.dAll_superfilenames
    + versions.k5600_demographic_data_delta_rid.dAll_superfilenames
    + versions.k5610_demographic_data_bdid.dAll_superfilenames
    + versions.k5610_demographic_data_did.dAll_superfilenames
    + versions.k5610_demographic_data_file_number.dAll_superfilenames
    + versions.k5610_demographic_data_ssn.dAll_superfilenames
    + versions.k5610_demographic_data_delta_rid.dAll_superfilenames
    + versions.k6000_inquiries_bdid.dAll_superfilenames
    + versions.k6000_inquiries_file_number.dAll_superfilenames
    + versions.k6000_inquiries_delta_rid.dAll_superfilenames
    + versions.k6500_government_trade_bdid.dAll_superfilenames
    + versions.k6500_government_trade_file_number.dAll_superfilenames
    + versions.k6500_government_trade_delta_rid.dAll_superfilenames
    + versions.k6510_government_debarred_contractor_bdid.dAll_superfilenames
    + versions.k6510_government_debarred_contractor_file_number.dAll_superfilenames
    + versions.k6510_government_debarred_delta_rid.dAll_superfilenames
    + versions.k7000_snp_parent_name_address_bdid.dAll_superfilenames
    + versions.k7000_snp_parent_name_address_file_number.dAll_superfilenames
    + versions.k7010_snp_data_bdid.dAll_superfilenames
    + versions.k7010_snp_data_file_number.dAll_superfilenames
    + versions.k7010_snp_data_delta_rid.dAll_superfilenames
    + versions.kAutokey_delta_rid.dAll_superfilenames
    ;

	export dNew :=
      versions.k0010_header_bdid.dNew
    + versions.k0010_header_file_number.dNew
    + versions.k0010_header_delta_rid.dNew
    + versions.k1000_executive_summary_bdid.dNew
    + versions.k1000_executive_summary_file_number.dNew
    + versions.k1000_executive_summary_delta_rid.dNew
    + versions.k2000_trade_bdid.dNew
    + versions.k2000_trade_file_number.dNew
    + versions.k2000_trade_delta_rid.dNew
    + versions.k2015_trade_payment_totals_bdid.dNew
    + versions.k2015_trade_payment_totals_file_number.dNew
    + versions.k2015_trade_payment_totals_delta_rid.dNew
    + versions.k2020_trade_payment_trends_bdid.dNew
    + versions.k2020_trade_payment_trends_file_number.dNew
    + versions.k2020_trade_payment_trends_delta_rid.dNew
    + versions.k2025_trade_quarterly_averages_bdid.dNew
    + versions.k2025_trade_quarterly_averages_file_number.dNew
    + versions.k2025_trade_quarterly_averages_delta_rid.dNew
    + versions.k4010_bankruptcy_bdid.dNew
    + versions.k4010_bankruptcy_file_number.dNew
    + versions.k4010_bankruptcy_delta_rid.dNew
    + versions.k4020_tax_liens_bdid.dNew
    + versions.k4020_tax_liens_file_number.dNew
    + versions.k4020_tax_liens_delta_rid.dNew
    + versions.k4030_judgement_bdid.dNew
    + versions.k4030_judgement_file_number.dNew
    + versions.k4030_judgement_delta_rid.dNew
    + versions.k4035_attachment_lien_bdid.dNew
    + versions.k4035_attachment_lien_file_number.dNew
    + versions.k4040_bulk_transfers_bdid.dNew
    + versions.k4040_bulk_transfers_file_number.dNew
    + versions.k4500_collateral_accounts_bdid.dNew
    + versions.k4500_collateral_accounts_file_number.dNew
    + versions.k4500_collateral_accounts_delta_rid.dNew
    + versions.k4510_ucc_filings_bdid.dNew
    + versions.k4510_ucc_filings_file_number.dNew
    + versions.k4510_ucc_filings_delta_rid.dNew
    + versions.k5000_bank_details_bdid.dNew
    + versions.k5000_bank_details_file_number.dNew
    + versions.k5000_bank_details_delta_rid.dNew
    + versions.k5600_demographic_data_bdid.dNew
    + versions.k5600_demographic_data_file_number.dNew
    + versions.k5600_demographic_data_delta_rid.dNew
    + versions.k5610_demographic_data_bdid.dNew
    + versions.k5610_demographic_data_did.dNew
    + versions.k5610_demographic_data_file_number.dNew
    + versions.k5610_demographic_data_ssn.dNew
    + versions.k5610_demographic_data_delta_rid.dNew
    + versions.k6000_inquiries_bdid.dNew
    + versions.k6000_inquiries_file_number.dNew
    + versions.k6000_inquiries_delta_rid.dNew
    + versions.k6500_government_trade_bdid.dNew
    + versions.k6500_government_trade_file_number.dNew
    + versions.k6500_government_trade_delta_rid.dNew
    + versions.k6510_government_debarred_contractor_bdid.dNew
    + versions.k6510_government_debarred_contractor_file_number.dNew
    + versions.k6510_government_debarred_delta_rid.dNew
    + versions.k7000_snp_parent_name_address_bdid.dNew
    + versions.k7000_snp_parent_name_address_file_number.dNew
    + versions.k7010_snp_data_bdid.dNew
    + versions.k7010_snp_data_file_number.dNew
    + versions.k7010_snp_data_delta_rid.dNew
    + versions.kAutokey_delta_rid.dNew
		;

	export dAll_Oldsuperfilenames :=
		dataset([
       KeyName_0010_Header_BDID
      ,KeyName_0010_Header_FILE_NUMBER
      ,KeyName_0010_Header_Delta_rid
      ,KeyName_1000_Executive_Summary_BDID
      ,KeyName_1000_Executive_Summary_FILE_NUMBER
      ,KeyName_1000_Executive_Summary_Delta_rid
      ,KeyName_2000_Trade_BDID
      ,KeyName_2000_Trade_FILE_NUMBER
      ,KeyName_2000_Trade_Delta_rid
      ,KeyName_2015_Trade_Payment_Totals_BDID
      ,KeyName_2015_Trade_Payment_Totals_FILE_NUMBER
      ,KeyName_2015_Trade_Payment_Totals_Delta_rid
      ,KeyName_2020_Trade_Payment_Trends_BDID
      ,KeyName_2020_Trade_Payment_Trends_FILE_NUMBER
      ,KeyName_2020_Trade_Payment_Trends_Delta_rid
      ,KeyName_2025_Trade_Quarterly_Averages_BDID
      ,KeyName_2025_Trade_Quarterly_Averages_FILE_NUMBER
      ,KeyName_2025_Trade_Quarterly_Averages_Delta_rid
      ,KeyName_4010_Bankruptcy_BDID
      ,KeyName_4010_Bankruptcy_FILE_NUMBER
      ,KeyName_4010_Bankruptcy_Delta_rid
      ,KeyName_4020_Tax_Liens_BDID
      ,KeyName_4020_Tax_Liens_FILE_NUMBER
      ,KeyName_4020_Tax_Liens_Delta_rid
      ,KeyName_4030_Judgement_BDID
      ,KeyName_4030_Judgement_FILE_NUMBER
      ,KeyName_4030_Judgement_Delta_rid
      ,KeyName_4500_Collateral_Accounts_BDID
      ,KeyName_4500_Collateral_Accounts_FILE_NUMBER
      ,KeyName_4500_Collateral_Accounts_Delta_rid
      ,KeyName_4510_UCC_Filings_BDID
      ,KeyName_4510_UCC_Filings_FILE_NUMBER
      ,KeyName_4510_UCC_Filings_Delta_rid
      ,KeyName_5000_Bank_Details_BDID
      ,KeyName_5000_Bank_Details_FILE_NUMBER
      ,KeyName_5000_Bank_Details_Delta_rid
      ,KeyName_5600_Demographic_Data_BDID
      ,KeyName_5600_Demographic_Data_FILE_NUMBER
      ,KeyName_5600_Demographic_Data_Delta_rid
      ,KeyName_5610_Demographic_Data_BDID
      ,KeyName_5610_Demographic_Data_DID
      ,KeyName_5610_Demographic_Data_FILE_NUMBER
      ,KeyName_5610_Demographic_Data_SSN
      ,KeyName_5610_Demographic_Data_Delta_rid
      ,KeyName_6000_Inquiries_BDID
      ,KeyName_6000_Inquiries_FILE_NUMBER
      ,KeyName_6000_Inquiries_Delta_rid
      ,KeyName_6500_Government_Trade_BDID
      ,KeyName_6500_Government_Trade_FILE_NUMBER
      ,KeyName_6500_Government_Trade_Delta_rid
      ,KeyName_6510_Government_Debarred_Contractor_BDID
      ,KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER  
      ,KeyName_6510_Government_Debarred_Delta_rid
      ,KeyName_7010_SNP_Data_BDID
      ,KeyName_7010_SNP_Data_FILE_NUMBER
      ,KeyName_7010_SNP_Data_Delta_rid
      ,KeyName_Autokey_Delta_rid
		], tools.Layout_Names);

end;