import EBR, ut, address;

export mapping_5610_demographic_data(string filedate) := function

File_5610_demographic_data := EBR.File_Sprayed_Input(segment_code = '5610');

Layout_5610_trade_payment_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string2		FISCAL_YR_END_MM;
	string1		PROFIT_RANGE_CODE;
	string25	PROFIT_RANGE_DESC;
	string7		PROFIT_RANGE_ACTUAL;
	string1		NET_WORTH_CODE;
	string25	NET_WORTH_DESC;
	decimal7	NET_WORTH_ACTUAL;
	string4		IN_BLDNG_SINCE_YY;
	string1		OWN_OR_RENT_CODE;
	string7		BLDNG_SQUARE_FEET;
	string7		ACTIVE_CUST_COUNT;
	string1		OWNERSHIP_CODE;
	string20	OWNERSHIP_DESC;
	string31	CORP_NAME;
	string20	CORP_CITY;
	string2		CORP_STATE_CODE;
	string20	CORP_STATE_DESC;
	string10	CORP_PHONE;
	string10	OFFICER_TITLE_1;
	string10	OFFICER_FIRST_NAME_1;
	string1		OFFICER_M_I_1;
	string20	OFFICER_LAST_NAME_1;
	string10	OFFICER_TITLE_2;
	string10	OFFICER_FIRST_NAME_2;
	string1		OFFICER_M_I_2;
	string20	OFFICER_LAST_NAME_2;
	string10	OFFICER_TITLE_3;
	string10	OFFICER_FIRST_NAME_3;
	string1		OFFICER_M_I_3;
	string20	OFFICER_LAST_NAME_3;
end;

rec := record
	string503 allcat;
end;

