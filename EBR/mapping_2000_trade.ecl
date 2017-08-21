import EBR,ut;

export mapping_2000_trade(string filedate) := function

File_2000_trade := File_Sprayed_Input(segment_code = '2000');

Layout_2000_Trade_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string1		PAYMENT_INDICATOR;
	string4		BUSINESS_CATEGORY_CODE;
	string10	BUSINESS_CATEGORY_DESCRIPTION;
	string6		DATE_REPORTED_YMD;
	string4		DATE_LAST_SALE_YM;
	string7		PAYMENT_TERMS;
	string1		HIGH_CREDIT_MASK;
	string8		RECENT_HIGH_CREDIT;
	string1		ACCOUNT_BALANCE_MASK;
	string8		MASKED_ACCOUNT_BALANCE;
	string3		CURRENT_PERCENT;
	string3		DEBT_01_30_PERCENT;
	string3		DEBT_31_60_PERCENT;
	string3		DEBT_61_90_PERCENT;
	string3		DEBT_91_PLUS_PERCENT;
	string2		COMMENT_CODE;
	string10	COMMENT_DESCRIPTION;
	string1		NEW_TRADE_FLAG;
	string1		TRADE_TYPE_CODE;
	string10	TRADE_TYPE_DESC;
	string1		DISPUTE_INDICATOR;
	string2		DISPUTE_CODE;
end;

rec := record
	string503 allcat;
end;

rec ebr_2000(File_2000_trade le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_1000_prj := project(File_2000_trade,ebr_2000(LEFT));

Layout_2000_Trade_tmp ebr_2000_trans(ebr_1000_prj le) := transform
	self.FILE_NUMBER										:=	le.allcat[1..10];
	self.SEGMENT_CODE										:=	le.allcat[11..14];
	self.SEQUENCE_NUMBER								:=	le.allcat[15..19];
	self.PAYMENT_INDICATOR							:=	le.allcat[26];
	self.BUSINESS_CATEGORY_CODE					:=	le.allcat[27..30];
	self.BUSINESS_CATEGORY_DESCRIPTION	:=	le.allcat[31..40];
	self.DATE_REPORTED_YMD							:=	le.allcat[41..46];
	self.DATE_LAST_SALE_YM							:=	le.allcat[47..50];
	self.PAYMENT_TERMS									:=	le.allcat[51..57];
	self.HIGH_CREDIT_MASK								:=	le.allcat[58];
	self.RECENT_HIGH_CREDIT							:=	le.allcat[59..66];
	self.ACCOUNT_BALANCE_MASK						:=	le.allcat[67];
	self.MASKED_ACCOUNT_BALANCE					:=	le.allcat[68..75];
	self.CURRENT_PERCENT								:=	le.allcat[76..78];
	self.DEBT_01_30_PERCENT							:= 	le.allcat[79..81];
	self.DEBT_31_60_PERCENT             :=	le.allcat[82..84];
	self.DEBT_61_90_PERCENT             :=	le.allcat[85..87];
	self.DEBT_91_PLUS_PERCENT           :=	le.allcat[88..90];
	self.COMMENT_CODE										:=	le.allcat[91..92];
	self.COMMENT_DESCRIPTION						:=	le.allcat[93..102];
	self.NEW_TRADE_FLAG									:=	le.allcat[103];
	self.TRADE_TYPE_CODE								:=	le.allcat[104];
	self.TRADE_TYPE_DESC								:=	le.allcat[105..114];
	self.DISPUTE_INDICATOR							:=	le.allcat[115];
	self.DISPUTE_CODE										:=	le.allcat[116..117];
end;

File_2000_layout := project(ebr_1000_prj,ebr_2000_trans(LEFT));

EBR.Layout_2000_Trade_In ebr_2000_trade_tr(File_2000_layout l) := transform
	self.orig_DATE_REPORTED_YMD	:=	l.DATE_REPORTED_YMD;
	self.orig_DATE_LAST_SALE_YM	:=	l.DATE_LAST_SALE_YM;
	self.date_reported					:=	if(l.DATE_REPORTED_YMD[1..2] > '50','19'+l.DATE_REPORTED_YMD[1..2]+l.DATE_REPORTED_YMD[3..4]+l.DATE_REPORTED_YMD[5..6],'20'+l.DATE_REPORTED_YMD[1..2]+l.DATE_REPORTED_YMD[3..4]+l.DATE_REPORTED_YMD[5..6]);
	self.date_last_sale					:=	if(l.DATE_LAST_SALE_YM[1..2] > '50','19'+l.DATE_LAST_SALE_YM[1..2]+l.DATE_LAST_SALE_YM[3..4],'20'+l.DATE_LAST_SALE_YM[1..2]+l.DATE_LAST_SALE_YM[3..4]);
	self.process_date						:=	filedate;
	self												:=	l;
	self												:=	[];
end;

Filenm_2000_trade := project(File_2000_layout,ebr_2000_trade_tr(LEFT));

FileName_2000_tr := '~thor_data400::in::ebr_2000_trade_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_2000_' + trim(decode_segments('2000'))),
												output(Filenm_2000_trade,,FileName_2000_tr,overwrite,__compressed__)
											 );

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_2000_' + trim(decode_segments('2000')),FileName_2000_tr);

return sequential(Out_File,add_file);
end;