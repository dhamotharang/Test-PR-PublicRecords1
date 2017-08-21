import aid,address,Debt_Settlement;

export Debt_Settlement := 
module
	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091209a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

	EXPORT rkey_debt_settlement__autokey__addressb2	:=
	RECORD
		string28 prim_name;
		string10 prim_range;
		string2 st;
		unsigned4 city_code;
		string5 zip;
		string8 sec_range;
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	END;
	
	EXPORT rkey_debt_settlement__autokey__citystnameb2	:=
	RECORD
		unsigned4 city_code;
		string2	st;
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	END;
	
	EXPORT rkey_debt_settlement__autokey__nameb2	:=
	RECORD
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	END;
	
	EXPORT rkey_debt_settlement__autokey__namewords2	:=
	RECORD
		string40	word;
		string2 state;
		unsigned4 seq;
		unsigned6 bdid;
		unsigned4 lookups;
	END;
	
	EXPORT rkey_debt_settlement__autokey__payload	:=
	RECORD
		unsigned6 																											fakeid;
		unsigned6																												did;
		unsigned1																												did_score;
		unsigned6																												Bdid;
		unsigned1																												bdid_score;
		unsigned8							    																			raw_aid;
		unsigned8							    																			ace_aid;
		string1																													record_type;
		unsigned4 																											dt_vendor_first_reported;
		unsigned4 																											dt_vendor_last_reported;
		Debt_Settlement.layouts.input.Common	 													rawfields;
		Address.Layout_Clean_Name																				clean_attorney_name;
		Address.Layout_Clean182_fips		    														clean_address;
		Debt_Settlement.layouts.Miscellaneous.Cleaned_Phones						clean_phones;
		unsigned8																												__internal_fpos__;
	END;
	
	EXPORT rkey_debt_settlement__autokey__phoneb2	:=
	RECORD
		string7 p7;
		string3 p3;
		string40 cname_indic;
		string40 cname_sec;
		string2 st;
		unsigned6 bdid;
		unsigned4 lookups;
	END;
	
	EXPORT rkey_debt_settlement__autokey__stnameb2	:=
	RECORD
		string2 st;
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	END;
	
	EXPORT rkey_debt_settlement__autokey__zipb2	:=
	RECORD
		integer zip;
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	END;
	
	EXPORT rkey_debt_settlement__bdid :=
	RECORD
		unsigned6																												Bdid;
		unsigned6																												did;
		unsigned1																												did_score;
		unsigned1																												bdid_score;
		unsigned8							    																			raw_aid;
		unsigned8							    																			ace_aid;
		string1																													record_type;
		unsigned4 																											dt_vendor_first_reported;
		unsigned4 																											dt_vendor_last_reported;
		Debt_Settlement.layouts.input.Common	 													rawfields;
		Address.Layout_Clean_Name																				clean_attorney_name;
		Address.Layout_Clean182_fips		    														clean_address;
		Debt_Settlement.layouts.Miscellaneous.Cleaned_Phones						clean_phones;
		unsigned8																												__internal_fpos__;
	END;
	
	EXPORT dkey_debt_settlement__autokey__addressb2 		:= DATASET([]	,rkey_debt_settlement__autokey__addressb2);
	EXPORT dkey_debt_settlement__autokey__citystnameb2 	:= DATASET([]	,rkey_debt_settlement__autokey__citystnameb2);
	EXPORT dkey_debt_settlement__autokey__nameb2		 		:= DATASET([]	,rkey_debt_settlement__autokey__nameb2);
	EXPORT dkey_debt_settlement__autokey__namewords2 		:= DATASET([]	,rkey_debt_settlement__autokey__namewords2);
	EXPORT dkey_debt_settlement__autokey__payload			 	:= DATASET([]	,rkey_debt_settlement__autokey__payload);
	EXPORT dkey_debt_settlement__autokey__phoneb2 			:= DATASET([]	,rkey_debt_settlement__autokey__phoneb2);
	EXPORT dkey_debt_settlement__autokey__stnameb2 			:= DATASET([]	,rkey_debt_settlement__autokey__stnameb2);
	EXPORT dkey_debt_settlement__autokey__zipb2 				:= DATASET([]	,rkey_debt_settlement__autokey__zipb2);
	EXPORT dkey_debt_settlement__bdid 									:= DATASET([]	,rkey_debt_settlement__bdid);
end;
