import EBR,ut,lib_stringlib,doxie,address,lib_fileservices;

export mapping_7010_snp_data(string filedate) := function

File_7010_snp_data := EBR.File_Sprayed_Input(segment_code = '7010');

Layout_7010_snp_data_tmp :=	record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string80	DATA_PRINT_LINE;
end;

rec := record
	string503 allcat;
end;

rec ebr_7010(File_7010_snp_data le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_7010_prj := project(File_7010_snp_data,ebr_7010(LEFT));

Layout_7010_snp_data_tmp ebr_7010_trans(ebr_7010_prj le) := transform

	self.FILE_NUMBER			:=	le.allcat[1..10];  
	self.SEGMENT_CODE			:=	le.allcat[11..14];  
	self.SEQUENCE_NUMBER	:=	le.allcat[15..19];  
	self.DATA_PRINT_LINE	:=	le.allcat[26..105];
end;

File_7010_layout := project(ebr_7010_prj,ebr_7010_trans(LEFT));

EBR.Layout_7010_snp_data_In ebr_7010_snp_data_tr(File_7010_layout le) := transform
	self.process_date	:=	filedate;      
	self 							:= 	le;
	self							:=	[];
end;

Filenm_7010_snp_data:= project(File_7010_layout,ebr_7010_snp_data_tr(LEFT));

FileName_7010_tr := '~thor_data400::in::ebr_7010_snp_data_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_7010_' + trim(decode_segments('7010'))),
												output(Filenm_7010_snp_data,,FileName_7010_tr,overwrite,__compressed__)
												);

add_files := fileservices.AddSuperFile('~thor_data400::in::EBR_7010_' + trim(decode_segments('7010')),FileName_7010_tr);

return sequential(Out_File,add_files);
end;
