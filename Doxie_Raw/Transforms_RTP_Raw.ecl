IMPORT Codes, iesp, batchServices, AutoStandardI, ut, doxie;

pvs_in := iesp.gateway_qsent.t_QSentCISSearchRequest;
pvs_response_ex := iesp.gateway_qsent.t_QSentCISSearchResponseEx;
pvs_contact_result := iesp.gateway_qsent.t_CIPContactResult;
pvs_address_response := Doxie_Raw.PhonesPlus_Layouts.t_QSentCISOCAddress_out;
pvs_response := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT Transforms_RTP_Raw := MODULE
    /*--- SHARED FUNCTIONS ---*/
    SHARED fn_get_data_source(string3 data_source_code) := function
			datasource_desc := CASE(data_source_code
			,'LL'=>'Telephone Company'
			,'A1'=>'Consumer Bureau'
			,'A2'=>'Consumer Bureau-Inquiry'
			,'PV'=>'Real-Time Telephone Network'
			,data_source_code);
			return datasource_desc;
		end;
    
    SHARED fn_get_status_desc(integer status_code) := function
			status_desc := CASE(status_code
			,10=>'Active-Landline'
			,11=>'Active-Wireless'
			,12=>'Active-VOIP'
			,13=>'Active-Unknown Line Type'
			,20=>'Active-Landline'
			,21=>'Active-Wireless'
			,22=>'Active-VOIP'
			,23=>'Active-Unknown Unknown Line Type'
			,30=>'Inactive-Landline'
			,31=>'Inactive-Wireless'
			,32=>'Inactive-VOIP'
			,33=>'Inactive-Unknown Line Type'
			,40=>'Unknown Line Type'
			,41=>'Unknown Line Type'
			,42=>'Unknown Line Type'
			,43=>'Unknown Line Type'
			,'');

			return status_desc;
		end;
    
    shared active_phones_Set := [10, 11, 12, 13, 20, 21, 22, 23];
		shared possible_disconnected_phones_set := [30, 31, 32, 33];
		
		SHARED fn_get_status_desc2(integer status_code) := function
			status_desc := MAP(status_code in active_phones_set	=> 'Active Phone',
												status_code in possible_disconnected_phones_set => 'Possible Disconnected Phone',
											  status_code = 40 => 'Connection Status Unknown - Landline',
												status_code = 41 =>'Connection Status Unknown - Wireless',
												status_code = 42 =>'Connection Status Unknown - VOIP',
												status_code = 43 =>'Unknown line and connection',
												'');
			return status_desc;
		end;
    
    EXPORT pvs_address_response xformAddress (iesp.share.t_Address L)  := transform
        string s3 := IF(L.zip5<>'',L.zip5
		         ,IF(L.state<>'',L.state
          ,IF(L.city<>'',L.City,'')));
          addr1 := doxie.CleanAddress182(L.streetAddress1,s3);

				SELF.StreetNumber := addr1[1..10];
				SELF.StreetPreDirection := addr1[11..12];
				SELF.StreetName := addr1[13..40];
				SELF.Streetsuffix := addr1[41..44];			
				SELF.Streetpostdirection := addr1[45..46];
				SELF.unitdesignation := addr1[47..56];
				SELF.unitNumber := addr1[57..64];
				SELF.city := L.city;
				SELF.state := L.state;
				SELF.zip5 := L.zip5;
				SELF.zip4 := L.zip4;
				SELF.streetAddress1 := L.streetAddress1;
				SELF.streetAddress2 := L.streetAddress2;
    end;
    
    /*--- EXPORT TRANSFORM ---*/
    //New gateway Request
    EXPORT iesp.gateway_qsent.t_QSentCISSearchRequest xfm_searchRequestNew(batchServices.RealTimePhones_Params.params in_mod) := TRANSFORM
			SELF.SearchBy.BusinessName := AutoStandardI.InterfaceTranslator.company_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_value.params));
      SELF.SearchBy.FirstName := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
      SELF.SearchBy.LastName := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
      SELF.SearchBy.StreetAddress := AutoStandardI.InterfaceTranslator.addr_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_value.params));
      SELF.SearchBy.City := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
      st := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
  		SELF.SearchBy.SSN := trim(in_mod.ssn);  // we need the leading zeros if we are only sending a 4 digit ssn
			SELF.SearchBy.State := IF(st<>'' and Codes.valid_st(StringLib.StringToUpperCase(st)) ,st,'ALL');
      SELF.SearchBy.Zip5 := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.Zip_val.params));
      SELF.SearchBy.Zip4 := '' ; 
			ph := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
      SELF.SearchBy.phone.phoneNpa := (ph[1..3]);
      SELF.SearchBy.phone.phoneNXX := (ph[4..6]);
      SELF.SearchBy.phone.phoneLine := (ph[7..10]);		
			SELF.SearchBy.UseSimilarFirstNames := true;
      SELF.SearchBy.UseSimilarLastNames := in_mod.TUGatewayPhoneticMatch;
			SELF.SearchBy.ExcludedPhones := in_mod.ExcludedPhones;
			DataRestrictionMask := AutoStandardI.DataRestrictionI.val(project(in_mod,AutoStandardI.DataRestrictionI.params,opt)); 
			SELF.Options.RequestCredential := DataRestrictionMask.RequestCredential;
			SELF.Options.ShowNonPublished := ph='';
			SELF.Options.QueryType := 'BR';
			SELF.Options.Match := TRUE;
			SELF.Options.MatchSortCode := 'S'; //sort values 'A' - alphabetical, 'S' - score. Default is 'S'
			SELF.Options.ResultCount:= if (in_mod.RecordCount >= batchServices.constants.REALTIME_Record_max , batchServices.constants.REALTIME_Record_max, in_mod.RecordCount);  //was 30 because it was not set...
			SELF.Options.ServiceType := if (in_mod.servicetype = '',if(ph<>'','PVS','iQ411'), trim(in_mod.serviceType));
			SELF.User.GLBPurpose := (string)AutoStandardI.InterfaceTranslator.glb_purpose.val(project(in_mod,AutoStandardI.InterfaceTranslator.glb_purpose.params));
			SELF.User.DLPurpose := (string)AutoStandardI.InterfaceTranslator.dppa_purpose.val(project(in_mod,AutoStandardI.InterfaceTranslator.dppa_purpose.params));
			SELF.User.ReferenceCode := if(in_mod.uid <> '' or in_mod.acctno <> '', trim(in_mod.UID) + '-' + in_mod.acctno, in_mod.EspTransactionId);
			SELF.SearchBy := [];
			SELF.Options := [];
			SELF.User := [];
			SELf := [];			
		END;
    
    //In Dataset to New Gateway
		EXPORT iesp.gateway_qsent.t_QSentCISSearchRequest into_GWin(pvs_in L) := transform
			self := L;
		end;
    
    //Outdataset from New GateWay on Fail
		EXPORT pvs_response_ex errX(pvs_in le) := transform
       self.response._Header.Message := FAILMESSAGE;
       self.response._Header.Status := FAILCODE;
       self := [];
		end;
    
    //Transform iQ411 response
		EXPORT pvs_response xfm_ToOutputResponse(dataset(pvs_response_ex) in_response,
                                             batchServices.RealTimePhones_Params.params in_mod) := FUNCTION
																						 
		PVS_inp := normalize(dataset(in_response[1]),left.response.ContactResults, transform(right));
								
		pvs_response xfm_ToGtwResponse(PVS_inp contact_result) := transform
        contact_info := contact_result.contactInfo;
        phone_info := contact_info.PhoneInfo;
        data_source_info := contact_result.dataSourceInfo;
				data_source := data_source_info.DataSource;
				SELF.TypeFlag := if(data_source = 'PV', 'P', 'I');
				SELF.New_Type := 'Real-Time Phones';
				SELF.Listed_Name := contact_info.ListingName;
				SELF.phone := phone_info.phone;
        SELf.fName := contact_info.Name.first;
				SELf.LName := contact_info.Name.last;
				string s2 := IF(contact_info.geoaddress.address.zip5<>'',contact_info.geoaddress.address.zip5
				         ,IF(contact_info.geoaddress.address.state<>'',contact_info.geoaddress.address.state
								 ,IF(contact_info.geoaddress.address.city<>'',contact_info.geoaddress.address.City,'')));
        addr := doxie.CleanAddress182(contact_info.geoaddress.address.streetAddress1,s2);
  			SELF.prim_range := addr[1..10];
				SELF.predir := addr[11..12];
				SELF.prim_name := addr[13..40];
				SELF.suffix := addr[41..44];			
				SELF.postdir := addr[45..46];
				SELF.unit_desig := addr[47..56];
				SELF.sec_range := addr[57..64];
				SELF.city_name := contact_info.geoaddress.address.city;
				SELF.st := contact_info.geoaddress.address.state;
				SELF.zip := contact_info.geoaddress.address.zip5;
				SELF.zip4 := contact_info.geoaddress.address.zip4;
				SELF.SSNMatch := contact_result.SSNMatch;
				tempssn := case( contact_result.ssnMatch, 	'04' => in_mod.SSN[6..9],  // LAST 4
																			'03' => in_mod.SSN,  // ALL
																			'');
				SELF.SSN := tempssn;
        SELF.caption_text := CASE(contact_info.addressType
				                        ,'F'=>'Firm'
																,'G'=>'General delivery'
																,'H'=>'Multi-dwelling'
																,'M'=>'Military'
																,'P'=>'Post office box'
																,'R'=>'Rural route'
																,'S'=>'Street Address'
																,'U'=>'Unknown'
																// ,'D '=>'Need more information to identify'
																 ,'');
				SELF.listing_type_bus := IF(data_source_info.ListingType in ['BR','BG'],'B','');
				SELF.listing_type_gov := IF(data_source_info.ListingType in ['BR','BG'],'G','');
				SELF.listing_type_res := IF(data_source_info.ListingType in ['RS','BR'],'R','');
				SELF.RealTimePhone_Ext.StatusCode := (string)phone_Info.StatusCode;
				SELF.RealTimePhone_Ext.StatusCode_Desc := fn_get_status_desc(phone_info.StatusCode);
				SELF.RealTimePhone_Ext.StatusCode_FlagDesc := fn_get_status_desc2(phone_Info.StatusCode);
				SELF.RealTimePhone_Ext.StatusCode_Flag := MAP(phone_Info.StatusCode in active_phones_Set => 'G', 
																											phone_Info.StatusCode in possible_disconnected_phones_set => 'R',
																											'');
				SELF.RealTimePhone_Ext.DataSource := fn_get_data_source(data_source);
				SELF.RealTimePhone_Ext.PortingCode := (string)phone_info.PortingCode;
				SELF.RealTimePhone_Ext.PortingCode_desc := CASE(phone_info.PortingCode
				                                           ,0=>'UNKNOWN'
				                                           ,1=>'PORTED'
				                                           ,2=>'NOT PORTED'
																									 ,'');
        SELF.RealTimePhone_Ext.CongressionalDistrict := contact_info.CongressionalDistrict;
        SELF.RealTimePhone_Ext.CarrierRoute := contact_info.CarrierRoute;
        SELF.RealTimePhone_Ext.SortZone := contact_info.CarrierRouteSortZone;
        SELF.RealTimePhone_Ext.MetroStatAreaCode := contact_info.MetropolitanStatisticalAreaCode;
        SELF.RealTimePhone_Ext.ConsMetroStatAreaCode := contact_info.ConsolidatedMetropolitanStatisticalAreaCode;
        SELF.RealTimePhone_Ext.Latitude := contact_info.geoaddress.Location.Latitude;
        SELF.RealTimePhone_Ext.Longitude := contact_info.geoaddress.Location.Longitude;
        SELF.RealTimePhone_Ext.AddressType := contact_info.AddressType;
        SELF.RealTimePhone_Ext.CountyCode := contact_info.FederalInformationProcessingStandards;
        SELF.RealTimePhone_Ext.ListingName := contact_info.ListingName;
        SELF.RealTimePhone_Ext.ListingType := data_source_info.ListingType;
        SELF.RealTimePhone_Ext.PrivacyIndicator := CASE(contact_info.PrivacyIndicator
				                                           ,'SL'=>'STANDARD LISTING'
				                                           ,'NL'=>'UNLISTED'
				                                           ,'NP'=>'NON-PUBLISHED'
																									 ,'');				
				SELF.RealTimePhone_Ext.ServiceClass := phone_info.ServiceClass;
				SELF.RealTimePhone_Ext.GenericName := phone_info.GenericName;
				SELF.RealTimePhone_Ext.DeliveryPointCode := contact_info.DeliveryPointCode;
				SELF.RealTimePhone_Ext.DeliveryPointCheckDigit := contact_info.DeliveryPointCheckDigit;
        SELF.RealTimePhone_Ext.ListingCreationDate := data_source_info.CreationDate;
        SELF.RealTimePhone_Ext.ListingTransactionDate := data_source_info.ListingTransactionDate;
				oc := phone_info.OperatingCarrier;
        SELF.carrier_name := oc.operatingCompanyName;
        SELF.RealTimePhone_Ext.operatingcompany.address := Row (xformAddress (oc.OperatingCompanyaddress));
        SELF.RealTimePhone_Ext.operatingcompany.contact.address := Row (xformAddress (oc.Contactaddress));
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.fName := oc.contactName.first;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.LName := oc.contactName.last;				
				SELF.RealTimePhone_Ext.operatingcompany.contact.email := oc.Contactemail;				
				SELF.RealTimePhone_Ext.operatingcompany.name := oc.OperatingCompanyName;
				SELF.RealTimePhone_Ext.operatingcompany.number := oc.OperatingCompanyNumber;
        SELF.RealTimePhone_Ext.operatingCompany.AffiliatedTo := oc.Affiliate;
        SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneNpa := oc.ContactPhone[1..3];
        SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneNXX := oc.ContactPhone[4..6];
        SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneLine := oc.ContactPhone[7..10];
        SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.PhoneExt := oc.ContactExtension;
        SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxNpa := oc.ContactFax[1..3];
        SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxNXX := oc.ContactFax[4..6];
        SELF.RealTimePhone_Ext.operatingCompany.PhoneInfo.FaxLine := oc.ContactFax[7..10];
				SELF.RealTimePhone_Ext := oc;
				SELF := [];
			END;
		
		RETURN PROJECT(PVS_inp, xfm_ToGtwResponse(LEFT));
		END;
END;