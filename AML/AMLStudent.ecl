import american_student_list, AlloyMedia_student_list, RISK_INDICATORS, doxie, Suppress, AML;

export AMLStudent(GROUPED DATASET(RISK_INDICATORS.Layout_Boca_Shell_ids) ids_only, doxie.IDataAccess mod_access) := FUNCTION

  Layout_AS_Plus := RECORD
    string8 DATE_FIRST_SEEN;
    string8 DATE_LAST_SEEN;
    string3 college_major;
    boolean HRDegreeField;
    boolean AttendCollege;
    unsigned6 did;
    unsigned4 seq;
    unsigned3 historydate;
    string1 src; // used to identify source ('A'=alloy vs 'C' or 'H' = american student) so we can tiebreak on rollup
  end;

  Layout_AS_Plus_CCPA := RECORD
    unsigned4 global_sid; // CCPA changes
    Layout_AS_Plus;
  end;

  Layout_AS_Plus_CCPA student(ids_only le, american_student_list.key_DID ri) := TRANSFORM
    self.did := le.did;
    self.seq := le.seq;
    self.historydate := le.historydate;
    self.date_last_seen := min( RISK_INDICATORS.iid_constants.mygetdate(le.historydate), ri.date_last_seen );
    self.AttendCollege := ri.file_type in ['A', 'H', 'C'] or (ri.file_type = 'M' and ri.college_code <> '' and  ri.tier <> '' and ri.college_major <> '') or
            (ri.file_type = '' and ri.college_code <> '' and  ri.tier <> '' and ri.college_major <> ' ' and  ri.class <> '' and ri.income_level_code <> '') ;
    self.src := ri.historical_flag; // ASL records will be indicated by a historical (H) or current (C) indicator
    self.global_sid := ri.global_sid;
    self := [];
  end;

// 1.  ams_file_type in [“A”, “H”, “C”]
// 2.  ams_file_type in[“M”] AND any of the following are populated: (ams_college_code, ams_college_tier, ams_college_major)
// 3.  ams_file_type in[“”] AND any of the following are populated: (ams_college_code, ams_college_tier, ams_college_major, ams_class, ams_income_level_code)


  student_file_unsuppressed := join(ids_only, american_student_list.key_DID,
    left.did!=0
    and keyed(left.did=right.l_did)
    and (unsigned3)(right.date_first_seen[1..6]) < left.historydate,
    student(left,right), left outer, atmost(keyed(left.did=right.l_did), 100)
  );

    student_file_flagged := Suppress.MAC_FlagSuppressedSource(student_file_unsuppressed, mod_access);

    student_file := PROJECT(student_file_flagged, TRANSFORM(Layout_AS_Plus,
    self.date_last_seen := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.date_last_seen);
    self.AttendCollege := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.AttendCollege);
    self.src := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.src);
    SELF := LEFT;
    ));

    Layout_AS_Plus roll( Layout_AS_Plus le, Layout_AS_Plus ri ) := TRANSFORM
    self := map(
      // current ASL over historical
      le.src='C' and ri.src='H' => le,
      le.src='H' and ri.src='C' => ri,

      // take the newer record when the DLS are unequal
      le.date_last_seen > ri.date_last_seen => le,
      le.date_last_seen < ri.date_last_seen => ri,

      // take american student over alloy
      le.src in ['C','H'] and ri.src = 'A' => le,
      ri.src in ['C','H'] and le.src = 'A' => ri,

      // take the newer record when the DFS are unequal
      le.date_first_seen > ri.date_first_seen => le,
      le.date_first_seen < ri.date_first_seen => ri,

      le
    );
  END;


  // alloy
  Layout_AS_Plus_CCPA alloy_main(ids_only le, AlloyMedia_student_list.Key_DID ri) := TRANSFORM
    self.global_sid := ri.global_sid;
    self.did := le.did;
    self.seq := le.seq;
    self.historydate := le.historydate;
    // self.src := 'A';

    college_major := case( ri.major_code,
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
    self.college_major := college_major;
    self.HRDegreeField := college_major in ['P','G','T','S'];  // accounting, law, medicine, finance
    self.date_first_seen := ri.date_vendor_first_reported;
    self.date_last_seen := min( RISK_INDICATORS.iid_constants.mygetdate(le.historydate), ri.date_vendor_last_reported );
    self := [];
  end;

  alloy_file_unsuppressed := join(ids_only, AlloyMedia_student_list.Key_DID,
      left.did!=0
      and keyed(left.did=right.did)
      and right.date_vendor_first_reported < RISK_INDICATORS.iid_constants.myGetDate(left.historydate),
      alloy_main(left, right), atmost(keyed(left.did=right.did), 100), keep(1));

  alloy_file := Suppress.Suppress_ReturnOldLayout(alloy_file_unsuppressed, mod_access, Layout_AS_Plus);

  student_all := group(rollup(sort(ungroup(student_file + alloy_file),seq, did), roll(left,right), seq, did),seq, did);

  // output(student_file, named('student_file'), overwrite);
  // output(alloy_file, named('alloy_file'), overwrite);
  // output(student_all, named('student_all'), overwrite);

  return student_all;
end;
