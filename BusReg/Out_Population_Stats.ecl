import Business_Header, strata;
export Out_Population_Stats(

	string pversion

) :=
module

	Strata.createAsBusinessStats.Header		(fBusReg_As_Business_Header	(File_BusReg_Company											)	,'Accutrend Business Registrations'	,'data'	,pversion	,Email_Notification_Lists.BuildSuccess	,Business_headers		);
	Strata.createAsBusinessStats.Contacts	(fBusReg_As_Business_Contact(File_BusReg_Company, file_busreg_contact	)	,'Accutrend Business Registrations'	,'data'	,pversion	,Email_Notification_Lists.BuildSuccess	,Business_Contacts	);

	export All :=
	parallel(
		 Business_headers	
		,Business_Contacts
//		,BusReg.Strata_Company_Population_Stats
//		,BusReg.Strata_Contacts_Population_Stats
	);



end;



