import _Control, riskwise, risk_indicators;
onThor := _Control.Environment.OnThor;

export iid_getACsplit(grouped dataset(risk_indicators.layout_output) somedata, boolean isFCRA) := function

AC_Key := if(isFCRA, risk_indicators.Key_FCRA_AreaCode_Change_plus, risk_indicators.Key_AreaCode_Change_plus);

risk_indicators.layout_output get_ac_split(risk_indicators.layout_output le, AC_Key ri) :=
TRANSFORM
	SELF.areacodesplitflag := IF(ri.old_NPA<>'' and ~ri.reverse_flag,'Y','N');
	SELF.areacodesplitdate := ri.permissive_start;
	SELF.altareacode := ri.new_NPA;
	SELF.reverse_areacodesplitflag := IF(ri.old_NPA<>'' and ri.reverse_flag,'Y','N');
	SELF := le;
END;

// NB: not historical


ac_split_roxie := JOIN(somedata, AC_Key, 
									LENGTH(TRIM(LEFT.phone10))=10 AND
									keyed(LEFT.phone10[1..3]=RIGHT.old_NPA) AND
									keyed(LEFT.phone10[4..6]=RIGHT.old_NXX) and
									(unsigned) (right.permissive_start[1..6]) < left.historydate,
									get_ac_split(LEFT,RIGHT),left outer,
									ATMOST(keyed(left.phone10[1..3]=right.old_NPA) and keyed(left.phone10[4..6]=right.old_nxx), Riskwise.max_atmost), keep(100));

ac_split_thor_phone := JOIN(distribute(somedata(LENGTH(TRIM(phone10))=10), hash64(phone10[1..6])), 
									distribute(pull(AC_Key), hash64(old_NPA+old_NXX)), 
									(LEFT.phone10[1..3]=RIGHT.old_NPA) AND
									(LEFT.phone10[4..6]=RIGHT.old_NXX) and
									(unsigned) (right.permissive_start[1..6]) < left.historydate,
									get_ac_split(LEFT,RIGHT),left outer,
									ATMOST((left.phone10[1..3]=right.old_NPA) and (left.phone10[4..6]=right.old_nxx), Riskwise.max_atmost), keep(100), LOCAL);

ac_split_thor_nophone := PROJECT(somedata(LENGTH(TRIM(phone10))<>10), TRANSFORM(risk_indicators.layout_output,
																SELF.areacodesplitflag := 'N',
																SELF.reverse_areacodesplitflag := 'N',
																SELF := LEFT));
																
ac_split_thor := ac_split_thor_phone + ac_split_thor_nophone;

#IF(onThor)
	ac_split := ac_split_thor;
#ELSE
	ac_split := ac_split_roxie;
#END
		
return group(sort(ac_split,seq),seq);

end;
