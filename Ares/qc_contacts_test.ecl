contacts_ds := Ares.file_gpcontacts;

mc_ds:=Ares.Files.gpcnt_mc;

myContacts := Project(contacts_ds, Transform(Ares.layout_gpcnt or {string version},
																						self.version := 'mine',
																						self := left));
																	
//OUTPUT(myContacts, NAMED('myContacts'));
																			
																						
qcContact := Project(mc_ds, Transform(Ares.layout_gpcnt or {string version},
																						self.version := 'qc',
																						self := left));
																						
OUTPUT(qcContact, NAMED('qcContact'));																						
														
 cmbContacts := sort(myContacts + qcContact, RECORD);
 OUTPUT(cmbContacts, NAMED('cmbContacts'));

RecordOf(cmbContacts) xform(cmbContacts l) := Transform
	self.version := 'both';
	self := l;
End;				

cmbContacts_dist := distribute(cmbContacts, hash(Accuity_Location_ID,Department,Contact_Type,Contact_Information));

combined_sorted := sort(cmbContacts_dist,Accuity_Location_ID,Department,Contact_Type,Contact_Information,local);

rolled := Rollup(combined_sorted, xform(left), record, local);

OUTPUT(rolled, NAMED('rolled'));

Output(count(rolled(version='both')), named('cnt_matching'));
Output(count(rolled(version='mine')), named('cnt_mine_only'));
Output(count(rolled(version='qc')), named('cnt_qc_only'));													

// Output(sort(rolled(version='mine'),Accuity_Location_ID) , named('mine_only'));
// Output(sort(rolled(version='mine',Accuity_Location_ID !=''),Accuity_Location_ID), named('mine_by_Accuity_Location_ID'));



// Output(sort(rolled(version='qc'),Accuity_Location_ID), named('qc_only'));	
// Output(sort(rolled(version='both'),Accuity_Location_ID), named('both_only'));
// Output(sort(rolled(version='both', Accuity_Location_ID !=''),Accuity_Location_ID), named('both_by_Accuity_Location_ID'));
// Output(count(rolled(version='both', Accuity_Location_ID !='')), named('both_by_Accuity_Location_ID_count'));






mine := rolled(version='mine');
qc := rolled(version='qc');

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

joined := join(mine, qc, left.Accuity_Location_ID = right.Accuity_Location_ID AND left.Department = right.Department,xform_diff(left,right));                                                                                                            
                                                                                                         
                                                                                                                                
output(joined, named('joined_diffs'));
