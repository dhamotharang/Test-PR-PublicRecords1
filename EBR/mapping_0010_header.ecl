import EBR,ut, AID;

export mapping_0010_header(string filedate) :=	function

File_0010_header := EBR.File_Sprayed_Input(segment_code = '0010');

EBR.Layout_0010_Header_In_AID ebr_0010_trans(File_0010_header l) := transform
	self.orig_EXTRACT_DATE_MDY			:=	l.EXTRACT_DATE_MDY;
	self.orig_FILE_ESTAB_DATE_MMYY	:=	l.FILE_ESTAB_DATE_MMYY;
	self.extract_date								:=	if(l.EXTRACT_DATE_MDY[7..8] > '50','19'+l.EXTRACT_DATE_MDY[7..8]+l.EXTRACT_DATE_MDY[1..2]+l.EXTRACT_DATE_MDY[4..5],'20'+l.EXTRACT_DATE_MDY[7..8]+l.EXTRACT_DATE_MDY[1..2]+l.EXTRACT_DATE_MDY[4..5]);
	self.file_estab_date						:=	if(l.FILE_ESTAB_DATE_MMYY[3..4] > '50','19'+l.FILE_ESTAB_DATE_MMYY[3..4]+l.FILE_ESTAB_DATE_MMYY[1..2],'20'+l.FILE_ESTAB_DATE_MMYY[3..4]+l.FILE_ESTAB_DATE_MMYY[1..2]);
	self.process_date								:= 	filedate;
	self.orig_ZIP										:=	l.ZIP;
	self.orig_ZIP_4									:=	l.ZIP_4;
	self.Append_RawAID							:=	0;
	self.Append_ACEAID							:=	0;	
	self.prep_addr_line1						:=	trim(l.STREET_ADDRESS,left,right);
	self.prep_addr_last_line				:=	if (trim(l.CITY,left,right) != '',
																						 StringLib.StringCleanSpaces(trim(l.CITY,left,right) + ', ' +
																																				 trim(l.STATE_CODE,left,right) + ' ' + 
																																				 trim(l.ZIP,left,right)[1..5]), 
																						 StringLib.StringCleanSpaces(trim(l.STATE_CODE,left,right) + ' ' + 
																																				 trim(l.ZIP,left,right)[1..5])
																					);
	self														:=	l;
end;


Filenm_0010_header := project(File_0010_header,ebr_0010_trans(LEFT));

FileName_0010_header := '~thor_data400::in::ebr_0010_header_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_0010_' + trim(decode_segments('0010'))),
												output(Filenm_0010_header,,FileName_0010_header,overwrite,__compressed__)
											);

add_file := sequential(
												FileServices.AddSuperFile(EBR.FileName_0010_Header_In,FileName_0010_header)
											);

return sequential(Out_File,add_file);
end;