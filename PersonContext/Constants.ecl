IMPORT PersonContext, STD;

EXPORT CONSTANTS := MODULE

 EXPORT GetDateTimeGMT := std.Date.SecondsToString(Std.date.CurrentSeconds(FALSE), '%Y-%m-%d %H:%M:%S');

 EXPORT StatusCodes := MODULE
    EXPORT  SoapError                     := '100';
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
    EXPORT  SoapErrorMessage       := 'Soap connection error';
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
		EXPORT HSN 	:= 'HSN'; //Record Level Header Statement Component Name
		EXPORT HSA 	:= 'HSA'; //Record Level Header Statement Component Address
		EXPORT HSD 	:= 'HSD'; //Record Level Header Statement Component Date Of Birth
		EXPORT HSS 	:= 'HSS'; //Record Level Header Statement Component SSN.
		EXPORT HSP 	:= 'HSP'; //Record Level Header Statement Component Phone.
		EXPORT HSL 	:= 'HSL'; //Record Level Header Statement Component DLN.
    EXPORT SF   := 'SF'; //  Consumer Level Freeze Flag
    EXPORT IT   := 'IT'; //  Consumer Level Identity Theft Flag
    EXPORT FA   := 'FA'; //  Consumer Level Fraud Alert Flag
    EXPORT LA   := 'LA'; // Consumer Level Legal Alert Flag
    EXPORT LH   := 'LH'; // Consumer Level Legal Hold Flag
    EXPORT AA   := 'AA'; // Consumer Level Attorney Alert Flag
    
    EXPORT ConsumerLevel := [CS,HS,SF,IT,FA,LA,LH,AA];
		EXPORT RecordLevel := [HS,RS,DR,HSN,HSA,HSD,HSS,HSP,HSL,SR];

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

	EXPORT security_freeze_default_purposes := '110,112,114,115,118,121,127,129,132,211,212,214,216,218,219,220,221,222,223,224,225,226,227,228,230,231,233,234,235'; // all new codes, minus the collections purpose (113)
	
	EXPORT StateCodes := DATASET(
		[{'AL', '110,129,211,219,222,231,233,234,235'},
		{'AK', '110,115,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'AS', '110,129,211,219,222,231,233,234,235'},
		{'AZ', '110,115,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'AR', '110,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'CA', '110,118,121,129,132,211,216,218,219,221,222,225,231,233,234,235'},
		{'CO', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'CT', '110,112,115,129,132,211,212,216,219,222,231,233,234,235'},
		{'DE', '110,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'DC', '110,129,132,211,216,219,222,231,233,234,235'},
		{'FL', '110,112,118,121,129,211,212,218,219,221,222,231,233,234,235'},
		{'GA', '110,129,211,219,222,231,233,234,235'},
		{'GU', '110,129,211,219,222,231,233,234,235'},
		{'HI', '110,115,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'ID', '110,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'IL', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'IN', '110,112,114,118,121,129,132,211,212,214,216,218,219,221,222,231,233,234,235'},
		{'IA', '110,115,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'KS', '110,114,129,211,214,219,222,231,233,234,235'},
		{'KY', '110,112,114,129,211,212,214,219,222,231,233,234,235'},
		{'LA', '110,114,129,211,214,219,222,231,233,234,235'},
		{'ME', '110,118,121,129,132,211,216,218,219,221,222,225,231,233,234,235'},
		{'MD', '110,129,211,219,222,231,233,234,235'},
		{'MA', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'MI', '110,129,211,219,222,231,233,234,235'},
		{'MN', '110,112,129,132,211,212,216,219,222,231,233,234,235'},
		{'MS', '110,129,132,211,219,222,231,233,234,235'},
		{'MO', '110,115,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'MT', '110,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'NE', '110,112,129,132,211,212,216,219,222,231,233,234,235'},
		{'NV', '110,115,129,132,211,219,222,225,231,233,234,235'},
		{'NH', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'NJ', '110,118,121,129,132,211,216,218,219,221,222,225,231,233,234,235'},
		{'NM', '110,129,211,219,222,231,233,234,235'},
		{'NY', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235,225'},
		{'NC', '110,129,211,219,222,231,233,234,235'},
		{'ND', '110,112,129,211,212,219,222,231,233,234,235'},
		{'MP', '110,129,211,219,222,231,233,234,235'},
		{'OH', '110,129,132,211,216,219,222,231,233,234,235'},
		{'OK', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'OR', '110,115,129,211,219,222,231,233,234,235'},
		{'PA', '110,114,129,132,211,214,216,219,222,231,233,234,235'},
		{'PR', '110,129,211,219,222,231,233,234,235'},
		{'RI', '110,115,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'SC', '110,129,211,219,222,231,233,234,235'},
		{'SD', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'TN', '110,115,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'TX', '110,129,132,211,216,219,222,231,233,234,235'},
		{'UT', '110,115,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'VT', '110,115,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'VI', '110,129,211,219,222,231,233,234,235'},
		{'VA', '110,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'WA', '110,118,121,129,132,211,216,218,219,221,222,231,233,234,235'},
		{'WV', '110,115,118,121,129,211,218,219,221,222,231,233,234,235'},
		{'WI', '110,118,121,129,132,211,218,219,221,222,231,233,234,235'},
		{'WY', '110,115,118,121,129,211,218,219,221,222,231,233,234,235'}],	Layouts.Layout_StateCodes);
END;
  
