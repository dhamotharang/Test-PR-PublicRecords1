import SANCTN, lib_stringlib;

#uniquename(cluster);
#OPTION('multiplePersistInstances',FALSE);

layout_payload := record
	string payload;
end;

// Filter each of the record types into separate datasets
aka_dba_payload            := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                                   ,layout_payload,csv(terminator('\n'), separator('')))(regexfind('7',payload[25]));

// Parse the party records
SANCTN.layout_SANCTN_aka_dba_spray get_aka_dba(aka_dba_payload input) := Transform
	self.BATCH_NUMBER    	:= input.payload[1..8];
	self.INCIDENT_NUMBER 	:= input.payload[9..16];
	self.PARTY_NUMBER    	:= input.payload[17..24];
	self.RECORD_TYPE     	:= input.payload[25];
	self.ORDER_NUMBER		 	:= input.payload[26..29];
	self.NAME_TYPE	     	:= input.payload[30];
	self.LAST_NAME			 	:= input.payload[31..80];
	self.FIRST_NAME				:= input.payload[81..130];
	self.MIDDLE_NAME			:= input.payload[131..180];
	self.COMPANY					:= StringLib.StringFindReplace(input.payload[181..280],'~','\r');;
	// self.AKA_DBA_TEXT    := StringLib.StringFindReplace(input.payload[31..530],'~','\r');
end;


// Do the project and persist the result
out_aka_dba := distribute(project(aka_dba_payload,get_aka_dba(left)),hash(BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER));
EXPORT parse_SANCTN_aka_dba := out_aka_dba : PERSIST(SANCTN.cluster + 'persist::SANCTN::aka_dba');

