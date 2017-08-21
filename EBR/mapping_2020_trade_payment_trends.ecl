import EBR,ut;

export mapping_2020_trade_payment_trends(string filedate) := function

File_2020_trade_payment_trends := EBR.File_Sprayed_Input(segment_code = '2020');

Layout_2020_trade_payment_tmp :=	record
	string10 FILE_NUMBER;
	string4 SEGMENT_CODE;
	string5 SEQUENCE_NUMBER;
	string2 TREND_MM1;
	string2 TREND_YY1;
	string3 DBT1;
	string1 ACCT_BAL_MASK1;
	string8 ACCT_BAL1;
	string3 CURRENT_BALANCE_PCT1;
	string3 DBT_01_30_PCT1;
	string3 DBT_31_60_PCT1;
	string3 DBT_61_90_PCT1;
	string3 DBT_91_PLUS_PCT1;
	string2 TREND_MM2;
	string2 TREND_YY2;
	string3 DBT2;
	string1 ACCT_BAL_MASK2;
	string8 ACCT_BAL2;
	string3 CURRENT_BALANCE_PCT2;
	string3 DBT_01_30_PCT2;
	string3 DBT_31_60_PCT2;
	string3 DBT_61_90_PCT2;
	string3 DBT_91_PLUS_PCT2;
	string2 TREND_MM3;
	string2 TREND_YY3;
	string3 DBT3;
	string1 ACCT_BAL_MASK3;
	string8 ACCT_BAL3;
	string3 CURRENT_BALANCE_PCT3;
	string3 DBT_01_30_PCT3;
	string3 DBT_31_60_PCT3;
	string3 DBT_61_90_PCT3;
	string3 DBT_91_PLUS_PCT3;
	string2 TREND_MM4;
	string2 TREND_YY4;
	string3 DBT4;
	string1 ACCT_BAL_MASK4;
	string8 ACCT_BAL4;
	string3 CURRENT_BALANCE_PCT4;
	string3 DBT_01_30_PCT4;
	string3 DBT_31_60_PCT4;
	string3 DBT_61_90_PCT4;
	string3 DBT_91_PLUS_PCT4;
	string2 TREND_MM5;
	string2 TREND_YY5;
	string3 DBT5;
	string1 ACCT_BAL_MASK5;
	string8 ACCT_BAL5;
	string3 CURRENT_BALANCE_PCT5;
	string3 DBT_01_30_PCT5;
	string3 DBT_31_60_PCT5;
	string3 DBT_61_90_PCT5;
	string3 DBT_91_PLUS_PCT5;
	string2 TREND_MM6;
	string2 TREND_YY6;
	string3 DBT6;
	string1 ACCT_BAL_MASK6;
	string8 ACCT_BAL6;
	string3 CURRENT_BALANCE_PCT6;
	string3 DBT_01_30_PCT6;
	string3 DBT_31_60_PCT6;
	string3 DBT_61_90_PCT6;
	string3 DBT_91_PLUS_PCT6;
end;

rec := record
	string503 allcat;
end;

rec ebr_2020(File_2020_trade_payment_trends le) := transform
		SELF.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_1000_prj := project(File_2020_trade_payment_trends,ebr_2020(LEFT));

