import _control, ut, Business_Header, Business_Header_SS, did_add, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_2025_Trade_Quarterly_Averages_In;
segment_code 		:= '2025';
dBase					:=	EBR.File_2025_Trade_Quarterly_Averages_Base;


//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_2025_Trade_Quarterly_Averages_Base Convert2Base(File_in l, integer cnt) := 
transform
	self.date_first_seen					:= '';
	self.date_last_seen 					:= self.date_first_seen;
	self.QUARTER									:= choose(cnt,	
																					l.QUARTER_1,									l.QUARTER_2,									l.QUARTER_3,
																					l.QUARTER_4,									l.QUARTER_5);
	self.QUARTER_YY								:= choose(cnt,	
																					l.QUARTER_YY_1,								l.QUARTER_YY_2,								l.QUARTER_YY_3,
																					l.QUARTER_YY_4,								l.QUARTER_YY_5);
	self.DEBT											:= choose(cnt,	
																					l.DEBT_1,											l.DEBT_2,											l.DEBT_3,
																					l.DEBT_4,											l.DEBT_5);
	self.ACCOUNT_BALANCE_MASK			:= choose(cnt,	
																					l.ACCOUNT_BALANCE_MASK_1,			l.ACCOUNT_BALANCE_MASK_2,			l.ACCOUNT_BALANCE_MASK_3,
																					l.ACCOUNT_BALANCE_MASK_4,			l.ACCOUNT_BALANCE_MASK_5);
	self.ACCOUNT_BALANCE					:= choose(cnt,	
																					l.ACCOUNT_BALANCE_1,					l.ACCOUNT_BALANCE_2,					l.ACCOUNT_BALANCE_3,
																					l.ACCOUNT_BALANCE_4,					l.ACCOUNT_BALANCE_5);
	self.CURRENT_BALANCE_PERCENT	:= choose(cnt,	
																					l.CURRENT_BALANCE_PERCENT_1,	l.CURRENT_BALANCE_PERCENT_2,	l.CURRENT_BALANCE_PERCENT_3,
																					l.CURRENT_BALANCE_PERCENT_4,	l.CURRENT_BALANCE_PERCENT_5);
	self.DEBT_01_30_PERCENT				:= choose(cnt,	
																					l.DEBT_01_30_PERCENT_1,				l.DEBT_01_30_PERCENT_2,				l.DEBT_01_30_PERCENT_3,
																					l.DEBT_01_30_PERCENT_4,				l.DEBT_01_30_PERCENT_5);
	self.DEBT_31_60_PERCENT				:= choose(cnt,	
																					l.DEBT_31_60_PERCENT_1,				l.DEBT_31_60_PERCENT_2,				l.DEBT_31_60_PERCENT_3,
																					l.DEBT_31_60_PERCENT_4,				l.DEBT_31_60_PERCENT_5);
	self.DEBT_61_90_PERCENT				:= choose(cnt,	
																					l.DEBT_61_90_PERCENT_1,				l.DEBT_61_90_PERCENT_2,				l.DEBT_61_90_PERCENT_3,
																					l.DEBT_61_90_PERCENT_4,				l.DEBT_61_90_PERCENT_5);
	self.DEBT_91_PLUS_PERCENT			:= choose(cnt,	
																					l.DEBT_91_PLUS_PERCENT_1,			l.DEBT_91_PLUS_PERCENT_2,			l.DEBT_91_PLUS_PERCENT_3,
																					l.DEBT_91_PLUS_PERCENT_4,			l.DEBT_91_PLUS_PERCENT_5);
	self.process_date_first_seen	:= 	(unsigned4)l.process_date;
	self.process_date_last_seen		:= 	self.process_date_first_seen;
	self.record_type							:= 	'C';
	self													:=	l;
	self													:=	[];
end;

File_in2base := normalize(File_in, 5, Convert2Base(left, counter));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Clear bdid field on base file
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.Layout_2025_Trade_Quarterly_Averages_Base BlankBDIDBase(ebr.Layout_2025_Trade_Quarterly_Averages_Base l) := 
transform
  self.file_number 			:= regexreplace('\n', l.file_number, ' ');
	self.bdid 						:= 0;
	self.DotID 					 	:= 0;
	self.DotScore 		 		:= 0;
	self.DotWeight 		 		:= 0;
	self.EmpID 				 		:= 0;
	self.EmpScore 		 		:= 0;
	self.EmpWeight 		 		:= 0;
 	self.POWID 				 		:= 0;
	self.POWScore 		 		:= 0;
	self.POWWeight 				:= 0;
	self.ProxID 					:= 0;
	self.ProxScore 				:= 0;
	self.ProxWeight 			:= 0;
	self.SeleID						:= 0;
	self.SeleScore 				:= 0;
	self.SeleWeight 			:= 0;	
	self.OrgID 						:= 0;
	self.OrgScore 				:= 0;
	self.OrgWeight 				:= 0;
	self.UltID 				 		:= 0;
	self.UltScore 		 		:= 0;
	self.UltWeight 		 		:= 0;		
	self 									:= l;
end;

File_Base_blank_bdid := project(dBase, BlankBDIDBase(left));

File_Combined	:=	if(EBR.EBR_Init_Flag(segment_code) = false,
											File_in2base + File_Base_blank_bdid,
											File_in2base
										 );
										 
