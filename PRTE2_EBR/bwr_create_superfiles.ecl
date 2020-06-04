import promotesupers, roxiekeybuild, std,ebr;

STD.File.CreateSuperFile('~prte::in::ebr::0010_header',,1);
STD.File.CreateSuperFile('~prte::in::ebr::5600_demographic_data',,1);
STD.File.CreateSuperFile('~prte::in::ebr::5610_demographic_data',,1);
STD.File.CreateSuperFile('~prte::in::ebr::execsummary',,1);
STD.File.CreateSuperFile('~prte::in::ebr::tradepmttot',,1);

STD.File.CreateSuperFile('~prte::in::ebr::0010_header_ins',,1);
STD.File.CreateSuperFile('~prte::in::ebr::5600_demographic_data_ins',,1);
STD.File.CreateSuperFile('~prte::in::ebr::5610_demographic_data_ins',,1);
STD.File.CreateSuperFile('~prte::in::ebr::execsummaryins',,1);
STD.File.CreateSuperFile('~prte::in::ebr::tradepmttotins',,1);

 promotesupers.mac_create_superfiles('~prte::base::ebr::0010_header');
 promotesupers.mac_create_superfiles('~prte::base::ebr::5600_demographic_data');
 promotesupers.mac_create_superfiles('~prte::base::ebr::5610_demographic_data');
 promotesupers.mac_create_superfiles('~prte::base::ebr::executive_summary_data');
 promotesupers.mac_create_superfiles('~prte::base::ebr::trade_payment_tot_data');
 
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'address');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'addressb');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'citystname');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'citystnameb');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'fein');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'name');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'nameb');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'namewords');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'payload');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'phone');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'phoneb');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'ssn');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'stname');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'stnameb');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'zip');
// roxiekeybuild.mac_create_superkey_files('~prte', '::key::ebr_autokey', 'zipb');


ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::Payload');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::address');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::addressb');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::citystname');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::citystnameb');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::fein');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::name');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::nameb');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::namewords');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::phone');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::phoneb');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::phoneb');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::ssn');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::stname');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::stnameb');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::zip');
ebr.create_superkeys(prte2_ebr.Constants.KEY_PREFIX  + 'autokey::zipb');


//0100 Header
STD.File.CreateSuperFile('~prte::key::ebr::built::0010_header::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::0010_header::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::0010_header::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::0010_header::bdid',,1);

STD.File.CreateSuperFile('~prte::key::ebr::built::0010_header::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::0010_header::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::0010_header::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::0010_header::file_number',,1);

STD.File.CreateSuperFile('~prte::key::ebr::built::0010_header::linkids',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::0010_header::linkids',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::0010_header::linkids',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::0010_header::linkids',,1);


//1000 Executive Summary
STD.File.CreateSuperFile('~prte::key::ebr::built::1000_executive_summary::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::1000_executive_summary::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::1000_executive_summary::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::1000_executive_summary::bdid',,1);

STD.File.CreateSuperFile('~prte::key::ebr::built::1000_executive_summary::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::1000_executive_summary::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::1000_executive_summary::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::1000_executive_summary::file_number',,1);

//2000 Trade
STD.File.CreateSuperFile('~prte::key::ebr::built::2000_trade::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::2000_trade::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::2000_trade::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::2000_trade::file_number',,1);

//2015 Trade Payment Totals
STD.File.CreateSuperFile('~prte::key::ebr::built::2015_trade_payment_totals::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::2015_trade_payment_totals::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::2015_trade_payment_totals::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::2015_trade_payment_totals::file_number',,1);

//2020 Trade Payment Trends
STD.File.CreateSuperFile('~prte::key::ebr::built::2020_trade_payment_trends::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::2020_trade_payment_trends::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::2020_trade_payment_trends::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::2020_trade_payment_trends::file_number',,1);

//2025 Trade Quarterly Average
STD.File.CreateSuperFile('~prte::key::ebr::built::2025_trade_quarterly_averages::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::2025_trade_quarterly_averages::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::2025_trade_quarterly_averages::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::2025_trade_quarterly_averages::file_number',,1);


//4040 Bankruptcy
STD.File.CreateSuperFile('~prte::key::ebr::built::4010_bankruptcy::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::4010_bankruptcy::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::4010_bankruptcy::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::4010_bankruptcy::file_number',,1);


//4020 Tax Liens
STD.File.CreateSuperFile('~prte::key::ebr::built::4020_tax_liens::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::4020_tax_liens::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::4020_tax_liens::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::4020_tax_liens::file_number',,1);


//4030 Judgement
STD.File.CreateSuperFile('~prte::key::ebr::built::4030_judgement::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::4030_judgement::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::4030_judgement::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::4030_judgement::file_number',,1);


//4500 Collateral Accounts
STD.File.CreateSuperFile('~prte::key::ebr::built::4500_collateral_accounts::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::4500_collateral_accounts::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::4500_collateral_accounts::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::4500_collateral_accounts::file_number',,1);

//4510 UCC Filings
STD.File.CreateSuperFile('~prte::key::ebr::built::4510_ucc_filings::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::4510_ucc_filings::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::4510_ucc_filings::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::4510_ucc_filings::file_number',,1);

//5000 Bank Details
STD.File.CreateSuperFile('~prte::key::ebr::built::5000_bank_details::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::5000_bank_details::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandfather::5000_bank_details::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::5000_bank_details::file_number',,1);


//5600 Demographic Data
STD.File.CreateSuperFile('~prte::key::ebr::built::5600_demographic_data::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::5600_demographic_data::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::5600_demographic_data::bdid',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::5600_demographic_data::bdid',,1);

STD.File.CreateSuperFile('~prte::key::ebr::built::5600_demographic_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::5600_demographic_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::5600_demographic_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::5600_demographic_data::file_number',,1);

STD.File.CreateSuperFile('~prte::key::ebr::built::5600_demographic_data::linkids',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::5600_demographic_data::linkids',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::5600_demographic_data::linkids',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::5600_demographic_data::linkids',,1);



// 5610 Demographic Data
STD.File.CreateSuperFile('~prte::key::ebr::built::5610_demographic_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::5610_demographic_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::5610_demographic_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::5610_demographic_data::file_number',,1);


// 6000 Inquiries
STD.File.CreateSuperFile('~prte::key::ebr::built::6000_inquiries::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::6000_inquiries::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::6000_inquiries::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::6000_inquiries::file_number',,1);


// 6500 Government Trade
STD.File.CreateSuperFile('~prte::key::ebr::built::6500_government_trade::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::6500_government_trade::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::6500_government_trade::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::6500_government_trade::file_number',,1);


// 6510 Government Debarred contractor
STD.File.CreateSuperFile('~prte::key::ebr::built::6510_government_debarred_contractor::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::6510_government_debarred_contractor::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::6510_government_debarred_contractor::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::6510_government_debarred_contractor::file_number',,1);


// 7010 SNP Data
STD.File.CreateSuperFile('~prte::key::ebr::built::7010_snp_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::father::7010_snp_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::grandather::7010_snp_data::file_number',,1);
STD.File.CreateSuperFile('~prte::key::ebr::qa::7010_snp_data::file_number',,1);

