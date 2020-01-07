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
