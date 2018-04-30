﻿IMPORT doxie, Doxie_Raw, Gateway,Phones;
EXPORT GetPhoneDetails(DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dInPhones,
	                      DATASET(Gateway.Layouts.Config) dGateways     = DATASET([],Gateway.Layouts.Config),
                       PhoneFinder_Services.iParam.ReportParams inMod)
											           := FUNCTION

tempMod := MODULE(PROJECT(inMod,Phones.IParam.PhoneAttributes.BatchParams,OPT))
		EXPORT UNSIGNED		max_lidb_age_days					:= PhoneFinder_Services.Constants.LIBD_LastActivityThreshold; 
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

  dsPhonesAttrRecsGrp := GROUP(SORT(dsPhonesAttr_recs, acctno, phone, carrier_city = '', contact_name = ''), acctno, phone);

  PhoneFinder_Services.Layouts.PhoneFinder.Final appendDetails(Phones.Layouts.PhoneAttributes.Raw le, DATASET(Phones.Layouts.PhoneAttributes.Raw) ri) := TRANSFORM
    SELF.acctno                                                   := le.acctno;
    SELF.phone                                                    := le.phone;
    SELF.src                                                      := IF(EXISTS(ri(source = Phones.Constants.PhoneAttributes.ATT_LIDB_RealTime)),
		                                                                             Phones.Constants.PhoneAttributes.ATT_LIDB_RealTime, '');
    SELF.typeflag                                                 := 'P';
    SELF.phone_source                                             := PhoneFinder_Services.Constants.PhoneSource.QSentGateway;
    SELF.dt_last_seen                                             := (STRING8)MAX(ri,ri.dt_last_reported);
    SELF.coc_description                                          := le.phone_serv_type;
    SELF.carrier_name                                             := le.carrier_name;
    SELF.phone_region_city                                        := le.carrier_city;
    SELF.phone_region_st                                          := le.carrier_state;
    SELF.RealTimePhone_Ext.CarrierRoute                           := le.carrier_route;
    SELF.RealTimePhone_Ext.SortZone                               := le.carrier_route_zonecode;
    SELF.RealTimePhone_Ext.DeliveryPointCode                      := le.delivery_point_code;
    SELF.RealTimePhone_Ext.operatingcompany.number                := IF(le.operator_id <> '', le.operator_id, le.carrier_id); // operator id = spid and carrier id = ocn
    SELF.RealTimePhone_Ext.operatingcompany.name                  := le.ocn_abbr_name;
    SELF.RealTimePhone_Ext.operatingCompany.AffiliatedTo          := le.affiliated_to;
    SELF.RealTimePhone_Ext.operatingcompany.contact.name.fullname := le.contact_Name;
    SELF.RealTimePhone_Ext.operatingcompany.contact.address       := ROW(addr_format(le.contact_address1, le.contact_address2,
                                                                                     le.contact_city,le.contact_state, le.contact_zip));
    SELF.RealTimePhone_Ext.operatingcompany.contact.email         := le.Contact_email;    
    SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneNpa    := le.Contact_Phone[1..3];
    SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneNXX    := le.Contact_Phone[4..6];
    SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneLine   := le.Contact_Phone[7..10];
    SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneExt    := '';
    SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxNpa      := le.Contact_Fax[1..3];
    SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxNXX      := le.Contact_Fax[4..6];
    SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxLine     := le.Contact_Fax[7..10];
    SELF                                                          := [];                                                      
  END;
  
  dDetailedPhoneInfo  := ROLLUP(dsPhonesAttrRecsGrp, GROUP, appendDetails(LEFT, ROWS(LEFT)));
	RETURN dDetailedPhoneInfo;
	END;