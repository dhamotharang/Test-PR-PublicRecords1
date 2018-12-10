officers_ds := Ares.file_gpofficers;

mc_ds:=Ares.Files.gpoff_mc;

myofficer := Project(officers_ds, Transform(Ares.layout_gpoff or {string version},
																						self.version := 'mine',
																						self := left));

qcofficer := Project(mc_ds, Transform(Ares.layout_gpoff or {string version},
																						self.version := 'qc',
																						self := left));
																					
Output(count(qcofficer)-count(myofficer),named('cnt_defference'));

cmbofficers := sort(myofficer + qcofficer, RECORD);

RecordOf(cmbofficers) xform(cmbofficers l) := Transform
	self.version := 'both';
	self := l;
End;	

cmbofficers_dist := distribute(cmbofficers, hash(Accuity_Location_ID,Department,OfficerName));

combined_sorted := sort(cmbofficers_dist,Accuity_Location_ID,Department,OfficerName,local);

rolled := Rollup(combined_sorted, xform(left), Accuity_Location_ID,Department,OfficerName, local);

Output(count(rolled),named('cnt_rolled'));
Output(count(rolled(version='both')), named('cnt_matching'));
Output(count(rolled(version='mine')), named('cnt_mine_only'));
Output(count(rolled(version='qc')), named('cnt_qc_only'));													

mine := rolled(version='mine');
qc := rolled(version='qc');

sorted_mine := sort(mine,Accuity_Location_ID,Department,OfficerName);
deduped_mine:= DEDUP(sorted_mine,Accuity_Location_ID,Department,OfficerName);
output(deduped_mine, named('deduped_mine'));

sorted_qc := sort(qc,Accuity_Location_ID,Department,OfficerName);
deduped_qc:= DEDUP(sorted_qc,Accuity_Location_ID,Department,OfficerName);
output(deduped_qc, named('deduped_qc'));

diff_layout := record
	mine.Accuity_Location_ID;
	mine.Department;
	string diff;
	STRING l_officername;
	STRING r_officername;
End;

diff_layout xform_diff(mine l, qc r) := Transform
	self.Accuity_Location_ID := l.Accuity_Location_ID;
	self.Department := l.Department;
  self.diff := ROWDIFF(L,R);
	self.l_officername := l.officername;
	self.r_officername :=r.officername;
End;

//joined_ds := join(mine, qc, left.Accuity_Location_ID = right.Accuity_Location_ID AND left.Department = right.Department,xform_diff(left,right));                                                                                                            
joined_ds := join(deduped_mine, deduped_qc, left.Accuity_Location_ID = right.Accuity_Location_ID AND left.Department = right.Department,xform_diff(left,right));                                                                                                            

output(joined_ds, named('diffs'));
output(COUNT(joined_ds), named('diffs_cnt'));
