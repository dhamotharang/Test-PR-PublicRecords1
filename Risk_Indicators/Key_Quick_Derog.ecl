import watchdog, bankrupt, doxie_files, doxie, ut;


slimrec := record
	unsigned6	did;
	unsigned1	criminal_count;
	boolean	bankrupt;
	unsigned1	liens_historical_unreleased_count;
end;

slimrec into_did(watchdog.File_Best L) := transform
	self.did := L.did;
	self := [];
end;

dids := distribute(project(watchdog.file_best(did != 0), into_did(LEFT)), hash(did));


slimrec get_bankrupt(dids L, bankrupt.File_BK_Search R) := transform
	self.bankrupt := if ((unsigned6)R.debtor_did != 0, true, false);
	self := L;
end;

wbkrupt := join(dids, distribute(bankrupt.File_BK_Search((unsigned6)debtor_did != 0), hash((unsigned6) debtor_did)),
				left.did = (unsigned6)right.debtor_did,
			get_bankrupt(LEFT,RIGHT), left outer, keep(1), local);


widerec := record
	slimrec;
	string16	  rmsid;
	string35    crim_case_num;
end;

widerec get_liens(wbkrupt L, bankrupt.File_Liens R) := transform
	isRecent := ut.DaysApart(r.filing_date,ut.GetDate)<365*2+1;
	self.liens_historical_unreleased_count := if ((unsigned6)R.did != 0 and isrecent and (integer)R.release_date = 0, 1, 0);
	self.rmsid := R.rmsid;
	self.crim_case_num := '';
	self := L;
end;

liens_unrolled := join(wbkrupt, distribute(bankrupt.file_liens((unsigned6)did != 0), hash((unsigned6)did)),
				left.did = (unsigned6)Right.did,
				get_liens(LEFT,RIGHT), left outer, local);

widerec roll_liens(widerec L, widerec R) := transform
	self.liens_historical_unreleased_count := L.liens_historical_unreleased_count + if (L.rmsid != R.rmsid, R.liens_historical_unreleased_count, 0);
	self := L;
end;

wliens := rollup(sort(liens_unrolled, did, rmsid, local), roll_liens(LEFT,RIGHT), did, local);

widerec get_crim(wliens L, doxie_files.file_offenders R) := transform
	self.crim_case_num := R.case_num;
	self.criminal_count := if ((unsigned6)R.did != 0, 1, 0);
	self := L;
end;

crim_unrolled := join(wliens, distribute(doxie_files.File_Offenders((unsigned6)did != 0), hash((unsigned6)did)),
				left.did = (unsigned6)right.did,
				get_crim(LEFT,RIGHT), left outer, local);

widerec roll_crim(crim_unrolled L, crim_unrolled R) := transform
	self.criminal_count := L.criminal_count + if (L.crim_case_num != R.crim_case_num, R.criminal_count, 0);
	self := L;
end;

wcrim := rollup(sort(crim_unrolled, did, crim_case_num, local), roll_crim(LEFT,RIGHT), did, local);

slimrec back_to_slim(wcrim L) := transform
	self := l;
end;

outf := project(wcrim, back_to_slim(LEFT));
			
export Key_Quick_Derog := index(outf, {did}, {outf}, '~thor_data400::key::did_quick_derog_' + doxie.Version_SuperKey);
 