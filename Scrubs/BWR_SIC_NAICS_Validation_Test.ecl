IMPORT SCRUBS;

OUTPUT(SCRUBS.fn_valid_SicCode('0111'),NAMED('fn_valid_sic_test_TRUE'));
OUTPUT(SCRUBS.fn_valid_SicCode('333'),NAMED('fn_valid_sic_test2_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode('80410101'),NAMED('fn_valid_sic_test3_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode(''),NAMED('fn_valid_sic_test4_TRUE'));
OUTPUT(SCRUBS.fn_valid_SicCode('AAAA'),NAMED('fn_valid_sic_test5_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode('AAAAAAAA'),NAMED('fn_valid_sic_test6_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode('0'),NAMED('fn_valid_sic_test7_TRUE'));
OUTPUT(SCRUBS.fn_valid_SicCode('1'),NAMED('fn_valid_sic_test8_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode('22'),NAMED('fn_valid_sic_test9_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode('55555'),NAMED('fn_valid_sic_test10_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode('7777777'),NAMED('fn_valid_sic_test11_FALSE'));
OUTPUT(SCRUBS.fn_valid_SicCode('011901'),NAMED('fn_valid_sic_test12_TRUE'));
OUTPUT(SCRUBS.fn_valid_SicCode('01190303'),NAMED('fn_valid_sic_test13_TRUE'));


OUTPUT(SCRUBS.fn_valid_NAICSCode('11'),NAMED('fn_valid_naics1_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('333'),NAMED('fn_valid_naics2_TRUE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('80410101'),NAMED('fn_valid_naics3_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode(''),NAMED('fn_valid_naics4_TRUE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('AAAA'),NAMED('fn_valid_naics5_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('AAAAAAAA'),NAMED('fn_valid_naics6_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('0'),NAMED('fn_valid_naics7_TRUE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('1'),NAMED('fn_valid_naics8_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('22'),NAMED('fn_valid_naics9_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('55555'),NAMED('fn_valid_naics10_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('7777777'),NAMED('fn_valid_naics11_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('011901'),NAMED('fn_valid_naics12_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('01190303'),NAMED('fn_valid_naics13_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('111'),NAMED('fn_valid_naics14_TRUE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('1111'),NAMED('fn_valid_naics15_TRUE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('11111'),NAMED('fn_valid_naics16_TRUE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('111110'),NAMED('fn_valid_naics17_TRUE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('116'),NAMED('fn_valid_naics18_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('0111'),NAMED('fn_valid_naics19_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('01111'),NAMED('fn_valid_naics20_FALSE'));
OUTPUT(SCRUBS.fn_valid_NAICSCode('011111'),NAMED('fn_valid_naics21_FALSE'));