
import Data_Services;

r := RECORD
	string23 	eid;
	boolean primary_officer_indicator;
  string1 	primary_officer;
	UNSIGNED4 cfs_officers_id;
  string50 	officer_name;
  string25 	date_time_dispatched;
  string25 	date_time_enroute;
  string25 	date_time_arrived;
  string25 	date_time_cleared;
  real8 		minutes_on_call;
  real8 		minutes_response;
  string30 	unit;
	unsigned4 data_provider_id;
END;

d:=dataset([],r);

EXPORT Key_Payload_CFS_Officer(string v = 'qa', boolean isDelta = false) := 
	index(d,{eid, primary_officer_indicator},{d},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::cfs::officer::v2::' + if(isDelta, 'delta::', '') + v + '::eid', OPT);
