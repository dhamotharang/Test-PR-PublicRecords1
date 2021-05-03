IMPORT $, MDR, PRTE2, ut, STD, VersionControl;

EXPORT InfutorWP_ingest_prep := FUNCTION

fIn_Raw := CanadianPhones.file_InfutorWP().RawIn;

prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output

//Map to Base
CanadianPhones.Layout_InfutorWP.BaseOut xfrmFields(ClnRawIn L) := TRANSFORM
	SELF.Date_first_reported	:= (string)VersionControl.fGetFilenameVersion('~thor_data400::in::infutorwp');//thorlib.wuid()[2..9];
	SELF.Date_last_reported		:= (string)VersionControl.fGetFilenameVersion('~thor_data400::in::infutorwp');

	SELF.vendor					:= 'I7';
	SELF.Source_file		:= 'INFUTOR_WHITEPAGES';
	SELF.lastname				:= L.CAN_LNAME;
	SELF.firstname			:= STD.Str.CleanSpaces(REGEXREPLACE('_|=',L.CAN_FNAME,' '));
	SELF.generational		:= L.CAN_SUFFIX;
	SELF.title					:= L.CAN_TITLE;
	SELF.housenumber		:= L.CAN_HOUSE;
	SELF.directional		:= L.CAN_PREDIR;
	SELF.streetname			:= TRIM(L.CAN_STREET) +' '+ TRIM(L.CAN_STRTYPE);
	SELF.streetsuffix		:= L.CAN_POSTDIR;
	SELF.suitenumber		:= TRIM(L.CAN_APTTYPE) +' '+TRIM(L.CAN_APTNBR);
	SELF.postalcity			:= L.CAN_CITY;
	SELF.province				:= L.CAN_PROVINCE;
	SELF.postalcode			:= L.CAN_POSTALCD;
	SELF.phonenumber		:= STD.Str.Filter(L.CAN_PHONE,'1234567890');
	SELF.company_name			:= IF(L.CAN_RECTYPE = 'B', L.CAN_LNAME, '');
	SELF.Record_ID				:= 0; //TBD
	SELF.city							:= L.CAN_CITY;
	SELF.Record_Type			:= IF(L.CAN_RECTYPE = 'R', 'R', '');
	SELF.Bus_Govt_Indicator	:= IF(L.CAN_RECTYPE = 'B', '1', '');
	SELF.listing_type			:= L.CAN_RECTYPE;
	SELF									:= L;
	SELF									:= [];
END;

	df_out	:= PROJECT(ClnRawIn, xfrmFields(LEFT));

RETURN df_out;
END;
