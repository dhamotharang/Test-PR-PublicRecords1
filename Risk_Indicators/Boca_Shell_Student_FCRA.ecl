import _Control, american_student_list, FCRA, Riskwise, AlloyMedia_student_list;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Student_FCRA(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell_ids) ids_only, integer bsversion) := FUNCTION

	Layout_AS_Plus := RECORD
		Riskwise.Layouts.Layout_American_Student student;
		unsigned6 did;
		unsigned4 seq;
		unsigned3 historydate;
		string1 src; // used to identify source ('A'=alloy vs 'S='american student) so we can tiebreak on rollup
	end;


	Layout_AS_Plus student_corr(ids_only le, FCRA.Key_Override_Student_New_FFID ri) := TRANSFORM
		self.did := le.did;
		self.seq := le.seq;
		self.historydate := le.historydate;
		self.student := ri;
		
		// corrections records are still ASL data, which should be picked over alloy, but the rollup logic below will only call out H vs C when picking between ASL records. still use DLS to help pick newer records.
		self.src := 'S'; // american student data
    self.student.file_type2 := ri.file_type;
    self.student.college_tier := if(bsversion>=50, ri.tier2, ri.tier);
	end;

	Layout_AS_Plus student(ids_only le, american_student_list.key_DID_FCRA ri) := TRANSFORM
		self.did := le.did;
		self.seq := le.seq;
		self.historydate := le.historydate;
		self.student.date_last_seen := min( iid_constants.mygetdate(le.historydate), ri.date_last_seen );
		self.student.file_type2 := ri.file_type;
		//NOTE: the student FCRA income level code will now be overwritten in Risk_Indicators.getAllBocaShellData as census data can't be used in FCRA 
		self.student := row(ri, transform( Riskwise.Layouts.Layout_American_Student, self := left, self.file_type2 := ri.file_type, self.college_tier := if(bsversion>=50, ri.tier2, ri.tier) ) );
		self.src := ri.historical_flag; // ASL records will be indicated by a historical (H) or current (C) indicator
	end;


	student_correct_roxie := join(ids_only, FCRA.Key_Override_Student_New_FFID,
		keyed(right.flag_file_id in left.student_correct_ffid),
		student_corr(left, right), atmost(right.flag_file_id in left.student_correct_ffid, 100));

	student_correct_thor := join(ids_only, pull(FCRA.Key_Override_Student_New_FFID),
		right.flag_file_id in left.student_correct_ffid,
		student_corr(left, right), LOCAL, ALL);
		
	#IF(onThor)
		student_correct := student_correct_thor;
	#ELSE
		student_correct := student_correct_roxie;
	#END
  
	student_file_roxie := join(ids_only, american_student_list.key_DID_FCRA, 
			left.did!=0
			and keyed(left.did=right.l_did)
			and right.date_first_seen < iid_constants.myGetDate(left.historydate)
			and (string)right.key not in left.student_correct_record_id,
			student(left, right), atmost(keyed(left.did=right.l_did), 100));

	student_file_thor := join(distribute(ids_only(did!=0), hash64(did)), 
			distribute(pull(american_student_list.key_DID_FCRA), hash64(l_did)), 
			left.did=right.l_did
			and right.date_first_seen < iid_constants.myGetDate(left.historydate)
			and (string)right.key not in left.student_correct_record_id,
			student(left, right), atmost(left.did=right.l_did, 100), LOCAL);
			
	#IF(onThor)
		student_file := student_correct + student_file_thor;
	#ELSE
		student_file := student_correct + ungroup(student_file_roxie);
	#END
  
	Layout_AS_Plus roll( Layout_AS_Plus le, Layout_AS_Plus ri ) := TRANSFORM
		self := map(
		
			// Use any other record over File Type 'M'
			le.student.file_type='M' and ri.student.file_type<>'M' => ri,
			ri.student.file_type='M' and le.student.file_type<>'M'=> le,		
			
			// current ASL over historical
			le.src='C' and ri.src='H' => le,
			le.src='H' and ri.src='C' => ri,
		
			// take the newer record when the DLS are unequal
			le.student.date_last_seen > ri.student.date_last_seen => le,
			le.student.date_last_seen < ri.student.date_last_seen => ri,

			// take american student over alloy
			le.src in ['C','H'] and ri.src = 'A' => le,
			ri.src in ['C','H'] and le.src = 'A' => ri,

			// take the newer record when the DFS are unequal
			le.student.date_first_seen > ri.student.date_first_seen => le,
			le.student.date_first_seen < ri.student.date_first_seen => ri,
		
			le
		);
	END;



	// alloy
	Layout_AS_Plus alloy_main(ids_only le, AlloyMedia_student_list.Key_DID_FCRA ri) := TRANSFORM
		self.did := le.did;
		self.seq := le.seq;
		self.historydate := le.historydate;
		self.src := 'A';

		self.student.college_major := case( ri.major_code,
			'001' => 'P',
			'002' => 'N',
			'004' => 'Q',
			'005' => 'B',
			'008' => 'M',
			'010' => 'C',
			'011' => 'Y',
			'012' => 'D',
			'014' => 'E',
			'016' => 'F',
			'017' => 'Y',
			'018' => 'G',
			'019' => 'K',
			'020' => 'Z',
			'021' => 'R',
			'023' => 'O',
			'024' => 'L',
			'025' => 'H',
			'028' => 'T',
			'030' => 'I',
			'034' => 'J',
			ri.major_code
		);
		
		self.student.file_type := ri.file_type;
		self.student.file_type2 := map(
			ri.file_type = 'C' => 'A', // avoid overlap with the C in existing american student field
			ri.file_type
		); 

		self.student.college_type := case( ri.public_private_code,
			'2' => 'P',
			'1' => 'S',
			'3' => 'U',
			ri.public_private_code
		);

		self.student.college_code := case( ri.public_private_code,
			'1' => '4',
			'2' => '4',
			'3'	=> '2',
			ri.public_private_code
		);

		self.student.class := case( trim(ri.class_rank),
			''  => '',
			'0' => 'HS',
			'1' => 'FR',
			'2' => 'SO',
			'3' => 'JR',
			'4' => 'SR',
			'5' => 'GS1',
			'6' => 'GS2',
			'7' => 'GS3',
			'8' => 'GS4',
			'9' => 'GR',
			'A' => 'P1',
			'B' => 'U2',
			'C' => 'U3',
			'D' => 'U4',
			'E' => 'U5',
			'UN'
			);

		self.student.date_first_seen := ri.date_vendor_first_reported;
		self.student.date_last_seen := min( iid_constants.mygetdate(le.historydate), ri.date_vendor_last_reported );

		self.student.college_name := ri.school_name;
		self.student.college_tier := if(bsversion>=50, ri.tier2, ri.tier);

		self.student.rec_type := ri.clean_rec_type;

		self := [];
	end;

  alloy_correct1_roxie := join( ids_only, FCRA.Key_Override_Alloy_FFID,
    keyed(right.flag_file_id in left.student_correct_ffid),
    transform(recordof(AlloyMedia_student_list.Key_DID_FCRA), self := right, self := []), 
		atmost(right.flag_file_id in left.student_correct_ffid, 100));

  alloy_correct1_thor := join( ids_only, pull(FCRA.Key_Override_Alloy_FFID),
    right.flag_file_id in left.student_correct_ffid,
    transform(recordof(AlloyMedia_student_list.Key_DID_FCRA), self := right, self := []), 
		ALL, LOCAL);
		
	#IF(onThor)
		alloy_correct1 := alloy_correct1_thor;
	#ELSE
		alloy_correct1 := alloy_correct1_roxie;
	#END
	alloy_correct := join(ids_only(did<>0), alloy_correct1, left.did=right.did, alloy_main(left,right));

	alloy_file_roxie := join(ids_only, AlloyMedia_student_list.Key_DID_FCRA, 
		left.did!=0
		and keyed(left.did=right.did)
		and right.date_vendor_first_reported < iid_constants.myGetDate(left.historydate)
    and (trim(right.sequence_number) + trim(right.key_code) + (string)right.rawaid) not in left.student_correct_record_id,
		alloy_main(left, right), atmost(keyed(left.did=right.did), 100));
	
	alloy_file_thor := join(distribute(ids_only(did!=0), hash64(did)), 
		distribute(pull(AlloyMedia_student_list.Key_DID_FCRA), hash64(did)), 
		(left.did=right.did)
		and right.date_vendor_first_reported < iid_constants.myGetDate(left.historydate)
    and (trim(right.sequence_number) + trim(right.key_code) + (string)right.rawaid) not in left.student_correct_record_id,
		alloy_main(left, right), atmost(left.did=right.did, 100), LOCAL);	

	#IF(onThor)
		alloy_file := alloy_correct + alloy_file_thor;
	#ELSE
		alloy_file := alloy_correct + ungroup(alloy_file_roxie);
	#END
  
	student_all := group(rollup(sort(ungroup(student_file + alloy_file),seq,record /* use record to avoid indeterminate code */), roll(left,right), seq),seq);
	return student_all;
end;