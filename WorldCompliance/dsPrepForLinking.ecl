IMPORT STD;
IMPORT ADDRESS;
import ut;

dsMastersUS := WorldCompliance.Files.dsMasters(Country in Filters.usaCountries, EntryType = 'Individual');

//REGEX to find Non Digit Chars
NonDigitChars := '[\\x00-\\x2F\\x3A-\\xA0]';

rAsciiUSNamesAndAddress xForm(WorldCompliance.Layouts.rEntity rEnt, WorldCompliance.Layouts.rAddress rAddr) := TRANSFORM
SELF.Ent_ID 							:= rEnt.Ent_ID;
SELF.LexID 								:= [];
SELF.name 								:= WorldCompliance.UnicodeToAscii(rEnt.name);
SELF.FirstName 						:= WorldCompliance.UnicodeToAscii(rEnt.FirstName);
SELF.LastName 						:= WorldCompliance.UnicodeToAscii(rEnt.LastName);
SELF.Suffix 							:= WorldCompliance.UnicodeToAscii(rEnt.Suffix);
SELF.Dob 									:= rEnt.Dob;
SELF.Dob2 								:= rEnt.Dob2;
SELF.NationalId						:= rEnt.NationalId;
SELF.EntryType						:= rEnt.EntryType;

SELF.Gender								:= rEnt.Gender;

SELF.FName 								:= STD.STr.GetNthWord(WorldCompliance.UnicodeToAscii(rEnt.FirstName),1);
SELF.MiddleName 					:= STD.STr.GetNthWord(WorldCompliance.UnicodeToAscii(rEnt.FirstName),2);

SELF.Clean_Dob 						:= MAP(
				REGEXFIND('^[0-9]{4}$',rEnt.Dob) => rEnt.Dob+'0000',				// year
				ut.ConvertDate(rEnt.Dob,'%B %d, %Y') <> '' => ut.ConvertDate(rEnt.Dob,'%B %d, %Y',	'%Y%m%d'),	// MON dd, yyyy
				ut.ConvertDate(rEnt.Dob,'%B %Y') <> '' => ut.ConvertDate(rEnt.Dob,'%B %Y',	'%Y%m%d'),	// MON yyyy
				ut.ConvertDate(rEnt.Dob,'%B, %Y') <> '' => ut.ConvertDate(rEnt.Dob,'%B, %Y',	'%Y%m%d'),	// MON yyyy
				ut.ConvertDate(rEnt.Dob,'%d %B %Y') <> '' => ut.ConvertDate(rEnt.Dob,'%d %B %Y',	'%Y%m%d'),	// dd MON yyyy
				ut.ConvertDate(rEnt.Dob,'%d %B, %Y') <> '' => ut.ConvertDate(rEnt.Dob,'%d %B, %Y',	'%Y%m%d'),	// dd MON yyyy
				ut.ConvertDate(rEnt.Dob,'%Y.%m.%d') <> '' => ut.ConvertDate(rEnt.Dob,'%Y.%m.%d',	'%Y%m%d'),	// yyyy.mm.dd
				ut.ConvertDate(rEnt.Dob,'%m-%d-%Y') <> '' => ut.ConvertDate(rEnt.Dob,'%m-%d-%Y',	'%Y%m%d'),	// m-d-yyyy
				'');,

IsAllDigits 							:= NOT REGEXFIND(NonDigitChars, rEnt.NationalId);
STRING GetSSN() 					:= if( LENGTH(rEnt.NationalId) = 9 AND IsAllDigits, rEnt.NationalId, '');
SELF.SSN									:= GetSSN();

SELF.Orig_Address 				:= WorldCompliance.UnicodeToAscii(rAddr.Address);
SELF.Orig_City 						:= WorldCompliance.UnicodeToAscii(rAddr.City);
SELF.Orig_SateProvince 		:= WorldCompliance.UnicodeToAscii(rAddr.StateProvince);
SELF.Country 							:= WorldCompliance.UnicodeToAscii(rAddr.Country);
SELF.Orig_PostalCode 			:= WorldCompliance.UnicodeToAscii(rAddr.PostalCode);

STRING sClean_Address			:=	Address.cleanaddress182(SELF.Orig_Address,
   																								SELF.Orig_City+
   																								' '+
   																								SELF.Orig_SateProvince+
   																								' '+
   																								SELF.Orig_PostalCode);
																									
SELF.Clean_Address 				:= sClean_Address[1..64];
SELF.Clean_prim_range 		:= sClean_Address[1..  10];
SELF.Clean_prim_name 			:= sClean_Address[13.. 40];
SELF.Clean_sec_range 			:= sClean_Address[57.. 64];
																								
SELF.Clean_City 					:= sClean_Address[65..89];
SELF.Clean_StateProvince 	:= sClean_Address[115..116];
SELF.Clean_ZipCode		 		:= sClean_Address[117..121];
SELF.Clean_ZipCode4		 		:= sClean_Address[122..125];
SELF.Error_Code 					:= sClean_Address[179..182];

END;


EXPORT dsPrepForLinking := JOIN(dsMastersUS, WorldCompliance.Files.dsAddresses, LEFT.Ent_ID = RIGHT.Ent_ID, xForm(LEFT, RIGHT), LEFT OUTER);