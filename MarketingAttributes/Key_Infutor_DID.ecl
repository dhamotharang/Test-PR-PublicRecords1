Import Data_Services, doxie, ut;

f := MarketingAttributes.Build_Infutor;

export Key_Infutor_DID := index(f,{did},{f},
			Data_Services.Data_Location.Prefix('NONAMEGIVEN')+'thor_data400::key::mktattr::'+doxie.Version_SuperKey+'::infutor_did');
