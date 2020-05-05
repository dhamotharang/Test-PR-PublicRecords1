IMPORT UT, Risk_Indicators;

EXPORT CVI2004_1_0(STRING in_primrange, STRING in_primname,
STRING in_state, STRING in_city, STRING5 in_zip5, STRING5 in_zip4, REAL in_lat, REAL in_long,
STRING best_address, STRING best_city, STRING best_state, STRING5 best_zip5, STRING5 best_zip4) := FUNCTION
  insufficientInput := in_zip5 = '' OR in_city = '' OR in_state = '' 
                                 OR best_zip5 = '' OR best_city = '' OR best_state = '' OR in_zip4 = '' OR best_zip4 = '';
  clean_a2 := IF(insufficientInput, '', risk_indicators.MOD_AddressClean.clean_addr(best_address, best_city, best_state, best_zip5));
  best_primrange := IF(insufficientInput, '', clean_a2[1..10]);
  best_primname := IF(insufficientInput, '', clean_a2[13..40]);
  best_lat := IF(insufficientInput, 0, (REAL)clean_a2[146..155]);
  best_long := IF(insufficientInput, 0, (REAL)clean_a2[156..166]);
  isInputBest        := IF(insufficientInput, FALSE, in_primrange = best_primrange AND in_primname = best_primname 
                                 AND in_zip5 = best_zip5 AND in_zip4 = best_zip4 AND in_city = best_city AND in_state = best_state);
  addr_dist := IF(isInputBest, -1, ut.LL_Dist(in_lat, in_long, best_lat, best_long));
  cvi := MAP(insufficientInput => '0',
                      isInputBest => '1',
                      addr_dist > 0 AND addr_dist < 50 => '2',
                      addr_dist >= 50 AND addr_dist < 200 => '3',
                      addr_dist >= 200 AND addr_dist < 500 => '4',
                      '5');
  RETURN cvi;
	
END;
