import ut, STD;
export Statistics(

	string pversion = 'qa'
 
) :=
module
	
	shared mindate := 19500000;
	shared maxdate := Std.Date.Today();

	ut.macGetCoverageDates(files(pversion).base.Companies.new	,_Dataset.Name + ' Companies Base'	,dt_first_seen	,dt_last_seen	,Companies_base_Coverage_stats	,false,mindate,maxdate);
	ut.macGetCoverageDates(files(pversion).base.Contacts.new	,_Dataset.Name + ' Contacts Base'		,dt_first_seen	,dt_last_seen	,Contacts_base_Coverage_stats		,false,mindate,maxdate);

	export All :=
	sequential(
		 output(Companies_base_Coverage_stats	,named(_Dataset.Name + 'Companies_Base_Coverage_Stats'	))
		,output(Contacts_base_Coverage_stats		,named(_Dataset.Name + 'Contacts_base_Coverage_stats'		))
	);

end;