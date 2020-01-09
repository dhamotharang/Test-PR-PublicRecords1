import FraudgovUIKEL;

// output(FraudgovUIKEL.files.Wages);
// dsWage := FraudGovUIKEL.files.Wages;
// dsEmps := FraudGovUIKEL.files.Employer;

// dsEmpsA := FraudGovUIKEL.Q__show_Employers.Res0;
// OUTPUT(COUNT(dsEmpsA((B_A___Qtly_Wgs_Tot_A1_Qc_ > 0 AND B_A___Qtly_Empl_Cnt_A1_Qc_ <=0) OR (B_A___Qtly_Wgs_Tot_A2_Qc_ > 0 AND B_A___Qtly_Empl_Cnt_A2_Qc_ <=0) OR (B_A___Qtly_Wgs_Tot_A3_Qc_ > 0 AND B_A___Qtly_Empl_Cnt_A3_Qc_ <=0) OR (B_A___Qtly_Wgs_Tot_A4_Qc_ > 0 AND B_A___Qtly_Empl_Cnt_A4_Qc_ <=0))), NAMED('t1a'));


// OUTPUT(COUNT(dsEmpsA((B_A___Qtly_Wgs_Tot_A1_Qc_ > 0 OR B_A___Qtly_Wgs_Tot_A2_Qc_ > 0 OR B_A___Qtly_Wgs_Tot_A3_Qc_ > 0 OR B_A___Qtly_Wgs_Tot_A4_Qc_ > 0) AND B_A___Yrly_Wgs_Tot_A1_Qc_ <= 0)), NAMED('t2a'));
// OUTPUT(dsEmpsA((B_A___Qtly_Wgs_Tot_A1_Qc_ > 0 OR B_A___Qtly_Wgs_Tot_A2_Qc_ > 0 OR B_A___Qtly_Wgs_Tot_A3_Qc_ > 0 OR B_A___Qtly_Wgs_Tot_A4_Qc_ > 0) AND B_A___Yrly_Wgs_Tot_A1_Qc_ <= 0), NAMED('t2b'));
// OUTPUT(COUNT(dsEmpsA((B_A___Qtly_Empl_Cnt_A1_Qc_ > 0 OR B_A___Qtly_Empl_Cnt_A2_Qc_ > 0 OR B_A___Qtly_Empl_Cnt_A3_Qc_ > 0 OR B_A___Qtly_Empl_Cnt_A4_Qc_ > 0) AND B_A___Yrly_Empl_Cnt_A1_Qc_ <= 0)), NAMED('t3a'));
// OUTPUT(dsEmpsA((B_A___Qtly_Empl_Cnt_A1_Qc_ > 0 OR B_A___Qtly_Empl_Cnt_A2_Qc_ > 0 OR B_A___Qtly_Empl_Cnt_A3_Qc_ > 0 OR B_A___Qtly_Empl_Cnt_A4_Qc_ > 0) AND B_A___Yrly_Empl_Cnt_A1_Qc_ <= 0), NAMED('t3b'));


// OUTPUT(COUNT(dsEmpsA(B_A___Yrly_Wgs_Tot_A1_Qc_ > 0 AND B_A___Yrly_Empl_Cnt_A1_Qc_ <=0)), NAMED('t4a'));
//OUTPUT(COUNT(dsEmpsA((B_A___Qtly_Tax_Rate_Echo_A1_Qc_ > 0 OR B_A___Qtly_Tax_Rate_Echo_A2_Qc_ > 0 OR B_A___Qtly_Tax_Rate_Echo_A3_Qc_ > 0 OR B_A___Qtly_Tax_Rate_Echo_A4_Qc_ > 0) AND B_A___Yrly_Tax_Rt_Avg_A1_Qc_ <= 0)), NAMED('t5a'));
// OUTPUT(COUNT(dsEmpsA(B_A___Qtly_Wgs_Tot_A1_Qc_=-99998 AND 
			// (B_A___Qtly_Wgs_Tot_A1_Qc_!=B_A___Qtly_Wgs_Tot_A2_Qc_ OR B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Qtly_Wgs_Tot_A3_Qc_ OR
			 // B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Qtly_Wgs_Tot_A4_Qc_ OR B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Qtly_Wgs_Tot_A5_Qc_ OR 
			 // B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Yrly_Wgs_Tot_A1_Qc_ OR B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Yrly_Wgs_Tot_A1_Qc_ OR 
			 
			 // B_A___Qtly_Wgs_Tot_A1_Qc_!=B_A___Qtly_Empl_Cnt_A1_Qc_ OR B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Qtly_Empl_Cnt_A2_Qc_ OR
			 // B_A___Qtly_Wgs_Tot_A1_Qc_!=B_A___Qtly_Empl_Cnt_A3_Qc_ OR B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Qtly_Empl_Cnt_A4_Qc_ OR
			 // B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Qtly_Wgs_Tot_A5_Qc_ OR B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Yrly_Empl_Cnt_A1_Qc_ OR 
			 // B_A___Qtly_Wgs_Tot_A1_Qc_ != B_A___Yrly_Empl_Cnt_A5_Qc_))), NAMED('t6a'));
