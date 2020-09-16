IMPORT WhoIs,ut,STD;
#option('multiplePersistInstances',FALSE);

EXPORT Normlize_Email(DATASET(Layouts.raw) ds_in) := FUNCTION	

//-----------------------------------------------------------------
//NORMALIZE Email
//-----------------------------------------------------------------
/*
  'RE'   = Registrant Email
	'AE'   = AdministrativeContact Email
	'BE'	 = BillingContact Email
  'TE'   = TechnicalContact Email
  'ZE'   = ZoneContact Email
*/


// Normalized Name records
Layouts.cleanFields t_norm_email (layouts.raw le, INTEGER C) := TRANSFORM
 
	registrant_rawtext	:= ut.cleanSpacesAndUpper(le.registrant_rawtext);
	registrant_email	:= ut.cleanSpacesAndUpper(le.registrant_email);
	registrant_name	  := ut.cleanSpacesAndUpper(le.registrant_name);
	registrant_organization	:= ut.cleanSpacesAndUpper(le.registrant_organization);
	registrant_street1	:= ut.cleanSpacesAndUpper(le.registrant_street1);
	registrant_street2	:= ut.cleanSpacesAndUpper(le.registrant_street2);
	registrant_street3	:= ut.cleanSpacesAndUpper(le.registrant_street3);
	registrant_street4	:= ut.cleanSpacesAndUpper(le.registrant_street4);
	registrant_city 	:= ut.cleanSpacesAndUpper(le.registrant_city);
	registrant_state	:= ut.cleanSpacesAndUpper(le.registrant_state);
	registrant_postalCode	:= ut.cleanSpacesAndUpper(le.registrant_postalCode);
	registrant_country	:= ut.cleanSpacesAndUpper(le.registrant_country);
	registrant_fax	  := ut.cleanSpacesAndUpper(le.registrant_fax);
	registrant_faxExt	:= ut.cleanSpacesAndUpper(le.registrant_faxExt);
	registrant_telephone	:= ut.cleanSpacesAndUpper(le.registrant_telephone);
	registrant_telephoneExt	:= ut.cleanSpacesAndUpper(le.registrant_telephoneExt);
	administrativeContact_rawtext	:= ut.cleanSpacesAndUpper(le.administrativeContact_rawtext);
	administrativeContact_email 	:= ut.cleanSpacesAndUpper(le.administrativeContact_email);
	administrativeContact_name	  := ut.cleanSpacesAndUpper(le.administrativeContact_name);
	administrativeContact_organization	:= ut.cleanSpacesAndUpper(le.administrativeContact_organization);
	administrativeContact_street1	:= ut.cleanSpacesAndUpper(le.administrativeContact_street1);
	administrativeContact_street2	:= ut.cleanSpacesAndUpper(le.administrativeContact_street2);
	administrativeContact_street3	:= ut.cleanSpacesAndUpper(le.administrativeContact_street3);
	administrativeContact_street4	:= ut.cleanSpacesAndUpper(le.administrativeContact_street4);
	administrativeContact_city	  := ut.cleanSpacesAndUpper(le.administrativeContact_city);
	administrativeContact_state	  := ut.cleanSpacesAndUpper(le.administrativeContact_state);
	administrativeContact_postalCode	:= ut.cleanSpacesAndUpper(le.administrativeContact_postalCode);
	administrativeContact_country	:= ut.cleanSpacesAndUpper(le.administrativeContact_country);
	administrativeContact_fax   	:= ut.cleanSpacesAndUpper(le.administrativeContact_fax);
	administrativeContact_faxExt	:= ut.cleanSpacesAndUpper(le.administrativeContact_faxExt);
	administrativeContact_telephone	:= ut.cleanSpacesAndUpper(le.administrativeContact_telephone);
	administrativeContact_telephoneExt	:= ut.cleanSpacesAndUpper(le.administrativeContact_telephoneExt);
	billingContact_rawText 	:= ut.cleanSpacesAndUpper(le.billingContact_rawText );
	billingContact_email 	  := ut.cleanSpacesAndUpper(le.billingContact_email );
	billingContact_name	    := ut.cleanSpacesAndUpper(le.billingContact_name);
	billingContact_organization 	:= ut.cleanSpacesAndUpper(le.billingContact_organization );
	billingContact_street1	:= ut.cleanSpacesAndUpper(le.billingContact_street1);
	billingContact_street2 	:= ut.cleanSpacesAndUpper(le.billingContact_street2 );
	billingContact_street3	:= ut.cleanSpacesAndUpper(le.billingContact_street3);
	billingContact_street4 	:= ut.cleanSpacesAndUpper(le.billingContact_street4 );
	billingContact_city 	:= ut.cleanSpacesAndUpper(le.billingContact_city );
	billingContact_state	:= ut.cleanSpacesAndUpper(le.billingContact_state);
	billingContact_postalCode 	:= ut.cleanSpacesAndUpper(le.billingContact_postalCode );
	billingContact_country	:= ut.cleanSpacesAndUpper(le.billingContact_country);
	billingContact_fax 	  := ut.cleanSpacesAndUpper(le.billingContact_fax );
	billingContact_faxExt	:= ut.cleanSpacesAndUpper(le.billingContact_faxExt);
	billingContact_telephone 	:= ut.cleanSpacesAndUpper(le.billingContact_telephone );
	billingContact_telephoneExt	:= ut.cleanSpacesAndUpper(le.billingContact_telephoneExt);
	technicalContact_rawText 	:= ut.cleanSpacesAndUpper(le.technicalContact_rawText );
	technicalContact_email	:= ut.cleanSpacesAndUpper(le.technicalContact_email);
	technicalContact_name 	:= ut.cleanSpacesAndUpper(le.technicalContact_name );
	technicalContact_organization	:= ut.cleanSpacesAndUpper(le.technicalContact_organization);
	technicalContact_street1 	:= ut.cleanSpacesAndUpper(le.technicalContact_street1 );
	technicalContact_street2	:= ut.cleanSpacesAndUpper(le.technicalContact_street2);
	technicalContact_street3 	:= ut.cleanSpacesAndUpper(le.technicalContact_street3 );
	technicalContact_street4	:= ut.cleanSpacesAndUpper(le.technicalContact_street4);
	technicalContact_city 	:= ut.cleanSpacesAndUpper(le.technicalContact_city );
	technicalContact_state	:= ut.cleanSpacesAndUpper(le.technicalContact_state);
	technicalContact_postalCode 	:= ut.cleanSpacesAndUpper(le.technicalContact_postalCode );
	technicalContact_country	:= ut.cleanSpacesAndUpper(le.technicalContact_country);
	technicalContact_fax  	:= ut.cleanSpacesAndUpper(le.technicalContact_fax );
	technicalContact_faxExt	:= ut.cleanSpacesAndUpper(le.technicalContact_faxExt);
	technicalContact_telephone 	:= ut.cleanSpacesAndUpper(le.technicalContact_telephone );
	technicalContact_telephoneExt	:= ut.cleanSpacesAndUpper(le.technicalContact_telephoneExt);
	zoneContact_rawText := ut.cleanSpacesAndUpper(le.zoneContact_rawText );
	zoneContact_email 	:= ut.cleanSpacesAndUpper(le.zoneContact_email );
	zoneContact_name	  := ut.cleanSpacesAndUpper(le.zoneContact_name);
	zoneContact_organization 	:= ut.cleanSpacesAndUpper(le.zoneContact_organization );
	zoneContact_street1 	:= ut.cleanSpacesAndUpper(le.zoneContact_street1 );
	zoneContact_street2	  := ut.cleanSpacesAndUpper(le.zoneContact_street2);
	zoneContact_street3 	:= ut.cleanSpacesAndUpper(le.zoneContact_street3 );
	zoneContact_street4 	:= ut.cleanSpacesAndUpper(le.zoneContact_street4 );
	zoneContact_city	  := ut.cleanSpacesAndUpper(le.zoneContact_city);
	zoneContact_state 	:= ut.cleanSpacesAndUpper(le.zoneContact_state );
	zoneContact_postalCode 	:= ut.cleanSpacesAndUpper(le.zoneContact_postalCode );
	zoneContact_country	:= ut.cleanSpacesAndUpper(le.zoneContact_country);
	zoneContact_fax 	  := ut.cleanSpacesAndUpper(le.zoneContact_fax );
	zoneContact_faxExt 	:= ut.cleanSpacesAndUpper(le.zoneContact_faxExt );
	zoneContact_telephone	:= ut.cleanSpacesAndUpper(le.zoneContact_telephone);
	zoneContact_telephoneExt	:= ut.cleanSpacesAndUpper(le.zoneContact_telephoneExt);
	SELF.rawtext     := CHOOSE(C, registrant_rawtext, administrativeContact_rawtext, billingContact_rawText, technicalContact_rawText, zoneContact_rawText); 
	SELF.email       := CHOOSE(C, registrant_email, administrativeContact_email, billingContact_email, technicalContact_email, zoneContact_email); 
	SELF.name        := CHOOSE(C, registrant_name, administrativeContact_name, billingContact_name, technicalContact_name, zoneContact_name); 
	SELF.organization:= CHOOSE(C, registrant_organization, administrativeContact_organization, billingContact_organization, technicalContact_organization, zoneContact_organization); 
	SELF.street1 := CHOOSE(C, registrant_street1, administrativeContact_street1, billingContact_street1, technicalContact_street1, zoneContact_street1); 
	SELF.street2 := CHOOSE(C, registrant_street2, administrativeContact_street2, billingContact_street2, technicalContact_street2, zoneContact_street2); 
	SELF.street3 := CHOOSE(C, registrant_street3, administrativeContact_street3, billingContact_street3, technicalContact_street3, zoneContact_street3); 
	SELF.street4 := CHOOSE(C, registrant_street4, administrativeContact_street4, billingContact_street4, technicalContact_street4, zoneContact_street4); 
	SELF.city    := CHOOSE(C, registrant_city, administrativeContact_city, billingContact_city, technicalContact_city, zoneContact_city); 
	SELF.state   := CHOOSE(C, registrant_state, administrativeContact_state, billingContact_state, technicalContact_state, zoneContact_state); 
	SELF.postalCode  := CHOOSE(C, registrant_postalCode, administrativeContact_postalCode, billingContact_postalCode, technicalContact_postalCode, zoneContact_postalCode); 
	SELF.country     := CHOOSE(C, registrant_country, administrativeContact_country, billingContact_country, technicalContact_country, zoneContact_country); 
	SELF.fax         := CHOOSE(C, registrant_fax, administrativeContact_fax, billingContact_fax, technicalContact_fax, zoneContact_fax); 
	SELF.faxExt      := CHOOSE(C, registrant_faxExt, administrativeContact_faxExt, billingContact_faxExt, technicalContact_faxExt, zoneContact_faxExt); 
	SELF.telephone   := CHOOSE(C, registrant_telephone, administrativeContact_telephone, billingContact_telephone, technicalContact_telephone, zoneContact_telephone); 
	SELF.telephoneExt:= CHOOSE(C, registrant_telephoneExt, administrativeContact_telephoneExt, billingContact_telephoneExt, technicalContact_telephoneExt, zoneContact_telephoneExt); 

	SELF.EmailType       := CHOOSE(C,'RE','AE','BE','TE','ZE');
	SELF 					:= le;
	SELF					:= [];
END;

	Norm_Email 	   := DEDUP(NORMALIZE(ds_in,5,t_norm_email(LEFT,COUNTER)),ALL,RECORD);
  GoodNormEmail  := Norm_Email(TRIM(email,ALL) <> '');	
  ds_final		   := PROJECT(GoodNormEmail,TRANSFORM(Layouts.CleanFields,SELF := LEFT;SELF:=[])): PERSIST('~thor_data400::in::WhoIs::Normalized_Email');

	RETURN ds_final;
END;