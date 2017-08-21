import strata, versioncontrol;
export Strata_Population_Stats(string pversion) :=
module
	export Business_headers :=
	module
 
		Strata.createAsBusinessStats.Header(fAs_Business_Header_NJ(files().base.NJ.qa),_dataset.name,'NJ',pversion,Email_Notification_Lists.stats,NJ);
		
                              
		export all :=
		sequential( NJ );

	end;

	export Business_Contacts :=
	module

		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_NJ(files().base.NJ.qa),_dataset.name,'NJ',pversion,Email_Notification_Lists.stats,NJ);
		

		export all :=
		sequential( NJ );

	end;
	
	export all := if(VersionControl.IsValidVersion(pversion),
	sequential(
		 business_headers.all
		,business_contacts.all
	));

end;