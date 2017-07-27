IMPORT thrive;
			 
ds  :=  DATASET('~thor_data400::in::wpl_thrive::20120516::ltsegment',
				thrive.layouts_LT.input,CSV(SEPARATOR([',']),HEADING(1),MAXLENGTH(40000))) ;
				
output(ds);
	
Field_PopulationStats  := record
  countgroup		:= count(group);
	xFname 				:= ave(group,if((string) ds.Fname<>'',100,0));
	xLname        := ave(group,if((string) ds.Lname<>'',100,0));
	xAddr 				:= ave(group,if((string) ds.Addr<>'',100,0));
	xCity					:= ave(group,if((string) ds.City<>'',100,0));
	xZip4 				:= ave(group,if((string) ds.Zip4<>'',100,0));
	xState 				:= ave(group,if((string) ds.State<>'',100,0));
	xZip 					:= ave(group,if((string) ds.Zip<>'',100,0));
	xEmail 				:= ave(group,if((string) ds.Email<>'',100,0));
	xPhone 				:= ave(group,if((string) ds.Phone<>'',100,0));
	xLoanType 		:= ave(group,if((string) ds.LoanType<>'',100,0));
	xBestTime 		:= ave(group,if((string) ds.BestTime<>'',100,0));
	xMortRate 		:= ave(group,if((string) ds.MortRate<>'',100,0));
	xPropertyType := ave(group,if((string) ds.PropertyType<>'',100,0));
	xRateType 		:= ave(group,if((string) ds.RateType<>'',100,0));
	xLTV 					:= ave(group,if((string) ds.LTV<>'',100,0));
	xYrsThere 		:= ave(group,if((string) ds.YrsThere<>'',100,0));
	xEmployer 		:= ave(group,if((string) ds.Employer<>'',100,0));
	xIncome 			:= ave(group,if((string) ds.Income<>'',100,0));
	xCredit 			:= ave(group,if((string) ds.Credit<>'',100,0));
	xLoanAmt 			:= ave(group,if((string) ds.LoanAmt<>'',100,0));
	xDT						:= ave(group,if((string) ds.DT<>'',100,0));
end;

fieldPOP := table(ds,Field_PopulationStats,all);	
output(fieldPOP);

Field_Max_Length_Stats := record
	unsigned4 xFname 				:= max(group,length((string) ds.Fname));
	unsigned4 xLname 				:= max(group,length((string) ds.Lname));
	unsigned4 xAddr 				:= max(group,length((string) ds.Addr));
	unsigned4 xCity 				:= max(group,length((string) ds.City));
	unsigned4 xZip4 				:= max(group,length((string) ds.Zip4));
	unsigned4 xState 				:= max(group,length((string) ds.State));
	unsigned4 xZip 					:= max(group,length((string) ds.Zip));
	unsigned4 xEmail 				:= max(group,length((string) ds.Email));
	unsigned4 xPhone 				:= max(group,length((string) ds.Phone));
	unsigned4 xLoanType 		:= max(group,length((string) ds.LoanType));
	unsigned4 xBestTime 		:= max(group,length((string) ds.BestTime));
	unsigned4 xMortRate 		:= max(group,length((string) ds.MortRate));
	unsigned4 xPropertyType := max(group,length((string) ds.PropertyType));
	unsigned4 xRateType 		:= max(group,length((string) ds.RateType));
	unsigned4 xLTV 					:= max(group,length((string) ds.LTV));
	unsigned4 xYrsThere			:= max(group,length((string) ds.YrsThere));
	unsigned4 xEmployer 		:= max(group,length((string) ds.Employer));
	unsigned4 xIncome 			:= max(group,length((string) ds.Income));
	unsigned4 xCredit 			:= max(group,length((string) ds.Credit));
	unsigned4 xLoanAmt 			:= max(group,length((string) ds.LoanAmt));
	unsigned4 xDT 					:= max(group,length((string) ds.DT));
end;
				
output(table(ds,Field_Max_Length_Stats,few));