import EBR,ut;

export mapping_6500_government_trade(string filedate) := function

File_6500_government_trade := EBR.File_Sprayed_Input(segment_code = '6500');

Layout_6500_trade_payment_tmp :=	record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string1		PAYMENT_IND;
	string4		BUS_CAT_CODE;
	string10	BUS_CAT_DESC;
	string6		DATE_REPORTED_YMD;
	string4		DATE_LAST_SALE_YM;
	string7		PAYMENT_TERMS;
	string1		HIGH_CREDIT_MASK;
	string8		RECENT_HIGH_CREDIT;
	string1		ACCT_BAL_MASK;
	string8		MASKED_ACCT_BAL;
	string3		CURRENT_PCT;
	string3		DBT_01_30_PCT;
	string3		DBT_31_60_PCT;
	string3		DBT_61_90_PCT;
	string3		DBT_91_PLUS_PCT;
	string2		COMMENT_CODE;
	string10	COMMENT_DESC;
	string1		NEW_TRADE_FLAG;
	string1		TRADE_TYPE_CODE;
	string10	TRADE_TYPE_DESC;
	string1		DISPUTE_IND;
	string2		DISPUTE_CODE;
end;

rec := record
	string503 allcat;
end;

rec ebr_6500(File_6500_government_trade le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_6500_prj := project(File_6500_government_trade,ebr_6500(LEFT));

Layout_6500_trade_payment_tmp ebr_6500_trans(ebr_6500_prj le) := transform
	self.FILE_NUMBER				:= le.allcat[1..10];
	self.SEGMENT_CODE				:= le.allcat[11..14];
	self.SEQUENCE_NUMBER		:= le.allcat[15..19];
	self.PAYMENT_IND				:= le.allcat[26];
	self.BUS_CAT_CODE				:= le.allcat[27..30];
	self.BUS_CAT_DESC				:= le.allcat[31..40];
	self.DATE_REPORTED_YMD	:= le.allcat[41..46];
	self.DATE_LAST_SALE_YM	:= le.allcat[47..50];
	self.PAYMENT_TERMS			:= le.allcat[51..57];
	self.HIGH_CREDIT_MASK		:= le.allcat[58];
	self.RECENT_HIGH_CREDIT	:= le.allcat[59..66];
	self.ACCT_BAL_MASK			:= le.allcat[67];
	self.MASKED_ACCT_BAL		:= le.allcat[68..75];
	self.CURRENT_PCT				:= le.allcat[76..78];
	self.DBT_01_30_PCT			:= le.allcat[79..81];
	self.DBT_31_60_PCT			:= le.allcat[82..84];
	self.DBT_61_90_PCT			:= le.allcat[85..87];
	self.DBT_91_PLUS_PCT		:= le.allcat[88..90];
	self.COMMENT_CODE				:= le.allcat[91..92];
	self.COMMENT_DESC				:= le.allcat[93..102];
	self.NEW_TRADE_FLAG			:= le.allcat[103];
	self.TRADE_TYPE_CODE		:= le.allcat[104];
	self.TRADE_TYPE_DESC		:= le.allcat[105..114];
	self.DISPUTE_IND				:= le.allcat[115];
	self.DISPUTE_CODE				:= le.allcat[116..117];
end;

File_6500_layout := project(ebr_6500_prj,ebr_6500_trans(LEFT));

EBR.Layout_6500_government_trade_In ebr_6500_government_trade_tr(File_6500_layout l) := transform
	self.orig_DATE_REPORTED_YMD	:=	l.DATE_REPORTED_YMD;
	self.orig_DATE_LAST_SALE_YM	:=	l.DATE_LAST_SALE_YM;
	self.date_reported					:=	if( l.DATE_REPORTED_YMD[1..2] > '50','19'+l.DATE_REPORTED_YMD[1..2]+l.DATE_REPORTED_YMD[3..4]+l.DATE_REPORTED_YMD[5..6],'20'+l.DATE_REPORTED_YMD[1..2]+l.DATE_REPORTED_YMD[3..4]+l.DATE_REPORTED_YMD[5..6]);
	self.date_last_sale					:=	if( l.DATE_LAST_SALE_YM[1..2] > '50','19'+l.DATE_LAST_SALE_YM[1..2]+l.DATE_LAST_SALE_YM[3..4],'20'+l.DATE_LAST_SALE_YM[1..2]+l.DATE_LAST_SALE_YM[3..4]);
	self.process_date						:=	filedate;
	self												:=	l;
	self												:=	[];
end;

Filenm_6500_government_trade:= project(File_6500_layout,ebr_6500_government_trade_tr(LEFT));

FileName_6500_tr := '~thor_data400::in::ebr_6500_government_trade_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_6500_' + trim(decode_segments('6500'))),
												output(Filenm_6500_government_trade,,FileName_6500_tr,overwrite,__compressed__)
												);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_6500_' + trim(decode_segments('6500')),FileName_6500_tr);

return sequential(Out_File,add_file);
end;