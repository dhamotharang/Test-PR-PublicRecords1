myloc := Project(Ares.file_gploc, Transform(Ares.layout_gploc or {string version},
																						self.version := 'mine',
																						self := left));
qcloc := Project(Ares.Files.gploc_mc, Transform(Ares.layout_gploc or {string version},
																						self.version := 'qc',
																						self := left));
cmbloc := sort(myloc(Primary_Key_Accuity_Location_ID != '') + qcloc, RECORD);

RecordOf(cmbloc) xform(cmbloc l) := Transform
	self.version := 'both';
	self := l;
End;				
cmbloc_dist := distribute(cmbloc, hash(	Update_Flag,ISO_Country_Code,Primary_Key_Accuity_Location_ID,Institution_Type,Office_Type,Branch_Name,Physical_Address_1,Physical_Address_2,City_Town,State_Province_Region_Abbreviated,State_Province_Region_Full,Postal_Code,Country_Name_Full,Employer_Tax_ID,Head_Office_Accuity_Location_ID,Institution_Identifier));
rolled := Rollup(cmbloc_dist, xform(left), Update_Flag,ISO_Country_Code,Primary_Key_Accuity_Location_ID,Institution_Type,Office_Type,Branch_Name,Physical_Address_1,Physical_Address_2,City_Town,State_Province_Region_Abbreviated,State_Province_Region_Full,Postal_Code,Country_Name_Full,Employer_Tax_ID,Head_Office_Accuity_Location_ID,Institution_Identifier, local);

cmb_locid_dist := distribute(cmbloc, hash(Primary_Key_Accuity_Location_ID));
RecordOf(cmbloc) xform_locid(cmbloc l) := Transform
	self.version := 'matched_id';
	self := l;
End;
rolled_id := Rollup(cmb_locid_dist, xform_locid(left), Primary_Key_Accuity_Location_ID, local);

Output(count(rolled(version='both')), named('cnt_matching'));
Output(count(rolled(version='mine')), named('cnt_mine_only'));
Output(count(rolled(version='qc')), named('cnt_qc_only'));													
Output(sort(rolled(version='mine'),Primary_Key_Accuity_Location_ID) , named('mine_only'));
Output(sort(rolled(version='qc'),Primary_Key_Accuity_Location_ID), named('qc_only'));	
Output(sort(rolled(version='both'),Primary_Key_Accuity_Location_ID), named('both_only'));	

Output(count(rolled_id(version='matched_id')), named('cnt_rolled_id_matching'));
Output(count(rolled_id(version='mine')), named('cnt_rolled_id_mine_only'));
Output(count(rolled_id(version='qc')), named('cnt_rolled_id_qc_only'));													
Output(sort(rolled_id(version='mine'),Primary_Key_Accuity_Location_ID) , named('rolled_id_mine_only'));
Output(sort(rolled_id(version='qc'),Primary_Key_Accuity_Location_ID), named('rolled_id_qc_only'));	
Output(sort(rolled_id(version='matched_id'),Primary_Key_Accuity_Location_ID), named('rolled_id_both_only'));	

mine := rolled(version='mine');
qc := rolled(version='qc');

diff_layout := record
	mine.Primary_Key_Accuity_Location_ID;
	string diff;
End;

diff_layout xform_diff(mine l, qc r) := Transform
	self.Primary_Key_Accuity_Location_ID := l.Primary_Key_Accuity_Location_ID;
	self.diff := ROWDIFF(L,R);
End;

joined := join(	mine, qc, 
								left.Primary_Key_Accuity_Location_ID = right.Primary_Key_Accuity_Location_ID,
								xform_diff(left,right));
output(joined, named('joined_diffs'));