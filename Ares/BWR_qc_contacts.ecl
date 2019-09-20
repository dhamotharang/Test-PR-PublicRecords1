contacts_ds := Ares.file_gpcontacts;

mc_ds:=Ares.Files.gpcnt_mc;

myContacts := Project(contacts_ds, Transform(Ares.layout_gpcnt or {string version},
																						self.version := 'mine',
																						self := left));
										
qcContact := Project(mc_ds, Transform(Ares.layout_gpcnt or {string version},
																						self.version := 'qc',
																						self := left));
																		
cmbContacts := sort(myContacts + qcContact, RECORD);

RecordOf(cmbContacts) xform(cmbContacts l) := Transform
	self.version := 'both';
	self := l;
End;				

cmbContacts_dist := distribute(cmbContacts, hash(Accuity_Location_ID,Department,Contact_Type,Contact_Information));

combined_sorted := sort(cmbContacts_dist,Accuity_Location_ID,Department,Contact_Type,Contact_Information,local);

rolled := Rollup(combined_sorted, xform(left), Accuity_Location_ID,Department,Contact_Type,Contact_Information, local);

Output(count(rolled),named('cnt_rolled'));
Output(count(rolled(version='both')), named('cnt_matching'));
Output(count(rolled(version='mine')), named('cnt_mine_only'));
Output(count(rolled(version='qc')), named('cnt_qc_only'));													

mine := rolled(version='mine');
qc := rolled(version='qc');


sorted_mine := sort(mine,Accuity_Location_ID,Department,Contact_Type,Contact_Information);
deduped_mine:= DEDUP(sorted_mine,Accuity_Location_ID,Department,Contact_Type,Contact_Information);

sorted_qc := sort(qc,Accuity_Location_ID,Department,Contact_Type,Contact_Information);
deduped_qc:= DEDUP(sorted_qc,Accuity_Location_ID,Department,Contact_Type,Contact_Information);

diff_layout := record
	mine.Accuity_Location_ID;
	mine.Department;
	STRING l_contactype;
	STRING l_contactinfo;
	STRING r_contactype;
	STRING r_contactinfo;
	string diff;
End;

diff_layout xform_diff(mine l, qc r) := Transform
	self.Accuity_Location_ID := l.Accuity_Location_ID;
	self.Department := l.Department;
  self.diff := ROWDIFF(L,R);
	self.l_contactype :=l.Contact_Type;
	self.r_contactype :=r.Contact_Type;
	self.l_contactinfo:=l.Contact_Information;
	self.r_contactinfo:=r.Contact_Information;
End;

joined_ds:= join(deduped_mine, deduped_qc, left.Accuity_Location_ID = right.Accuity_Location_ID AND left.Department = right.Department,xform_diff(left,right));                                                                                                       
output(joined_ds, named('diffs'));
output(COUNT(joined_ds), named('diffs_cnt'));


