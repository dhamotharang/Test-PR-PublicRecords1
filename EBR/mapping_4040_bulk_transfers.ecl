import EBR,ut;

export mapping_4040_bulk_transfers(string filedate) := function

File_4040_bulk_transfers := EBR.File_Sprayed_Input(segment_code = '4040');

Layout_4040_bulk_transfers_tmp :=	record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string6		DATE_FILED_YYMMDD;
	string2		DATE_FILED_YY;
	string2		DATE_FILED_MM;
	string2		DATE_FILED_DD;
	string2		TYPE_CODE;
	string10	TYPE_DESC;
	string2		ACTION_CODE;
	string10	ACTION_DESC;
	string16	DOCUMENT_NUMBER;
	string20	FILING_LOCATION;
	string9		LIABILITY_AMT;
	string35	TRANSFEREE;
	string1		BULK_TRANSFER_CODE;
	string50	BULK_TRANSFER_DESC;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
end;

rec := record
	string503 allcat;
end;

rec ebr_4040(File_4040_bulk_transfers le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_4040_prj := project(File_4040_bulk_transfers,ebr_4040(LEFT));

Layout_4040_bulk_transfers_tmp ebr_4040_trans(ebr_4040_prj le) := transform
	self.FILE_NUMBER				:= le.allcat[1..10];                                                       
	self.SEGMENT_CODE				:= le.allcat[11..14];                                                       
	self.SEQUENCE_NUMBER		:= le.allcat[15..19]; 
	self.DATE_FILED_YYMMDD	:= le.allcat[26..31];                                                     
	self.DATE_FILED_YY			:= le.allcat[32..33];                                                       
	self.DATE_FILED_MM			:= le.allcat[34..35];                                                        
	self.DATE_FILED_DD			:= le.allcat[36..37];                                                   
	self.TYPE_CODE					:= le.allcat[38..39];                                                        
	self.TYPE_DESC					:= le.allcat[40..49];                                                         
	self.ACTION_CODE				:= le.allcat[50..51];                                                        
	self.ACTION_DESC				:= le.allcat[52..61];                                                        
	self.DOCUMENT_NUMBER		:= le.allcat[62..77];                                                         
	self.FILING_LOCATION		:= le.allcat[78..97];                                                        
	self.LIABILITY_AMT			:= le.allcat[98..106];                                                  
	self.TRANSFEREE					:= le.allcat[107..141];                                                           
	self.BULK_TRANSFER_CODE	:= le.allcat[142];                                                        
	self.BULK_TRANSFER_DESC	:= le.allcat[143..192];                                                    
	self.DISPUTE_IND				:= le.allcat[193];                                                         
	self.DISPUTE_CODE				:= le.allcat[194..195];                                                          
end;

File_4040_layout := project(ebr_4040_prj,ebr_4040_trans(LEFT));

EBR.Layout_4040_bulk_transfers_In ebr_4040_bulk_transfers_tr(File_4040_layout l) := transform
	self.orig_DATE_FILED_YYMMDD	:=	l.Date_Filed_YYMMDD;
	self.date_filed							:=	if(l.Date_Filed_YYMMDD[1..2] > '50','19'+l.Date_Filed_YYMMDD[1..2]+l.Date_Filed_YYMMDD[3..4]+l.Date_Filed_YYMMDD[5..6],'20'+l.Date_Filed_YYMMDD[1..2]+l.Date_Filed_YYMMDD[3..4]+l.Date_Filed_YYMMDD[5..6]);
	self.process_date						:=	filedate;
	self												:=	l;
	self												:=	[];
end;

Filenm_4040_bulk_transfers:= project(File_4040_layout,ebr_4040_bulk_transfers_tr(LEFT));

FileName_4040_tr := '~thor_data400::in::ebr_4040_bulk_transfers_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_4040_' + trim(decode_segments('4040'))),
												output(Filenm_4040_bulk_transfers,,FileName_4040_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_4040_' + trim(decode_segments('4040')),FileName_4040_tr);

return sequential(Out_File,add_file);
end;