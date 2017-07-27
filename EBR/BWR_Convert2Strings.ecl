stringy_thingy := 'A00025000';

ebr.Convert2Strings('0010', myoutfile1)
ebr.Convert2Strings('1000', myoutfile2)
ebr.Convert2Strings('2000', myoutfile3)
ebr.Convert2Strings('2015', myoutfile4)
myoutfile5 := ebr.Convert2Strings2020;
myoutfile6 := ebr.Convert2Strings2025;
ebr.Convert2Strings('4010', myoutfile7)
ebr.Convert2Strings('4020', myoutfile8)
ebr.Convert2Strings('4030', myoutfile9)
ebr.Convert2Strings('4035', myoutfile10)
ebr.Convert2Strings('4040', myoutfile11)
ebr.Convert2Strings('4500', myoutfile12)
ebr.Convert2Strings('4510', myoutfile13)
ebr.Convert2Strings('5000', myoutfile14)
ebr.Convert2Strings('5600', myoutfile15)
myoutfile16 := ebr.Convert2Strings5610;
myoutfile17 := ebr.Convert2Strings6000;
ebr.Convert2Strings('6500', myoutfile18)
ebr.Convert2Strings('6510', myoutfile19)
ebr.Convert2Strings('7000', myoutfile20)
ebr.Convert2Strings('7010', myoutfile21)


output(myoutfile1(FILE_NUMBER < stringy_thingy),,'out::ebr_0010_header_sample',overwrite);

output(myoutfile2(FILE_NUMBER < stringy_thingy),,'out::ebr_1000_es',overwrite);
output(myoutfile3(FILE_NUMBER < stringy_thingy),,'out::ebr_2000_trade',overwrite);
output(myoutfile4(FILE_NUMBER < stringy_thingy),,'out::ebr_2015_trade_ptotals',overwrite);
output(myoutfile5(FILE_NUMBER < stringy_thingy),,'out::ebr_2020_trade_ptrends',overwrite);
output(myoutfile6(FILE_NUMBER < stringy_thingy),,'out::ebr_2025_trade_qavgs',overwrite);
output(myoutfile7(FILE_NUMBER < stringy_thingy),,'out::ebr_4010_bankrupt',overwrite);
output(myoutfile8(FILE_NUMBER < stringy_thingy),,'out::ebr_4020_tax',overwrite);
output(myoutfile9(FILE_NUMBER < stringy_thingy),,'out::ebr_4030_judgement',overwrite);
output(myoutfile10(FILE_NUMBER < stringy_thingy),,'out::ebr_4035_al',overwrite);
output(myoutfile11(FILE_NUMBER < stringy_thingy),,'out::ebr_4040_bt',overwrite);
output(myoutfile12(FILE_NUMBER < stringy_thingy),,'out::ebr_4500_ca',overwrite);
output(myoutfile13(FILE_NUMBER < stringy_thingy),,'out::ebr_4510_ucc',overwrite);
output(myoutfile14(FILE_NUMBER < stringy_thingy),,'out::ebr_5000_bd',overwrite);
output(myoutfile15(FILE_NUMBER < stringy_thingy),,'out::ebr_5600_dd1',overwrite);

output(myoutfile16(FILE_NUMBER < stringy_thingy),,'out::ebr_5610_dd2',overwrite);

output(myoutfile17(FILE_NUMBER < stringy_thingy),,'out::ebr_6000_Inquiries',overwrite);
output(myoutfile18(FILE_NUMBER < stringy_thingy),,'out::ebr_6500_gt',overwrite);
output(myoutfile19(FILE_NUMBER < stringy_thingy),,'out::ebr_6510_gdc',overwrite);
output(myoutfile20(FILE_NUMBER < stringy_thingy),,'out::ebr_7000_snp_pna',overwrite);
output(myoutfile21(FILE_NUMBER < stringy_thingy),,'out::ebr_7010_snp_data',overwrite);

fileservices.Despray('out::ebr_0010_header','10.140.128.250', '/data/jvilaplana/ebr_0010_header.d00');
fileservices.Despray('out::ebr_1000_es','10.140.128.250', '/data/jvilaplana/ebr_1000_executive_summary.d00');
fileservices.Despray('out::ebr_2000_trade','10.140.128.250', '/data/jvilaplana/ebr_2000_trade.d00');
fileservices.Despray('out::ebr_2015_trade_ptotals','10.140.128.250', '/data/jvilaplana/ebr_2015_trade_payment_totals.d00');
fileservices.Despray('out::ebr_2020_trade_ptrends','10.140.128.250', '/data/jvilaplana/ebr_2020_trade_payment_trends.d00');
fileservices.Despray('out::ebr_2025_trade_qavgs','10.140.128.250', '/data/jvilaplana/ebr_2025_trade_quarterly_averages.d00');
fileservices.Despray('out::ebr_4010_bankrupt','10.140.128.250', '/data/jvilaplana/ebr_4010_bankruptcy.d00');
fileservices.Despray('out::ebr_4020_tax','10.140.128.250', '/data/jvilaplana/ebr_4020_tax_liens.d00');
fileservices.Despray('out::ebr_4030_judgement','10.140.128.250', '/data/jvilaplana/ebr_4030_judgement.d00');
fileservices.Despray('out::ebr_4035_al','10.140.128.250', '/data/jvilaplana/ebr_4035_attachment_lien.d00');
fileservices.Despray('out::ebr_4040_bt','10.140.128.250', '/data/jvilaplana/ebr_4040_bulk_transfers.d00');
fileservices.Despray('out::ebr_4500_ca','10.140.128.250', '/data/jvilaplana/ebr_4500_collateral_accounts.d00');
fileservices.Despray('out::ebr_4510_ucc','10.140.128.250', '/data/jvilaplana/ebr_4510_ucc_filings.d00');
fileservices.Despray('out::ebr_5000_bd','10.140.128.250', '/data/jvilaplana/ebr_5000_bank_details.d00');
fileservices.Despray('out::ebr_5600_dd1','10.140.128.250', '/data/jvilaplana/ebr_5600_demographic_data.d00');
fileservices.Despray('out::ebr_5610_dd2','10.140.128.250', '/data/jvilaplana/ebr_5610_demographic_data.d00');
fileservices.Despray('out::ebr_6000_Inquiries','10.140.128.250', '/data/jvilaplana/ebr_6000_inquiries.d00');
fileservices.Despray('out::ebr_6500_gt','10.140.128.250', '/data/jvilaplana/ebr_6500_government_trade.d00');
fileservices.Despray('out::ebr_6510_gdc','10.140.128.250', '/data/jvilaplana/ebr_6510_government_debarred_contractor.d00');
fileservices.Despray('out::ebr_7000_snp_pna','10.140.128.250', '/data/jvilaplana/ebr_7000_snp_parent_name_address.d00');
fileservices.Despray('out::ebr_7010_snp_data','10.140.128.250', '/data/jvilaplana/ebr_7010_snp_data.d00');
