import SANCTN;

#uniquename(cluster);
#OPTION('multiplePersistInstances',FALSE);

layout_payload := record
	string payload;
end;

// Filter each of the record types into separate datasets
party_payload            := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                                   ,layout_payload,csv(terminator('\n'), separator('')))(regexfind('3',payload[25]));

// Parse the party records
SANCTN.layout_SANCTN_party_in pty_payload(party_payload input) := Transform
	self.BATCH_NUMBER    := input.payload[1..8];
	self.INCIDENT_NUMBER := input.payload[9..16];
	self.PARTY_NUMBER    := input.payload[17..24];
	self.RECORD_TYPE     := input.payload[25];
	self.ORDER_NUMBER    := input.payload[26..29];
	self.PARTY_NAME      := input.payload[30..74];
	self.PARTY_POSITION  := input.payload[75..119];
	self.PARTY_VOCATION  := input.payload[120..164];
	self.PARTY_FIRM      := input.payload[165..234];
	self.inADDRESS       := input.payload[235..279];
	self.inCITY          := input.payload[280..324];
	self.inSTATE         := input.payload[325..344];
	self.inZIP           := input.payload[345..354];
	self.SSNUMBER        := input.payload[355..365];
	self.FINES_LEVIED    := input.payload[366..375];
	self.RESTITUTION     := input.payload[376..385];
	self.OK_FOR_FCR      := input.payload[386];
end;

// Do the project and persist the result
out_pty := distribute(project(party_payload,pty_payload(left)),hash(BATCH_NUMBER, INCIDENT_NUMBER));
export parse_SANCTN_party_in:= out_pty : PERSIST(SANCTN.cluster + 'persist::SANCTN::party');
