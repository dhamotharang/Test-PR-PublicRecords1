// This tests number of time address cleaned is called in Normilize;
// One needs an access to a box where cleaner runs and needs to check logs

#workunit ('name', 'NCO address clean: test');
 
layout_address_short := RECORD // generally, same fields as in layouts_NCO.nco_in
  string15 first_name;
  string15 last_name;
  string30 address1;
  string30 address2;
  string30 city;
  string2  state;
  string9  zip;
  string30 former_address1;
  string30 former_address2; //30
  string30 former_city;
  string2  former_state;
  string9  former_zip;
END;

ds_batch_in := DATASET ([
  {'Vladimir', 'Myullyari', 
   '6161 NW 2nd Ave. ', ' #122 ', 'Miami', 'FL', '33487', 
   '9952 SW 8st ', ' #249', 'Miami', 'FL', '33174'}
], layout_address_short);

// Assign internal id for every record (linking monitoring results back to input records, updating address short term history, etc.)
Monitoring.layouts_NCO.verification AssignId (layout_address_short L) := TRANSFORM
  SELF.customer_id := 'NCO_ZZZ000';
  SELF.record_id := 'wwwwwwwwwwwwwwwwwww';
  SELF := L;
  SELF := [];
END;
DS_BATCH_NEW := PROJECT (ds_batch_in, AssignId (Left));

// ========== NORMALIZE BY ADDRESS AND CLEAN "NEW" RECORDS FROM THIS BATCH ==========
ds_batch_new_normed := NORMALIZE (DS_BATCH_NEW, 3, Monitoring.Client_NCO.NormalizeToBase (Left, COUNTER));

OUTPUT (ds_batch_new_normed, NAMED ('ds_batch_new_normed'));
// clean := Address.CleanAddress182 ('9952 SW 8 ST. #249', 'MIAMI FL 33174', 'victor2.br.seisint.com', 12346);
// output (clean);

// for testing either sandbox Address.CleanAddress182 with these values:
  // CorrectPort 	:= 12346;//address.CleaningServer.CorrectPort(lib_system.cleaningPort);
  // CorrectServer	:= 'victor2.br.seisint.com';//address.CleaningServer.CorrectServer(lib_system.cleaningServer);
// OR use direct call in Monitoring.Client_NCO:
//address_cleaned := IF (hasValidAddress, Address.CleanAddress182(address_line_1, address_line_2, 'victor2.br.seisint.com', 12346), '');

