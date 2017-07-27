//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert2Strings() function
// -- Pass it the segment code(ex, '0010') and the output file
// -- it will convert the binary fields to strings
//////////////////////////////////////////////////////////////////////////////////////////////
import ut, Business_Header, Business_Header_SS, did_add, address;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Input Files
//////////////////////////////////////////////////////////////////////////////////////////////
File_Base := ebr.File_2025_Trade_Quarterly_Averages_Base;

Layout_New_Base := 
record
		ebr.Layout_Base_ASCII;
		string8 process_date;
		string10 FILE_NUMBER;
		string4 SEGMENT_CODE;
		string5 SEQUENCE_NUMBER;
		string1 QUARTER;
		string2 QUARTER_YY;
		string3 DEBT;
		string1 ACCOUNT_BALANCE_MASK;
		string8 ACCOUNT_BALANCE;
		string3 CURRENT_BALANCE_PERCENT;
		string3 DEBT_01_30_PERCENT;
		string3 DEBT_31_60_PERCENT;
		string3 DEBT_61_90_PERCENT;
		string3 DEBT_91_PLUS_PERCENT;
		string1 lf;
end;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert binary fields to strings
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_New_Base t2strings(Layout_2025_Trade_Quarterly_Averages_Base l) := 
transform
	self.bdid 				:= if (l.bdid = 0,'',intformat(l.bdid, 12, 1));
	self.date_first_seen		:= l.date_first_seen;
	self.date_last_seen 		:= l.date_last_seen;
	self.process_date_first_seen	:= intformat(l.process_date_first_seen,8,1);
	self.process_date_last_seen 	:= intformat(l.process_date_last_seen,8,1);
	self.record_type			:= l.record_type;
	self.lf					:= '\n';
	self 					:= l;
end;

export Convert2Strings2025 := project(File_Base, t2strings(left));