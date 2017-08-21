import EBR,ut;

export mapping_4030_judgement(string filedate) := function

File_4030_judgement := EBR.File_Sprayed_Input(segment_code = '4030');

Layout_4030_judgement_tmp := record
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
	string35	Plaintiff_Name;
	string1		Dispute_Indicator;
	string2		Dispute_Code;
end;

rec := record
	string503 allcat;
end;

rec ebr_4030(File_4030_judgement le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_4030_prj := project(File_4030_judgement,ebr_4030(LEFT));

Layout_4030_judgement_tmp ebr_4030_trans(ebr_4030_prj le) := transform
	self.FILE_NUMBER				:= le.allcat[1..10];    
	self.SEGMENT_CODE				:= le.allcat[11..14];      
	self.SEQUENCE_NUMBER		:= le.allcat[15..19];      
	self.Date_Filed_YMD			:= le.allcat[26..31];  
	self.Type_Code					:= le.allcat[32..33];  
	self.Type_Description		:= le.allcat[34..43]; 
	self.Action_Code				:= le.allcat[44..45];  
	self.Action_Description	:= le.allcat[46..55];      
	self.Document_Number		:= le.allcat[56..71];     
	self.Filing_Location		:= le.allcat[72..91];     
	self.Liability_Amount		:= le.allcat[92..100];    
	self.Plaintiff_Name			:= le.allcat[101..135];     
	self.Dispute_Indicator	:= le.allcat[136];         
	self.Dispute_Code				:= le.allcat[137..138];
end;

File_4030_layout := project(ebr_4030_prj,ebr_4030_trans(LEFT));

EBR.Layout_4030_judgement_In ebr_4030_judgement_tr(File_4030_layout l) := transform
	self.orig_DATE_FILED_YMD	:= l.Date_Filed_YMD;
	self.date_filed						:= if(l.Date_Filed_YMD[1..2] > '50','19'+l.Date_Filed_YMD[1..2]+l.Date_Filed_YMD[3..4]+l.Date_Filed_YMD[5..6],'20'+l.Date_Filed_YMD[1..2]+l.Date_Filed_YMD[3..4]+l.Date_Filed_YMD[5..6]);
	self.process_date					:= filedate;
	self											:= l;
	self											:=	[];
end;

Filenm_4030_judgement:= project(File_4030_layout,ebr_4030_judgement_tr(LEFT));

FileName_4030_tr := '~thor_data400::in::ebr_4030_judgement_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_4030_' + trim(decode_segments('4030'))),
												output(Filenm_4030_judgement,,FileName_4030_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_4030_' + trim(decode_segments('4030')),FileName_4030_tr);

return sequential(Out_File,add_file);
end;