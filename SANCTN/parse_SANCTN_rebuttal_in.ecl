import SANCTN, lib_stringlib;

#uniquename(cluster);
#OPTION('multiplePersistInstances',FALSE);

layout_payload := record
	string payload;
end;

// Filter each of the record types into separate datasets
rebuttal_payload            := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                                   ,layout_payload,csv(terminator('\n'), separator('')))(regexfind('5',payload[25]));

// Parse the party records
SANCTN.layout_SANCTN_rebuttal_in get_rebuttal(rebuttal_payload input) := Transform
	self.BATCH_NUMBER    := input.payload[1..8];
	self.INCIDENT_NUMBER := input.payload[9..16];
	self.PARTY_NUMBER    := input.payload[17..24];
	self.RECORD_TYPE     := input.payload[25];
	self.ORDER_NUMBER    := input.payload[26..29];
	self.PARTY_TEXT      := StringLib.StringFindReplace(input.payload[30..284],'~','\r');
end;


// Do the project and persist the result
out_rebuttal := distribute(project(rebuttal_payload,get_rebuttal(left)),hash(BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER));
EXPORT parse_SANCTN_rebuttal_in := out_rebuttal : PERSIST(SANCTN.cluster + 'persist::SANCTN::rebuttal');

