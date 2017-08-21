import EBR,ut,doxie,AID;

export mapping_5000_bank_details(string filedate) := function

File_5000_bank_details := EBR.File_Sprayed_Input(segment_code = '5000');

Layout_5000_bank_details_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string30	NAME;
	string30	STREET_ADDRESS;
	string20	CITY;
	string2		STATE_CODE;
	string20	STATE_DESC;
	string5		ZIP_CODE;
	string10	TELEPHONE;
	string1		RELATIONSHIP_CODE;
	string21	RELATIONSHIP_DESC;
	string1		BAL_RANGE_CODE;
	string1		ACCT_BAL_RANGE_CODE;
	string1		NBR_FIG_IN_BAL;
	decimal13	ACCT_BAL_TOTAL;
	string1		ACCT_RATING_CODE;
	string6		DATE_ACCT_OPENED_YMD;
	string6		DATE_ACCT_CLOSED_YMD;
	string8		NAME_ADDR_KEY;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
end;

rec := record
	string503 allcat;
end;

rec ebr_5000(File_5000_bank_details le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_5000_prj := project(File_5000_bank_details,ebr_5000(LEFT));

Layout_5000_bank_details_tmp ebr_5000_trans(ebr_5000_prj le) := transform
	self.FILE_NUMBER					:= le.allcat[1..10];  
	self.SEGMENT_CODE					:= le.allcat[11..14];  
	self.SEQUENCE_NUMBER			:= le.allcat[15..19];  
	self.NAME									:= le.allcat[26..55];  
	self.STREET_ADDRESS				:= le.allcat[56..85];  
	self.CITY									:= le.allcat[86..105];  
	self.STATE_CODE						:= le.allcat[106..107];  
	self.STATE_DESC						:= le.allcat[108..127];  
	self.ZIP_CODE							:= le.allcat[128..132];  
	self.TELEPHONE						:= le.allcat[133..142];  
	self.RELATIONSHIP_CODE		:= le.allcat[143];  
	self.RELATIONSHIP_DESC		:= le.allcat[144..164];  
	self.BAL_RANGE_CODE				:= le.allcat[165];  
	self.ACCT_BAL_RANGE_CODE	:= le.allcat[166];  
	self.NBR_FIG_IN_BAL				:= le.allcat[167];  
	self.ACCT_BAL_TOTAL				:= (decimal13)le.allcat[168..180];  
	self.ACCT_RATING_CODE			:= le.allcat[181];  
	self.DATE_ACCT_OPENED_YMD	:= le.allcat[182..187];  
	self.DATE_ACCT_CLOSED_YMD	:= le.allcat[188..193];  
	self.NAME_ADDR_KEY				:= le.allcat[194..201];  
	self.DISPUTE_IND					:= le.allcat[202];  
	self.DISPUTE_CODE					:= le.allcat[203..204];  
end;

File_5000_layout := project(ebr_5000_prj,ebr_5000_trans(LEFT));

Layout_5000_bank_temp :=	record
	string8		process_date;
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string30	NAME;
	string30	STREET_ADDRESS;
	string20	CITY;
	string2		STATE_CODE;
	string20	STATE_DESC;
	string5		ZIP_CODE;
	string10	TELEPHONE;
	string1		RELATIONSHIP_CODE;
	string21	RELATIONSHIP_DESC;
	string1		BAL_RANGE_CODE;
	string1		ACCT_BAL_RANGE_CODE;
	string1		NBR_FIG_IN_BAL;
	string13	ACCT_BAL_TOTAL;
	string1		ACCT_RATING_CODE;
	string6		DATE_ACCT_OPENED_YMD;
	string6		DATE_ACCT_CLOSED_YMD;
	string8		NAME_ADDR_KEY;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
	AID.Common.xAID	Append_RawAID;
	AID.Common.xAID	Append_ACEAID;
	string100	prep_addr_line1;
	string50	prep_addr_last_line;	
end;

EBR.Layout_5000_Bank_Details_In_AID ebr_5000_bank_details_tr(File_5000_layout l) := transform
	self.ACCT_BAL_TOTAL	:= (string13)l.ACCT_BAL_TOTAL;
	self.process_date		:= filedate;
	self.Append_RawAID				:=	0;
	self.Append_ACEAID				:=	0;	
	string CleanCity					:=	if (trim(l.CITY,left,right) = 'NA',
																			'',
																			l.CITY
																		);
	string CleanState					:=	if (trim(l.STATE_CODE,left,right) = 'NA',
																			'',
																			l.STATE_CODE
																		);		
	string CleanZIP					:=	if (trim(l.ZIP_CODE,left,right) = '00000',
																			'',
																			l.ZIP_CODE
																		);																		
	self.prep_addr_line1			:=	trim(l.STREET_ADDRESS,left,right);
	self.prep_addr_last_line	:=	if (trim(CleanCity,left,right) != '',
																				StringLib.StringCleanSpaces(trim(CleanCity,left,right) + ', ' +
																																		trim(CleanState,left,right) + ' ' + 
																																		trim(CleanZIP,left,right)[1..5]), 
																				StringLib.StringCleanSpaces(trim(CleanState,left,right) + ' ' + 
																																		trim(CleanZIP,left,right)[1..5])
																		);	
	self 											:= l;
end;

Filenm_5000_bank_details:= project(File_5000_layout,ebr_5000_bank_details_tr(LEFT));

FileName_5000_tr := '~thor_data400::in::ebr_5000_bank_details_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_5000_' + trim(decode_segments('5000'))),
												output(Filenm_5000_bank_details,,FileName_5000_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_5000_' + trim(decode_segments('5000')),FileName_5000_tr);

return sequential(Out_File,add_file);
end;