rec ebr_5610(File_5610_demographic_data le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_5610_prj := project(File_5610_demographic_data,ebr_5610(LEFT));

//JIRA - DF-19305 Jon Dawson keeps coming in as a officer for Jon's Tree Service. 
// He is not associated with this company. Adding a filter to keep him from being added as an officer.
Layout_5610_trade_payment_tmp ebr_5610_trans(ebr_5610_prj le) := transform,
	skip(le.allcat[1..10] = '940772280' and 
			((ut.CleanSpacesAndUpper(le.allcat[227..236]) = 'JON' and ut.CleanSpacesAndUpper(le.allcat[238..257]) = 'DAWSON') or
			 (ut.CleanSpacesAndUpper(le.allcat[268..277]) = 'JON' and ut.CleanSpacesAndUpper(le.allcat[279..298]) = 'DAWSON') or
			 (ut.CleanSpacesAndUpper(le.allcat[309..318]) = 'JON' and ut.CleanSpacesAndUpper(le.allcat[320..339]) = 'DAWSON')))			 
	self.FILE_NUMBER						:= le.allcat[1..10];                                                                                                                                                                                                                        
	self.SEGMENT_CODE						:= le.allcat[11..14];                                                                                                                                                                                                                        
	self.SEQUENCE_NUMBER				:= le.allcat[15..19];
	self.FISCAL_YR_END_MM				:= le.allcat[26..27];                                                                                                                                                                                                                        
	self.PROFIT_RANGE_CODE			:= le.allcat[28];                                                                                                                                                                                                                        
	self.PROFIT_RANGE_DESC			:= le.allcat[29..53];                                                                                                                                                                                                                        
	self.PROFIT_RANGE_ACTUAL		:= le.allcat[54..60];                                                                                                                                                                                                                        
	self.NET_WORTH_CODE					:= le.allcat[61];                                                                                                                                                                                                                        
	self.NET_WORTH_DESC					:= le.allcat[62..86];                                                                                                                                                                                                                        
	self.NET_WORTH_ACTUAL				:= (decimal7)le.allcat[87..93];                                                                                                                                                                                                                        
	self.IN_BLDNG_SINCE_YY			:= le.allcat[94..97];                                                                                                                                                                                                                        
	self.OWN_OR_RENT_CODE       := le.allcat[98];                                                                                                                                                                                                                        
	self.BLDNG_SQUARE_FEET      := le.allcat[99..105];                                                                                                                                                                                                                        
	self.ACTIVE_CUST_COUNT			:= le.allcat[106..112];                                                                                                                                                                                                                        
	self.OWNERSHIP_CODE					:= le.allcat[113];                                                                                                                                                                                                                        
	self.OWNERSHIP_DESC					:= le.allcat[114..133];                                                                                                                                                                                                                        
	self.CORP_NAME							:= le.allcat[134..164];                                                                                                                                                                                                                        
	self.CORP_CITY							:= le.allcat[165..184];                                                                                                                                                                                                                        
	self.CORP_STATE_CODE				:= le.allcat[185..186];                                                                                                                                                                                                                        
	self.CORP_STATE_DESC				:= le.allcat[187..206];                                                                                                                                                                                                                        
	self.CORP_PHONE							:= le.allcat[207..216];                                                                                                                                                                                                                        
	self.OFFICER_TITLE_1				:= le.allcat[217..226];                                                                                                                                                                                                                        
	self.OFFICER_FIRST_NAME_1		:= le.allcat[227..236];                                                                                                                                                                                                                        
	self.OFFICER_M_I_1					:= le.allcat[237];                                                                                                                                                                                                                        
	self.OFFICER_LAST_NAME_1		:= le.allcat[238..257];                                                                                                                                                                                                                        
	self.OFFICER_TITLE_2				:= le.allcat[258..267];                                                                                                                                                                                                                        
	self.OFFICER_FIRST_NAME_2		:= le.allcat[268..277];                                                                                                                                                                                                                        
	self.OFFICER_M_I_2					:= le.allcat[278];                                                                                                                                                                                                                        
	self.OFFICER_LAST_NAME_2		:= le.allcat[279..298];                                                                                                                                                                                                                        
	self.OFFICER_TITLE_3				:= le.allcat[299..308];                                                                                                                                                                                                                        
	self.OFFICER_FIRST_NAME_3		:= le.allcat[309..318];                                                                                                                                                                                                                        
	self.OFFICER_M_I_3					:= le.allcat[319];                                                                                                                                                                                                                        
	self.OFFICER_LAST_NAME_3		:= le.allcat[320..339];
end;

File_5610_layout := project(ebr_5610_prj,ebr_5610_trans(LEFT));

Layout_5610_temp := record
	string8		process_date;
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string2		FISCAL_YR_END_MM;
	string1		PROFIT_RANGE_CODE;
	string25	PROFIT_RANGE_DESC;
	string7		PROFIT_RANGE_ACTUAL;
	string1		NET_WORTH_CODE;
	string25	NET_WORTH_DESC;
	decimal7	NET_WORTH_ACTUAL;
	string4		IN_BLDNG_SINCE_YY;
	string1		OWN_OR_RENT_CODE;
	string7		BLDNG_SQUARE_FEET;
	string7		ACTIVE_CUST_COUNT;
	string1		OWNERSHIP_CODE;
	string20	OWNERSHIP_DESC;
	string31	CORP_NAME;
	string20	CORP_CITY;
	string2		CORP_STATE_CODE;
	string20	CORP_STATE_DESC;
	string10	CORP_PHONE;
	string10	OFFICER_TITLE_1;
	string10	OFFICER_FIRST_NAME_1;
	string1		OFFICER_M_I_1;
	string20	OFFICER_LAST_NAME_1;
	string10	OFFICER_TITLE_2;
	string10	OFFICER_FIRST_NAME_2;
	string1		OFFICER_M_I_2;
	string20	OFFICER_LAST_NAME_2;
	string10	OFFICER_TITLE_3;
	string10	OFFICER_FIRST_NAME_3;
	string1		OFFICER_M_I_3;
	string20	OFFICER_LAST_NAME_3;
	string73	clean_officer_name_1;
	string73	clean_officer_name_2;
	string73	clean_officer_name_3;
end;

Layout_5610_temp  ebr_5610_trs(File_5610_layout le) := transform
	self.clean_officer_name_1 :=	Address.CleanPersonFML73(StringLib.StringCleanSpaces(trim(le.OFFICER_FIRST_NAME_1,left,right)+' '+trim(le.OFFICER_M_I_1,left,right)+' '+ trim(le.OFFICER_LAST_NAME_1,left,right)));
	self.clean_officer_name_2 :=	Address.CleanPersonFML73(StringLib.StringCleanSpaces(trim(le.OFFICER_FIRST_NAME_2,left,right)+' '+trim(le.OFFICER_M_I_2,left,right)+' '+ trim(le.OFFICER_LAST_NAME_2,left,right)));
	self.clean_officer_name_3 :=	Address.CleanPersonFML73(StringLib.StringCleanSpaces(trim(le.OFFICER_FIRST_NAME_3,left,right)+' '+trim(le.OFFICER_M_I_3,left,right)+' '+ trim(le.OFFICER_LAST_NAME_3,left,right)));
	self.process_date					:=	filedate;
	self 											:=	le;
end;

ebr_5610_tmp := project(File_5610_layout,ebr_5610_trs(LEFT));

EBR.Layout_5610_demographic_data_In ebr_5610_demographic_data_tr(ebr_5610_tmp l) := transform
	self.FILE_NUMBER						:=	l.FILE_NUMBER;      
	self.SEGMENT_CODE						:=	l.SEGMENT_CODE;      
	self.SEQUENCE_NUMBER				:=	l.SEQUENCE_NUMBER;      
	self.FISCAL_YR_END_MM				:=	l.FISCAL_YR_END_MM;      
	self.PROFIT_RANGE_CODE			:=	l.PROFIT_RANGE_CODE;      
	self.PROFIT_RANGE_DESC			:=	l.PROFIT_RANGE_DESC;      
	self.PROFIT_RANGE_ACTUAL		:=	l.PROFIT_RANGE_ACTUAL;      
	self.NET_WORTH_CODE					:=	l.NET_WORTH_CODE;      
	self.NET_WORTH_DESC					:=	l.NET_WORTH_DESC;      
	self.NET_WORTH_ACTUAL				:=	(string7) l.NET_WORTH_ACTUAL;      
	self.IN_BLDNG_SINCE_YY			:=	l.IN_BLDNG_SINCE_YY;      
	self.OWN_OR_RENT_CODE				:=	l.OWN_OR_RENT_CODE;      
	self.BLDNG_SQUARE_FEET			:=	l.BLDNG_SQUARE_FEET;      
	self.ACTIVE_CUST_COUNT			:=	l.ACTIVE_CUST_COUNT;      
	self.OWNERSHIP_CODE					:=	l.OWNERSHIP_CODE;      
	self.OWNERSHIP_DESC					:=	l.OWNERSHIP_DESC;      
	self.CORP_NAME							:=	l.CORP_NAME;      
	self.CORP_CITY							:=	l.CORP_CITY;      
	self.CORP_STATE_CODE				:=	l.CORP_STATE_CODE;      
	self.CORP_STATE_DESC				:=	l.CORP_STATE_DESC;      
	self.CORP_PHONE							:=	l.CORP_PHONE;      
	self.OFFICER_TITLE_1				:=	l.OFFICER_TITLE_1;      
	self.OFFICER_FIRST_NAME_1		:=	l.OFFICER_FIRST_NAME_1;      
	self.OFFICER_M_I_1					:=	l.OFFICER_M_I_1;      
	self.OFFICER_LAST_NAME_1		:=	l.OFFICER_LAST_NAME_1;      
	self.OFFICER_TITLE_2				:=	l.OFFICER_TITLE_2;      
	self.OFFICER_FIRST_NAME_2		:=	l.OFFICER_FIRST_NAME_2;      
	self.OFFICER_M_I_2					:=	l.OFFICER_M_I_2;      
	self.OFFICER_LAST_NAME_2		:=	l.OFFICER_LAST_NAME_2;      
	self.OFFICER_TITLE_3				:=	l.OFFICER_TITLE_3;      
	self.OFFICER_FIRST_NAME_3		:=	l.OFFICER_FIRST_NAME_3;      
	self.OFFICER_M_I_3					:=	l.OFFICER_M_I_3;
	self.OFFICER_LAST_NAME_3		:=	l.OFFICER_LAST_NAME_3;
	self.clean_officer_name_1.title				:= l.clean_officer_name_1[1..5];
	self.clean_officer_name_1.fname				:= l.clean_officer_name_1[6..25];
	self.clean_officer_name_1.mname				:= l.clean_officer_name_1[26..45];
	self.clean_officer_name_1.lname				:= l.clean_officer_name_1[46..65];
	self.clean_officer_name_1.name_suffix := l.clean_officer_name_1[66..70];
	self.clean_officer_name_1.name_score	:= l.clean_officer_name_1[71..73];
	self.clean_officer_name_2.title				:= l.clean_officer_name_2[1..5];
	self.clean_officer_name_2.fname				:= l.clean_officer_name_2[6..25];
	self.clean_officer_name_2.mname				:= l.clean_officer_name_2[26..45];
	self.clean_officer_name_2.lname				:= l.clean_officer_name_2[46..65];
	self.clean_officer_name_2.name_suffix	:= l.clean_officer_name_2[66..70];
	self.clean_officer_name_2.name_score	:= l.clean_officer_name_2[71..73];
	self.clean_officer_name_3.title				:= l.clean_officer_name_3[1..5];
	self.clean_officer_name_3.fname				:= l.clean_officer_name_3[6..25];
	self.clean_officer_name_3.mname				:= l.clean_officer_name_3[26..45];
	self.clean_officer_name_3.lname				:= l.clean_officer_name_3[46..65];
	self.clean_officer_name_3.name_suffix	:= l.clean_officer_name_3[66..70];
	self.clean_officer_name_3.name_score	:= l.clean_officer_name_3[71..73];
	self.process_date											:= filedate;
	self																	:=	[];
end;

Filenm_5610_demographic_data:= project(ebr_5610_tmp,ebr_5610_demographic_data_tr(LEFT));

FileName_5610_tr := '~thor_data400::in::ebr_5610_demographic_data_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_5610_' + trim(decode_segments('5610'))),
												output(Filenm_5610_demographic_data,,FileName_5610_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_5610_' + trim(decode_segments('5610')),FileName_5610_tr);

return sequential(Out_File,add_file);
end;