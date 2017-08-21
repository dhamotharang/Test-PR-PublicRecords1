import EBR,ut;

export mapping_4010_bankruptcy(string filedate) := function

File_4010_bankruptcy := EBR.File_Sprayed_Input(segment_code = '4010');

Layout_4010_trade_payment_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string6		DATE_FILED_YYMMDD;
	string2		TYPE_CODE;
	string10	TYPE_DESC;
	string2		ACTION_CODE;
	string10	ACTION_DESC;
	string16	DOCUMENT_NUMBER;
	string9		LIABILITY_AMT;
	string9		ASSET_AMT;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
end;

rec := record
	string503 allcat;
end;

rec ebr_4010(File_4010_bankruptcy le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_4010_prj := project(File_4010_bankruptcy,ebr_4010(LEFT));

Layout_4010_trade_payment_tmp ebr_4010_trans(ebr_4010_prj le) := transform
	self.FILE_NUMBER				:= le.allcat[1..10];       
	self.SEGMENT_CODE				:= le.allcat[11..14];         
	self.SEQUENCE_NUMBER		:= le.allcat[15..19];         
	self.DATE_FILED_YYMMDD	:= le.allcat[26..31];     
	self.TYPE_CODE					:= le.allcat[32..33];         
	self.TYPE_DESC					:= le.allcat[34..43];         
	self.ACTION_CODE				:= le.allcat[44..45];     
	self.ACTION_DESC				:= le.allcat[46..55];         
	self.DOCUMENT_NUMBER		:= le.allcat[56..71];         
	self.LIABILITY_AMT			:= le.allcat[72..80];         
	self.ASSET_AMT					:= le.allcat[81..89];         
	self.DISPUTE_IND				:= le.allcat[90];             
	self.DISPUTE_CODE				:= le.allcat[91..92]; 
end;

File_4010_layout := project(ebr_4010_prj,ebr_4010_trans(LEFT));

EBR.Layout_4010_bankruptcy_In ebr_4010_bankruptcy_tr(File_4010_layout l) := transform
	self.orig_DATE_FILED_YYMMDD	:=	l.DATE_FILED_YYMMDD;
	self.date_filed							:=	if(l.DATE_FILED_YYMMDD[1..2] > '50','19'+l.DATE_FILED_YYMMDD[1..2]+l.DATE_FILED_YYMMDD[3..4]+l.DATE_FILED_YYMMDD[5..6],'20'+l.DATE_FILED_YYMMDD[1..2]+l.DATE_FILED_YYMMDD[3..4]+l.DATE_FILED_YYMMDD[5..6]);
	self.process_date						:=	filedate;
	self												:=	l;
	self												:=	[];
end;

Filenm_4010_bankruptcy:= project(File_4010_layout,ebr_4010_bankruptcy_tr(LEFT));

FileName_4010_tr := '~thor_data400::in::ebr_4010_bankruptcy_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_4010_' + trim(decode_segments('4010'))),
												output(Filenm_4010_bankruptcy,,FileName_4010_tr,overwrite,__compressed__)
											 );

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_4010_' + trim(decode_segments('4010')),FileName_4010_tr);

return sequential(Out_File,add_file);
end;