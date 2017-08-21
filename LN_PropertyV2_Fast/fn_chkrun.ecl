EXPORT fn_chkrun   := module
shared layout_metrics := RECORD
  string9 version;
  string5 update_type;
  string8 prep_start_date;
  string8 prep_end_date;
  string8 base_build_start_date;
  string8 base_build_end_date;
  string8 key_build_start_date;
  string8 key_build_end_date;
  string8 cert_date;
  string8 prod_date;
  unsigned8 total_processing_days;
  unsigned8 total_deployment_days;
  unsigned8 total_qa_days;
  unsigned8 total_days;
  string120 workunits;
  string8 last_updated;
 END;


shared fmetrics := dataset('~thor_data400::lookup::ln_propertyv2::build_metrics',layout_metrics,flat);
//##CHECK TO RUN DELTA AFTER FULL

f1 := fmetrics ( version =  max( fmetrics (trim(update_type) = 'FULL'), version));

export run_delta :=  if ( f1[1].key_build_end_date = '',fail('FULL BUILD IS RUNNING'));

//###CHECK TO RUN SPRAY
f2 := fmetrics ( version =  max( fmetrics , version));

export run_spray := if ( f2[1].prep_end_date = '',fail('PREP PROCESS IS RUNNING'));



end;