IMPORT thrive;
			 
ds  :=  DATASET('~thor_data400::in::wpl_thrive::20120516::pdsegment',
				thrive.layouts_PD.input,CSV(SEPARATOR([',']),HEADING(1),MAXLENGTH(40000))) ;
				
output(ds);
	
Field_PopulationStats  := record
  countgroup			:= count(group);
	xfname					:= ave(group,if((string) ds.fname						<>'',100,0));
	xmname					:= ave(group,if((string) ds.mname						<>'',100,0));
	xlname					:= ave(group,if((string) ds.lname						<>'',100,0));
	xaddr						:= ave(group,if((string) ds.addr						<>'',100,0));
	xcity						:= ave(group,if((string) ds.city						<>'',100,0));
	xst							:= ave(group,if((string) ds.st							<>'',100,0));
	xzip						:= ave(group,if((string) ds.zip							<>'',100,0));
	xzip4						:= ave(group,if((string) ds.zip4						<>'',100,0));
	xphone_home			:= ave(group,if((string) ds.phone_home			<>'',100,0));
	xphone_cell			:= ave(group,if((string) ds.phone_cell			<>'',100,0));
	xphone_work			:= ave(group,if((string) ds.phone_work			<>'',100,0));
	xemail					:= ave(group,if((string) ds.email						<>'',100,0));
	xdob						:= ave(group,if((string) ds.dob							<>'',100,0));
	xown_home				:= ave(group,if((string) ds.own_home				<>'',100,0));
	xdr							:= ave(group,if((string) ds.dr							<>'',100,0));
	xis_military		:= ave(group,if((string) ds.is_military 		<>'',100,0));
	xemployer				:= ave(group,if((string) ds.employer				<>'',100,0));
	xpay_frequency	:= ave(group,if((string) ds.pay_frequency   <>'',100,0));
	xincome_monthly := ave(group,if((string) ds.income_monthly  <>'',100,0));
	xmonths_employed:= ave(group,if((string) ds.months_employed <>'',100,0));
	xmonths_at_bank := ave(group,if((string) ds.months_at_bank	<>'',100,0));
	xip							:= ave(group,if((string) ds.ip							<>'',100,0));
end;

fieldPOP := table(ds,Field_PopulationStats,all);	
output(fieldPOP);

Field_Max_Length_Stats := record
	unsigned4 xfname				:= max(group,length((string)   ds.fname));
	unsigned4 xmname				:= max(group,length((string)   ds.mname));
	unsigned4 xlname				:= max(group,length((string)   ds.lname));
	unsigned4 xaddr					:= max(group,length((string)   ds.addr));
	unsigned4 xcity					:= max(group,length((string)   ds.city));
	unsigned4 xst						:= max(group,length((string)   ds.st));
	unsigned4 xzip					:= max(group,length((string)   ds.zip));
	unsigned4 xzip4					:= max(group,length((string)   ds.zip4));
	unsigned4 xphone_home		:= max(group,length((string)   ds.phone_home));
	unsigned4 xphone_cell		:= max(group,length((string)   ds.phone_cell));
	unsigned4 xphone_work		:= max(group,length((string)   ds.phone_work));
	unsigned4 xemail				:= max(group,length((string)   ds.email));
	unsigned4 xdob					:= max(group,length((string)   ds.dob));
	unsigned4 xown_home			:= max(group,length((string)   ds.own_home));
	unsigned4 xdr						:= max(group,length((string) 	 ds.dr));
	unsigned4 xis_military	:= max(group,length((string)   ds.is_military));
	unsigned4 xemployer			:= max(group,length((string)   ds.employer));
	unsigned4 xpay_frequency:= max(group,length((string)   ds.pay_frequency));
	unsigned4 xincome_monthly:= max(group,length((string)  ds.income_monthly));
	unsigned4 xmonths_employed:= max(group,length((string) ds.months_employed));
	unsigned4 xmonths_at_bank:= max(group,length((string)  ds.months_at_bank));
	unsigned4 xip						:= max(group,length((string)   ds.ip));
end;
				
output(table(ds,Field_Max_Length_Stats,few));