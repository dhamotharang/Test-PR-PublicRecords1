import amex, doxie,Riskwise,american_student_list, risk_indicators, ut;
export fn_getCollege(dataset (doxie.layout_references) dids, boolean isFCRA = false,unsigned3 history_date = 999999) := FUNCTION;
full_history_date := risk_indicators.iid_constants.full_history_date(history_date);
sLayout	:= record
  unsigned6 did;
  Riskwise.Layouts.Layout_American_Student ;
end;
sLayout studentFCRA(dids le, recordof(american_student_list.key_stu_DID_FCRA) ri) := TRANSFORM
  self.did := le.did;
	self := ri;
	self.college_tier := american_student_list.CollegeTier(ri.college_name[1..23],ri.file_type,ri.college_code, ri.college_type);
end;
sLayout student(dids le, recordof(american_student_list.key_stu_DID) ri) := TRANSFORM
	self.did := le.did;
	self := ri;
	self.college_tier := american_student_list.CollegeTier(ri.college_name[1..23],ri.file_type,ri.college_code, ri.college_type);
end;

sfile_nonFCRA := join(dids, american_student_list.key_stu_DID, 
											left.did!=0 and keyed(left.did=right.l_did),
											student(left,right), left outer, atmost(keyed(left.did=right.l_did), 100), 
											keep(AMEX.constants.max_college_to_use));

sfile_FCRA := join(dids, american_student_list.key_stu_DID_FCRA, 
											left.did!=0 and keyed(left.did=right.l_did),
											studentFCRA(left,right), left outer, atmost(keyed(left.did=right.l_did), 100), 
											keep(AMEX.constants.max_college_to_use));
studentRecs := if (isFCRA, sfile_FCRA, sfile_nonFCRA);									
studentRecsH := studentRecs((unsigned)date_first_seen < (unsigned)full_history_date);

outlayout  := record
  integer class_score;
  sLayout;
end;
outlayout classScore(sLayout l) := transform
  self.class_score := map(l.class = 'GR' => 1,
														l.class = 'UN' => 2,
														l.class = 'SR' => 3,
														l.class = 'JR' => 4,
														l.class = 'SO' => 5,
														l.class = 'FR' => 6,
														7); 
  self := l;
end;
 recsA := project(studentRecsH, classScore(left));
 sortedrecs := sort(recsA, did, class, class_score, college_name, college_code, college_type);
 doutrecs := dedup(sortedrecs, did, class, class_score, college_name, college_code, college_type);
 soutrecs := sort(doutrecs, class_score);
 
 // this isnt' in prod repository yet..  ut.date_yy_to_YYYY, so i'll just use it locally for now 
Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := function
	now		:= ut.GetDate;
	high	:= (unsigned)now[1..4] + delta;
	test	:= yy + ((unsigned)now[1..2]*100);
	yyyy	:= if(test<=high, test, test-100);
	return yyyy;
	// NOTE: Pass yy<100 and delta<100 or craziness ensues
end;
 
 
 highRecs := soutrecs(class <> '', college_name = '', college_code = '', college_type = '');
 highYR := if (exists(highRecs), Date_YY_to_YYYY((integer)highRecs[1].class),0);
 yearsSinceHigh := if (exists(highRecs), (string)ut.GetAge((string)highYR+'0601'), '');
  
 foundCollege := soutRecs(file_type = 'C' or 
                          file_type = 'H' or 
													(file_type = 'M' and 
													 class <> '' and 
													 college_name = '' and 
					                 college_code = '' and
					                 college_type = ''
					                ));
 
 best2 := TOPN(soutRecs, AMEX.constants.max_college, class_score, record)  ;
 
AMEX.layouts.college_data  loadIt() := Transform
  self.Attended_High_school_indicator := if (exists(highRecs) or exists(foundCollege), 'Y','');
	self.Years_since_HS_Graduation := yearsSinceHigh;
  
	foundCollege1 := best2[1].college_type<>'' or best2[1].college_code<>'' or best2[1].college_tier<>'';
	self.College_indicator1 := if (foundCollege1, 'Y','');
	self.College_public_private_flag1 := best2[1].college_type;
	self.College_2yr_4yr__grad_indicator1 := best2[1].college_code;
	self.College_Education_program_tier1 := best2[1].college_tier;
		
	foundCollege2 := best2[2].college_type<>'' or best2[2].college_code<>'' or best2[2].college_tier<>'';
	self.College_indicator2 := if (foundCollege2, 'Y','');
	self.College_public_private_flag2 := best2[2].college_type;
	self.College_2yr_4yr__grad_indicator2 := best2[2].college_code;
	self.College_Education_program_tier2 := best2[2].college_tier;
END;
	
collegeRec := DATASET([loadit()]);
return collegeRec;
END;