/**
	If we cannot find the current address in the infutor files, then we will impute a current record.
	
	Specifically, if there is just one unique address associated with a give LexId, then that address will
		be considered as current;

**/
EXPORT proc_imputeCurrentRecords(DATASET(Spokeo.Layout_temp) src) := FUNCTION

	spk := DISTRIBUTE(src(LexId<>0), LexId);
/*
	find records with a single address that is NOT current
*/
	t := TABLE(spk, {spk.LexId, current := COUNT(GROUP,current_address_flag='Y'), confirmed := COUNT(GROUP,confirmed_address_flag='Y'),
								better := COUNT(GROUP,better_address_flag='Y'), lnsource := COUNT(GROUP,address_source='L'), n := COUNT(GROUP)}, 
								LexId, LOCAL);

	solo := Distribute(t(current=0,n=1), LexId);

	spk1:= JOIN(spk, solo, LEFT.LexId=Right.LexId, TRANSFORM(Spokeo.Layout_Temp,
								self.Current_address_flag := IF(right.n=1,'Y',left.Current_address_flag);
								self := left;), LEFT OUTER, LOCAL);

	t2 := TABLE(spk1, {spk1.LexId, current := COUNT(GROUP,current_address_flag='Y'), confirmed := COUNT(GROUP,confirmed_address_flag='Y'),
								better := COUNT(GROUP,better_address_flag='Y'), lnsource := COUNT(GROUP,address_source='L'), n := COUNT(GROUP)}, 
								LexId, LOCAL);

	nocurrent := DISTRIBUTE(t2(current=0),LexId);
	spk3 := JOIN(spk, nocurrent, left.LexId=right.LexId, TRANSFORM(Spokeo.Layout_Temp, self := left;), inner, local);
	spk4 := DEDUP(SORT(spk3, LexId,Prepped_addr1,Prepped_addr2, LOCAL),LexId,Prepped_addr1,Prepped_addr2, LOCAL); 
	t4 := TABLE(spk4, {spk4.LexId, current := COUNT(GROUP,current_address_flag='Y'), confirmed := COUNT(GROUP,confirmed_address_flag='Y'),
								better := COUNT(GROUP,better_address_flag='Y'), lnsource := COUNT(GROUP,address_source='L'), n := COUNT(GROUP)}, 
								LexId, LOCAL);

	solo2 := DISTRIBUTE(t4(current=0,n=1), LexId);
	spk5:= JOIN(spk1, solo2, LEFT.LexId=Right.LexId, TRANSFORM(Spokeo.Layout_Temp,
								self.Current_address_flag := IF(right.n=1,'Y',left.Current_address_flag);
								self := left;), LEFT OUTER, LOCAL);

	result := spk5 + src(LexId=0);


/*
	spk1 := DEDUP(SORT(spk, LexId,Prepped_addr1,Prepped_addr2, LOCAL),LexId,Prepped_addr1,Prepped_addr2, LOCAL); 
	t := TABLE(spk1, {spk1.LexId, current := COUNT(GROUP,current_address_flag='Y'), confirmed := COUNT(GROUP,confirmed_address_flag='Y'),
								better := COUNT(GROUP,better_address_flag='Y'), lnsource := COUNT(GROUP,address_source='L'), n := COUNT(GROUP)}, 
								LexId, LOCAL);

	solo := DISTRIBUTE(t(current=0,n=1), LexId); // no current address, one unique address

	spk2 := JOIN(spk, solo, LEFT.LexId=Right.LexId, TRANSFORM(Spokeo.Layout_Temp,
								self.Current_address_flag := IF(right.n=1,'Y',left.Current_address_flag);
								self := left;), LEFT OUTER, LOCAL);

	result := spk2 & src(LexId=0);
*/
	return result;
END;
/*
ds1 := Spokeo.File_Processed;
lfn := '~thor::spokeo::out::processed::201701a';
ds := DISTRIBUTE(ds1(LexId<>0), LexId);

t := TABLE(ds, {ds.LexId, current := COUNT(GROUP,current_address_flag='Y'), confirmed := COUNT(GROUP,confirmed_address_flag='Y'),
								better := COUNT(GROUP,better_address_flag='Y'), lnsource := COUNT(GROUP,address_source='L'), n := COUNT(GROUP)}, 
								LexId, LOCAL);

// find records with a single address that is NOT current
solo := Distribute(t(current=0,n=1), LexId);
OUTPUT(COUNT(t(current=0)), named('n_nocurrent'));
OUTPUT(COUNT(t(current=0,n=1)), named('n_nocurrentone'));
OUTPUT(COUNT(t(current=0,n>1)), named('n_nocurrentmulti'));
OUTPUT(t(current=0,n>1), named('nocurrentmulti'));

ds2:= JOIN(ds, solo, LEFT.LexId=Right.LexId, TRANSFORM(Spokeo.Layout_Temp,
								self.Current_address_flag := IF(right.n=1,'Y',left.Current_address_flag);
								self := left;), LEFT OUTER, LOCAL);
//ds2 := dataset(lfn, spokeo.Layout_Temp, thor);					

t2 := TABLE(ds2, {ds2.LexId, current := COUNT(GROUP,current_address_flag='Y'), confirmed := COUNT(GROUP,confirmed_address_flag='Y'),
								better := COUNT(GROUP,better_address_flag='Y'), lnsource := COUNT(GROUP,address_source='L'), n := COUNT(GROUP)}, 
								LexId, LOCAL);
OUTPUT(t2);
OUTPUT(COUNT(t2(current=0)), named('n_nocurrent2'));
OUTPUT(COUNT(t2(current=0,n=1)), named('n_nocurrentone2'));
OUTPUT(COUNT(t2(current=0,n>1)), named('n_nocurrentmulti2'));
OUTPUT(t2(current=0,n>1), named('nocurrentmulti2'));
OUTPUT(t2(current=0,n=1));

nocurrent := DISTRIBUTE(t2(current=0),LexId);
ds3 := JOIN(ds, nocurrent, left.LexId=right.LexId, TRANSFORM(Spokeo.Layout_Temp, self := left;), inner, local);
OUTPUT(COUNT(ds3), named('cnt_nocurrent'));
ds4 := DEDUP(SORT(ds3, LexId,Prepped_addr1,Prepped_addr2, LOCAL),LexId,Prepped_addr1,Prepped_addr2, LOCAL); 
OUTPUT(COUNT(ds4), named('cnt_nocurrent2'));
t4 := TABLE(ds4, {ds4.LexId, current := COUNT(GROUP,current_address_flag='Y'), confirmed := COUNT(GROUP,confirmed_address_flag='Y'),
								better := COUNT(GROUP,better_address_flag='Y'), lnsource := COUNT(GROUP,address_source='L'), n := COUNT(GROUP)}, 
								LexId, LOCAL);
OUTPUT(t4);
OUTPUT(COUNT(t4(n=1)), named('t2_onecurrent'));
OUTPUT(COUNT(t4(n>1)), named('t2_multicurrent'));

solo2 := DISTRIBUTE(t4(current=0,n=1), LexId);
ds5:= JOIN(ds2, solo2, LEFT.LexId=Right.LexId, TRANSFORM(Spokeo.Layout_Temp,
								self.Current_address_flag := IF(right.n=1,'Y',left.Current_address_flag);
								self := left;), LEFT OUTER, LOCAL);

OUTPUT(ds5+ds1(LexId=0),,lfn,COMPRESSED,OVERWRITE);
*/
