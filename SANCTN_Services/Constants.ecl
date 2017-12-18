import data_services;

// incident is identified by batch_number + incident_number (ID)
EXPORT Constants := MODULE
  
  // maximum number of actual incidents per ID is just 2 (usually blank case number in one of the records,
  // or "different" source doc), but records include text info, which is upto 252 so far
  EXPORT unsigned2 INCIDENT_RECORDS_MAX := 500; // ~252 * 2
  EXPORT unsigned2 TEXT_PER_INCIDENT := 400;  // ~252

  EXPORT unsigned2 PARTY_PER_INCIDENT := 3000; // as of 2012.07: one entry with 10639, others < 2000
  // Note that the name is sort of misleading:
  // "party" here is not unique: party index contains all text entries for each party.

  EXPORT unsigned2 TEXT_PER_PARTY := 700; // as of 2012.07
  // This number also include records where text contains non-printable chars only, like '\n\n'.
  // Such records are not important for Web presentation, but can be important for API users.
  // Without these records the max is ~350
  // If they can be omitted in the future, "regexfind('^[[:print:]]+$',trim(party_text))" can be used.


  // case number is not unique for different IDs, but we allow search by it
  EXPORT unsigned2 ID_PER_CASENUMBER := 500; // ~210

  // Autokeys' related
	EXPORT string ak_keyname := data_services.data_location.prefix() + 'thor_data400::key::sanctn::qa::autokey::';
	EXPORT string ak_typeStr := 'AK';
  EXPORT set_skip := ['P','Q','S','F']; //keys to skip searching in

  // boolean search
	export STRING stem		:= '~thor_data400::base';
	export STRING srcType := 'sanctn';
	export STRING qual		:= 'test';
	
	export unsigned2 incident_text_length := 16000;
	
END;
