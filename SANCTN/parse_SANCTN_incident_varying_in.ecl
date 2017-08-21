import SANCTN,lib_stringlib;

#uniquename(cluster);
#OPTION('multiplePersistInstances',FALSE);

layout_payload := record
	string payload;
end;

// Filter each of the record types into separate datasets
incident_varying_payload := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                                   ,layout_payload,csv(terminator('\n'), separator('')))(regexfind('2',payload[25]));

// Parse the incident varying records
SANCTN.layout_SANCTN_incident_varying_in inc_var_payload(incident_varying_payload input) := Transform
	self.BATCH_NUMBER    := input.payload[1..8];
	self.INCIDENT_NUMBER := input.payload[9..16];
	self.PARTY_NUMBER    := input.payload[17..24];
	self.RECORD_TYPE     := input.payload[25];
	self.ORDER_NUMBER    := input.payload[26..29];
	self.INCIDENT_TEXT   := lib_stringlib.StringLib.StringFindReplace(input.payload[30..284],'~','\r');
end;


parsed_incident_text := sort(project(incident_varying_payload,inc_var_payload(left)),BATCH_NUMBER,INCIDENT_NUMBER,ORDER_NUMBER);

// Do the project and persist the result
out_inc_var := distribute(parsed_incident_text(TRIM(INCIDENT_TEXT,LEFT,RIGHT) != '\r'),hash(BATCH_NUMBER, INCIDENT_NUMBER));
export parse_SANCTN_incident_varying_in := out_inc_var : PERSIST(SANCTN.cluster + 'persist::SANCTN::incident_varying');

