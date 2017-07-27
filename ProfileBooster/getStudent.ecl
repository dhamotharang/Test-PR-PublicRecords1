IMPORT american_student_list, RiskWise, ut;

EXPORT getStudent(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim, boolean onThor ) := FUNCTION

ProfileBooster.Layouts.Layout_PB_Slim_student	addStudent(PBslim le, american_student_list.key_DID ri) := transform
		self.student_date_first_seen	:= ri.date_first_seen;
		self.student_date_last_seen		:= ri.date_last_seen;
		self.student_college_code			:= ri.college_code;
		self.student_college_type			:= ri.college_type;
		self.student_college_tier			:= ri.tier2;
		self := le;
	end; 

students_roxie := join(PBslim, american_student_list.key_DID,
		left.did2!=0
		and keyed(left.did2=right.l_did)
		and (unsigned3)(right.date_first_seen[1..6]) < left.historydate,
		addStudent(left,right), left outer, atmost(keyed(left.did2=right.l_did), 100));

students_thor := join(
	distribute(PBslim, did2), 
	distribute(pull(american_student_list.key_DID), l_did),
		left.did2!=0
		and left.did2=right.l_did
		and (unsigned3)(right.date_first_seen[1..6]) < left.historydate,
		addStudent(left,right), left outer, local);
			
students := if(onthor, students_thor, students_roxie);
			
dedupStudent := dedup(sort(students, seq, DID2, -student_date_last_seen, -student_date_first_seen),seq, DID2);
										
// output(students, named('students'));
// output(dedupStudent, named('dedupStudent'));

RETURN dedupStudent;

END;										