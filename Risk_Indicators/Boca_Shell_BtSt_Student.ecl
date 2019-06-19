/*
Used in the BTST shell
Common School Link (btst_schools_in_common) - Number of unique schools in intersection of BT schools and ST schools
*/
import american_student_list, Riskwise, AlloyMedia_student_list, Business_Risk, risk_indicators;

export Boca_Shell_BtSt_Student(GROUPED DATASET(risk_indicators.Layout_Boca_Shell) student_info) := FUNCTION
		
	btst_student:= record
		string8 bt_date_first_seen ;
		string8 bt_date_last_seen ;
		string25 bt_college_name ;
		unsigned4 bt_seq ;
		integer bt_class;
		string8 st_date_first_seen ;
		string8 st_date_last_seen ;
		string25 st_college_name ;
		unsigned4 st_seq;
		integer st_class;
		integer btst_schools_in_common;
	end;

	student_info_ungrpd := ungroup(student_info);
	
	//history date was already applied at the boca shell level
	btst_student splitBTST(risk_indicators.Layout_Boca_Shell l, integer c) := transform
		bt := if(c = 1, true, false);
		self.bt_seq := if(bt, l.seq, 0);
		self.bt_date_first_seen := if(bt, l.student.date_first_seen, '0');
		self.bt_date_last_seen  := if(bt, l.student.date_last_seen, '0');
		self.bt_college_name  := if(bt, l.student.college_name, '');
		self.bt_class  := if(bt and (integer) l.student.class > 0, (integer) l.student.class, 0); 
		st := if(c = 2, true, false);
		self.st_seq := if(st, l.seq, 0);
		self.st_date_first_seen := if(st, l.student.date_first_seen, '0');
		self.st_date_last_seen  := if(st, l.student.date_last_seen, '0');
		self.st_college_name  := if(st, l.student.college_name, '');
		self.st_class  := if(st and (integer) l.student.class > 0, (integer) l.student.class, 0); 	
		self.btst_schools_in_common := 0;
	end;
	
	bt_student_tmp := project(student_info_ungrpd(seq % 2 = 0), splitBTST(LEFT, 1)); //BT
	st_student_tmp := project(student_info_ungrpd(seq % 2 != 0), splitBTST(LEFT, 2)); //ST
	
	bt_student := bt_student_tmp(bt_seq != 0);
	st_student := st_student_tmp(st_seq != 0);
		
//BT and ST have same college names
	btst_common_college := join(bt_student, st_student,
		left.bt_seq = right.st_seq - 1 and
		left.bt_college_name != '' and
		(left.bt_college_name = right.st_college_name or 
			Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(left.bt_college_name, right.st_college_name)) = true),
	transform(	btst_student, 
				self.btst_schools_in_common := 1;
			self := left));

	btst_college := join(student_info_ungrpd(seq % 2 = 0), btst_common_college,
		left.seq = right.bt_seq,
		transform(btst_student, 
			self.bt_seq := left.seq;
			self.btst_schools_in_common := right.btst_schools_in_common;
			self := right),atmost(riskwise.max_atmost), 
			left outer); //as want to ensure we have accts we started with

	btst_common_college_grpd := group(sort(btst_college, bt_seq, -btst_schools_in_common ), bt_seq);
	
	btst_student rollCommonCollege(btst_student l, btst_student r) := transform
		self.btst_schools_in_common := l.btst_schools_in_common + r.btst_schools_in_common;
		self := l;
	end;
	btst_common_college_rolled := rollup(btst_common_college_grpd, left.bt_seq = right.bt_seq, rollCommonCollege(left, right));

// //debugging outputs
	// output(bt_student_tmp, named('bt_student_tmp'));
	// output(st_student_tmp, named('st_student_tmp'));
	// output(bt_student, named('bt_student'));
	// output(st_student, named('st_student'));
	// output(btst_common_college, named('btst_common_college'));
	// output(btst_common_college_grpd, named('btst_common_college_grpd'));
	// output(btst_common_college_rolled, named('btst_common_college_rolled'));

	return btst_common_college_rolled;
	
end;
