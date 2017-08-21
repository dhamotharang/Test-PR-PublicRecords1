import strata, versioncontrol;
export Strata_Population_Stats(string pversion) :=
module
	export Business_headers :=
	module

		Strata.createAsBusinessStats.Header(fAs_Business_Header_CA(files().base.CA.qa),_dataset.name,'CA',pversion,Email_Notification_Lists.stats,CA);
		Strata.createAsBusinessStats.Header(fAs_Business_Header_CT(files().base.CT.qa),_dataset.name,'CT',pversion,Email_Notification_Lists.stats,CT);
		Strata.createAsBusinessStats.Header(fAs_Business_Header_IN(files().base.IN.qa),_dataset.name,'IN',pversion,Email_Notification_Lists.stats,IN);
		Strata.createAsBusinessStats.Header(fAs_Business_Header_LA(files().base.LA.qa),_dataset.name,'LA',pversion,Email_Notification_Lists.stats,LA);
		Strata.createAsBusinessStats.Header(fAs_Business_Header_OH(files().base.OH.qa),_dataset.name,'OH',pversion,Email_Notification_Lists.stats,OH);
		Strata.createAsBusinessStats.Header(fAs_Business_Header_PA(files().base.PA.qa),_dataset.name,'PA',pversion,Email_Notification_Lists.stats,PA);
		Strata.createAsBusinessStats.Header(fAs_Business_Header_TX(files().base.TX.qa),_dataset.name,'TX',pversion,Email_Notification_Lists.stats,TX);
                              
		export all :=
		sequential(
			 CA
			,CT
			,IN
			,LA
			,OH
			,PA
			,TX
       
		);

	end;

	export Business_Contacts :=
	module

		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_CA(files().base.CA.qa),_dataset.name,'CA',pversion,Email_Notification_Lists.stats,CA);
		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_CT(files().base.CT.qa),_dataset.name,'CT',pversion,Email_Notification_Lists.stats,CT);
		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_IN(files().base.IN.qa),_dataset.name,'IN',pversion,Email_Notification_Lists.stats,IN);
		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_LA(files().base.LA.qa),_dataset.name,'LA',pversion,Email_Notification_Lists.stats,LA);
		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_OH(files().base.OH.qa),_dataset.name,'OH',pversion,Email_Notification_Lists.stats,OH);
		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_PA(files().base.PA.qa),_dataset.name,'PA',pversion,Email_Notification_Lists.stats,PA);
		Strata.createAsBusinessstats.Contacts(fAs_Business_Contact_TX(files().base.TX.qa),_dataset.name,'TX',pversion,Email_Notification_Lists.stats,TX);

		export all :=
		sequential(
			 CA
			,CT
			,IN
			,LA
			,OH
			,PA
			,TX
       
		);

	end;
	
	export all := if(VersionControl.IsValidVersion(pversion),
	sequential(
		 business_headers.all
		,business_contacts.all
	));

end;