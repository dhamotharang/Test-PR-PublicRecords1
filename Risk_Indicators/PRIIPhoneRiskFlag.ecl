export PRIIPhoneRiskFlag (STRING10 phone_in) :=
MODULE
import ut;


	export isCellular(STRING2 nxxtype)     := nxxtype='04' or nxxtype='55' or nxxtype='60';
	export isMobile(STRING2 nxxtype)	    := nxxtype='01' or nxxtype='57' or nxxtype='62';
	export isPaging(STRING2 nxxtype)       := nxxtype='02' or nxxtype='56' or nxxtype='61';
	export isPCS(STRING2 nxxtype)          := nxxtype='64' or nxxtype='65';
	shared isOtherNonPOTS(STRING2 nxxtype) := nxxtype='58' or nxxtype='63' or nxxtype='67' or nxxtype='68' or nxxtype='03' or
									  nxxtype='05' or nxxtype='06' or nxxtype='07' or nxxtype='09' or nxxtype='10' or
									  nxxtype='11' or nxxtype='13' or nxxtype='14' or nxxtype='15' or nxxtype='16' or
									  nxxtype='17' or nxxtype='88' or nxxtype='30';



	shared isEmptyPhone 	:= (INTEGER)phone_in = 0 or length(TRIM(phone_in)) < 6;


	// Replicate code from the RW PRIIPhoneRiskFlag function

	export PhoneRiskFlag(STRING2 nxxtype, BOOLEAN disco, STRING4 sic) := MAP(disco => '5',
															   isEmptyPhone => '7',
															   isCellular(nxxtype) or isMobile(nxxtype) => '1',
															   isPaging(nxxtype) => '2',
															   isPCS(nxxtype) => '3',
															   isOtherNonPOTS(nxxtype) => '4',
															   sic <> '' => '6',
															   '0');


	shared isPayPhone(STRING2 nxxtype)	     := nxxtype='16' or TRIM(phone_in)[7] = '9'; // if 7th byte of the phone is a 9, it's a potential pay phone
	shared isTollFree := phone_in[1..3] in ['800', '866', '877', '888'];
	isStandardService(STRING2 nxxtype) := nxxtype='00' or nxxtype='50' or nxxtype='51' or nxxtype='54' or nxxtype='66' or nxxtype='52' ;
	isSpecialNumber(STRING2 nxxtype)	:= nxxtype='57' or nxxtype='63' or nxxtype='67' or nxxtype='68' or nxxtype='03' or nxxtype='05' or
								   nxxtype='06' or nxxtype='07' or nxxtype='10' or nxxtype='11' or nxxtype='13' or nxxtype='14' or
								   nxxtype='15' or nxxtype='16' or nxxtype='17' or nxxtype='88';



	export PWphoneRiskFlag(STRING2 nxxtype, STRING4 sic, STRING1 phoneType='1') := MAP(sic <> '' => '5',
									    isEmptyPhone => 'Z',
									    phoneType in ['3','4'] => '7',
									    phoneType = '5' => 'U',
									    isStandardService(nxxtype) => '0',
									    isCellular(nxxtype) => '1',
									    isPaging(nxxtype) => '2',
									    isPCS(nxxtype) or isMobile(nxxtype) => '3',
									    isTollFree => '6',
									    isPayPhone(nxxtype) => 'A',
									    isSpecialNumber(nxxtype) => '9',
									    'U');

	export isPOTS(STRING2 nxxtype) := nxxtype='00' or nxxtype='50' or nxxtype='51' or
							    nxxtype='54' or nxxtype='66' or nxxtype='52';

	isDirectoryAssistance := phone_in[4..10]='5551212';

	export patriotPhoneType(string2 nxxtype) := MAP(isEmptyPhone => 'B',
										   isDirectoryAssistance => 'A',
										   isTollFree => '4',
										   isCellular(nxxtype) => '7',
										   isPaging(nxxtype) => '8',
										   isPayPhone(nxxtype) => '5',
										   isPots(nxxtype) => '0',
										   'Z');

	// returns phonetype that is built onto the telcordia file in st. cloud.  this does it at runtime
	// dialable-us, nondialable-us, dialable-nonUS, nondialable-nonUS
	export telcordiaPhoneType(string1 dial_ind, string1 point_id) := map( dial_ind='1' and point_id in['0','3','6'] => '1',
															dial_ind='0' and point_id in['0','3','6'] => '2',
															dial_ind='1' and point_id ~in['0','3','6'] => '3',
															dial_ind='0' and point_id ~in['0','3','6'] => '4',
															'');

	export telcordiaServiceType(string2 nxxtype) := map(nxxtype='00' => '1',
																											nxxtype='01' => '5',
																											nxxtype='02' => '8',
																											nxxtype='03' => '12',
																											nxxtype='04' => '10',
																											nxxtype='05' => '13',
																											nxxtype='06' => '14',
																											nxxtype='07' => '15',
																											nxxtype='09' => '17',
																											nxxtype='10' => '18',
																											nxxtype='11' => '19',
																											nxxtype='13' => '21',
																											nxxtype='15' => '23',
																											nxxtype='16' => '24',
																											nxxtype='17' => '25',
																											nxxtype='30' => '29',
																											nxxtype='50' => '2',
																											nxxtype='51' => '3',
																											nxxtype='52' => '4',
																											nxxtype='54' => '3',
																											nxxtype='55' => '11',
																											nxxtype='56' => '9',
																											nxxtype='57' => '6',
																											nxxtype='58' => '7',
																											nxxtype='60' => '11',
																											nxxtype='61' => '9',
																											nxxtype='62' => '6',
																											nxxtype='63' => '7',
																											nxxtype='64' => '28',
																											nxxtype='65' => '28',
																											nxxtype='66' => '3',
																											nxxtype='67' => '7',
																											nxxtype='68' => '7',
																											'0');



	// Phone Validation Flag
	//gongRes := dx_Gong.key_history_phone()(p7=phone_in[4..10],p3=phone_in[1..3],current_flag);

//	export PhoneValidFlag := MAP(~EXISTS(tpm) and length(TRIM(phone_in))>=6 => 0,
//						    gongRes[1].business_flag => 1,
//						    ~gongRes[1].business_flag and EXISTS(gongRes) => 2,
//						    ~EXISTS(gongRes) and length(TRIM(phone_in))>=10 => 3,
//						    4);


END;