//////////////////////////////////////////////////////////////////////////////////////////
// -- Set Record Type flag
//////////////////////////////////////////////////////////////////////////////////////////
latestPerFileNumber := dedup(SORT(distribute(File_Combined,hash(FILE_NUMBER)), FILE_NUMBER, -process_date_last_seen, local), FILE_NUMBER, local);

SetCurrent 	:= join (File_Combined,latestPerFileNumber
											,left.FILE_NUMBER = right.FILE_NUMBER
											,transform(ebr.Layout_2025_Trade_Quarterly_Averages_Base,
																 self.record_type := if(left.process_date_last_seen = right.process_date_last_seen, 'C' ,'H');
																 self             := left;)
											,left outer
											,lookup);

sortSetCurrent := SORT(SetCurrent, FILE_NUMBER, -process_date_last_seen, local);										 
										 
//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on Raw Fields, setting date_first_seen, date_last_seen
//////////////////////////////////////////////////////////////////////////////////////////
ebr.Layout_2025_Trade_Quarterly_Averages_Base RollupBase(ebr.Layout_2025_Trade_Quarterly_Averages_Base L, ebr.Layout_2025_Trade_Quarterly_Averages_Base R) := 
transform
	self.date_first_seen 					:= (string8)ut.EarliestDate(
																			ut.EarliestDate((unsigned6)L.date_first_seen,(unsigned6)R.date_first_seen),
																			ut.EarliestDate((unsigned6)L.date_last_seen,(unsigned6)R.date_last_seen));
	self.date_last_seen 					:= (string8)max((unsigned6)L.date_last_seen, (unsigned6)R.date_last_seen);
	self.process_date		 					:= (string8)max((unsigned6)L.process_date, (unsigned6)R.process_date);		
	self.process_date_first_seen	:= 	ut.EarliestDate(	L.process_date_first_seen,R.process_date_first_seen);
	self.process_date_last_seen 	:= 	max(L.process_date_last_seen, R.process_date_last_seen);
	self := L;
END;

File_Combined_dist 	:= distribute(sortSetCurrent,hash(FILE_NUMBER));
File_Combined_sort 	:= sort		(File_Combined_dist, record, 
																except 	bdid, date_first_seen, date_last_seen, process_date_first_seen, 
																process_date_last_seen, record_type, process_date, 
																local);

File_Combined_rollup:= rollup	(File_Combined_sort,RollupBase(left, right), record, 
																except 	bdid, date_first_seen, date_last_seen, process_date_first_seen, 
																process_date_last_seen, record_type, process_date, 
																local);													

//////////////////////////////////////////////////////////////////////////////////////////
// -- Distribute both files
//////////////////////////////////////////////////////////////////////////////////////////
File_dist 				:= distribute(File_Combined_rollup,hash(FILE_NUMBER));
File_sort 				:= sort(File_dist,FILE_NUMBER,-process_date,local);

File_Header_dist  := distribute(ebr.File_0010_Header_Base,	hash(FILE_NUMBER));
File_Header_sort  := sort(File_Header_dist,	FILE_NUMBER,	-process_date_last_seen,	local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Match to the header record on FILE_NUMBER to get the bdid
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.Layout_2025_Trade_Quarterly_Averages_Base getBDID(File_sort l, File_Header_sort r) := 
transform
	self.DotID 					 	:= r.DotID;
	self.DotScore 		 		:= r.DotScore;
	self.DotWeight 		 		:= r.DotWeight;
	self.EmpID 				 		:= r.EmpID;
	self.EmpScore 		 		:= r.EmpScore;
	self.EmpWeight 		 		:= r.EmpWeight;
 	self.POWID 				 		:= r.POWID;
	self.POWScore 		 		:= r.POWScore;
	self.POWWeight 				:= r.POWWeight;
	self.ProxID 					:= r.ProxID;
	self.ProxScore 				:= r.ProxScore;
	self.ProxWeight 			:= r.ProxWeight;
	self.SeleID 					:= r.SeleID;
	self.SeleScore 				:= r.SeleScore;
	self.SeleWeight 			:= r.SeleWeight;	
	self.OrgID 						:= r.OrgID;
	self.OrgScore 				:= r.OrgScore;
	self.OrgWeight 				:= r.OrgWeight;
	self.UltID 				 		:= r.UltID;
	self.UltScore 		 		:= r.UltScore;
	self.UltWeight 		 		:= r.UltWeight;		
	self.bdid							:= r.bdid;
	self.date_first_seen	:= r.date_first_seen;
	self.date_last_seen		:= r.date_last_seen;
	self									:= l;
end;

File_Out := join(	File_sort,
									File_Header_sort,
									left.FILE_NUMBER = right.FILE_NUMBER and 
									(unsigned)left.process_date >= (unsigned)right.process_date_first_seen and
									(unsigned)left.process_date <= (unsigned)right.process_date_last_seen,
									getBDID(left,right),keep(1),
									local);
			
ebr.Layout_2025_Trade_Quarterly_Averages_Base	tLayout_2025_Trade_Quarterly_Averages_Base(ebr.Layout_2025_Trade_Quarterly_Averages_Base	l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self 							:= l;
end;

projectBase  := project(File_Out, tLayout_2025_Trade_Quarterly_Averages_Base(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export BDID_2025_Trade_Quarterly_Averages := addGlobalSID
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;