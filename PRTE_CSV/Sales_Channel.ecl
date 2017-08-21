import aid,address,saleschannel;

export Sales_Channel := 
module
	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091209a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

	EXPORT rkey_bdid :=
	RECORD
		unsigned6														rid													;
		unsigned6														bdid												;
		unsigned1														bdid_score									;
		unsigned6														did													;
		unsigned1														did_score										;
		unsigned4   												date_first_seen							;
		unsigned4   												date_last_seen							;
		unsigned4   												date_vendor_first_reported	;
		unsigned4   												date_vendor_last_reported		;
		AID.Common.xAID											RawAID											;
		AID.Common.xAID											AceAID											;
		unsigned1  													record_type									; 
		SalesChannel.layouts.input					rawfields										;
		Address.Layout_Clean_Name						clean_name									;
		Address.Layout_Clean182_fips				clean_address								;
		unsigned8														__internal_fpos__						;
	END;

	export dkey_bdid 	:= dataset([]	,rkey_bdid	);
	export dkey_did 	:= dataset([]	,rkey_bdid	);
end;