Layout_2020_trade_payment_tmp ebr_2020_trans(ebr_1000_prj le) := transform
	SELF.FILE_NUMBER						:=	le.allcat[1..10];   
	SELF.SEGMENT_CODE						:=	le.allcat[11..14];   
	SELF.SEQUENCE_NUMBER				:=	le.allcat[15..19];   
	SELF.TREND_MM1							:=	le.allcat[26..27];   
	SELF.TREND_YY1							:=	le.allcat[28..29];   
	SELF.DBT1										:=	le.allcat[30..32];   
	SELF.ACCT_BAL_MASK1					:=	le.allcat[33];   
	SELF.ACCT_BAL1							:=	le.allcat[31..38];   
	SELF.CURRENT_BALANCE_PCT1		:=	le.allcat[39..41];   
	SELF.DBT_01_30_PCT1					:=	le.allcat[42..44];   
	SELF.DBT_31_60_PCT1					:=	le.allcat[45..47];   
	SELF.DBT_61_90_PCT1					:=	le.allcat[48..50];   
	SELF.DBT_91_PLUS_PCT1				:=	le.allcat[51..53];   
	SELF.TREND_MM2							:=	le.allcat[54..56];   
	SELF.TREND_YY2							:=	le.allcat[57..58];   
	SELF.DBT2										:=	le.allcat[59..61];   
	SELF.ACCT_BAL_MASK2					:=	le.allcat[62];   
	SELF.ACCT_BAL2							:=	le.allcat[63..70];   
	SELF.CURRENT_BALANCE_PCT2		:=	le.allcat[71..73];   
	SELF.DBT_01_30_PCT2					:=	le.allcat[74..76];   
	SELF.DBT_31_60_PCT2					:=	le.allcat[77..79];   
	SELF.DBT_61_90_PCT2					:=	le.allcat[80..82];   
	SELF.DBT_91_PLUS_PCT2				:=	le.allcat[83..85];   
	SELF.TREND_MM3							:=	le.allcat[86..87];   
	SELF.TREND_YY3							:=	le.allcat[88..89];   
	SELF.DBT3										:=	le.allcat[90..92];   
	SELF.ACCT_BAL_MASK3					:=	le.allcat[93];   
	SELF.ACCT_BAL3							:=	le.allcat[94..101];   
	SELF.CURRENT_BALANCE_PCT3		:=	le.allcat[102..104];   
	SELF.DBT_01_30_PCT3					:=	le.allcat[105..107];   
	SELF.DBT_31_60_PCT3					:=	le.allcat[108..110];   
	SELF.DBT_61_90_PCT3					:=	le.allcat[111..113];   
	SELF.DBT_91_PLUS_PCT3				:=	le.allcat[114..116];   
	SELF.TREND_MM4							:=	le.allcat[117..118];   
	SELF.TREND_YY4							:=	le.allcat[119..120];   
	SELF.DBT4										:=	le.allcat[121..123];   
	SELF.ACCT_BAL_MASK4					:=	le.allcat[124];   
	SELF.ACCT_BAL4							:=	le.allcat[125..132];   
	SELF.CURRENT_BALANCE_PCT4		:=	le.allcat[133..135];   
	SELF.DBT_01_30_PCT4					:=	le.allcat[136..138];   
	SELF.DBT_31_60_PCT4					:=	le.allcat[139..141];   
	SELF.DBT_61_90_PCT4					:=	le.allcat[142..144];   
	SELF.DBT_91_PLUS_PCT4				:=	le.allcat[145..147];   
	SELF.TREND_MM5							:=	le.allcat[148..149];   
	SELF.TREND_YY5							:=	le.allcat[150..151];   
	SELF.DBT5										:=	le.allcat[152..154];   
	SELF.ACCT_BAL_MASK5					:=	le.allcat[155];   
	SELF.ACCT_BAL5							:=	le.allcat[156..163];   
	SELF.CURRENT_BALANCE_PCT5		:=	le.allcat[164..166];   
	SELF.DBT_01_30_PCT5					:=	le.allcat[167..169];   
	SELF.DBT_31_60_PCT5					:=	le.allcat[170..172];   
	SELF.DBT_61_90_PCT5					:=	le.allcat[173..175];   
	SELF.DBT_91_PLUS_PCT5				:=	le.allcat[176..178];   
	SELF.TREND_MM6							:=	le.allcat[179..180];   
	SELF.TREND_YY6							:=	le.allcat[181..183];   
	SELF.DBT6										:=	le.allcat[184..186];   
	SELF.ACCT_BAL_MASK6					:=	le.allcat[187];   
	SELF.ACCT_BAL6							:=	le.allcat[188..195];   
	SELF.CURRENT_BALANCE_PCT6		:=	le.allcat[196..198];   
	SELF.DBT_01_30_PCT6					:=	le.allcat[199..201];   
	SELF.DBT_31_60_PCT6					:=	le.allcat[202..204];   
	SELF.DBT_61_90_PCT6					:=	le.allcat[205..207];   
	SELF.DBT_91_PLUS_PCT6				:=	le.allcat[208..210];
end;

File_2020_layout := project(ebr_1000_prj,ebr_2020_trans(LEFT));

EBR.Layout_2020_Trade_Payment_Trends_In ebr_2020_trade_payment_tr(File_2020_layout l) := transform
	SELF.process_date	:= 	filedate;
	SELF							:= 	l;
	self							:=	[];
end;

Filenm_2020_trade_payment_trends:= project(File_2020_layout,ebr_2020_trade_payment_tr(LEFT));

FileName_2020_tr := '~thor_data400::in::ebr_2020_trade_payment_trends_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_2020_' + trim(decode_segments('2020'))),
												output(Filenm_2020_trade_payment_trends,,FileName_2020_tr,overwrite,__compressed__)
											);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_2020_' + trim(decode_segments('2020')),FileName_2020_tr);

return sequential(Out_File,add_file);
end;