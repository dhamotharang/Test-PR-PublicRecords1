IMPORT PersonContext, STD;

EXPORT CONSTANTS := MODULE

 EXPORT GetDateTimeGMT := std.Date.SecondsToString(Std.date.CurrentSeconds(FALSE), '%Y-%m-%d %H:%M:%S');

 EXPORT StatusCodes := MODULE
    EXPORT  NoSearchRecords               := '401';
    EXPORT  ResultsFound                  := '501';
    EXPORT  NoResultsFound                := '503';
    EXPORT  RecIDOutOfSequence            := '505'; 
    EXPORT  LexidRecidCombinationError    := '506';
  END;

 EXPORT Messages := MODULE  
    EXPORT  NoSearchRecordsMsg     := 'NO VALID INPUT SEARCH KEYS PROVIDED';
    EXPORT  ResultsFoundMsg        := 'RESULTS FOUND';
    EXPORT  NoResultsFoundMsg      := 'NO RESULTS FOUND';
    EXPORT  ESP_Method             := 'PersonContextDeltabase';
    EXPORT  ResultStructure        := 'PersonContextDeltabaseResponseEx';
  END;

 EXPORT AlertMessages := MODULE
    EXPORT IDTheftMessage           := 'The subject of this consumer report currently has an Identity Theft Alert on file preventing the return of some or all of the information you requested.';
    EXPORT FraudMessage             := 'The subject of this consumer report currently has a Security Fraud Alert on file preventing the return of the information you requested.  If the consumer would like their Security Fraud Alert lifted please instruct them to call LexisNexis Risk Solutions Inc. at 800-456-1244.';
    EXPORT FreezeMessage            := 'The subject of this consumer report currently has a Security Freeze on file preventing the return of the information you requested.  If the consumer would like their Security Freeze lifted please instruct them to call LexisNexis Risk Solutions Inc. at 800-456-1244.';
    EXPORT ConsumerPhoneMessage     := 'The consumer has provided the following phone number for verification purposes: ';
 END;

	EXPORT LegalFlag := MODULE
		EXPORT Hold := 'H';
		EXPORT SuppressAll := 'SA';
		EXPORT SuppressProduct := 'SP';
	END;
	
 EXPORT RecordTypes := MODULE
    EXPORT CS   := 'CS'; // Consumer Level Consumer Statement
    EXPORT RS   := 'RS'; // Record Level Record Statement
    EXPORT DR   := 'DR'; // Record Level Dispute Record
    EXPORT SR   := 'SR'; // Record Level Long Term Supression Record
    EXPORT HS   := 'HS'; // Consumer Level Header Statement
    EXPORT SF   := 'SF'; //  Consumer Level Freeze Flag
    EXPORT IT   := 'IT'; //  Consumer Level Identity Theft Flag
    EXPORT FA   := 'FA'; //  Consumer Level Fraud Alert Flag
    EXPORT LA   := 'LA'; // Consumer Level Legal Alert Flag
    EXPORT LH   := 'LH'; // Consumer Level Legal Hold Flag
    EXPORT AA   := 'AA'; // Consumer Level Attorney Alert Flag
    
    EXPORT ConsumerLevel := [CS,HS,SF,IT,FA,LA,LH,AA];
    EXPORT RecordLevel   := [RS,DR,SR];

  END;
  
  EXPORT EventTypes := MODULE
    EXPORT DEL := 'DEL'; // Event Type DELete
    EXPORT ADD := 'ADD'; // Event Type ADD
  END;
  
  EXPORT DataGroups := MODULE
    EXPORT ACTIVITY                            := 'ACTIVITY';
    EXPORT ADDRESS                              := 'ADDRESS'; 
    EXPORT ADVO                                    := 'ADVO';
    EXPORT AIRCRAFT                            := 'AIRCRAFT';
    EXPORT AIRCRAFT_DETAILS            := 'AIRCRAFT_DETAILS';
    EXPORT AIRCRAFT_ENGINE              := 'AIRCRAFT_ENGINE';
    EXPORT ASSESSMENT                        := 'ASSESSMENT';
    EXPORT ATF                                      := 'ATF'; 
    EXPORT AVM                                      := 'AVM';
    EXPORT AVM_MEDIANS                      := 'AVM_MEDIANS';
    EXPORT BANKRUPTCY_MAIN              := 'BANKRUPTCY_MAIN';
    EXPORT BANKRUPTCY_SEARCH          := 'BANKRUPTCY_SEARCH';
    EXPORT CCW                                      := 'CCW';
    EXPORT COURT_OFFENSES                 := 'COURT_OFFENSE';
    EXPORT DEED                                    := 'DEED';
    EXPORT DID_DEATH                          := 'DID_DEATH';
    EXPORT EMAIL_DATA                        := 'EMAIL_DATA';
    EXPORT GONG                                    := 'GONG';
    EXPORT HDR                                      := 'HDR';
    EXPORT HUNTING_FISHING              := 'HUNTING_FISHING';
    EXPORT IBEHAVIOR_CONSUMER        := 'IBEHAVIOR_CONSUMER';
    EXPORT IBEHAVIOR_PURCHASE        := 'IBEHAVIOR_PURCHASE';
    EXPORT IMPULSE                              := 'IMPULSE';
    EXPORT INFUTOR                              := 'INFUTOR';
    EXPORT INFUTORCID                        := 'INFUTORCID';
    EXPORT INQUIRIES                          := 'INQUIRIES';
    EXPORT LIEN_MAIN                          := 'LIEN_MAIN';
    EXPORT LIEN_PARTY                        := 'LIEN_PARTY';
    EXPORT MARI                                    := 'MARI';
    EXPORT MARRIAGE                            := 'MARRIAGE';
    EXPORT MARRIAGE_SEARCH              := 'MARRIAGE_SEARCH';
    EXPORT OFFENDERS                           := 'OFFENDER';
    EXPORT OFFENDERS_PLUS                := 'OFFENDERS_PLUS';
    EXPORT OFFENSES                             := 'OFFENSE';
    EXPORT PAW                                      := 'PAW';
    EXPORT PERSON                                := 'PERSON';
    EXPORT PILOT_CERTIFICATE          := 'PILOT_CERTIFICATE';
    EXPORT PILOT_REGISTRATION        := 'PILOT_REGISTRATION';
    EXPORT PROFLIC                              := 'PROFLIC';
    EXPORT PROPERTY                            := 'PROPERTY';
    EXPORT PROPERTY_SEARCH              := 'PROPERTY_SEARCH';
    EXPORT PUNISHMENT                        := 'PUNISHMENT';
    EXPORT SEARCH                                := 'SEARCH';
    EXPORT SO_MAIN                              := 'SO_MAIN';
    EXPORT SO_OFFENSES                      := 'SO_OFFENSES';
    EXPORT SSN                                      := 'SSN';
    EXPORT STUDENT                              := 'STUDENT';
    EXPORT STUDENT_ALLOY                  := 'STUDENT_ALLOY';
    EXPORT THRIVE                                := 'THRIVE';
    EXPORT UCC                                      := 'UCC';
    EXPORT UCC_PARTY                          := 'UCC_PARTY';
    EXPORT WATERCRAFT                        := 'WATERCRAFT';
    EXPORT WATERCRAFT_COASTGUARD  := 'WATERCRAFT_COASTGUARD';
    EXPORT WATERCRAFT_DETAILS        := 'WATERCRAFT_DETAILS';
  END;

	EXPORT security_freeze_default_codes := '110,112,114,115,118,121,127,129,132,211,212,214,216,218,219,220,221,222,223,224,225,226,227,228,230,231,233,234,235'; // all new codes, minus the collections purpose (113)
END;
  
