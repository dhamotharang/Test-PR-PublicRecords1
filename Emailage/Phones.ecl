import dx_gong, Phonesplus_v2, STD, mdr;

gong := dx_gong.key_history_did();
last_2_years_gong_phones := gong(STD.Date.MonthsBetween((integer)((string)dt_last_seen[1..6] + '00'), Std.Date.Today()) <= $.Constants.threshold_months);
gong_phones := project(last_2_years_gong_phones
				,TRANSFORM($.layouts.rPhone
					,SELF.LexId := LEFT.did
					,SELF.phone := LEFT.phone10
					,SELF.phone_type := 'LANDLINE'
					,SELF.phone_source := 'D'
					,SELF.phone_ind := if(LEFT.current_flag = true and LEFT.deletion_date = '', 'C', 'F')
					,SELF.Allowed_for_GLB := true;
					,SELF.Allowed_for_nonGLB := true;
					));

gong_phones trGong(gong_phones l, gong_phones r) := transform
  SELF.phone_ind := if(l.phone_ind = 'C', l.phone_ind, r.phone_ind);
  SELF := l;    
end;

roll_gong_ph := rollup(sort(distribute(gong_phones, hash(lexid)), lexid, phone, local), left.lexid=right.lexid and left.phone=right.phone, trGong(left, right), local);
sort_gong_ph := distribute(roll_gong_ph, hash(lexid));

dgongGrouped := GROUP(sort_gong_ph,lexid,LOCAL);
dgong := PROJECT(dgongGrouped
					,TRANSFORM({dgongGrouped, integer counter_ := 0}
						,SELF.counter_ := COUNTER + 1						
						,SELF:=LEFT;)
						);
dgongUngrouped := UNGROUP(dgong);
gong_only_20 := distribute(project(dgongUngrouped(counter_ <= 21), $.layouts.rPhone), hash(lexid));

excludeSet := ['EQ','UT','UW','KW','VW','NW','E2','DW','SV','MD','YE','EN','BW','WR','ZK','ZT','TN','L9'];
inFile := Phonesplus_v2.Key_Phonesplus_Fdid;
                  
//Translate Src Codes
addSrc := record
	Phonesplus_v2.Layout_Phonesplus_Base;
	string sourceTranslated;
end;

addSrc tranTr(inFile l):= transform
		self.sourceTranslated := Phonesplus_v2.Translation_Codes.fGet_all_sources(l.src_all); 
		self := l;
end;

filtFile := project(inFile, tranTr(left))(sourceTranslated not in excludeSet);

ph_plus_v2 := filtFile(src not in $.Filters.SRC_EXCLUSIONS and ~MDR.Source_is_DPPA(src));
last_2_years_ph_plus := ph_plus_v2(STD.Date.MonthsBetween((integer)(((string)datelastseen)[1..6] + '00'), Std.Date.Today()) <= $.Constants.threshold_months);
phones_plus := project(last_2_years_ph_plus
				,TRANSFORM({$.layouts.rPhone, integer confidencescore}
					,SELF.LexId := LEFT.did
					,SELF.phone := LEFT.cellphone
					,SELF.phone_type := LEFT.append_phone_type
					,SELF.phone_source := 'P'
					,SELF.phone_ind := if(LEFT.confidencescore>=11, 'C', 'F')
					,SELF.Allowed_for_GLB := true;
					,SELF.Allowed_for_nonGLB := ~mdr.sourceTools.SourceIsGLB(LEFT.src);
					,SELF.confidencescore := LEFT.confidencescore
					));

phones_plus trPhoneplus(phones_plus l, phones_plus r) := transform
  SELF.phone_ind := if(l.phone_ind = 'C', l.phone_ind, r.phone_ind);
  SELF.Allowed_for_nonGLB := if(l.Allowed_for_nonGLB=true,l.Allowed_for_nonGLB,r.Allowed_for_nonGLB);
  SELF := l;    
end;

roll_phones_plus := rollup(sort(distribute(phones_plus, hash(lexid)), lexid, phone, local), left.lexid=right.lexid and left.phone=right.phone, trPhoneplus(left, right), local);
sort_phone_plus := sort(distribute(roll_phones_plus, hash(lexid)), lexid, -confidencescore, local);

dPhonePlusGrouped := GROUP(sort_phone_plus,lexid,LOCAL);
dPhonesPlus := PROJECT(dPhonePlusGrouped
					,TRANSFORM({dPhonePlusGrouped, integer counter_ := 0}
						,SELF.counter_ := COUNTER + 1						
						,SELF:=LEFT;)
						);
dPhonePlusUngrouped := UNGROUP(dPhonesPlus);
phonplus_only_20 := distribute(project(dPhonePlusUngrouped(counter_ <= 21), $.layouts.rPhone), hash(lexid));

all_phones := gong_only_20 + phonplus_only_20;
all_phones_sorted := sort(distribute(all_phones, hash(LexId)), LexId, phone, local);

all_phones_sorted rollupdups(all_phones_sorted l, all_phones_sorted R) := TRANSFORM
	 SELF.phone_type := if(L.phone_source = 'D', L.phone_type, R.phone_type)
	,SELF.phone_source := if(L.phone_source = 'D', L.phone_source, R.phone_source);
	,SELF.phone_ind := if(L.phone_ind = 'C', L.phone_ind, R.phone_ind)
	,SELF.Allowed_for_nonGLB := if(L.Allowed_for_nonGLB = true, L.Allowed_for_nonGLB, R.Allowed_for_nonGLB)
	,SELF := L;
END;

uniq_phones := rollup(all_phones_sorted, left.lexid=right.lexid and left.phone=right.phone, rollupdups(left, right), local);

EXPORT Phones := join($.AllowedLexids, distribute(uniq_phones, hash(LexId)), left.lexid = right.LexId, TRANSFORM(RIGHT), local);
