IMPORT PersonContext, STD;

EXPORT CONSTANTS := MODULE

	EXPORT GetDateTimeGMT := std.Date.SecondsToString(Std.date.CurrentSeconds(FALSE), '%Y-%m-%d %H:%M:%S');

  EXPORT StatusCodes := MODULE
		EXPORT  NoSearchRecords               := '401';
		EXPORT  ResultsFound                  := '501';
		EXPORT  NoResultsFound								:= '503';
		EXPORT  RecIDOutOfSequence 						:= '505'; 
		EXPORT  LexidRecidCombinationError    := '506';
	END;

  EXPORT Messages := MODULE	
		EXPORT  NoSearchRecordsMsg            := 'NO VALID INPUT SEARCH KEYS PROVIDED';
		EXPORT  ResultsFoundMsg								:= 'RESULTS FOUND';
		EXPORT  NoResultsFoundMsg							:= 'NO RESULTS FOUND';
		EXPORT 	ESP_Method 										:= 'PersonContextDeltabase';
		EXPORT 	ResultStructure 							:= 'PersonContextDeltabaseResponseEx';
	END;

  EXPORT RecordTypes := MODULE
	  EXPORT CS 	:= 'CS'; // Consumer Level Consumer Statement
		EXPORT RS 	:= 'RS'; // Record Level Record Statement
		EXPORT DR 	:= 'DR'; // Record Level Dispute Record
		EXPORT SR 	:= 'SR'; // Record Level Long Term Supression Record
		EXPORT HS 	:= 'HS'; // Consumer Level Header Statement
		EXPORT HSN 	:= 'HSN'; //Record Level Header Statement Component Name
		EXPORT HSA 	:= 'HSA'; //Record Level Header Statement Component Address
		EXPORT HSD 	:= 'HSD'; //Record Level Header Statement Component Date Of Birth
		EXPORT HSS 	:= 'HSS'; //Record Level Header Statement Component SSN.
		EXPORT HSP 	:= 'HSP'; //Record Level Header Statement Component Phone.
		EXPORT HSL 	:= 'HSL'; //Record Level Header Statement Component DLN.
	  EXPORT SF 	:= 'SF'; //Consumer Level Freeze Flag
		EXPORT IT 	:= 'IT'; //Consumer Level Identity Theft Flag
		EXPORT FA 	:= 'FA'; //Consumer Level Fraud Alert Flag
		
		EXPORT ConsumerLevel := [CS,SF,IT,FA];
		EXPORT RecordLevel := [HS,RS,DR,HSN,HSA,HSD,HSS,HSP,HSL,SR];

	END;
	
	EXPORT EventTypes := MODULE
		EXPORT DEL := 'DEL'; // Event Type DELete
		EXPORT ADD := 'ADD'; // Event Type ADD
	END;
	
	EXPORT DataGroups := MODULE
		EXPORT ACTIVITY								:= 'ACTIVITY';
		EXPORT ADDRESS								:= 'ADDRESS'; 
		EXPORT ADVO										:= 'ADVO';
		EXPORT AIRCRAFT								:= 'AIRCRAFT';
		EXPORT AIRCRAFT_DETAILS				:= 'AIRCRAFT_DETAILS';
		EXPORT AIRCRAFT_ENGINE				:= 'AIRCRAFT_ENGINE';
		EXPORT ASSESSMENT							:= 'ASSESSMENT';
		EXPORT ATF										:= 'ATF'; 
		EXPORT AVM                    := 'AVM';
		EXPORT AVM_MEDIANS						:= 'AVM_MEDIANS';
		EXPORT BANKRUPTCY_MAIN				:= 'BANKRUPTCY_MAIN';
		EXPORT BANKRUPTCY_SEARCH			:= 'BANKRUPTCY_SEARCH';
		EXPORT CCW										:= 'CCW';
		EXPORT COURT_OFFENSES					:= 'COURT_OFFENSE';
		EXPORT DEED										:= 'DEED';
		EXPORT DID_DEATH							:= 'DID_DEATH';
		EXPORT EMAIL_DATA							:= 'EMAIL_DATA';
		EXPORT GONG										:= 'GONG';
		EXPORT HDR										:= 'HDR';
		EXPORT HUNTING_FISHING				:= 'HUNTING_FISHING';
		EXPORT IBEHAVIOR_CONSUMER			:= 'IBEHAVIOR_CONSUMER';
		EXPORT IBEHAVIOR_PURCHASE			:= 'IBEHAVIOR_PURCHASE';
		EXPORT IMPULSE								:= 'IMPULSE';
		EXPORT INFUTOR								:= 'INFUTOR';
		EXPORT INFUTORCID             := 'INFUTORCID';
		EXPORT INQUIRIES							:= 'INQUIRIES';
		EXPORT LIEN_MAIN							:= 'LIEN_MAIN';
		EXPORT LIEN_PARTY							:= 'LIEN_PARTY';
		EXPORT MARI										:= 'MARI';
		EXPORT MARRIAGE								:= 'MARRIAGE';
		EXPORT MARRIAGE_SEARCH				:= 'MARRIAGE_SEARCH';
		EXPORT OFFENDERS 							:= 'OFFENDER';
		EXPORT OFFENDERS_PLUS					:= 'OFFENDERS_PLUS';
		EXPORT OFFENSES               := 'OFFENSE';
		EXPORT PAW										:= 'PAW';
		EXPORT PERSON                 := 'PERSON';
		EXPORT PILOT_CERTIFICATE			:= 'PILOT_CERTIFICATE';
		EXPORT PILOT_REGISTRATION			:= 'PILOT_REGISTRATION';
		EXPORT PROFLIC								:= 'PROFLIC';
		EXPORT PROPERTY								:= 'PROPERTY';
		EXPORT PROPERTY_SEARCH 				:= 'PROPERTY_SEARCH';
		EXPORT PUNISHMENT							:= 'PUNISHMENT';
		EXPORT SEARCH									:= 'SEARCH';
		EXPORT SO_MAIN								:= 'SO_MAIN';
		EXPORT SO_OFFENSES						:= 'SO_OFFENSES';
		EXPORT SSN										:= 'SSN';
		EXPORT STUDENT								:= 'STUDENT';
		EXPORT STUDENT_ALLOY					:= 'STUDENT_ALLOY';
		EXPORT THRIVE									:= 'THRIVE';
		EXPORT UCC										:= 'UCC';
		EXPORT UCC_PARTY							:= 'UCC_PARTY';
		EXPORT WATERCRAFT							:= 'WATERCRAFT';
		EXPORT WATERCRAFT_COASTGUARD	:= 'WATERCRAFT_COASTGUARD';
		EXPORT WATERCRAFT_DETAILS			:= 'WATERCRAFT_DETAILS';
  END;

END;
	
