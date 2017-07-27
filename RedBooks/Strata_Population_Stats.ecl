import strata, versioncontrol;
export Strata_Population_Stats(string pversion) :=
module
	export Business_headers :=
	module

		Strata.createAsBusinessStats.Header(fAs_Business_Header_Combined(files().base.Combined.qa),_dataset.name,'Combined',pversion,Email_Notification_Lists.stats,Combined);
		
                              
		export all :=
		sequential( Combined );

	end;
	

	export Business_Contacts :=
	module

		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_Combined(files().base.Combined.qa),_dataset.name,'Combined',pversion,Email_Notification_Lists.stats,Combined);
		
		export all :=
		sequential( Combined	);

	end;
	
	export all := if(VersionControl.IsValidVersion(pversion),
	sequential(
		 business_headers.all
		,business_contacts.all
	));

end;