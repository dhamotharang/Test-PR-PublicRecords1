import EBR,ut;

export mapping_6000_inquiries(string filedate) := function
File_6000_inquiries := EBR.File_Sprayed_Input(segment_code = '6000');

Layout_6000_trade_payment_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string4		BUS_CODE;
	string10	BUS_DESC;
	string2		INQ_MM_1;
	string2		INQ_YY_1;
	string3		INQ_COUNT_1;
	string2		INQ_MM_2;
	string2		INQ_YY_2;
	string3		INQ_COUNT_2;
	string2		INQ_MM_3;
	string2		INQ_YY_3;
	string3		INQ_COUNT_3;
	string2		INQ_MM_4;
	string2		INQ_YY_4;
	string3		INQ_COUNT_4;
	string2		INQ_MM_5;
	string2		INQ_YY_5;
	string3		INQ_COUNT_5;
	string2		INQ_MM_6;
	string2		INQ_YY_6;
	string3		INQ_COUNT_6;
	string2		INQ_MM_7;
	string2		INQ_YY_7;
	string3		INQ_COUNT_7;
	string2		INQ_MM_8;
	string2		INQ_YY_8;
	string3		INQ_COUNT_8;
	string2		INQ_MM_9;
	string2		INQ_YY_9;
	string3		INQ_COUNT_9;
end;

rec := record
	string503 allcat;
end;

rec ebr_6000(File_6000_inquiries le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_6000_prj := project(File_6000_inquiries,ebr_6000(LEFT));

Layout_6000_trade_payment_tmp ebr_6000_trans(ebr_6000_prj le) := transform
	self.FILE_NUMBER			:= le.allcat[1..10];    
	self.SEGMENT_CODE			:= le.allcat[11..14];   
	self.SEQUENCE_NUMBER	:= le.allcat[15..19];   
	self.BUS_CODE					:= le.allcat[26..29];   
	self.BUS_DESC					:= le.allcat[30..39];    
	self.INQ_MM_1					:= le.allcat[40..41];   
	self.INQ_YY_1					:= le.allcat[42..43];   
	self.INQ_COUNT_1			:= le.allcat[44..46];   
	self.INQ_MM_2					:= le.allcat[47..48];   
	self.INQ_YY_2					:= le.allcat[49..50];   
	self.INQ_COUNT_2			:= le.allcat[51..53];   
	self.INQ_MM_3					:= le.allcat[54..55];   
	self.INQ_YY_3					:= le.allcat[56..57];   
	self.INQ_COUNT_3			:= le.allcat[58..60];   
	self.INQ_MM_4					:= le.allcat[61..62];   
	self.INQ_YY_4					:= le.allcat[63..64];   
	self.INQ_COUNT_4			:= le.allcat[65..67];   
	self.INQ_MM_5					:= le.allcat[68..69];   
	self.INQ_YY_5					:= le.allcat[70..71];   
	self.INQ_COUNT_5			:= le.allcat[72..74];   
	self.INQ_MM_6					:= le.allcat[75..76];   
	self.INQ_YY_6					:= le.allcat[77..78];   
	self.INQ_COUNT_6			:= le.allcat[79..81];   
	self.INQ_MM_7					:= le.allcat[82..83];   
	self.INQ_YY_7					:= le.allcat[84..85];   
	self.INQ_COUNT_7			:= le.allcat[86..88];   
	self.INQ_MM_8					:= le.allcat[89..90];   
	self.INQ_YY_8					:= le.allcat[91..92];   
	self.INQ_COUNT_8			:= le.allcat[93..95];   
	self.INQ_MM_9					:= le.allcat[96..97];   
	self.INQ_YY_9					:= le.allcat[98..99];   
	self.INQ_COUNT_9			:= le.allcat[100..102];  
end;

File_6000_layout := project(ebr_6000_prj,ebr_6000_trans(LEFT));

EBR.Layout_6000_inquiries_In ebr_6000_inquiries_tr(File_6000_layout l) := transform
	self.process_date :=	filedate;
	self							:=	l;
	self							:=	[];
end;

Filenm_6000_inquiries:= project(File_6000_layout,ebr_6000_inquiries_tr(LEFT));

FileName_6000_tr := '~thor_data400::in::ebr_6000_inquiries_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_6000_' + trim(decode_segments('6000'))),
												output(Filenm_6000_inquiries,,FileName_6000_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_6000_' + trim(decode_segments('6000')),FileName_6000_tr);

return sequential(Out_File,add_file);
end;