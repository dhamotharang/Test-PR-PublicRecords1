import EBR,ut;

export mapping_5600_demographic_data(string filedate) := function

File_5600_demographic_data := EBR.File_Sprayed_Input(segment_code = '5600');

Layout_5600_trade_payment_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string4		SIC_1_CODE;
	string34	SIC_1_DESC;
	string4		SIC_2_CODE;
	string34	SIC_2_DESC;
	string4		SIC_3_CODE;
	string34	SIC_3_DESC;
	string4		SIC_4_CODE;
	string34	SIC_4_DESC;
	string1		YRS_IN_BUS_CODE;
	string20	YRS_IN_BUS_DESC;
	string3		YRS_IN_BUS_ACTUAL;
	string1		SALES_CODE;
	string29	SALES_DESC;
	decimal7	SALES_ACTUAL;
	string1		EMPL_SIZE_CODE;
	string20	EMPL_SIZE_DESC;
	string7		EMPL_SIZE_ACTUAL;
	string1		BUS_TYPE_CODE;
	string20	BUS_TYPE_DESC;
	string1		OWNER_TYPE_CODE;
	string20	OWNER_TYPE_DESC;
	string1		LOCATION_CODE;
	string20	LOCATION_DESC;
end;

rec := record
	string503 allcat;
end;

rec ebr_5600(File_5600_demographic_data le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_5600_prj := project(File_5600_demographic_data,ebr_5600(LEFT));

Layout_5600_trade_payment_tmp ebr_5600_trans(ebr_5600_prj le) := transform
	self.FILE_NUMBER					:= le.allcat[1..10];    
	self.SEGMENT_CODE					:= le.allcat[11..14];    
	self.SEQUENCE_NUMBER			:= le.allcat[15..19];    
	self.SIC_1_CODE						:= le.allcat[26..29];    
	self.SIC_1_DESC						:= le.allcat[30..63];    
	self.SIC_2_CODE						:= le.allcat[64..67];    
	self.SIC_2_DESC						:= le.allcat[68..101];    
	self.SIC_3_CODE						:= le.allcat[102..105];    
	self.SIC_3_DESC						:= le.allcat[106..139];    
	self.SIC_4_CODE						:= le.allcat[140..143];    
	self.SIC_4_DESC						:= le.allcat[144..177];    
	self.YRS_IN_BUS_CODE			:= le.allcat[178];    
	self.YRS_IN_BUS_DESC			:= le.allcat[179..198];    
	self.YRS_IN_BUS_ACTUAL		:= le.allcat[199..201];    
	self.SALES_CODE						:= le.allcat[202];    
	self.SALES_DESC						:= le.allcat[203..231];    
	self.SALES_ACTUAL					:= (decimal7)le.allcat[232..238];    
	self.EMPL_SIZE_CODE				:= le.allcat[239];    
	self.EMPL_SIZE_DESC				:= le.allcat[240..259];    
	self.EMPL_SIZE_ACTUAL			:= le.allcat[260..266];    
	self.BUS_TYPE_CODE				:= le.allcat[267];    
	self.BUS_TYPE_DESC				:= le.allcat[268..287];    
	self.OWNER_TYPE_CODE			:= le.allcat[288];    
	self.OWNER_TYPE_DESC			:= le.allcat[289..308];    
	self.LOCATION_CODE				:= le.allcat[309];    
	self.LOCATION_DESC				:= le.allcat[310..329]; 
end;

File_5600_layout := project(ebr_5600_prj,ebr_5600_trans(LEFT));

EBR.Layout_5600_demographic_data_In ebr_5600_demographic_data_tr(File_5600_layout l) := transform
	self.SALES_ACTUAL	:=	(string7)l.SALES_ACTUAL;
	self.process_date	:=	filedate;
	self							:=	l;
	self							:=	[];
end;

Filenm_5600_demographic_data:= project(File_5600_layout,ebr_5600_demographic_data_tr(LEFT));

FileName_5600_tr := '~thor_data400::in::ebr_5600_demographic_data_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_5600_' + trim(decode_segments('5600'))),
												output(Filenm_5600_demographic_data,,FileName_5600_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_5600_' + trim(decode_segments('5600')),FileName_5600_tr);

return sequential(Out_File,add_file);
end;