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
  {'KL53226','D'} // Fake, not on DNC
], input_layout);


results := dx_dma.Flag_DNC_Records(input);

ASSERT(results[1].phonenumber = 'fgsdgfs', 'Sanity check, expected to fail.');

ASSERT(results[1].phonenumber = '0543281198');
ASSERT(results[1].retain_me = 'C');
ASSERT(results[1].do_not_call_flag = 'Y');

ASSERT(results[2].phonenumber = '0896950895');
ASSERT(results[2].retain_me = 'B');
ASSERT(results[2].do_not_call_flag = 'Y');

ASSERT(results[3].phonenumber = '9542784676');
ASSERT(results[3].retain_me = 'A');
ASSERT(results[3].do_not_call_flag = '');

ASSERT(results[4].phonenumber = 'KL53226');
ASSERT(results[4].retain_me = 'D');
ASSERT(results[4].do_not_call_flag = '');

OUTPUT(results, NAMED('final'));
