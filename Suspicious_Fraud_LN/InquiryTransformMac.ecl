/* This MACRO performs the common inquiry calculations and returns the raw inquiries */

IMPORT Inquiry_AccLogs, Suspicious_Fraud_LN, UT;

EXPORT InquiryTransformMac (TransformName, OutputLayout, KeyName, getDID = FALSE) := MACRO
	OutputLayout TransformName(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, KeyName ri) := TRANSFORM
		#IF(getDID)
		SELF.did := le.Clean_Input.did;
		#END
		SELF.Seq := le.Seq;
		
		SELF.Transaction_ID := StringLib.StringToUpperCase(TRIM(ri.Search_Info.Transaction_ID));
		SELF.Sequence_Number := StringLib.StringToUpperCase(TRIM(ri.Search_Info.Sequence_Number));
		Date := TRIM(StringLib.StringFilter(ri.search_info.datetime[1..8], '0123456789'));
		Time := TRIM(StringLib.StringFilter(ri.search_info.datetime[10..15], '0123456789'));
		LogDate := IF(LENGTH(Date) = 8, Date, ''); // Make sure we have a valid 8 byte date
		LogTime := IF(LENGTH(Time) = 6, Time, ''); // Make sure we have a valid 6 byte time (HHMMSS)
		SELF.LogDate := LogDate;
		SELF.LogTime := LogTime;
		
		// Remove ALL spaces from the following to prevent silly things like Industry = PAY DAY OR Industry = PAYDAY
		Industry := StringLib.StringToUpperCase(TRIM(ri.Bus_Intel.Industry, ALL));
		Vertical := StringLib.StringToUpperCase(TRIM(ri.Bus_Intel.Vertical, ALL));
		Sub_Market := StringLib.StringToUpperCase(TRIM(ri.Bus_Intel.Sub_Market, ALL));
		Func := StringLib.StringToUpperCase(TRIM(ri.Search_Info.Function_Description));
		Product_Code := StringLib.StringToUpperCase(TRIM(ri.Search_Info.Product_Code));
		SELF.Industry := Industry;
		SELF.Vertical := Vertical;
		SELF.Sub_Market := Sub_Market;
		SELF.Func := Func;
		SELF.Product_Code := Product_Code;
		
		InputFirstName := le.Clean_Input.FirstName;
		InputMiddleName := le.Clean_Input.MiddleName;
		InputMiddleInitial := le.Clean_Input.MiddleInitial;
		InputLastName := le.Clean_Input.LastName;
		
		FirstName := StringLib.StringToUpperCase(TRIM(ri.Person_Q.FName, LEFT, RIGHT));
		MiddleNameTemp := StringLib.StringToUpperCase(TRIM(ri.Person_Q.MName, LEFT, RIGHT));
		MiddleName := MiddleNameTemp;
		MiddleInitial := MiddleNameTemp[1];
		LastName := StringLib.StringToUpperCase(TRIM(ri.Person_Q.LName, LEFT, RIGHT));
		
		// If the customer enters the First, Middle and Last, only consider it a match if all 3 match
		MiddleInput := TRIM(InputMiddleName) <> '' OR TRIM(InputMiddleInitial) <> '';
		FullInput := TRIM(InputFirstName) <> '' AND MiddleInput AND TRIM(InputLastName) <> '';

		NameMatch := MAP(FullInput AND InputFirstName = FirstName AND InputLastName = LastName AND 
																																					InputMiddleName = MiddleName AND MiddleName <> ''							=> TRUE, // Customer entered full name, only count as a match if the full name matches
										 FullInput AND InputFirstName = FirstName AND InputLastName = LastName AND 
																																			InputMiddleInitial = MiddleInitial AND MiddleInitial <> ''				=> TRUE, // Customer entered full name with middle initial, only count as a match if the full name and initial match
										 NOT MiddleInput AND InputFirstName = FirstName AND InputLastName = LastName																				=> TRUE, // First Name AND Last Name Match, Middle Name not input
										 NOT FullInput AND InputFirstName = FirstName AND 
																										(InputLastName = LastName OR (InputMiddleName = MiddleName AND MiddleInput))				=> TRUE, // First Name AND Last Name OR Middle Name match, Full Name not input, only match on Middle if Middle Input
										 NOT FullInput AND InputFirstName = FirstName AND 
																										(InputLastName = LastName OR (InputMiddleInitial = MiddleInitial AND MiddleInput))	=> TRUE, // First Name AND Last Name OR Middle Initial match, Full Name not input, only match on Middle if Middle Input
																																																																					 FALSE // We don't have a match on name based on these rules!
										);
		
		SELF.Name_Match := NameMatch;
		SELF.Inquiry_Hit := TRUE;
		SELF.SuspiciousFraudFunction := Func IN Inquiry_AccLogs.Shell_Constants.Set_SuspiciousFraud_Function_Names;
		
		now								:= ut.GetTimeDate(); // YYYY-MM-DDHHMMSSw where w is week, so parse this out below
		nowYYYYMMDDHHMMSS	:= IF(le.Clean_Input.ArchiveDate <> 999999, (STRING)le.Clean_Input.ArchiveDate + '01000000', now[1..4] + now[6..7] + now[9..16]);
		logYYYYMMDDHHMMSS	:= LogDate + LogTime;
		secondsApart			:= ut.SecondsApart(logYYYYMMDDHHMMSS, nowYYYYMMDDHHMMSS);
		SELF.AgeInYears		:= TRUNCATE((secondsApart / 31557600)); // Average 31,557,600 seconds per year (365.25 days due to leap year)
		SELF.AgeInMonths	:= TRUNCATE((secondsApart / 2629800)); // Average 2,629,800 seconds per month (Year average / 12 due to different number days per month)
		SELF.AgeInWeeks		:= TRUNCATE((secondsApart / 604800)); // Exactly 604,800 seconds per week
		SELF.AgeInDays		:= TRUNCATE((secondsApart / 86400)); // Exactly 86,400 seconds per day
		SELF.AgeInHours		:= TRUNCATE((secondsApart / 3600)); // Exactly 3,600 seconds per hour
		SELF.AgeInMinutes	:= TRUNCATE((secondsApart / 60)); // Exactly 60 seconds per minute
		SELF.AgeInSeconds	:= secondsApart;
		
		SELF := ri;
	END;
ENDMACRO;