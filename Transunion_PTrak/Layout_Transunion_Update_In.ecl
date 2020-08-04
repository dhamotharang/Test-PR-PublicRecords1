//-----------------------------------------------------
//Layout defined in P-Trak Convertion Instructions Doc
//-----------------------------------------------------
export Layout_Transunion_Update_In := RECORD
	STRING1 RECORDTYPE;
	STRING15 FIRSTNAME;
	STRING15 MIDDLENAME;
	STRING25 LASTNAME;
	STRING2 PREFIX;
	STRING3 SUFFIX;
	STRING11 PARTYID;
	STRING9 SSN;
	STRING32 AKA1;
	STRING32 AKA2;
	STRING32 AKA3;
	STRING10 TELEPHONE;
	STRING14 FILLER1;
	STRING1 ADDRESSSTANDARDIZATION;
	STRING8 FILESINCEDATE; // From the vendor: :  Date that this consumer’s record was compiled by the data provider
	STRING6 HOUSENUMBER;
	STRING2 STREETTYPE;
	STRING2 STREETDIRECTION;
	STRING27 STREETNAME;
	STRING5 APARTMENTNUMBER;
	STRING27 CITY;
	STRING2 STATE;
	STRING5 ZIPCODE;
	STRING4 ZIP4;
	STRING14 FILLER2;
	STRING8 COMPILATIONDATE; // From the vendor: Date that this particular record was added to the database.  
	STRING8 BIRTHDATE;
	STRING1 BIRTHDATEIND;							               
	STRING1 DECEASEDINDICATOR;
	STRING10 DECEASEDDATE; //field added on 20120219 full update
END;
