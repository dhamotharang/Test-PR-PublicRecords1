import _control, ut, Business_Header, Business_Header_SS, did_add, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_2025_Trade_Quarterly_Averages_In;
segment_code 		:= '2025';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_2025_Trade_Quarterly_Averages_Base Convert2Base(File_in l, integer cnt) := 
transform
	self.date_first_seen		:= '';
	self.date_last_seen 		:= self.date_first_seen;
	self.QUARTER				:= choose(cnt,	
		l.QUARTER_1,				l.QUARTER_2,				l.QUARTER_3,
		l.QUARTER_4,				l.QUARTER_5);
	self.QUARTER_YY			:= choose(cnt,	
		l.QUARTER_YY_1,			l.QUARTER_YY_2,			l.QUARTER_YY_3,
		l.QUARTER_YY_4,			l.QUARTER_YY_5);
	self.DEBT					:= choose(cnt,	
		l.DEBT_1,					l.DEBT_2,					l.DEBT_3,
		l.DEBT_4,					l.DEBT_5);
	self.ACCOUNT_BALANCE_MASK	:= choose(cnt,	
		l.ACCOUNT_BALANCE_MASK_1,	l.ACCOUNT_BALANCE_MASK_2,	l.ACCOUNT_BALANCE_MASK_3,
		l.ACCOUNT_BALANCE_MASK_4,	l.ACCOUNT_BALANCE_MASK_5);
	self.ACCOUNT_BALANCE		:= choose(cnt,	
		l.ACCOUNT_BALANCE_1,		l.ACCOUNT_BALANCE_2,		l.ACCOUNT_BALANCE_3,
		l.ACCOUNT_BALANCE_4,		l.ACCOUNT_BALANCE_5);
	self.CURRENT_BALANCE_PERCENT	:= choose(cnt,	
		l.CURRENT_BALANCE_PERCENT_1,	l.CURRENT_BALANCE_PERCENT_2,	l.CURRENT_BALANCE_PERCENT_3,
		l.CURRENT_BALANCE_PERCENT_4,	l.CURRENT_BALANCE_PERCENT_5);
	self.DEBT_01_30_PERCENT		:= choose(cnt,	
		l.DEBT_01_30_PERCENT_1,		l.DEBT_01_30_PERCENT_2,		l.DEBT_01_30_PERCENT_3,
		l.DEBT_01_30_PERCENT_4,		l.DEBT_01_30_PERCENT_5);
	self.DEBT_31_60_PERCENT		:= choose(cnt,	
		l.DEBT_31_60_PERCENT_1,		l.DEBT_31_60_PERCENT_2,		l.DEBT_31_60_PERCENT_3,
		l.DEBT_31_60_PERCENT_4,		l.DEBT_31_60_PERCENT_5);
	self.DEBT_61_90_PERCENT		:= choose(cnt,	
		l.DEBT_61_90_PERCENT_1,		l.DEBT_61_90_PERCENT_2,		l.DEBT_61_90_PERCENT_3,
		l.DEBT_61_90_PERCENT_4,		l.DEBT_61_90_PERCENT_5);
	self.DEBT_91_PLUS_PERCENT	:= choose(cnt,	
		l.DEBT_91_PLUS_PERCENT_1,	l.DEBT_91_PLUS_PERCENT_2,	l.DEBT_91_PLUS_PERCENT_3,
		l.DEBT_91_PLUS_PERCENT_4,	l.DEBT_91_PLUS_PERCENT_5);
	self 					:= 	l;
	self					:=	[];
end;

File_in2base := normalize(File_in, 5, Convert2Base(left, counter));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)

ebr.Layout_2025_Trade_Quarterly_Averages_Base			tLayout_2025_Trade_Quarterly_Averages_Base(		    ebr.Layout_2025_Trade_Quarterly_Averages_Base		l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

projectBase  := project(BDID_Append, tLayout_2025_Trade_Quarterly_Averages_Base(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export BDID_2025_Trade_Quarterly_Averages := addGlobalSID
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;