// xtWage := TABLE(dsWage, {wageyearqtr, cnt:=count(group)}, wageyearqtr, MERGE);
// OUTPUT(SORT(xtWage, wageyearqtr));
// OUTPUT(dsEmpsA);

// Investigate wages
// lowYrWg := FraudGovUIKEL.Q__show_Employers.Res0(B_A___Yrly_Wgs_Tot_A1_Qc_ < 100 and B_A___Yrly_Wgs_Tot_A1_Qc_ > 0);
// highYrWg := FraudGovUIKEL.Q__show_Employers.Res0(B_A___Yrly_Wgs_Tot_A1_Qc_ > 500000000);
// OUTPUT(lowYrWg, NAMED('LowYrlyWage'));
// OUTPUT(dsWage((integer)empnum in SET(lowYrWg, Bus_Acct_U_I_D_Echo_)), NAMED('LowYrlyWageTrump'));
// OUTPUT(dsWage(empnum = '0583522'), NAMED('lowwg1'));
// OUTPUT(dsWage(empnum = '0718440'), NAMED('lowwg2'));
// OUTPUT(dsWage(empnum = '0843924'), NAMED('lowwg3'));
// OUTPUT(highYrWg, NAMED('HighYrlyWage'));
// OUTPUT(dsWage((integer)empnum in SET(highYrWg, Bus_Acct_U_I_D_Echo_)), NAMED('HighYrlyWageTrump'));


// OUTPUT(FraudgovUIKEL.Q__show_Employer_Quarters_Emp.Res0(_uacctno_ in [475529, 790935, 791347, 510106]));
// OUTPUT(FraudgovUIKEL.Q__show_Employer_Quarters.Res0(_r_employer_ in [2192, 424065, 101137, 16417]));
// output(COUNT(FraudgovUIKEL.files.Employer));

// output(FraudgovUIKel.Files.Wages(ultid = 29664687));

// output(FraudgovUIKel.Q__show_Employers.Res0);
// output(FraudgovUIKel.Q__show_Employers.Res0(B_A___Emp_Mv_Fr_Per_B_U_I_D_Qtly_Max_A1_Qc_>0));
output(FraudgovUIKEL.Q__show_To_employer_employees.Res0(clean_movement_flag_=1 AND _r_To_Employer_=163993));
output(FraudgovUIKEL.Q__show_To_employer_employees.Res0(clean_movement_flag_=1 AND _r_To_Employer_=135967));

// output(FraudgovUIKEL.Q__show_From_employer_employees.Res0(clean_movement_flag_=1 AND _r_From_Employer_=321365));
// output(FraudgovUIKEL.Q__show_From_employer_employees.Res0(clean_movement_flag_=1 AND _r_From_Employer_=477013));
// output(FraudgovUIKEL.Q__show_From_employer_employees.Res0(clean_movement_flag_=1 AND _r_From_Employer_=41901));
// output(FraudgovUIKEL.Q__show_From_employer_employees.Res0(clean_movement_flag_=1 AND _r_From_Employer_=206918));


