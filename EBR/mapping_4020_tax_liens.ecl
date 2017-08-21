import EBR,ut;

export mapping_4020_tax_liens(string filedate) := function

File_4020_tax := EBR.File_Sprayed_Input(segment_code = '4020');

Layout_4020_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string6		Date_Filed_YMD;
	string2		Type_Code;
	string10	Type_Description;
	string2		Action_Code;
	string10	Action_Description;
	string16	Document_Number;
	string20	Filing_Location;
	string9		Liability_Amount;
	string1		Tax_Lien_Code;
	string50	Tax_Lien_Description;
	string1		Dispute_Indicator;
	string2		Dispute_Code;
end;

rec := record
	string503 allcat;
end;

rec ebr_1000(File_4020_tax le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

prj := project(File_4020_tax,ebr_1000(LEFT));

Layout_4020_tmp ebr_4020_trans(prj le) := transform
	self.FILE_NUMBER					:= le.allcat[1..10];              
	self.SEGMENT_CODE					:= le.allcat[11..14];             
	self.SEQUENCE_NUMBER			:= le.allcat[15..19];     
	self.Date_Filed_YMD				:= le.allcat[26..31];           
	self.Type_Code						:= le.allcat[32..33];             
	self.Type_Description			:= le.allcat[34..43];             
	self.Action_Code					:= le.allcat[44..45];         
	self.Action_Description		:= le.allcat[46..55];             
	self.Document_Number			:= le.allcat[56..71];             
	self.Filing_Location			:= le.allcat[72..91];             
	self.Liability_Amount			:= le.allcat[92..100];            
	self.Tax_Lien_Code				:= le.allcat[101];                
	self.Tax_Lien_Description	:= le.allcat[102..151];           
	self.Dispute_Indicator		:= le.allcat[152];            
	self.Dispute_Code					:= le.allcat[153..154];          
end;

File_4020_layout := project(prj,ebr_4020_trans(LEFT));

EBR.Layout_4020_Tax_Liens_In ebr_4020_ex(File_4020_layout l) := transform
	self.orig_Date_Filed_YMD	:=	l.Date_Filed_YMD;
	self.date_filed						:=	if(l.Date_Filed_YMD[1..2] > '50','19'+l.Date_Filed_YMD[1..2]+l.Date_Filed_YMD[3..4]+l.Date_Filed_YMD[5..6],'20'+l.Date_Filed_YMD[1..2]+l.Date_Filed_YMD[3..4]+l.Date_Filed_YMD[5..6]);
	self.process_date					:=	filedate;
	self											:= 	l;
	self											:=	[];
end;

FileNm_4020_tax_liens := project(File_4020_layout,ebr_4020_ex(LEFT));

FileName_4020_tax_liens := '~thor_data400::in::ebr_4020_tax_liens_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_4020_' + trim(decode_segments('4020'))),
												output(FileNm_4020_tax_liens,,FileName_4020_tax_liens,overwrite,__compressed__)
											);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_4020_' + trim(decode_segments('4020')),FileName_4020_tax_liens);

return sequential(Out_File,add_file);
end;