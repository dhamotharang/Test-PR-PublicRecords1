export XML_Telcordia := 

module

	shared	lSubDirName					:=	'';
	shared	lXMLVersion					:=	'20081015';
	shared	lXMLFileNamePrefix	:=	PRTE_CSV.Constants.XMLFilesBaseName + lSubDirName;
	
	
export rthor_data400__key__telcordia__tpm_slim :=
record,maxLength(9999)
	string3 npa;
	string3 nxx;
	string1 tb;
	string1 dial_ind;
	string1 point_id;
	string2 nxx_type;
	DATASET({ string5 zip }) zipcodes;
	unsigned integer8 __internal_fpos__;
end;

export dthor_data400__key__telcordia__tpm_slim:= dataset(lXMLFileNamePrefix + 'thor_data400__key__telcordia__' + lXMLVersion + '__tpm_slim.xml', rthor_data400__key__telcordia__tpm_slim, xml('Dataset/Row'));
end;


