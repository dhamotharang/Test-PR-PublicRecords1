IMPORT PhonesPlus, doxie, batchServices, AutoStandardI, ut;

pvs_in := Phonesplus.Layout_Qsent_gateway.t_QSentCISSearchRequest;
pvs_listing := Phonesplus.Layout_Qsent_gateway.t_QSentCISListing;
pvs_response_ex := Phonesplus.Layout_Qsent_gateway.t_QSentCISSearchResponseEx;
pvs_address_response := Doxie_Raw.PhonesPlus_Layouts.t_QSentCISOCAddress_out;
pvs_response := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT Transforms_RTP_Raw_OldGateway := MODULE
    /*--- SHARED FUNCTIONS ---*/
    SHARED fn_get_status_desc(string3 status_code) := function
			status_desc := CASE(status_code
			,'010'=>'Active-Landline'
			,'011'=>'Active-Wireless'
			,'012'=>'Active-VOIP'
			,'013'=>'Active-Unknown Line Type'
			,'020'=>'Active-Landline'
			,'021'=>'Active-Wireless'
			,'022'=>'Active-VOIP'
			,'023'=>'Active-Unknown Unknown Line Type'
			,'030'=>'Inactive-Landline'
			,'031'=>'Inactive-Wireless'
			,'032'=>'Inactive-VOIP'
			,'033'=>'Inactive-Unknown Line Type'
			,'040'=>'Unknown Line Type'
			,'041'=>'Unknown Line Type'
			,'042'=>'Unknown Line Type'
			,'043'=>'Unknown Line Type'
			,'');

			return status_desc;
		end;
        
    /*--- EXPORT TRANSFORM ---*/
    //Old gateway request
    EXPORT pvs_in xfm_searchRequest(batchServices.RealTimePhones_Params.params in_mod) := TRANSFORM
			SELF.SearchBy.BusinessName := AutoStandardI.InterfaceTranslator.company_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_value.params));
      SELF.SearchBy.FirstName := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
      SELF.SearchBy.LastName := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
      SELF.SearchBy.StreetAddress := AutoStandardI.InterfaceTranslator.addr_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_value.params));
      SELF.SearchBy.City := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
      st := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
  		SELF.SearchBy.SSN := trim(in_mod.ssn);  // we need the leading zeros if we are only sending a 4 digit ssn
			SELF.SearchBy.State := IF(st<>'' and ut.valid_st(StringLib.StringToUpperCase(st)) ,st,'ALL');
      SELF.SearchBy.Zip5 := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.Zip_val.params));
      SELF.SearchBy.Zip4 := '' ; 
			ph := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
      SELF.SearchBy.phone.phoneNpa := (ph[1..3]);
      SELF.SearchBy.phone.phoneNXX := (ph[4..6]);
      SELF.SearchBy.phone.phoneLine := (ph[7..10]);		
			SELF.SearchBy.UseSimilarFirstNames := true;
			DataRestrictionMask := AutoStandardI.DataRestrictionI.val(project(in_mod,AutoStandardI.DataRestrictionI.params,opt)); 
			SELF.Options.RequestCredential := DataRestrictionMask.RequestCredential;
			SELF.Options.ShowNonPublished := ph='';
			SELF.Options.QueryType := 'BR';
			SELF.Options.Match := '1';
			SELF.Options.ResultCount:= (string)if (in_mod.RecordCount >= batchServices.constants.REALTIME_Record_max , batchServices.constants.REALTIME_Record_max, in_mod.RecordCount);  //was 30 because it was not set...
			SELF.Options.ServiceType := if (in_mod.servicetype = '',if(ph<>'','PVS','iQ411'), trim(in_mod.serviceType));
			SELF.User.GLBPurpose := (string)AutoStandardI.InterfaceTranslator.glb_purpose.val(project(in_mod,AutoStandardI.InterfaceTranslator.glb_purpose.params));
			SELF.User.DLPurpose := (string)AutoStandardI.InterfaceTranslator.dppa_purpose.val(project(in_mod,AutoStandardI.InterfaceTranslator.dppa_purpose.params));			
			SELF.User.ReferenceCode := if(in_mod.uid <> '' or in_mod.acctno <> '', trim(in_mod.UID) + '-' + in_mod.acctno,in_mod.EspTransactionId);
			SELF.SearchBy := [];
			SELF.Options := [];
			SELF.User := [];
			SELf := [];			
		END;
    
    //In Dataset to Gateway
		EXPORT Phonesplus.Layout_Qsent_gateway.t_QSentCISSearchRequest into_GWin(pvs_in L) := transform
			self := L;
		end;
		    
		//Outdataset from GateWay on Fail
		EXPORT pvs_response_ex errX(pvs_in le) := transform
            self.response.ErrorMessage := FAILMESSAGE;
            self.response.ErrorCode := (STRING)FAILCODE;
            self := [];
		end;
    
    //Transforms Statelistings - LandLine
		EXPORT getListings(dataset(pvs_response_ex) in_response, 
                       batchServices.RealTimePhones_Params.params in_mod) := FUNCTION

		//TRansforming gateway results to flat listing
		  //bug with compiler: 48133
    //Old code:   
    //PVS_inp := pvs_gw_rslts[1].response.statelistings.statelisting;
    //workaround is below for PVS_inp attribute:
    //New code:
		PVS_inp := normalize(dataset(in_response[1]),left.response.statelistings.statelisting, transform(right));
		STLS_inp:= NORMALIZE(PVS_inp,count(LEFT.listings.listing)
		            ,TRANSFORM(pvs_listing
								,SELF := LEFT.listings.listing[counter]
								));	
			
		// status_code := pvs_gw_rslts[1].response.Summary.Statuscode;
    status_code := project(in_response, transform({string3 Statuscode}, self.Statuscode := LEFT.response.summary.Statuscode))[1].Statuscode;		
    
    pvs_response xfm_stListing(pvs_listing L) := TRANSFORM
        
				SELF.TypeFlag := 'I';
				SELF.New_Type := 'Real-Time Phones';
				SELF.Listed_Name := L.ListingName;
				SELF.phone := L.Phone.phoneNpa + L.Phone.phoneNxx + L.Phone.phoneLine;
				SELf.fName := L.Name.first;
				SELf.LName := L.Name.last;
				string s2 := IF(L.address.zip5<>'',L.address.zip5
				         ,IF(L.address.state<>'',L.address.state
								 ,IF(L.address.city<>'',L.address.City,'')));
        addr := doxie.CleanAddress182(L.address.streetAddress1,s2);
  			SELF.prim_range := addr[1..10];
				SELF.predir := addr[11..12];
				SELF.prim_name := addr[13..40];
				SELF.suffix := addr[41..44];			
				SELF.postdir := addr[45..46];
				SELF.unit_desig := addr[47..56];
				SELF.sec_range := addr[57..64];
				SELF.city_name := L.address.city;
				SELF.st := L.address.state;
				SELF.zip := L.address.zip5;
				SELF.zip4 := L.address.zip4;
				SELF.SSNMatch := L.SSNMatch;
				tempssn := case( l.ssnMatch, 	'04' => in_mod.SSN[6..9],  // LAST 4
																			'03' => in_mod.SSN,  // ALL
																			'');
				SELF.SSN := tempssn;
				SELF.caption_text := CASE(L.address.addressType
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
				SELF.listing_type_bus := IF(L.ListingType in ['BR','BG'],'B','');
				SELF.listing_type_gov := IF(L.ListingType in ['BR','BG'],'G','');
				SELF.listing_type_res := IF(L.ListingType in ['RS','BR'],'R','');
				SELF.carrier_name := L.operatingcompany.Name;
				oc := L.operatingcompany;
        SELF.RealTimePhone_Ext.operatingcompany.address := Row (Doxie_Raw.Transforms_RTP_Raw.xformAddress (oc.address)); 
				oc1 := L.operatingcompany.contact;
        SELF.RealTimePhone_Ext.operatingcompany.contact.address := Row (Doxie_Raw.Transforms_RTP_Raw.xformAddress (oc1.address));
				oc_contact_name := L.operatingcompany.contact.name;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.fullname := oc_contact_name.full;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.fName := oc_contact_name.first;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.MName := oc_contact_name.middle;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.LName := oc_contact_name.last;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.name_prefix := oc_contact_name.prefix;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.name_suffix := oc_contact_name.suffix;
				SELF.RealTimePhone_Ext.operatingcompany := L.operatingcompany;
				SELF.RealTimePhone_Ext := L.DeliveryInfo;
				SELF.RealTimePhone_Ext.StatusCode := Status_code;
				SELF.RealTimePhone_Ext.StatusCode_Desc := fn_get_status_desc(Status_code);
				SELF.RealTimePhone_Ext := L;
				SELF := [];
		END;
    
    RETURN PROJECT(STLS_inp,xfm_STListing(LEFT));
    END;
    
    //Transforms PVListings -CellPhone
		EXPORT pvs_response xfm_PVListing(pvs_response_ex L ) := TRANSFORM
        pvl := L.response.PVListing;
				SELF.TypeFlag := 'P';
				SELF.New_Type := 'Real-Time Phones';
				SELF.Listed_Name := pvl.genericName;
				SELF.phone := pvl.phone.phoneNpa+pvl.phone.phoneNxx+pvl.phone.phoneLine;
				SELF.carrier_name := pvl.operatingcompany.Name;
				SELF.RealTimePhone_Ext.StatusCode := L.response.Summary.Statuscode;  // why not use the above code
				SELF.RealTimePhone_Ext.StatusCode_Desc := fn_get_status_desc(L.response.Summary.Statuscode);
				SELF.RealTimePhone_Ext.PortingCode := pvl.PortingCode;
				SELF.RealTimePhone_Ext.PortingCode_desc := CASE(pvl.PortingCode
				                                           ,'0'=>'UNKNOWN'
				                                           ,'1'=>'PORTED'
				                                           ,'2'=>'NOT PORTED'
																									 ,'');
				oc := pvl.operatingcompany;
				SELF.RealTimePhone_Ext.operatingcompany.address := Row (Doxie_Raw.Transforms_RTP_Raw.xformAddress (oc.address)); 
				oc1 := pvl.operatingcompany.contact;
				SELF.RealTimePhone_Ext.operatingcompany.contact.address := Row (Doxie_Raw.Transforms_RTP_Raw.xformAddress (oc1.address));
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.fullname := pvl.operatingcompany.contact.name.full;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.fName := pvl.operatingcompany.contact.name.first;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.MName := pvl.operatingcompany.contact.name.middle;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.LName := pvl.operatingcompany.contact.name.last;
        SELF.RealTimePhone_Ext.operatingcompany.contact.name.name_prefix := pvl.operatingcompany.contact.name.prefix;
				SELF.RealTimePhone_Ext.operatingcompany.contact.name.name_suffix := pvl.operatingcompany.contact.name.suffix;				
				SELF.RealTimePhone_Ext.operatingcompany := pvl.operatingcompany;
				SELF.RealTimePhone_Ext := pvl;
				SELF := [];
		END;
END;