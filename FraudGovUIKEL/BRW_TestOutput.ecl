import FraudgovUIKEL;

//output(FraudgovUIKEL.files.Wages);



//output(FraudgovUIKel.Q__show_Employers.Res0(claim_count_ > 0));
// output(FraudgovUIKel.Q__show_Employers.Res0(Bus_Acct_Sele_I_D_Append_=-99999));

// output(FraudgovUIKel.Q__show_Claims.Res0(_acctno_=110716));
//output(FraudgovUIKel.Q__show_Employer_Claims.Res0(_r_employer_!=0));
output(topn(FraudgovUIKel.Q__show_Legal.Res0, 100, -Move_To_Count_));
output(FraudgovUIKel.Q__show_Legal.Res0(Move_Same_Sele_Diff_Emp_Count_>0));
output(FraudgovUIKel.Q__show_Legal.Res0(Move_Same_Ult_Diff_Sele_Emp_Count_>0));
output(FraudgovUIKel.Q__show_Legal.Res0(Same_Ult_Diff_Sele_Employee_Count_>0));

output(FraudgovUIKel.Q__show_Legal_Person_Wages.Res0);
//output(FraudgovUIKel.Q__show_Legal.Res0(account_number_count_>1));
//output(FraudgovUIKel.Q__show_Claimant.Res0);

output(FraudgovUIKEL.files.WagesAssociations((fromwageyearqtr < towageyearqtr) AND toseleid=7079047 AND employeelexid != 0));
output(FraudgovUIKEL.files.WagesAssociations(fromseleid != toseleid AND fromultid=toultid AND fromwageyearqtr < towageyearqtr));

t1 := TABLE(FraudgovUIKEl.Files.WagesAssociations(fromseleid != 0 and employeelexid != 0 AND (fromwageyearqtr < towageyearqtr)), {toseleid, recs := COUNT(GROUP)}, toseleid, MERGE);
topn(t1, 100, -recs);



