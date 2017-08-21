import SANCTN;

#uniquename(cluster);
#OPTION('multiplePersistInstances',FALSE);

layout_payload := record
	string payload;
end;

// Filter each of the record types into separate datasets
license_payload            := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                                   ,layout_payload,csv(terminator('\n'), separator('')))(regexfind('6',payload[25]));

// Parse the party records
SANCTN.layout_SANCTN_license_in get_license(license_payload input) := Transform
	self.BATCH_NUMBER    := input.payload[1..8];
	self.INCIDENT_NUMBER := input.payload[9..16];
	self.PARTY_NUMBER    := input.payload[17..24];
	self.RECORD_TYPE     := input.payload[25];
	self.ORDER_NUMBER    := input.payload[26..29];
	self.LICENSE_NUMBER  := input.payload[30..79];
	self.LICENSE_TYPE  	 := input.payload[80..129];
	self.LICENSE_STATE   := input.payload[130..149];
end;


// Do the project and persist the result
out_license := distribute(project(license_payload,get_license(left)),hash(BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER));
EXPORT parse_SANCTN_license_in := out_license : PERSIST(SANCTN.cluster + 'persist::SANCTN::license');




