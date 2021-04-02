Import ProfileBooster, Data_Services, doxie, ut;

f := ProfileBooster.V2_Build_Infutor;

export V2_Key_Infutor_DID := index(f,{did},{f},
			//Data_Services.Data_Location.Prefix('NONAMEGIVEN')
			Data_Services.Data_Location.Prefix('NONAMEGIVEN')+'thor_data400::key::mktattr::'+doxie.Version_SuperKey+'::infutor_did');
