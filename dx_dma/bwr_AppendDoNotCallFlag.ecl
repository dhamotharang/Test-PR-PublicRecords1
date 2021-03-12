import dx_common;

// This BWR tests the DNC flagging macro using known inputs.

dnc_flag := RECORD
  STRING1 dnc_flag;
END;

input_layout := RECORD
  string10 phonenumber;
  string1 retain_me := ''; // Extra field to ensure macro keeps all input data.
  string1 do_not_call_flag := ''; //DNC flag field, can turn on and off to make sure macro will handle both scenarios.
END;


input := DATASET([
  {'9542784676','A'}, // Not on DNC
  {'0896950895','B'}, // On DNC
  {'0543281198','C'}, // On DNC
  {'KL53226','D'}, // Fake, not on DNC
  {'','F'} // Empty String, Y if second param = TRUE
], input_layout);


results := dx_dma.AppendDoNotCallFlag(input);
results2 := dx_dma.AppendDoNotCallFlag(input, flag_empty:= TRUE);

ASSERT(results[1].phonenumber = 'fgsdgfs', 'Sanity check, expected to fail.');

ASSERT(results[1].phonenumber = '');
ASSERT(results[1].retain_me = 'F');
ASSERT(results[1].do_not_call_flag = '');

ASSERT(results[2].phonenumber = '0543281198');
ASSERT(results[2].retain_me = 'C');
ASSERT(results[2].do_not_call_flag = 'Y');

ASSERT(results[3].phonenumber = '0896950895');
ASSERT(results[3].retain_me = 'B');
ASSERT(results[3].do_not_call_flag = 'Y');

ASSERT(results[4].phonenumber = '9542784676');
ASSERT(results[4].retain_me = 'A');
ASSERT(results[4].do_not_call_flag = '');

ASSERT(results[5].phonenumber = 'KL53226');
ASSERT(results[5].retain_me = 'D');
ASSERT(results[5].do_not_call_flag = '');

ASSERT(results2[1].phonenumber = '');
ASSERT(results2[1].retain_me = 'F');
ASSERT(results2[1].do_not_call_flag = 'Y');

ASSERT(results2[2].phonenumber = '0543281198');
ASSERT(results2[2].retain_me = 'C');
ASSERT(results2[2].do_not_call_flag = 'Y');

ASSERT(results2[3].phonenumber = '0896950895');
ASSERT(results2[3].retain_me = 'B');
ASSERT(results2[3].do_not_call_flag = 'Y');

ASSERT(results2[4].phonenumber = '9542784676');
ASSERT(results2[4].retain_me = 'A');
ASSERT(results2[4].do_not_call_flag = '');

ASSERT(results2[5].phonenumber = 'KL53226');
ASSERT(results2[5].retain_me = 'D');
ASSERT(results2[5].do_not_call_flag = '');

OUTPUT(results, NAMED('final'));
OUTPUT(results2, NAMED('final2'));
