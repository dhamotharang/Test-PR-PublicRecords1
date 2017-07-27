import SANCTN,lib_stringlib;

#uniquename(cluster);

layout_payload := record
	string payload;
end;

// Filter each of the record types into separate datasets
party_varying_payload := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                                ,layout_payload,csv(terminator('\n'), separator('')))(regexfind('4',payload[25]));

// Parse the party varying records
SANCTN.layout_SANCTN_party_varying_in pty_var_payload(party_varying_payload input) := Transform
	self.BATCH_NUMBER    := input.payload[1..8];
	self.INCIDENT_NUMBER := input.payload[9..16];
	self.PARTY_NUMBER    := input.payload[17..24];
	self.RECORD_TYPE     := input.payload[25];
	self.ORDER_NUMBER    := input.payload[26..29];
    self.PARTY_TEXT      := lib_stringlib.StringLib.StringFindReplace(input.payload[30..284],'~','\r');
end;

parsed_party_text    := sort(project(party_varying_payload,pty_var_payload(left)),BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,ORDER_NUMBER);

// Do the project and persist the result
out_pty_txt := distribute(parsed_party_text(TRIM(PARTY_TEXT,LEFT,RIGHT) != '\r'),hash(BATCH_NUMBER, INCIDENT_NUMBER));
export parse_SANCTN_party_varying_in := out_pty_txt : PERSIST(SANCTN.cluster + 'persist::SANCTN::party_varying');
