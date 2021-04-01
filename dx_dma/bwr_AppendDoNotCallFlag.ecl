import dx_common;

// This BWR tests the DNC flagging macro using known inputs.
// It tests the following capabilities:
// 1. Appending flags to a layout with the do_not_call_flag field already present.
// 2. Appending flags to a layout without the do_not_call_flag present.
// 3. Handling delta deletes properly, no flag should be present.
// 4. Handling delta adds properly, should be flag present.
// 5. Handling base records properly, if the number is present it should be flagged.
// 6. Handling empty strings based on empty string argument to append macro.

input_layout := RECORD
  string10 phonenumber;
  string1 retain_me := ''; // Extra field to ensure macro keeps all input data.
  string expected_result := '';
  string1 do_not_call_flag := ''; //DNC flag field, can turn on and off to make sure macro will handle both scenarios.
END;

input := DATASET([
  {'9542784676','A', 'Not on DNC'},
  {'0896950895','B', 'On DNC'},
  {'0543281198','C', 'On DNC'},
  {'KL53226','D', 'Fake number, not on DNC'},
  {'','F', 'Empty string, Y if flag_empty = TRUE'},
  {'2013871566','G', 'Deleted from DNC'},
  {'2054543946','H', 'Deleted from DNC'},
  {'3303642932','I', 'Deleted from DNC'},
  {'2013871566','J', 'Deleted from DNC'},
  {'2012109306','K', 'Added to DNC'},
  {'2012759056','L', 'Added to DNC'},
  {'2013127481','M', 'Added to DNC'}
], input_layout);

results_flag_empty := SORT(dx_dma.AppendDoNotCallFlag(input, flag_empty := TRUE), retain_me);
results_not_flag_empty := SORT(dx_dma.AppendDoNotCallFlag(input), retain_me);

expected_output_flag_empty := DATASET([
  {'9542784676','A', 'Not on DNC', ''},
  {'0896950895','B', 'On DNC', 'Y'},
  {'0543281198','C', 'On DNC', 'Y'},
  {'KL53226','D', 'Fake number, not on DNC', ''},
  {'','F', 'Empty string, Y if flag_empty = TRUE', 'Y'},
  {'2013871566','G', 'Deleted from DNC', ''},
  {'2054543946','H', 'Deleted from DNC', ''},
  {'3303642932','I', 'Deleted from DNC', ''},
  {'2013871566','J', 'Deleted from DNC', ''},
  {'2012109306','K', 'Added to DNC', 'Y'},
  {'2012759056','L', 'Added to DNC', 'Y'},
  {'2013127481','M', 'Added to DNC', 'Y'}
], RECORDOF(results_flag_empty));

expected_output_not_flag_empty := DATASET([
  {'9542784676','A', 'Not on DNC', ''},
  {'0896950895','B', 'On DNC', 'Y'},
  {'0543281198','C', 'On DNC', 'Y'},
  {'KL53226','D', 'Fake number, not on DNC', ''},
  {'','F', 'Empty string, Y if flag_empty = TRUE', ''},
  {'2013871566','G', 'Deleted from DNC', ''},
  {'2054543946','H', 'Deleted from DNC', ''},
  {'3303642932','I', 'Deleted from DNC', ''},
  {'2013871566','J', 'Deleted from DNC', ''},
  {'2012109306','K', 'Added to DNC', 'Y'},
  {'2012759056','L', 'Added to DNC', 'Y'},
  {'2013127481','M', 'Added to DNC', 'Y'}
], RECORDOF(results_not_flag_empty));

ASSERT(results_flag_empty = expected_output_flag_empty);
ASSERT(results_not_flag_empty = expected_output_not_flag_empty);
ASSERT(~(results_not_flag_empty != expected_output_not_flag_empty), 'Sanity check failed.');

OUTPUT(results_flag_empty = expected_output_flag_empty, NAMED('Test_1_passed'));
OUTPUT(results_not_flag_empty = expected_output_not_flag_empty, NAMED('Test_2_passed'));
OUTPUT(~(results_not_flag_empty != expected_output_not_flag_empty), NAMED('Sanity_check_passed'));

OUTPUT(input, NAMED('input'));
OUTPUT(expected_output_not_flag_empty, NAMED('results_append'));
OUTPUT(expected_output_flag_empty, NAMED('results_append_flag_empty'));
