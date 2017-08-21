export New_Suppression := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20081205';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__new_suppression__link_type_link_id	:=
record
	string5 linking_type;
	string20 linking_id;
	string15 document_type;
	string60 document_id;
	unsigned integer4 date_added;
	string25 user;
	string25 compliance_id;
	unsigned integer8 __internal_fpos__;
	end;

export dthor_data400__key__new_suppression__link_type_link_id := dataset(lCSVFileNamePrefix + 'thor_data400__key__new_suppression__' + lCSVVersion + '__link_type_link_id.csv', rthor_data400__key__new_suppression__link_type_link_id, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;