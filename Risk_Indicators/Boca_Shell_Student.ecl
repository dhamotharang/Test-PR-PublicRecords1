
import american_student_list, Riskwise, AlloyMedia_student_list, MDR;

export Boca_Shell_Student(GROUPED DATASET(Layout_Boca_Shell_ids) ids_only, integer bsversion, boolean isMarketing) := FUNCTION
		
	Layout_AS_Plus := RECORD
		Riskwise.Layouts.Layout_American_Student student;
		unsigned6 did;
		unsigned4 seq;
		unsigned3 historydate;
		string1 src; // used to identify source ('A'=alloy vs 'C' or 'H' = american student) so we can tiebreak on rollup
	end;
	 
	Layout_AS_Plus student(ids_only le, american_student_list.key_DID ri) := TRANSFORM
		self.did := le.did;
		self.seq := le.seq;
		self.historydate := le.historydate;
		self.student.date_last_seen := min( iid_constants.mygetdate(le.historydate), ri.date_last_seen );
		self.student.file_type2 := ri.file_type;
		self.student := ri;
		self.student.college_tier := if(bsversion>=50, ri.tier2, ri.tier);
		self.src := ri.historical_flag; // ASL records will be indicated by a historical (H) or current (C) indicator
	end;
	student_file := join(ids_only, american_student_list.key_DID, 
		left.did!=0 
		and if(bsversion >= 4, true, if(right.source = MDR.sourceTools.src_OKC_Student_List, false, true)) 
		and (~(right.source=mdr.sourceTools.src_OKC_Student_List and right.collegeid in Risk_Indicators.iid_constants.Set_Restricted_Colleges_For_Marketing) or isMarketing=false)
		and keyed(left.did=right.l_did)
		and (unsigned3)(right.date_first_seen[1..6]) < left.historydate,
		student(left,right), left outer, atmost(keyed(left.did=right.l_did), 100)
	);

	Layout_AS_Plus roll( Layout_AS_Plus le, Layout_AS_Plus ri ) := TRANSFORM
		self := map(

			// Use any other record over File Type 'M' 
			le.student.file_type='M' and ri.student.file_type<>'M' => ri,
			ri.student.file_type='M' and le.student.file_type<>'M'=> le,
		
			// current ASL over historical
			le.src in ['C','O'] and ri.src='H' => le,
			le.src='H' and ri.src in ['C','O'] => ri,
		
			
			// take the newer record when the DLS are unequal
			le.student.date_last_seen > ri.student.date_last_seen => le,
			le.student.date_last_seen < ri.student.date_last_seen => ri,

			// take american student over alloy
			le.src in ['C','H','O'] and ri.src = 'A' => le,
			ri.src in ['C','H','O'] and le.src = 'A' => ri,

			// take the newer record when the DFS are unequal
			le.student.date_first_seen > ri.student.date_first_seen => le,
			le.student.date_first_seen < ri.student.date_first_seen => ri,
			
			le
		);
	END;


	// alloy
	Layout_AS_Plus alloy_main(ids_only le, AlloyMedia_student_list.Key_DID ri) := TRANSFORM
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
		
		self.student.file_type  := ri.file_type;

		//translates C->A to avoid overlap with the C in existing ams field.
		// per brent, use 'A' instead of the previously decided 'G'; legacy models will still use file_type; edina shell will map our file_type2 to their file_type
		self.student.file_type2 := if( ri.file_type = 'C', 'A', ri.file_type );

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



	alloy_file := join(ids_only, AlloyMedia_student_list.Key_DID, 
			left.did!=0
			and keyed(left.did=right.did)
			and right.date_vendor_first_reported < iid_constants.myGetDate(left.historydate),
			alloy_main(left, right), atmost(keyed(left.did=right.did), 100));


	student_all := group(rollup(sort(ungroup(student_file + alloy_file),seq,record /* use record to avoid indeterminate code */), roll(left,right), seq),seq);
	return student_all;
end;