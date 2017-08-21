import SANCTN;

#uniquename(cluster);
#OPTION('multiplePersistInstances',FALSE);

layout_payload := record
	string payload;
end;

// Filter each of the record types into separate datasets
incident_payload := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                           ,layout_payload,csv(terminator('\n'), separator('')))(regexfind('1',payload[25]));

// Parse the incident records
SANCTN.layout_SANCTN_incident_in inc_payload(incident_payload input) := Transform
	self.BATCH_NUMBER    := input.payload[1..8];
	self.INCIDENT_NUMBER := input.payload[9..16];
	self.PARTY_NUMBER    := input.payload[17..24];
	self.RECORD_TYPE     := input.payload[25];
	self.ORDER_NUMBER    := input.payload[26..29];
	self.AG_CODE         := input.payload[30..37];
	self.CASE_NUMBER     := input.payload[38..57];
	self.INCIDENT_DATE   := input.payload[58..65];
	self.JURISDICTION    := input.payload[66..155];
	self.SOURCE_DOCUMENT := input.payload[156..225];
	self.ADDITIONAL_INFO := input.payload[226..295];
	self.AGENCY          := input.payload[296..365];
	self.ALLEGED_AMOUNT  := input.payload[366..375];
	self.ESTIMATED_LOSS  := input.payload[376..385];
	self.FCR_DATE        := input.payload[386..395];
	self.OK_FOR_FCR      := input.payload[396];
	self.MODIFIED_DATE	 := input.payload[397..406];
	self.LOAD_DATE			 := input.payload[407..416];
end;

// Do the project and persist the result
out_inc := distribute(project(incident_payload,inc_payload(left)),hash(BATCH_NUMBER, INCIDENT_NUMBER));
export parse_SANCTN_incident_in := out_inc : PERSIST(SANCTN.cluster + 'persist::SANCTN::incident');

