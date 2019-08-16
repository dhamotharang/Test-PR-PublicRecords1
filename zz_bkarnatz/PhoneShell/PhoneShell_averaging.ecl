EXPORT PhoneShell_averaging := functionmacro;

import std, zz_bkarnatz;

today := (String8)std.date.today();

Master := dataset('~scoringqa::out::DDT_CERT_NonFCRA_Master_' + today, zz_bkarnatz.PhoneShell.DDT_Master_NonFCRA_Layout.DDT_Master_Layout, thor);

// output(master, named('master'));

sortedMaster := sort(Master, -(integer)date);

// output(sortedMaster, named('sortedMaster'));

// NewMasterlay:= record
	// integer matchnum;
	// zz_bkarnatz.PhoneShell.DDT_Master_NonFCRA_Layout.DDT_Master_Layout;
// End;

NewMasterlay:= record
	String ImportantKeysUpdated;
	integer matchnum;	
	zz_bkarnatz.PhoneShell.DDT_Master_NonFCRA_Layout.DDT_Master_Layout;
End;

NewMasterlay PreMatchtrans(sortedMaster le) := Transform
	self.ImportantKeysUpdated :=  If(le.GongKeys_Version = '' and le.InquirytableKeys_Version = '' and le.InquiryTableUpdateKeys_Version = '' and le.PersonHeaderKeys_Version = '' and le.PhonesPlusV2Keys_Version = '' and le.QuickHeaderKeys_Version = '', 'No Pertinent Updates',
																if(le.GongKeys_Version <> '', 'GongKeys, ', '') + 
																if(le.InquirytableKeys_Version <> '', 'InquirytableKeys, ', '') + 
																if(le.InquiryTableUpdateKeys_Version <> '', 'InquiryTableUpdateKeys, ', '') + 
																if(le.PersonHeaderKeys_Version <> '', 'PersonHeaderKeys, ', '') + 
																if(le.PhonesPlusV2Keys_Version <> '', 'PhonesPlusV2Keys, ', '') + 
																if(le.QuickHeaderKeys_Version <> '', 'QuickHeaderKeys, ', ''));
																
														// if(le.PhonemartKeys_Version <> '', 'PhonemartKeys, ', '') + 										
	self := le;
	self := [];
End;

PreMatchMaster := project(sortedMaster, PreMatchtrans(left));
// output(PreMatchMaster, Named('PreMatchMaster'));

NewMasterlay Matchtrans(PreMatchMaster le, integer c) := Transform
	self.MatchNum := if(PreMatchMaster[1].ImportantKeysUpdated = le.ImportantKeysUpdated, c, 99999);											
	self := le;
End;

MatchMaster := project(PreMatchMaster, Matchtrans(left, counter));
// output(MatchMaster, Named('MatchMaster'));


MatchOnlyMaster := MatchMaster(MatchNum <> 99999);
// output(MatchOnlyMaster, Named('MatchOnlyMaster'));

export KeysChecked := output('GongKeys, InquirytableKeys, InquiryTableUpdateKeys, PersonHeaderKeys, PhonesPlusV2Keys, QuickHeaderKeys, ', named('KeysChecked'));
export KeysUpdated := output(MatchOnlyMaster[1].ImportantKeysUpdated, named('KeysUpdated'));


//The ddt report reports the keys that were updated yesterday, so that date will match the prev date and should be compared with the next day for the diff report.
PrevDay := MatchOnlyMaster[1].date + '_1';
CurrDay := (string8)std.date.adjustdate((integer)PrevDay[..8], 0, 0, 1) + '_1';

matchday1Prev:= MatchOnlyMaster[2].date + '_1';
matchday1 := (string8)std.date.adjustdate((integer)matchday1Prev[..8], 0, 0, 1) + '_1';

matchday2Prev := MatchOnlyMaster[3].date + '_1';
matchday2 := (string8)std.date.adjustdate((integer)matchday2Prev[..8], 0, 0, 1) + '_1';

matchday3Prev:= MatchOnlyMaster[4].date + '_1';
matchday3 := (string8)std.date.adjustdate((integer)matchday3Prev[..8], 0, 0, 1) + '_1';

matchday4Prev := MatchOnlyMaster[5].date + '_1';
matchday4 := (string8)std.date.adjustdate((integer)matchday4Prev[..8], 0, 0, 1) + '_1';

export ComparedDays := output(matchday1[..8] + ', ' + matchday2[..8] + ', '  + matchday3[..8] + ', '  + matchday4[..8], named('ComparedDays'));

// output(CurrDay, Named('CurrDay'));
// output(PrevDay, Named('PrevDay'));
// output(matchday1, Named('matchday1'));
// output(matchday1Prev, Named('matchday1Prev'));
// output(matchday2, Named('matchday2'));
// output(matchday2Prev, Named('matchday2Prev'));
// output(matchday3, Named('matchday3'));
// output(matchday3Prev, Named('matchday3Prev'));
// output(matchday4, Named('matchday4'));
// output(matchday4Prev, Named('matchday4Prev'));

