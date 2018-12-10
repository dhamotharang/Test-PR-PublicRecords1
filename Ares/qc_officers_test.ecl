officers_ds := Ares.file_gpofficers;
//OUTPUT(officers_ds, NAMED('officers_ds'));

mc_ds:=Ares.Files.gpoff_mc;
//OUTPUT(mc_ds, NAMED('mc_ds'));

// layout_versioned := RECORD(RECORDOF(Ares.layout_gpoff))
	// STRING version;
// END;

// layout_versioned versioned_xform (RECORDOF(Ares.layout_gpoff) L, STRING version_):= TRANSFORM
	// SELF.version := version_;
	// SELF := L;
// END;



myofficer := Project(officers_ds, Transform(Ares.layout_gpoff or {string version},
																						self.version := 'mine',
																						self := left));
																						
																						
// myofficer := Project(officers_ds,versioned_xform(LEFT,'mine'));	
OUTPUT(myofficer, NAMED('myofficer'));
OUTPUT(myofficer(Accuity_Location_ID='10000011'), NAMED('myofficer_'));																					
																						
qcofficer := Project(mc_ds, Transform(Ares.layout_gpoff or {string version},
																						self.version := 'qc',
																						self := left));
																						
																						
//qcofficer := Project(mc_ds,  versioned_xform(LEFT,'qc'));
OUTPUT(qcofficer, NAMED('qcofficer'));																						
														
cmbofficers := sort(myofficer + qcofficer, RECORD);
OUTPUT(cmbofficers, NAMED('cmbofficers'));
OUTPUT(cmbofficers(version='mine',Accuity_Location_ID !=''), NAMED('cmbofficers_by_version'));
//OUTPUT(cmbofficers(version='qc'), NAMED('cmbofficers_by_version'));

RecordOf(cmbofficers) xform(cmbofficers l) := Transform
	self.version := 'both';
	self := l;
End;				
//cmbofficers_dist := distribute(cmbofficers, hash(	UpdateFlag,PrimaryKey,Accuity_Location_ID,Department_Function,OfficerName));
//cmbofficers_dist := distribute(cmbofficers, hash(	UpdateFlag,Accuity_Location_ID,Department,OfficerName));
//cmbofficers_dist := distribute(cmbofficers, hash(	UpdateFlag,Department,OfficerName));
//cmbofficers_dist := distribute(cmbofficers, hash(Accuity_Location_ID,Department,OfficerName));
cmbofficers_dist := distribute(cmbofficers, hash(Accuity_Location_ID,OfficerName));

OUTPUT(cmbofficers_dist, NAMED('cmbofficers_dist'));
OUTPUT(cmbofficers_dist(Accuity_Location_ID='10000011'), NAMED('cmbofficers_'));

//combined_sorted := sort(cmbofficers_dist,UpdateFlag,Accuity_Location_ID,Department,OfficerName,local);
//combined_sorted := sort(cmbofficers_dist,Accuity_Location_ID,Department,OfficerName,local);
combined_sorted := sort(cmbofficers_dist,Accuity_Location_ID,OfficerName,local);
Output(combined_sorted, named('combined_sorted'));
Output(combined_sorted(Accuity_Location_ID='10000011'), named('combined_'));

//rolled := Rollup(cmbofficers_dist, xform(left), UpdateFlag,Accuity_Location_ID,Department,OfficerName, local);
//rolled := Rollup(cmbofficers_dist, xform(left), record, local);
rolled := Rollup(combined_sorted, xform(left), record, local);

OUTPUT(rolled, NAMED('rolled'));

Output(count(rolled(version='both')), named('cnt_matching'));
Output(count(rolled(version='mine')), named('cnt_mine_only'));
Output(count(rolled(version='qc')), named('cnt_qc_only'));													

Output(sort(rolled(version='mine'),Accuity_Location_ID) , named('mine_only'));
Output(sort(rolled(version='mine',Accuity_Location_ID !=''),Accuity_Location_ID), named('mine_by_Accuity_Location_ID'));
//Output(sort(rolled(version='mine',Accuity_Location_ID ='10000011',Department = '455'),Accuity_Location_ID), named('mine_test'));
Output(sort(rolled(version='mine',Department = '455'),Accuity_Location_ID), named('mine_test'));


Output(sort(rolled(version='qc'),Accuity_Location_ID), named('qc_only'));	
Output(sort(rolled(version='both'),Accuity_Location_ID), named('both_only'));
Output(sort(rolled(version='both', Accuity_Location_ID !=''),Accuity_Location_ID), named('both_by_Accuity_Location_ID'));
Output(count(rolled(version='both', Accuity_Location_ID !='')), named('both_by_Accuity_Location_ID_count'));


// Output(sort(rolled(version='mine'),PrimaryKey) , named('mine_only'));
// Output(sort(rolled(version='qc'),PrimaryKey), named('qc_only'));	
// Output(sort(rolled(version='both'),PrimaryKey), named('both_only'));	



mine := rolled(version='mine');
qc := rolled(version='qc');
//add a 2 fields- department_type mine/qc
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

joined := join(mine, qc, left.Accuity_Location_ID = right.Accuity_Location_ID AND left.Department = right.Department,xform_diff(left,right));                                                                                                            
                                                                                                         
                                                                                                                                
output(joined, named('joined_diffs'));
