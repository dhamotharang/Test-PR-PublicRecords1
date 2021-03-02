EXPORT layouts:=MODULE

// LexID Ind Codes	Definitions
// C	The identity is active, comprised of multiple sources, and has an SSN which we think they own
// D	The identity is deceased
// E	A possible newly emerging identity.  Comprised of a single record however seen recently
// I	An identity with no recent activity however in our system is not deceased
// S	This identity has a Best SSN that we think belongs to someone else
// A	The identity is active, comprised of multiple sources, but we can't determine their Best SSN

EXPORT rMetaData := RECORD
	UNSIGNED6 LexID;
	STRING1   lexid_ind := ''; //Active, Deceased, Emerging, Inactive, Suspect, ACtive (but Best SSN undetermined)
	UNSIGNED4 Best_DOB_GLB  := 0;
	UNSIGNED4 Best_DOB_nonGLB := 0;
	STRING2   crlf :='\r\n';
END;

EXPORT rFraudFlags := RECORD
	UNSIGNED6 LexID;
	STRING1   Factact_cd;
	UNSIGNED4 Fraud_Victim_Date_Reported;
	UNSIGNED4 First_Fraud_Victim_Date_Reported;
	UNSIGNED4 Last_Fraud_Victim_Date_Reported;
	STRING1   Fraud_Flag_Ind;
END;

EXPORT rNames := RECORD
	UNSIGNED6 LexID;
 	STRING20  fname;
    STRING20  mname;
    STRING20  lname;
    STRING5   name_suffix;
	STRING1   name_ind := 'C'; //Current Or Former
	boolean   Allowed_for_GLB := true;
	boolean   Allowed_for_nonGLB := false;
	STRING2   crlf :='\r\n';
END;

EXPORT rAddress := RECORD
	UNSIGNED6 LexID;
    STRING10  prim_range;
    STRING2   predir;
    STRING28  prim_name;
    STRING4   suffix;
    STRING2   postdir;
    STRING10  unit_desig;
    STRING8   sec_range;
    STRING25  city_name;
    STRING2   st;
    STRING5   zip;
    STRING4   zip4;
	STRING1   addr_ind := 'C'; //Current Or Former
	UNSIGNED4 Address_Date_First_Seen_for_GLB := 0;
	UNSIGNED4 Address_Date_Last_Seen_for_GLB := 0;
	UNSIGNED4 Address_Date_First_Seen_for_nonGLB := 0;
	UNSIGNED4 Address_Date_Last_Seen_for_nonGLB := 0;
	boolean   Allowed_for_GLB  := true;
	boolean   Allowed_for_nonGLB := false;
	STRING2   crlf :='\r\n';
END;

EXPORT rPhone := RECORD
	UNSIGNED6 LexID;
	STRING10  phone;
	STRING50  phone_type := ''; //LN to provide a list of codes & descriptions such as Landline, Wireless, & VOIP
	STRING1   phone_source := 'D'; //Directory Assistance or PhonesPlus
	STRING1   phone_ind := 'C'; //Include 2 years of phone history as well for the LexID.  Gong History and "below the line" phones in PhonesPlus
	boolean   Allowed_for_GLB := true;
	boolean   Allowed_for_nonGLB;
	STRING2   crlf :='\r\n';
END;

EXPORT rEmail := RECORD
	UNSIGNED6 LexID;
	STRING40  email;
	STRING2   crlf :='\r\n';
END;

EXPORT rRelative := RECORD
	UNSIGNED6 LexID1;
	UNSIGNED6 LexID2;
	STRING1   relation_ind := 'R'; //Relative or Associate
	STRING2   crlf :='\r\n';
END;

END;