RepLay := RECORD
  string field;
  integer8 total_cnt;
  integer8 diff_cnt;
  decimal10_2 diff_pct;
  integer8 up_cnt;
  decimal10_2 up_pct;
  integer8 down_cnt;
  decimal10_2 down_pct;
 END;

 
Prev4Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday4 + 'vs' + matchday4Prev + '_Cert';
Prev3Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday3 + 'vs' + matchday3Prev + '_Cert';
Prev2Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday2 + 'vs' + matchday2Prev + '_Cert';
Prev1Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday1 + 'vs' + matchday1Prev + '_Cert';
Currdiff := '~ScoringQA::out::PhoneShellv1Diffs_' + CurrDay + 'vs' + PrevDay + '_Cert';
 

ds_Prev4diff := dataset(Prev4Diff, RepLay, Thor);
ds_Prev3diff := dataset(Prev3Diff, RepLay, Thor);
ds_Prev2diff := dataset(Prev2Diff, RepLay, Thor);
ds_Prev1diff := dataset(Prev1Diff, RepLay, Thor);
ds_CurrDiff := dataset(Currdiff, RepLay, Thor); 

// output(ds_CurrDiff, Named('ds_CurrDiff'));
// output(ds_Prev1diff, Named('ds_Prev1diff'));
// output(ds_Prev2diff, Named('ds_Prev2diff'));
// output(ds_Prev3diff, Named('ds_Prev3diff'));
// output(ds_Prev4diff, Named('ds_Prev4diff'));


ds_SumPrev1_2 := join(ds_Prev1diff, ds_Prev2diff, left.field = right.field,
			  TRANSFORM(RepLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.diff_pct := LEFT.diff_pct + Right.diff_pct;
					SELF.up_pct := LEFT.up_pct + Right.up_pct;
					SELF.down_pct := LEFT.down_pct + Right.down_pct;
					Self := [];
					), Full Outer);

ds_SumPrev3_4 := join(ds_Prev3diff, ds_Prev4diff, left.field = right.field,
			  TRANSFORM(RepLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.diff_pct := LEFT.diff_pct + Right.diff_pct;
					SELF.up_pct := LEFT.up_pct + Right.up_pct;
					SELF.down_pct := LEFT.down_pct + Right.down_pct;
					Self := [];
					), Full Outer);


ds_SumPrev := join(ds_SumPrev1_2, ds_SumPrev3_4, left.field = right.field,
			  TRANSFORM(RepLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.diff_pct := LEFT.diff_pct + Right.diff_pct;
					SELF.up_pct := LEFT.up_pct + Right.up_pct;
					SELF.down_pct := LEFT.down_pct + Right.down_pct;
					Self := [];
					), Full Outer);


// output(ds_SumPrev1_2, Named('ds_SumPrev1_2'));
// output(ds_SumPrev3_4, Named('ds_SumPrev3_4'));
// output(ds_SumPrev, Named('ds_SumPrev'));

DiffLay := RECORD
  string field;
  decimal10_2 Current_diff;
  decimal10_2 Expected_diff;
  decimal10_2 Surprise_change;
  // decimal10_2 Surprise_pct;
  // decimal10_2 Current_up;
  // decimal10_2 Expected_up;
  decimal10_2 Surprise_up;
  // decimal10_2 Current_Down;
  // decimal10_2 Expected_Down;
  decimal10_2 Surprise_Down;
 END;

DiffinDiff_avg := join(ds_CurrDiff, ds_SumPrev, left.field = right.field,
			  TRANSFORM(DiffLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.Current_diff := LEFT.diff_pct;
					SELF.Expected_diff := right.diff_pct/4;
					SELF.Surprise_change := LEFT.diff_pct - (RIGHT.diff_pct/4);
					// SELF.Surprise_pct := ((LEFT.diff_pct - RIGHT.diff_pct)/Right.diff_pct)*100;  //not a good field.  need to do something about the magnitude of change vs size of bins.
					// SELF.Current_up := left.up_pct;
					// SELF.Expected_up := right.up_pct/4;
					SELF.Surprise_Up := left.up_pct - (right.up_pct/4);
					// SELF.Current_Down := left.down_pct;
					// SELF.Expected_Down := right.down_pct/4;
					SELF.Surprise_Down := left.down_pct - (right.down_pct/4);
					Self := [];
					), Full Outer);


sorted_DiffinDiff_avg := Sort(DiffinDiff_avg, -Abs(Surprise_change));
export DiffinDiff_Report := output(sorted_DiffinDiff_avg, named('Report'));


// Return sequential(KeysChecked, KeysUpdated, ComparedDays, DiffinDiff_Report);
Return 0;

// output(sorted_DiffinDiff_avg(Current_diff>=.5 or Expected_diff>=.5));

endmacro;