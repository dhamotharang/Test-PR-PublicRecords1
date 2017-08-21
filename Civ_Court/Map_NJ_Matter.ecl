IMPORT Civ_Court, civil_court, ut, lib_StringLib, STD;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/nj_civil_02.mp

CaseHeader	:= Civ_Court.Files_In_NJ.case_header;
Judgements	:= Civ_Court.Files_In_NJ.judgement;


Civil_Court.Layout_In_Matter jCaseJudge(CaseHeader L, Judgements R) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '59';
self.state_origin				:= 'NJ';
self.source_file				:= 'NJ-STATEWIDE';
self.case_key					  := '59'+ut.CleanSpacesAndUpper(L.docketed_judgement_year)+ut.CleanSpacesAndUpper(L.docketed_judgement_seq_num);
self.court_code					:=  ut.CleanSpacesAndUpper(L.court_code);
self.court						  :=	'NEW JERSEY COURT';
//self.case_type_code			:=	ut.CleanSpacesAndUpper(L.case_type_code); currently not used as there is no description table
self.case_title					:=	ut.CleanSpacesAndUpper(L.case_title);
ValidFileDate						:=	STD.DATE.IsValidDate((INTEGER) L.case_filed_date);
self.filing_date				:=	IF(ValidFileDate,trim(L.case_filed_date,left,right),'');
ValidJdmtDate						:=	STD.DATE.IsValidDate((INTEGER) R.judgement_entered_date);
self.judgmt_date				:=	IF(ValidJdmtDate,trim(R.judgement_entered_date,left,right),'');
tempSuitAmt							:= MAP(StringLib.StringFind(R.judgement_orig_amt,'{',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'{','0'),
															StringLib.StringFind(R.judgement_orig_amt,'A',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'A','1'),
															StringLib.StringFind(R.judgement_orig_amt,'B',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'B','2'),
															StringLib.StringFind(R.judgement_orig_amt,'C',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'C','3'),
															StringLib.StringFind(R.judgement_orig_amt,'D',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'D','4'),
															StringLib.StringFind(R.judgement_orig_amt,'E',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'E','5'),
															StringLib.StringFind(R.judgement_orig_amt,'F',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'F','6'),
															StringLib.StringFind(R.judgement_orig_amt,'G',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'G','7'),
															StringLib.StringFind(R.judgement_orig_amt,'H',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'H','8'),
															StringLib.StringFind(R.judgement_orig_amt,'I',1)>0 => StringLib.StringFindReplace(R.judgement_orig_amt,'I','9'),
															trim(R.judgement_orig_amt,left,right));
self.suit_amount				:= IF(trim(tempSuitAmt,left,right) <> '' and tempSuitAmt <> '000000000',
															ut.rmv_ld_zeros(tempSuitAmt),'');
tempAwardAmt						:= MAP(StringLib.StringFind(R.judgement_due_amt,'{',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'{','0'),
															StringLib.StringFind(R.judgement_due_amt,'A',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'A','1'),
															StringLib.StringFind(R.judgement_due_amt,'B',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'B','2'),
															StringLib.StringFind(R.judgement_due_amt,'C',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'C','3'),
															StringLib.StringFind(R.judgement_due_amt,'D',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'D','4'),
															StringLib.StringFind(R.judgement_due_amt,'E',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'E','5'),
															StringLib.StringFind(R.judgement_due_amt,'F',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'F','6'),
															StringLib.StringFind(R.judgement_due_amt,'G',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'G','7'),
															StringLib.StringFind(R.judgement_due_amt,'H',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'H','8'),
															StringLib.StringFind(R.judgement_due_amt,'I',1)>0 => StringLib.StringFindReplace(R.judgement_due_amt,'I','9'),
															trim(R.judgement_due_amt,left,right));
self.award_amount				:= IF(trim(tempAwardAmt,left,right) <> '' and tempAwardAmt <> '000000000',
															ut.rmv_ld_zeros(tempAwardAmt),'');
self := [];
end;

jNJ 	:=	join(sort(CaseHeader,docketed_judgement_year,docketed_judgement_seq_num,local),
							 sort(Judgements,docketed_judgement_year,docketed_judgement_seq_num,local),
							 trim(left.docketed_judgement_year,all) = trim(right.docketed_judgement_year,all) and
							 trim(left.docketed_judgement_seq_num,all) = trim(right.docketed_judgement_seq_num,all),
							 jCaseJudge(left,right),left outer,local);
							 
dNJ 	:= dedup(sort(distribute(jNJ,hash(case_key)),
                  process_date, case_key, court, filing_date, judgmt_date,
									suit_amount, award_amount, local),
									case_key, court, filing_date, judgmt_date,
									suit_amount, award_amount, local,left):
									PERSIST('~thor_data400::in::civil_NJ_matter');

EXPORT Map_NJ_Matter := dNJ;

