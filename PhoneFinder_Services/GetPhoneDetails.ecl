IMPORT doxie, Doxie_Raw, Gateway,Phones;
EXPORT GetPhoneDetails(DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dInPhones,
	                      DATASET(Gateway.Layouts.Config) dGateways     = DATASET([],Gateway.Layouts.Config),
                       PhoneFinder_Services.iParam.ReportParams inMod)
											           := FUNCTION

tempMod := MODULE(PROJECT(inMod,Phones.IParam.PhoneAttributes.BatchParams,OPT))
		EXPORT UNSIGNED		max_lidb_age_days					:= 60; 
		EXPORT BOOLEAN		use_realtime_lidb				 	:= TRUE;
		EXPORT DATASET (Gateway.Layouts.Config) gateways := dGateways; 
	END;
	
	dsPhonesAttr_recs:= Phones.GetPhoneMetadata_wLIDB(dInPhones, tempMod);
																														
 Doxie_Raw.PhonesPlus_Layouts.t_QSentCISOCAddress_out addr_format(string contact_address1,string contact_address2,string contact_city,string contact_state,string contact_zip) := TRANSFORM
				
				
				string s3 := IF(contact_zip<>'',contact_zip
		         ,IF(contact_state<>'',contact_state
          ,IF(contact_city<>'',contact_city,'')));
          addr1 := doxie.CleanAddress182(contact_address1,s3);

				SELF.StreetNumber := addr1[1..10];
				SELF.StreetPreDirection := addr1[11..12];
				SELF.StreetName := addr1[13..40];
				SELF.Streetsuffix := addr1[41..44];			
				SELF.Streetpostdirection := addr1[45..46];
				SELF.unitdesignation := addr1[47..56];
				SELF.unitNumber := addr1[57..64];
				SELF.city := contact_city;
				SELF.state := contact_state;
				SELF.zip5 := contact_zip;
				SELF.zip4 := '';
				SELF.streetAddress1 :=contact_address1;
				SELF.streetAddress2 := contact_address2;
				
  end;

	PhoneFinder_Services.Layouts.PhoneFinder.Final appendDetails(Phones.Layouts.PhoneAttributes.Raw pInput) := TRANSFORM
																																																												
		SELF.acctno                                               := pInput.acctno;
		SELF.phone                                                := pInput.phone;
		SELF.src                                                  := pInput.source;
		SELF.typeflag                                             := 'P';
		SELF.phone_source                                         := PhoneFinder_Services.Constants.PhoneSource.QSentGateway;
		SELF.dt_last_seen                                         := (STRING8)pInput.dt_last_reported;
		SELF.coc_description                                      := pInput.phone_serv_type;
  SELF.carrier_name                                         := pInput.carrier_name;
  SELF.phone_region_city                                    := pInput.carrier_city;
  SELF.phone_region_st                                      := pInput.carrier_state;
  SELF.RealTimePhone_Ext.CarrierRoute                       := pInput.carrier_route;
  SELF.RealTimePhone_Ext.SortZone                           := pInput.carrier_route_zonecode;
  SELF.RealTimePhone_Ext.DeliveryPointCode                  := pInput.delivery_point_code;
	 SELF.RealTimePhone_Ext.operatingcompany.number            := pInput.carrier_id;
	 SELF.RealTimePhone_Ext.operatingcompany.name              := pInput.operator_name;
	 SELF.RealTimePhone_Ext.operatingCompany.AffiliatedTo        := pInput.affiliated_to;
	 SELF.RealTimePhone_Ext.operatingcompany.contact.name.fullname := pInput.contact_Name;
	 SELF.RealTimePhone_Ext.operatingcompany.contact.address := Row(addr_format(pInput.contact_address1,pInput.contact_address2,pInput.contact_city,pInput.contact_state,pInput.contact_zip));
		SELF.RealTimePhone_Ext.operatingcompany.contact.email := pInput.Contact_email;		
		SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneNpa := pInput.Contact_Phone[1..3];
  SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneNXX := pInput.Contact_Phone[4..6];
  SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneLine := pInput.Contact_Phone[7..10];
  SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneExt := '';
	 SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxNpa := pInput.Contact_Fax[1..3];
  SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxNXX := pInput.Contact_Fax[4..6];
  SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxLine := pInput.Contact_Fax[7..10];
		SELF := [];																											
	END;
	
	dDetailedPhoneInfo	:= PROJECT(dsPhonesAttr_recs, appendDetails(LEFT));

	RETURN dDetailedPhoneInfo;
	END;