rec := record
string10 	question_number;
string300	question;
string100	sub_acct_id;
string100	response;
string10	interview_date;
string10	year;
string10	interview_date_formatted;
string10  filler;
end;
input := dataset('~foreign::10.194.10.1::thor::ms::data_analytics::analysis_CES', rec, CSV(SEPARATOR(['\t'])));

rec1 := record
integer   recordId;
string20 	question_number;
string600	question;
string100	sub_acct_id;
string100	response;
string10	interview_date;
string10	year;
string10	interview_date_formatted;
end;

rec1 xform(input l, integer c) := transform
	shiftValues := if(l.sub_acct_id[1..3] = 'ALL', true, false);
	self.question_number					:= l.question_number;
	self.question 								:= if(shiftValues, l.question + l.sub_acct_id, l.question);
	self.sub_acct_id							:= if(shiftValues, l.response, l.sub_acct_id);
	self.response 								:= if(shiftValues, l.interview_date, l.response);
	self.interview_date 					:= if(shiftValues, l.year, l.interview_date);
	self.year 										:= if(shiftValues, l.interview_date_formatted, l.year);
	self.interview_date_formatted	:= if(shiftValues, l.filler, l.interview_date_formatted);
	self.recordId 								:= c;
end;
ds := project(input, xform(left, counter));
output(choosen(ds, 100), all);

rec1 appendsubact(rec1 L, rec1 R) := TRANSFORM
	SELF.sub_acct_id := if(r.sub_acct_id = '', l.sub_acct_id, r.sub_acct_id);
	SELF.interview_date_formatted := if(r.interview_date_formatted = '', l.interview_date_formatted, r.interview_date_formatted);
	SELF.question_number := if(r.question_number = '', trim(l.question_number) + '_DUP', r.question_number);
	SELF := R;
END;
iter1 := sort(ITERATE(ds(recordId != 1),appendsubact(LEFT,RIGHT)), sub_acct_id, interview_date_formatted);

// qn := dedup(sort(appendSubAcct, question_number), question_number);
// output(qn, all);

op := record
string100	sub_acct_id;
string10	interview_date_formatted;
string10	interview_date;
string10	year;
string20 Q1;
string20 Q2b;
string20 Q3a;
string20 Q3c;
string20 Q9; 
string20 Q14;
string20 Q20a;
string20 Q20d;
string20 Q21a;
string20 Q22;
end;

op doRollup(recordof(iter1) l, DATASET(recordof(iter1)) allRows) := TRANSFORM
	
	self.sub_acct_id 								:= REGEXREPLACE('[,]*',TRIM(l.sub_acct_id,LEFT,RIGHT),'');
	self.interview_date 						:= l.interview_date;
	self.year 											:= l.year;
	self.interview_date_formatted 	:= l.interview_date_formatted;
	
	self.Q1													:= trim(allRows(question_number = 'Q1')[1].response);
	self.Q2b												:= trim(allRows(question_number = 'Q2b')[1].response);
	self.Q3a												:= trim(allRows(question_number = 'Q3a')[1].response);
	self.Q3c												:= trim(allRows(question_number = 'Q3c')[1].response);
	self.Q9													:= trim(allRows(question_number = 'Q9')[1].response); 
	self.Q14												:= trim(allRows(question_number = 'Q14')[1].response);
	self.Q20a												:= trim(allRows(question_number = 'Q20a')[1].response);
	self.Q20d												:= trim(allRows(question_number = 'Q20d')[1].response);
	self.Q21a												:= trim(allRows(question_number = 'Q21a_DUP')[1].response);
	self.Q22												:= trim(allRows(question_number = 'Q22_DUP')[1].response);
	
	self := [];
end;
result_0 := ROLLUP(group(iter1, sub_acct_id, interview_date_formatted), GROUP, doRollup(LEFT, ROWS(LEFT)));
result := sort(result_0, sub_acct_id, -interview_date_formatted);

op1 := record, maxlength(22000)
string100	sub_acct_id;
string100  mig_gen03_cd;
integer    totalRecords;
string10	recent_interview_date_formatted;
string10	recent_response_q3a;
end;

op1 doRollup1(recordof(result) l, DATASET(recordof(result)) allRows) := TRANSFORM
	self.sub_acct_id 											:= l.sub_acct_id;
	self.totalRecords											:= count(allRows);
	self.recent_interview_date_formatted 	:= allRows[1].interview_date_formatted;
	self.recent_response_q3a							:= allRows[1].Q3a;
	// self.detailedRecord							:= project(allRows, op);
	self := [];
end;
result0 := ROLLUP(group(result, sub_acct_id), GROUP, doRollup1(LEFT, ROWS(LEFT)));

ma := RECORD
  string sys_cd;
  string cust_cd;
  string vc_id;
  string mig_gen03_cd;
  string cust_id;
  string hh_id;
 END;
acct := dataset('~thor20_11::poc::fs_accts_slim', ma,CSV(SEPARATOR(['\t']))); 

j1 := join(result0, acct, trim(left.sub_acct_id) = trim(right.vc_id), transform(recordof(left), self.mig_gen03_cd := right.mig_gen03_cd, self := left), left outer);
result1 := j1;
output(result1,,'~thor::ms::data_analytics::analysis_ces::result_aggregate', overwrite, csv(heading(single), separator('\t'), terminator('\n')));
count(result1);


op2 := record
	op1;
	op and not sub_acct_id;
end;
j2 := join(result, result1, trim(left.sub_acct_id) = trim(right.sub_acct_id), transform(op2, self := right, self := left, self := []), left outer);
result2 := j2;
output(result2,,'~thor::ms::data_analytics::analysis_ces::result', overwrite, csv(heading(single), separator('\t'), terminator('\n')));
count(result2);



output(count(result1(mig_gen03_cd != '')), named('TotalRecordsWithMigrationId'));

t1 := table(result1, {recent_response_q3a, integer cnt := count(group)}, recent_response_q3a);
output(t1, named('Q3ADistribution'));

f1 := FileServices.DeSpray('~thor::ms::data_analytics::analysis_ces::result_aggregate', Analytics_poc.Constants.landing_ip, 'w:\\poc\\ces_aggregate_result.csv', ,,,true);
f2 := FileServices.DeSpray('~thor::ms::data_analytics::analysis_ces::result', Analytics_poc.Constants.landing_ip, 'w:\\poc\\ces_result.csv', ,,,true);
sequential(f1, f2);
