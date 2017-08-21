import doxie;

DIDs := table(Lssi.File_Hhid_Did_Add(clean_phone <> ''), {did}, did);

	weeklymain := lssi.File_LSSI_Base(did > 0); //weekly main
	dailyaddsfather := Dataset('~thor_data400::base::lssi_add_father', lssi.layout_hhid_did_lssi, flat, OPT)(did > 0); //daily father adds
oldFiles := distribute(weeklymain + dailyaddsfather, hash(did));

newAdds := distribute(doxie.key_lssi_did_add(did > 0), hash(did));

findNew1 := join(newAdds, oldFiles, 
									left.did = right.did, left only, local);

top_recs := choosen(findNew1, 10000);

findNew2 := join(oldFiles, top_recs, 
									left.npa+left.telno = right.npa+right.telno, 
									transform({string10 phone := ''}, 
									self.phone := right.npa + right.telno), 
									lookup);
									
setFindNew2 := set(findNew2, phone);

findNew := top_recs(npa + telno not in setFindNew2);

export bwr_new_dids :=  parallel(
output(count(DIDs), named('Cnt_Add_Recs_With_New_Dids')),
output(choosen(findnew, 100), named('Sample_New_Unique_LSSI_DIDs_Only')));
