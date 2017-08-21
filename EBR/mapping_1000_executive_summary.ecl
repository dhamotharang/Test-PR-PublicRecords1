import EBR,ut;

export mapping_1000_executive_summary(string filedate) :=	function

File_1000_ex := File_Sprayed_Input(segment_code = '1000');

Layout_1000_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string3		CURRENT_DBT;
	string3		PREDICTED_DBT;
	string3		CONF_PERCENT;
	string1		CONF_SLOPE;
	string6		PREDICTED_DEBT_DATE_MMDDYY;
	string3		AVERAGE_INDUSTRY_DBT;
	string3		AVERAGE_ALL_INDUSTRIES_DBT;
	string8		LOW_BALANCE;
	string8		HIGH_BALANCE;
	string8		CURRENT_ACCOUNT_BALANCE;
	string8		HIGH_CREDIT_EXTENDED;
	string8		MEDIAN_CREDIT_EXTENDED;
	string1		PAYMENT_PERFORMANCE;
	string1		PAYMENT_TREND;
	string20 	INDUSTRY_DESCRIPTION;
end;

rec := record
	string503	allcat;
end;

rec ebr_1000(File_1000_ex le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP + le.ZIP_4		+ le.PHONE_NUMBER		+ le.SIC_CODE					+ 
									le.BUSINESS_DESC				+	le.DISPUTE_IND			+ le.FILLER2					+	le.crlf;
end;

prj := project(File_1000_ex,ebr_1000(LEFT));

Layout_1000_tmp ebr_1000_trans(prj le) := transform
	self.FILE_NUMBER								:=	le.allcat[1..10];
	self.SEGMENT_CODE								:=	le.allcat[11..14];
	self.SEQUENCE_NUMBER						:=	le.allcat[15..19];
	self.CURRENT_DBT								:=	le.allcat[26..28];
	self.PREDICTED_DBT							:=	le.allcat[29..31];
 	self.CONF_PERCENT								:=	le.allcat[32..34];
	self.CONF_SLOPE									:=	le.allcat[35];
	self.PREDICTED_DEBT_DATE_MMDDYY	:=	le.allcat[36..41];
 	self.AVERAGE_INDUSTRY_DBT				:=	le.allcat[42..44];
	self.AVERAGE_ALL_INDUSTRIES_DBT	:=	le.allcat[45..47];
	self.LOW_BALANCE								:=	le.allcat[48..55];
	self.HIGH_BALANCE								:=	le.allcat[56..63];
	self.CURRENT_ACCOUNT_BALANCE		:=	le.allcat[64..71];
	self.HIGH_CREDIT_EXTENDED				:=	le.allcat[72..79];
	self.MEDIAN_CREDIT_EXTENDED			:=	le.allcat[80..87];
	self.PAYMENT_PERFORMANCE				:=	le.allcat[88];
	self.PAYMENT_TREND							:=	le.allcat[89];
 	self.INDUSTRY_DESCRIPTION				:=	le.allcat[90..109];
end;

File_1000_layout := project(prj,ebr_1000_trans(LEFT));

EBR.Layout_1000_Executive_Summary_In ebr_1000_ex(File_1000_layout l) := transform
	self.orig_PREDICTED_DBT_DATE_MMDDYY	:=	l.PREDICTED_DEBT_DATE_MMDDYY;
	self.predicted_dbt_date							:=	if(l.PREDICTED_DEBT_DATE_MMDDYY[5..6] > '50','19'+l.PREDICTED_DEBT_DATE_MMDDYY[5..6]+l.PREDICTED_DEBT_DATE_MMDDYY[1..2]+l.PREDICTED_DEBT_DATE_MMDDYY[3..4],'20'+l.PREDICTED_DEBT_DATE_MMDDYY[5..6]+l.PREDICTED_DEBT_DATE_MMDDYY[1..2]+l.PREDICTED_DEBT_DATE_MMDDYY[3..4]);
	self.process_date										:=	filedate;
	self																:=	l;
	self																:=	[];
end;

File_1000_ex_summary := project(File_1000_layout,ebr_1000_ex(LEFT));

FileName_1000_ex := '~thor_data400::in::ebr_1000_executive_summary_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_1000_' + trim(decode_segments('1000'))),
												output(File_1000_ex_summary,,FileName_1000_ex,overwrite,__compressed__)
											);

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_1000_' + trim(decode_segments('1000')),FileName_1000_ex);

return sequential(Out_File,add_file);
end;