import _control, ut, Business_Header, Business_Header_SS, did_add, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_2020_Trade_Payment_Trends_In;
segment_code 		:= '2020';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_2020_Trade_Payment_Trends_Base Convert2Base(File_in l, integer cnt) := 
transform
	self.date_first_seen	:= '';
	self.date_last_seen 	:= self.date_first_seen;
	self.TREND_MM			:= choose(cnt,	l.TREND_MM1,			l.TREND_MM2,			l.TREND_MM3,
									l.TREND_MM4,			l.TREND_MM5,			l.TREND_MM6);
	self.TREND_YY			:= choose(cnt,	l.TREND_YY1,			l.TREND_YY2,			l.TREND_YY3,
									l.TREND_YY4,			l.TREND_YY5,			l.TREND_YY6);
	self.DBT				:= choose(cnt,	l.DBT1,				l.DBT2,				l.DBT3,
									l.DBT4,				l.DBT5,				l.DBT6);
	self.ACCT_BAL_MASK		:= choose(cnt,	l.ACCT_BAL_MASK1,		l.ACCT_BAL_MASK2,		l.ACCT_BAL_MASK3,
									l.ACCT_BAL_MASK4,		l.ACCT_BAL_MASK5,		l.ACCT_BAL_MASK6);
	self.ACCT_BAL			:= choose(cnt,	l.ACCT_BAL1,			l.ACCT_BAL2,			l.ACCT_BAL3,
									l.ACCT_BAL4,			l.ACCT_BAL5,			l.ACCT_BAL6);
	self.CURRENT_BALANCE_PCT	:= choose(cnt,	l.CURRENT_BALANCE_PCT1,	l.CURRENT_BALANCE_PCT2,	l.CURRENT_BALANCE_PCT3,
									l.CURRENT_BALANCE_PCT4,	l.CURRENT_BALANCE_PCT5,	l.CURRENT_BALANCE_PCT6);
	self.DBT_01_30_PCT		:= choose(cnt,	l.DBT_01_30_PCT1,		l.DBT_01_30_PCT2,		l.DBT_01_30_PCT3,
									l.DBT_01_30_PCT4,		l.DBT_01_30_PCT5,		l.DBT_01_30_PCT6);
	self.DBT_31_60_PCT		:= choose(cnt,	l.DBT_31_60_PCT1,		l.DBT_31_60_PCT2,		l.DBT_31_60_PCT3,
									l.DBT_31_60_PCT4,		l.DBT_31_60_PCT5,		l.DBT_31_60_PCT6);
	self.DBT_61_90_PCT		:= choose(cnt,	l.DBT_61_90_PCT1,		l.DBT_61_90_PCT2,		l.DBT_61_90_PCT3,
									l.DBT_61_90_PCT4,		l.DBT_61_90_PCT5,		l.DBT_61_90_PCT6);
	self.DBT_91_PLUS_PCT	:= choose(cnt,	l.DBT_91_PLUS_PCT1,		l.DBT_91_PLUS_PCT2,		l.DBT_91_PLUS_PCT3,
									l.DBT_91_PLUS_PCT4,		l.DBT_91_PLUS_PCT5,		l.DBT_91_PLUS_PCT6);
	self 				:= 	l;
	self				:=	[];
end;

File_in2base := normalize(File_in, 6, Convert2Base(left, counter));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)

ebr.Layout_2020_Trade_Payment_Trends_Base				tLayout_2020_Trade_Payment_Trends_Base(			    ebr.Layout_2020_Trade_Payment_Trends_Base			l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

projectBase  := project(BDID_Append, tLayout_2020_Trade_Payment_Trends_Base(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export BDID_2020_Trade_Payment_Trends := addGlobalSID
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;