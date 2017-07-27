import doxie,Insurance_Certification,bipv2,Data_services;

pKeyBase := Insurance_Certification.Files().KeyBuild_Cert.built;	

Slim_Layout := RECORD
		Layouts_Certification.Keybuild - BIPV2.IDlayouts.l_xlink_ids;
	END;

KeyBase := project(pKeyBase,transform(Slim_Layout, self := left));

export Key_UniqueCert := index(KeyBase, {(UNSIGNED8)LNInsCertRecordID}, {KeyBase},
							            Data_services.Data_location.prefix('Insurance_Certification')+'thor_data400::key::Insurance_Certification::'+
												   doxie.Version_SuperKey + '::certification::unique');
