import EBR,ut;

export mapping_4510_ucc_filings(string filedate) := function

File_4510_ucc_filings := EBR.File_Sprayed_Input(segment_code = '4510');

Layout_4510_ucc_filings_tmp :=	record
	string10 FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string6		DATE_FILED_YYMMDD;
	string2		TYPE_CODE;
	string10	TYPE_DESC;
	string2		ACTION_CODE;
	string10	ACTION_DESC;
	string16	DOCUMENT_NUMBER;
	string20	FILING_LOCATION;
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
	string7		ADDTNL_COLL_CODES;
	string60	SECURED_PARTY;
	string60	ASSIGNEE;
	string2		ORIG_FILE_STATE_CODE;
	string20	ORIG_FILE_STATE_DESC;
	string16	ORIG_FILE_NUMBER;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
end;

rec := record
	string503 allcat;
end;

rec ebr_4510(File_4510_ucc_filings le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_4510_prj := project(File_4510_ucc_filings,ebr_4510(LEFT));

Layout_4510_ucc_filings_tmp ebr_4510_trans(ebr_4510_prj le) := transform
	self.FILE_NUMBER					:= le.allcat[1..10]; 
	self.SEGMENT_CODE					:= le.allcat[11..14]; 
	self.SEQUENCE_NUMBER			:= le.allcat[15..19]; 
	self.DATE_FILED_YYMMDD		:= le.allcat[26..31]; 
	self.TYPE_CODE						:= le.allcat[32..33]; 
	self.TYPE_DESC						:= le.allcat[34..43]; 
	self.ACTION_CODE					:= le.allcat[44..45]; 
	self.ACTION_DESC					:= le.allcat[46..55]; 
	self.DOCUMENT_NUMBER			:= le.allcat[56..71]; 
	self.FILING_LOCATION			:= le.allcat[72..91]; 
	self.COLL_CODE1						:= le.allcat[92]; 
	self.COLL_DESC1						:= le.allcat[93..128]; 
	self.COLL_CODE2						:= le.allcat[129]; 
	self.COLL_DESC2						:= le.allcat[130..165]; 
	self.COLL_CODE3						:= le.allcat[166]; 
	self.COLL_DESC3						:= le.allcat[167..202]; 
	self.COLL_CODE4						:= le.allcat[203]; 
	self.COLL_DESC4						:= le.allcat[204..239]; 
	self.COLL_CODE5						:= le.allcat[240]; 
	self.COLL_DESC5           :=  le.allcat[241..276]; 
	self.COLL_CODE6						:= le.allcat[277]; 
	self.COLL_DESC6						:= le.allcat[278..313]; 
	self.ADDTNL_COLL_CODES		:= le.allcat[314..320]; 
	self.SECURED_PARTY				:= le.allcat[321..380]; 
	self.ASSIGNEE							:= le.allcat[381..440]; 
	self.ORIG_FILE_STATE_CODE	:= le.allcat[441..442]; 
	self.ORIG_FILE_STATE_DESC	:= le.allcat[443..462]; 
	self.ORIG_FILE_NUMBER			:= le.allcat[463..478]; 
	self.DISPUTE_IND					:= le.allcat[479]; 
	self.DISPUTE_CODE					:= le.allcat[480..481]; 
end;

File_4510_layout := project(ebr_4510_prj,ebr_4510_trans(LEFT));

EBR.Layout_4510_ucc_filings_In ebr_4510_ucc_filings_tr(File_4510_layout l) := transform
	self.orig_DATE_FILED_YYMMDD	:=	l.Date_Filed_YYMMDD;
	self.date_filed							:=	if(l.Date_Filed_YYMMDD[1..2] > '50','19'+l.Date_Filed_YYMMDD[1..2]+l.Date_Filed_YYMMDD[3..4]+l.Date_Filed_YYMMDD[5..6],'20'+l.Date_Filed_YYMMDD[1..2]+l.Date_Filed_YYMMDD[3..4]+l.Date_Filed_YYMMDD[5..6]);
	self.process_date						:=	filedate;
	self 												:=	l;
	self												:=	[];
end;

Filenm_4510_ucc_filings:= project(File_4510_layout,ebr_4510_ucc_filings_tr(LEFT));

FileName_4510_tr := '~thor_data400::in::ebr_4510_ucc_filings_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_4510_' + trim(decode_segments('4510'))),
												output(Filenm_4510_ucc_filings,,FileName_4510_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_4510_' + trim(decode_segments('4510')),FileName_4510_tr);

return sequential(Out_File,add_file);
end;