import EBR,ut;


export mapping_2025_trade_quarterly_averages(string filedate) := function
	File_2025_trade_quarterly_averages := EBR.File_Sprayed_Input(segment_code = '2025');

Layout_2025_trade_payment_tmp :=	record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string6		FILLER1;
	string1		QUARTER_1;
	string2		QUARTER_YY_1;
	string3		DEBT_1;
	string1		ACCOUNT_BALANCE_MASK_1;
	string8		ACCOUNT_BALANCE_1;
	string3		CURRENT_BALANCE_PERCENT_1;
	string3		DEBT_01_30_PERCENT_1;
	string3		DEBT_31_60_PERCENT_1;
	string3		DEBT_61_90_PERCENT_1;
	string3		DEBT_91_PLUS_PERCENT_1;
	string1		QUARTER_2;
	string2		QUARTER_YY_2;
	string3		DEBT_2;
	string1		ACCOUNT_BALANCE_MASK_2;
	string8		ACCOUNT_BALANCE_2;
	string3		CURRENT_BALANCE_PERCENT_2;
	string3		DEBT_01_30_PERCENT_2;
	string3		DEBT_31_60_PERCENT_2;
	string3		DEBT_61_90_PERCENT_2;
	string3		DEBT_91_PLUS_PERCENT_2;
	string1		QUARTER_3;
	string2		QUARTER_YY_3;
	string3		DEBT_3;
	string1		ACCOUNT_BALANCE_MASK_3;
	string8		ACCOUNT_BALANCE_3;
	string3		CURRENT_BALANCE_PERCENT_3;
	string3		DEBT_01_30_PERCENT_3;
	string3		DEBT_31_60_PERCENT_3;
	string3		DEBT_61_90_PERCENT_3;
	string3		DEBT_91_PLUS_PERCENT_3;
	string1		QUARTER_4;
	string2		QUARTER_YY_4;
	string3		DEBT_4;
	string1		ACCOUNT_BALANCE_MASK_4;
	string8		ACCOUNT_BALANCE_4;
	string3		CURRENT_BALANCE_PERCENT_4;
	string3		DEBT_01_30_PERCENT_4;
	string3		DEBT_31_60_PERCENT_4;
	string3		DEBT_61_90_PERCENT_4;
	string3		DEBT_91_PLUS_PERCENT_4;
	string1		QUARTER_5;
	string2		QUARTER_YY_5;
	string3		DEBT_5;
	string1		ACCOUNT_BALANCE_MASK_5;
	string8		ACCOUNT_BALANCE_5;
	string3		CURRENT_BALANCE_PERCENT_5;
	string3		DEBT_01_30_PERCENT_5;
	string3		DEBT_31_60_PERCENT_5;
	string3		DEBT_61_90_PERCENT_5;
	string3		DEBT_91_PLUS_PERCENT_5;
end;

rec := record
	string503 allcat;
end;