// OUTPUT(FraudgovUIKEL.Q__show_Employer_Person_Wages.Res0);
// output(FraudgovUIKel.Q__show_Employers.Res0(B_A___Wg_Qtr_Cnt_Ev_>0), 
	// {Bus_Acct_U_I_D_Echo_, B_A___Qtly_Tax_Rt_Echo_A1_Qc_, B_A___Qtly_Tax_Rt_Echo_A2_Qc_, B_A___Qtly_Tax_Rt_Echo_A3_Qc_,
		// B_A___Qtly_Tax_Rt_Echo_A4_Qc_, B_A___Qtly_Tax_Rt_Echo_A5_Qc_, B_A___Yrly_Tax_Rt_Avg_A1_Qc_, B_A___Yrly_Tax_Rt_Avg_A5_Qc_});

// OUTPUT(FraudgovUIKEL.files.Employer(uacctno in [864649,846370,475529,867912,708798]),
	// {uacctno, qtryr, ratecodeqtrinfo, qtryr2, ratecodeqtrinfo2, qtryr3, ratecodeqtrinfo3,
	// qtryr4, ratecodeqtrinfo4, qtryr5, ratecodeqtrinfo5, qtryr6, ratecodeqtrinfo6, qtryr7, ratecodeqtrinfo7,
	// qtryr8, ratecodeqtrinfo8, qtryr9, ratecodeqtrinfo9, qtryr10, ratecodeqtrinfo10, qtryr11, ratecodeqtrinfo11,
	// qtryr12, ratecodeqtrinfo12, qtryr13, ratecodeqtrinfo13, qtryr14, ratecodeqtrinfo14, qtryr15, ratecodeqtrinfo15,
	// qtryr16, ratecodeqtrinfo16, qtryr17, ratecodeqtrinfo17, qtryr18, ratecodeqtrinfo18, qtryr19, ratecodeqtrinfo19,
	// qtryr20, ratecodeqtrinfo20});

//output(FraudgovUIKel.Q__show_Employers.Res0(Bus_Acct_Sele_I_D_Append_=-99999));

// output(FraudgovUIKel.Q__show_Claims.Res0(_application__id_=1000018));
//output(FraudgovUIKel.Q__show_Claims.Res0);
// output(FraudgovUIKel.Q__show_Employer_Claims.Res0(_r_employer_!=0));

// output(FraudgovUIKel.Q__show_Legal.Res0);

// output(topn(FraudgovUIKel.Q__show_Legal.Res0, 100, -Move_To_Count_));
// output(FraudgovUIKel.Q__show_Legal.Res0(Move_Same_Sele_Diff_Emp_Count_>0));
// output(FraudgovUIKel.Q__show_Legal.Res0(Move_Same_Ult_Diff_Sele_Emp_Count_>0));
// output(FraudgovUIKel.Q__show_Legal.Res0(Same_Ult_Diff_Sele_Employee_Count_>0));
/*
//output(FraudgovUIKel.Q__show_Person.Res0);
output(FraudgovUIKel.Q__show_Legal_Person_Wages.Res0);
//output(FraudgovUIKel.Q__show_Claimant.Res0);

output(FraudgovUIKel.Files.WagesAssociations((fromwageyearqtr < towageyearqtr) AND toseleid = 7079047 AND employeelexid != 0));
*/
// output(FraudgovUIKel.Q__show_Legal.Res0(Same_Ult_Diff_Sele_Employee_Count_>0));

// output(FraudgovUIKel.Files.WagesAssociations(employeelexid != 0 AND fromseleid != toseleid AND fromultid = toultid));


// t1 := TABLE(FraudgovUIKel.Files.WagesAssociations(employeelexid != 0 AND fromseleid != toseleid), {fromseleid, toseleid, recs := COUNT(GROUP)}, fromseleid, toseleid, MERGE);
// topn(t1, 100,-recs);

// t1 := TABLE(FraudgovUIKel.Files.WagesAssociations(fromseleid != 0 and employeelexid != 0 AND (fromwageyearqtr < towageyearqtr)), {toseleid, recs := COUNT(GROUP)}, toseleid, MERGE);
// topn(t1, 100,-recs);



