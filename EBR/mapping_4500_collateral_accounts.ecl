import EBR,ut;

export mapping_4500_collateral_accounts(string filedate) := function

File_4500_collateral_accounts := EBR.File_Sprayed_Input(segment_code = '4500');

Layout_4500_collateral_accounts_tmp :=	record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string3		TOTAL_UCC_FILED;
	string3		COLL_COUNT_UCC;
	string1		COLL_CODE1;
	string36	COLL_DESC1;
	string1		COLL_CODE2;
	string36	COLL_DESC2;
	string1		COLL_CODE3;
	string36	COLL_DESC3;
	string1		COLL_CODE4;
	string36	COLL_DESC4;
	string1		COLL_CODE5;
	string36	COLL_DESC5;
	string1		COLL_CODE6;
	string36	COLL_DESC6;
	string1		COLL_CODE7;
	string36	COLL_DESC7;
	string1		COLL_CODE8;
	string36	COLL_DESC8;
	string1		COLL_CODE9;
	string36	COLL_DESC9;
	string1		COLL_CODE10;
	string36	COLL_DESC10;
	string1		COLL_CODE11;
	string36	COLL_DESC11;
	string1		COLL_CODE12;
	string36	COLL_DESC12;
	string1		ADDTNL_COLL_CODES;
end;

rec := record
	string503 allcat;
end;

rec ebr_4500(File_4500_collateral_accounts le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_4500_prj := project(File_4500_collateral_accounts,ebr_4500(LEFT));

Layout_4500_collateral_accounts_tmp ebr_4500_trans(ebr_4500_prj le) := transform
	self.FILE_NUMBER				:= le.allcat[1..10];   
	self.SEGMENT_CODE				:= le.allcat[11..14];   
	self.SEQUENCE_NUMBER		:= le.allcat[15..19];   
	self.TOTAL_UCC_FILED		:= le.allcat[26..28];   
	self.COLL_COUNT_UCC			:= le.allcat[29..31];   
	self.COLL_CODE1					:= le.allcat[32];   
	self.COLL_DESC1					:= le.allcat[33..68];   
	self.COLL_CODE2					:= le.allcat[69];   
	self.COLL_DESC2					:= le.allcat[70..105];   
	self.COLL_CODE3					:= le.allcat[106];   
	self.COLL_DESC3					:= le.allcat[107..142];   
	self.COLL_CODE4					:= le.allcat[143];   
	self.COLL_DESC4					:= le.allcat[144..179];   
	self.COLL_CODE5					:= le.allcat[180];   
	self.COLL_DESC5					:= le.allcat[181..216];   
	self.COLL_CODE6					:= le.allcat[217];   
	self.COLL_DESC6					:= le.allcat[218..253];   
	self.COLL_CODE7					:= le.allcat[254];   
	self.COLL_DESC7					:= le.allcat[255..290];   
	self.COLL_CODE8					:= le.allcat[291];   
	self.COLL_DESC8					:= le.allcat[292..327];   
	self.COLL_CODE9					:= le.allcat[328];   
	self.COLL_DESC9					:= le.allcat[329..364];   
	self.COLL_CODE10				:= le.allcat[365];   
	self.COLL_DESC10				:= le.allcat[366..400];   
	self.COLL_CODE11				:= le.allcat[401];   
	self.COLL_DESC11				:= le.allcat[402..437];   
	self.COLL_CODE12				:= le.allcat[438];   
	self.COLL_DESC12				:= le.allcat[439..474];   
	self.ADDTNL_COLL_CODES	:= le.allcat[475];   
end;

File_4500_layout := project(ebr_4500_prj,ebr_4500_trans(LEFT));

EBR.Layout_4500_collateral_accounts_In ebr_4500_collateral_accounts_tr(File_4500_layout l) := transform
	self.process_date	:=	filedate;
	self							:=	l;
	self							:=	[];
end;

Filenm_4500_collateral_accounts:= project(File_4500_layout,ebr_4500_collateral_accounts_tr(LEFT));

FileName_4500_tr := '~thor_data400::in::ebr_4500_collateral_accounts_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_4500_' + trim(decode_segments('4500'))),
												output(Filenm_4500_collateral_accounts,,FileName_4500_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_4500_' + trim(decode_segments('4500')),FileName_4500_tr);

return sequential(Out_File,add_file);
end;