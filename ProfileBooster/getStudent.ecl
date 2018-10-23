IMPORT _Control, american_student_list, RiskWise, ut, mdr, risk_indicators;
onThor := _Control.Environment.OnThor;

EXPORT getStudent(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim) := FUNCTION

ProfileBooster.Layouts.Layout_PB_Slim_student	addStudent(PBslim le, american_student_list.key_DID ri) := transform
		self.student_date_first_seen	:= ri.date_first_seen;
		self.student_date_last_seen		:= ri.date_last_seen;
		self.student_college_code			:= ri.college_code;
		self.student_college_type			:= ri.college_type;
		self.student_college_tier			:= ri.tier2;
		self.src := ri.source;
		self := le;
	end; 

students_roxie := join(PBslim, american_student_list.key_DID,
		left.did2!=0
		and keyed(left.did2=right.l_did)
		and (unsigned3)(right.date_first_seen[1..6]) < left.historydate
		and ~(right.source=mdr.sourceTools.src_OKC_Student_List and right.collegeid in Risk_Indicators.iid_constants.Set_Restricted_Colleges_For_Marketing), // can't use this source in marketing products
		addStudent(left,right), left outer, atmost(keyed(left.did2=right.l_did), 100));

students_thor := join(
	distribute(PBslim, did2), 
	distribute(pull(american_student_list.key_DID), l_did),
		left.did2!=0
		and left.did2=right.l_did
		and (unsigned3)(right.date_first_seen[1..6]) < left.historydate
		and ~(right.source=mdr.sourceTools.src_OKC_Student_List and right.collegeid in Risk_Indicators.iid_constants.Set_Restricted_Colleges_For_Marketing), // can't use this source in marketing products
		addStudent(left,right), left outer, local);
			
#IF(onThor)
	students := students_thor;
#ELSE
	students := students_roxie;
#END

dedupStudent := dedup(sort(students, seq, DID2, -student_date_last_seen, -student_date_first_seen,src),seq, DID2);
										
// output(students, named('students'));
// output(dedupStudent, named('dedupStudent'));

RETURN dedupStudent;

END;										