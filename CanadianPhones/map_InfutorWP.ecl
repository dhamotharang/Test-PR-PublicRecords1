IMPORT $, Address, PromoteSupers, NID, PRTE2, ut, STD;

EXPORT map_InfutorWP(string8 FileDate) := FUNCTION

fIn_Raw := CanadianPhones.file_InfutorWP.RawIn;

prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output

NID.Mac_CleanParsedNames(ClnRawIn, fClnName, 
													firstname:= CAN_FNAME, lastname:= CAN_LNAME, middlename := '', namesuffix := CAN_SUFFIX
													,includeInRepository:= true, normalizeDualNames:= false, useV2 := true);

person_flags := ['P', 'D'];
business_flags := ['B'];

CanadianPhones.layoutCanadianWhitepagesBase xferFields(fClnName L) := TRANSFORM
	SELF.Date_first_reported	:= FileDate;
	SELF.Date_last_reported		:= FileDate;

	SELF.vendor			:= ' ';
	SELF.Source_file	:= 'INFUTOR_WHITEPAGES';
	SELF.lastname				:= L.CAN_LNAME;
	SELF.firstname			:= L.CAN_FNAME;
	SELF.generational		:= L.CAN_SUFFIX;
	SELF.title					:= L.CAN_TITLE;;
	SELF.housenumber		:= L.CAN_HOUSE;
	SELF.directional		:= L.CAN_PREDIR;
	SELF.streetname			:= TRIM(L.CAN_STREET) +' '+ TRIM(L.CAN_STRTYPE);
	SELF.streetsuffix		:= L.CAN_POSTDIR;
	SELF.suitenumber		:= TRIM(L.CAN_APTTYPE) +' '+TRIM(L.CAN_APTNBR);
	SELF.postalcity			:= L.CAN_CITY;
	SELF.province				:= L.CAN_PROVINCE;
	SELF.postalcode			:= L.CAN_POSTALCD;
	SELF.phonenumber		:= STD.Str.Filter(L.CAN_PHONE,'1234567890');
	
	CleanAddress				:= Address.CleanCanadaAddress109(TRIM(L.CAN_HOUSE)+ ' '+TRIM(L.CAN_STREET)+' '+TRIM(L.CAN_STRTYPE)+ ' '+TRIM(L.CAN_POSTDIR),
																												TRIM(L.CAN_CITY)+ ' ' +TRIM(L.CAN_PROVINCE)+' '+TRIM(L.CAN_POSTALCD)
																												);
	SELF.prim_range 			:= CleanAddress[1..10]; 
	SELF.predir 					:= CleanAddress[11..12];					   
	SELF.prim_name 				:= CleanAddress[13..40];
	SELF.addr_suffix 			:= CleanAddress[41..44];
	SELF.unit_desig 			:= CleanAddress[45..54];
	SELF.sec_range 				:= CleanAddress[55..62];
	SELF.p_city_name 			:= CleanAddress[63..92];
	SELF.state						:= CleanAddress[93..94];
	SELF.zip							:= CleanAddress[95..100];
	SELF.rec_type   			:= CleanAddress[101..102];
	SELF.language 				:= CleanAddress[103];
	SELF.errstat 					:= CleanAddress[104..109];
	SELF.language					:= L.CAN_LANG;
	SELF.company_name			:= IF(L.CAN_RECTYPE = 'B', L.CAN_LNAME, '');
	SELF.Record_ID				:= ''; //TBD
	SELF.city							:= L.CAN_CITY;
	SELF.Record_Type			:= IF(L.CAN_RECTYPE = 'R', 'R', '');
	SELF.Bus_Govt_Indicator	:= IF(L.CAN_RECTYPE = 'B', '1', '');
	SELF.listing_type			:= L.CAN_RECTYPE;
	SELF.name_title 			:= IF(L.nametype in person_flags, L.cln_title, '');
	SELF.fname 						:= IF(L.nametype in person_flags, L.cln_fname, '');
	SELF.mname 						:= IF(L.nametype in person_flags, L.cln_mname, '');
	SELF.lname 						:= IF(L.nametype in person_flags, L.cln_lname, '');
	SELF.name_suffix 			:= IF(L.nametype in person_flags, L.cln_suffix'';
	SELF.name_score 			:= '';
	SELF									:= [];
END;

df_out	:= PROJECT(fClnName, xferFields(LEFT));

PromoteSupers.Mac_SF_BuildProcess(df_out,CanadianPhones.thor_cluster + 'base::infutorwp',buildnewbasefile,3,,true);

RETURN buildnewbasefile;
END;
