IMPORT Civ_court, ut, STD;

File_In := DATASET('~thor_data400::in::civil::tx_gregg',Civ_Court.Layout_In_TX_Gregg.l_in,csv(heading(1),separator('\t')));

//Replace comma seperator with tab. Fields not parsing due to quotes and comma within the data
Civ_Court.Layout_In_TX_Gregg.l_in ReplaceComma(File_In L) := TRANSFORM
	self.line_data	:= REGEXREPLACE('(",")',L.line_data,'\t');
END;

xfrmLine	:= PROJECT(File_In, ReplaceComma(left));

//parse out fields, index on tab
Civ_Court.Layout_In_TX_Gregg.l_out xfrmFields(xfrmLine L)	:= TRANSFORM
	self.Party				:= STD.Str.FindReplace(L.line_data[1..STD.Str.Find(L.line_data, '\t',1) - 1],'"','');
	self.PartyType		:= L.line_data[STD.Str.Find(L.line_data, '\t',1) + 1..STD.Str.Find(L.line_data, '\t',2) - 1];
	// self.DOB					:= L.line_data[STD.Str.Find(L.line_data, '\t',2) + 1..STD.Str.Find(L.line_data, '\t',3) - 1];
	// self.DOD					:= L.line_data[STD.Str.Find(L.line_data, '\t',3) + 1..STD.Str.Find(L.line_data, '\t',4) - 1];
	self.CaseTitle		:= L.line_data[STD.Str.Find(L.line_data, '\t',2) + 1..STD.Str.Find(L.line_data, '\t',3) - 1];
	self.CaseType			:= L.line_data[STD.Str.Find(L.line_data, '\t',3) + 1..STD.Str.Find(L.line_data, '\t',4) - 1];
	self.CaseSubType	:= L.line_data[STD.Str.Find(L.line_data, '\t',4) + 1..STD.Str.Find(L.line_data, '\t',5) - 1];
	self.CaseNumber		:= L.line_data[STD.Str.Find(L.line_data, '\t',5) + 1..STD.Str.Find(L.line_data, '\t',6) - 1];
	self.FileDate			:= L.line_data[STD.Str.Find(L.line_data, '\t',6) + 1..STD.Str.Find(L.line_data, '\t',7) - 1];
	self.CaseStatusDate		:= L.line_data[STD.Str.Find(L.line_data, '\t',7) + 1..STD.Str.Find(L.line_data, '\t',8) - 1];
	self.ActiveCaseStatus	:= L.line_data[STD.Str.Find(L.line_data, '\t',8) + 1..STD.Str.Find(L.line_data, '\t',9) - 1];
	self.LastEventDate		:= L.line_data[STD.Str.Find(L.line_data, '\t',9) + 1..STD.Str.Find(L.line_data, '\t',10) - 1];
	self.LastEventType		:= STD.Str.FindReplace(L.line_data[STD.Str.Find(L.line_data, '\t',10) + 1..],'"','');
END;

File_out := PROJECT(xfrmLine, xfrmFields(left));

EXPORT File_In_TX_Gregg := File_out;