rec ebr_2025(File_2025_trade_quarterly_averages le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_1000_prj := project(File_2025_trade_quarterly_averages,ebr_2025(LEFT));

Layout_2025_trade_payment_tmp ebr_2025_trans(ebr_1000_prj le) := transform
	self.FILE_NUMBER									:= le.allcat[1..10];           
	self.SEGMENT_CODE                 := le.allcat[11..14];           
	self.SEQUENCE_NUMBER              := le.allcat[15..19];           
	self.FILLER1                      := le.allcat[20..25];           
	self.QUARTER_1                    := le.allcat[26];           
	self.QUARTER_YY_1                 := le.allcat[27..28];           
	self.DEBT_1                       := le.allcat[29..31];           
	self.ACCOUNT_BALANCE_MASK_1       := le.allcat[32];           
	self.ACCOUNT_BALANCE_1            := le.allcat[33..40];           
	self.CURRENT_BALANCE_PERCENT_1		:= le.allcat[41..43];           
	self.DEBT_01_30_PERCENT_1         := le.allcat[44..46];           
	self.DEBT_31_60_PERCENT_1         := le.allcat[47..49];           
	self.DEBT_61_90_PERCENT_1         := le.allcat[50..52];           
	self.DEBT_91_PLUS_PERCENT_1       := le.allcat[53..55];           
	self.QUARTER_2                    := le.allcat[56];           
	self.QUARTER_YY_2                 := le.allcat[57..58];           
	self.DEBT_2                       := le.allcat[59..61];           
	self.ACCOUNT_BALANCE_MASK_2       := le.allcat[62];           
	self.ACCOUNT_BALANCE_2            := le.allcat[63..70];           
	self.CURRENT_BALANCE_PERCENT_2    := le.allcat[71..73];           
	self.DEBT_01_30_PERCENT_2         := le.allcat[74..76];           
	self.DEBT_31_60_PERCENT_2         := le.allcat[77..79];           
	self.DEBT_61_90_PERCENT_2         := le.allcat[80..82];           
	self.DEBT_91_PLUS_PERCENT_2       := le.allcat[83..85];           
	self.QUARTER_3                    := le.allcat[86];           
	self.QUARTER_YY_3                 := le.allcat[87..88];           
	self.DEBT_3                       := le.allcat[89..91];           
	self.ACCOUNT_BALANCE_MASK_3       := le.allcat[92];           
	self.ACCOUNT_BALANCE_3            := le.allcat[93..100];           
	self.CURRENT_BALANCE_PERCENT_3    := le.allcat[101..103];           
	self.DEBT_01_30_PERCENT_3         := le.allcat[104..106];           
	self.DEBT_31_60_PERCENT_3         := le.  allcat[107..109];           
	self.DEBT_61_90_PERCENT_3         := le.  allcat[110..112];           
	self.DEBT_91_PLUS_PERCENT_3       := le.allcat[113..115];           
	self.QUARTER_4                    := le.allcat[116];           
	self.QUARTER_YY_4                 := le.allcat[117..118];           
	self.DEBT_4                       := le.allcat[119..121];           
	self.ACCOUNT_BALANCE_MASK_4       := le.allcat[122];           
	self.ACCOUNT_BALANCE_4            := le.allcat[123..130];           
	self.CURRENT_BALANCE_PERCENT_4    := le.allcat[131..133];           
	self.DEBT_01_30_PERCENT_4         := le.allcat[134..136];           
	self.DEBT_31_60_PERCENT_4         := le.allcat[137..139];           
	self.DEBT_61_90_PERCENT_4         := le.allcat[140..142];           
	self.DEBT_91_PLUS_PERCENT_4       := le.allcat[143..145];           
	self.QUARTER_5                    := le.allcat[146];           
	self.QUARTER_YY_5                 := le.allcat[147..148];           
	self.DEBT_5                       := le.allcat[149..151];           
	self.ACCOUNT_BALANCE_MASK_5       := le.allcat[152];           
	self.ACCOUNT_BALANCE_5            := le.allcat[153..160];           
	self.CURRENT_BALANCE_PERCENT_5    := le.allcat[161..163];           
	self.DEBT_01_30_PERCENT_5         := le.allcat[164..166];           
	self.DEBT_31_60_PERCENT_5         := le.allcat[167..169];           
	self.DEBT_61_90_PERCENT_5         := le.allcat[170..172];           
	self.DEBT_91_PLUS_PERCENT_5       := le.allcat[173..175];           
end;

File_2025_layout := project(ebr_1000_prj,ebr_2025_trans(LEFT));

EBR.Layout_2025_trade_quarterly_averages_In ebr_2025_trade_payment_tr(File_2025_layout l) := transform
	self.process_date :=	filedate;
	self							:=	l;
	self							:=	[];
end;

Filenm_2025_trade_quarterly_averages:= project(File_2025_layout,ebr_2025_trade_payment_tr(LEFT));

FileName_2025_tr := '~thor_data400::in::ebr_2025_trade_quarterly_averages_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_2025_' + trim(decode_segments('2025'))),
												output(Filenm_2025_trade_quarterly_averages,,FileName_2025_tr,overwrite,__compressed__)
											 );

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_2025_' + trim(decode_segments('2025')),FileName_2025_tr);

return sequential(Out_File,add_file);
end;