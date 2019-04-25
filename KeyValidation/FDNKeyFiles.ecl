EXPORT FDNKeyFiles := module
		import KeyValidation, ut, Autokey, Autokeyb2, ashirey;
		import FraudDefenseNetwork;
		
			export DIDKey := index(KeyValidation.FDNParentFiles.fdnDS, {did}, {unsigned8 record_id, unsigned8 uid}, 
															ut.foreign_prod_boca + 'thor_data400::key::fdn::qa::did');
															
		 export EmailKey := index(KeyValidation.FDNParentFiles.fdnDS, {email_address}, 
																			{unsigned8 record_id, unsigned8 uid}, 
																			ut.foreign_prod_boca + 'thor_data400::key::fdn::qa::email');
																			
		 export IPKey := index(KeyValidation.FDNParentFiles.fdnDS, {ip_address}, 
															{unsigned8 record_id, unsigned8 uid}, 
															ut.foreign_prod_boca + 'thor_data400::key::fdn::qa::ip');
															
		shared IDKey := index(KeyValidation.FDNParentFiles.FDNDS, {record_id, uid}, 
														KeyValidation.FDNParentFiles.fdnLayout - {unsigned8 record_id, unsigned8 uid},
														ut.foreign_prod_boca +'thor_data400::key::fdn::qa::id');
														
		ashirey.Flatten(IDKey, flatIDKey);
		export FlattenedIDKey := flatIDKey;
															 
		 // shared d := dataset([],KeyValidation.FDNLayouts.payloadAutoKeyLayout);
		 // export PayloadAutoKey := index(d,{fakeid},{d}, 
																	// ut.foreign_prod_boca +'thor_data400::key::fdn::qa::autokey::payload');
		export PayloadAutoKey := index(FraudDefenseNetwork.Key_Autokey_Payload, 
												ut.foreign_prod_boca +'thor_data400::key::fdn::qa::autokey::payload');

		ashirey.Flatten(PayloadAutoKey, flatPayloadAutoKey);
		export FlattenedPayloadAutokey := flatPayloadAutoKey;
																	
		//auto keys
		//auto keys are built from the payload auto key
		 export addressAutoKey := Autokey.Key_Address(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export addressb2AutoKey := Autokeyb2.Key_Address(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export cityStNameAutoKey := Autokey.Key_CityStName(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export cityStNameb2AutoKey := Autokeyb2.Key_CityStName(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export nameAutoKey := Autokey.Key_Name(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export phone2AutoKey := Autokey.Key_Phone2(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export phoneb2AutoKey := Autokeyb2.Key_Phone(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export ssn2AutoKey := Autokey.Key_SSN2(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export stNameAutoKey := Autokey.Key_StName(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export stNameb2AutoKey := Autokeyb2.Key_StName(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export zipAutoKey := Autokey.Key_Zip(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');
		 export zipb2AutoKey := Autokeyb2.Key_Zip(ut.foreign_prod_boca+'thor_data400::key::fdn::qa::autokey::');

end;