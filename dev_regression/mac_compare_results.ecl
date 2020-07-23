/*
  ** A MACRO to compare result dataset returned by $.SOAPCallRoxieQuery function.
  ** 
  ** @param in_recs_a         results from 1st call to SOAPCallRoxieQuery.
  ** @param in_recs_b         results from 2nd call to SOAPCallRoxieQuery.
  ** @returns                 for each row in (a) a result flag of -1, 0 or 1.
  **                            -1: at least one of the soapcalls failed.
  **                            0: results are not the same.
  **                            1: same results returned.
  ** 
*/
EXPORT mac_compare_results(in_testcases, in_recs_a, in_recs_b, out_recs) := MACRO

  #uniquename(result_rec)
  %result_rec% := recordof(in_recs_a[1].results[1]);

  #uniquename(result_hash_rec)
  %result_hash_rec% := dev_regression.layouts.soap_common;

  #uniquename(norm_results)
  %result_hash_rec% %norm_results%(recordof(in_recs_a) le, %result_rec% ri) := TRANSFORM
    SELF.hash_val := HASH(TOXML(ri));
    SELF := le;
  END;

  #uniquename(norm_recs_a)
  #uniquename(norm_recs_b)
  %norm_recs_a% := normalize(in_recs_a, LEFT.results, %norm_results%(LEFT, RIGHT)); 
  %norm_recs_b% := normalize(in_recs_b, LEFT.results, %norm_results%(LEFT, RIGHT)); 

  #uniquename(roll_results)
  %result_hash_rec% %roll_results%(%result_hash_rec% le, %result_hash_rec% ri) := TRANSFORM
    SELF.hash_val := le.hash_val + ri.hash_val;
    SELF := le;
  END;
  
  #uniquename(rolled_recs_a)
  #uniquename(rolled_recs_b)
  %rolled_recs_a% := rollup(%norm_recs_a%, LEFT.soap_seq = RIGHT.soap_seq, %roll_results%(LEFT, RIGHT));
  %rolled_recs_b% := rollup(%norm_recs_b%, LEFT.soap_seq = RIGHT.soap_seq, %roll_results%(LEFT, RIGHT));
  
  #uniquename(in_testcases_seq)
  %in_testcases_seq% := project(in_testcases, 
    TRANSFORM(dev_regression.layouts.testcase_result,
      SELF.soap_seq := COUNTER;
      SELF := LEFT;
      SELF := [];
    ));

  #uniquename(out_recs_a)
  %out_recs_a% := join(%in_testcases_seq%, %rolled_recs_a%,
    LEFT.soap_seq = RIGHT.soap_seq,
    TRANSFORM(dev_regression.layouts.testcase_result,
      SELF.hash_val := RIGHT.hash_val;
      SELF.soap_status := RIGHT.soap_status;
      SELF.soap_message := RIGHT.soap_message;
      SELF.result := IF(RIGHT.soap_status <> 0, -1, 0);
      SELF := LEFT;
    ),
    KEEP(1), LIMIT(0),
    LEFT OUTER);

  out_recs := join(%out_recs_a%, %rolled_recs_b%,
    LEFT.soap_seq = RIGHT.soap_seq,
    TRANSFORM(dev_regression.layouts.testcase_result,
      SELF.hash_val := IF(LEFT.hash_val > 0, LEFT.hash_val, RIGHT.hash_val);
      SELF.soap_status := IF(LEFT.soap_status <> 0, LEFT.soap_status, RIGHT.soap_status);
      SELF.soap_message := IF(LEFT.soap_message <> '', LEFT.soap_message, RIGHT.soap_message);
      SELF.result := map(
        LEFT.soap_status <> 0 OR RIGHT.soap_status <> 0 => -1,
        LEFT.hash_val = RIGHT.hash_val => 1,
        0);
      SELF := LEFT;
    ),
    KEEP(1), LIMIT(0),
    LEFT OUTER);

ENDMACRO;
