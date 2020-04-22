
/*
IMPORTANT: unwanted calls to both gateways were made without the double condition before the SOAPCALL.
DO NOT REMOVE!!!

ALSO IMPORTANT: QSent GW data is subject to CCPA suppression, which is not done here.
 If you are adding a call to this attribute, search for RealTimePhones_Raw() for reference on how to 
 apply suppressions.
*/
import AutoStandardI, BatchServices, PhonesPlus, ut, Phones, Gateway;

export RealTimePhones_Raw(
  batchServices.RealTimePhones_Params.params in_mod,
  dataset(Gateway.Layouts.Config) gateways, 
  integer waittime = 3, 
  integer retries =0, 
  boolean call_gateway = false) 	
  := FUNCTION										 		
    
    boolean isNewGateway := in_mod.UseQSENTV2;
    gateway_cfg := if(isNewGateway, gateways(Gateway.Configuration.isQsentV2(servicename)), gateways(Gateway.Configuration.isQsent(servicename)));
    gateway_URL := gateway_cfg[1].url;

    // reading input from global module		
    pvs_in := dataset([Doxie_Raw.Transforms_RTP_Raw_OldGateway.xfm_searchRequest(in_mod)]);
    pvs_in_new := dataset([Doxie_Raw.Transforms_RTP_Raw.xfm_searchRequestNew(in_mod)]);

    clean_phone := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
    companyName := AutoStandardI.InterfaceTranslator.company_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_value.params));
    
    // perform gateway search only if input has complete phone or Name and Address or company name and Address
    pvs_search := 
      ((clean_phone<>'') and LENGTH(TRIM(clean_phone))=10)
      OR
      (in_mod.lastname<>'' AND in_mod.Addr<>'' AND in_mod.state<>'' AND(in_mod.city<>'' OR in_mod.zip<>'')
      OR
      in_mod.ssn <>'' and in_mod.lastname<>'')
      OR
      (companyName<>'' AND in_mod.Addr<>'' AND in_mod.state<>'' AND(in_mod.city<>'' OR in_mod.zip<>''));

    // Calling Gateway
    Boolean makeGatewayCall := gateway_URL != '' and pvs_search and call_gateway;
        
    pvs_gw_rslts 			:= Gateway.SoapCall_QSent(pvs_in, gateway_cfg[1], waittime, retries, makeGatewayCall and ~isNewGateway);
    pvs_gw_rslts_new 	:= Gateway.SoapCall_QSentV2(pvs_in_new, gateway_cfg[1], waittime, retries, makeGatewayCall and isNewGateway);
    
    // Results by Statelisting and PVListing
    // errors from Qsent are located in the below.... currently there is no code to do anything with this
    // tberrorcode := (INTEGER)project(pvs_gw_rslts, transform({string ErrorCode}, self.ErrorCode := LEFT.response.Summary.ErrorCode))[1].ErrorCode;
    // tberrormessage := project(pvs_gw_rslts, transform({string Errormessage}, self.Errormessage := LEFT.response.Summary.Errormessage))[1].Errormessage;
    // tberrordescription := project(pvs_gw_rslts, transform({string Errordescription}, self.ErrorDescription := LEFT.response.Summary.Errordescription))[1].Errordescription;
    
    res_by_STLS := Doxie_Raw.Transforms_RTP_Raw_OldGateway.getListings(pvs_gw_rslts, in_mod);
    res_by_PVLS := PROJECT(pvs_gw_rslts, Doxie_Raw.Transforms_RTP_Raw_OldGateway.xfm_PVListing(LEFT));
    res_new_gtwy:= Doxie_Raw.Transforms_RTP_Raw.xfm_ToOutputResponse(pvs_gw_rslts_new, in_mod);
    
    Pvs_responseType := TABLE(pvs_gw_rslts,{string rsp_type := pvs_gw_rslts.Response.Summary.ResponseType});

    result := IF(isNewGateway,
      IF(pvs_gw_rslts_new[1].response.vendorHeader.TotalListingsReturned <> 0, res_new_gtwy),  
      IF(EXISTS(Pvs_responseType(rsp_type = Phones.Constants.ServiceType.PVS)), res_by_PVLS) +
      IF(EXISTS(Pvs_responseType(rsp_type = Phones.Constants.ServiceType.IQ411 or rsp_type='')), res_by_STLS)
      );

    GatewayErrorCode := if(isNewGateway, pvs_gw_rslts_new[1].response._Header.Status,
      (integer) pvs_gw_rslts[1].response.ErrorCode);
    GatewayErrorMessage := if(isNewGateway, pvs_gw_rslts_new[1].response._Header.Message,
      pvs_gw_rslts[1].response.ErrorMessage);

    URLMissing := LENGTH(TRIM(Gateway_URL)) = 0;
    URLErrorCode := IF (URLMissing, ut.constants_MessageCodes.GATEWAY_URL_MISSING,0);
    URLErrorMessage := IF (URLMissing, ut.MessageCode(ut.constants_MessageCodes.GATEWAY_URL_MISSING,'')[1].msg,'') ;

    OutErrorCode := if (URLMissing, URLErrorCode, GatewayErrorCode);
    OutErrorMessage := if (URLMissing, URLErrorMessage, 
      TRIM(batchservices.constants.RealTime.REALTIME_PHONE_MSG)+': ' + GatewayErrorMessage);

    OutResult := if (OutErrorCode = 0 or in_mod.failOnError = FALSE, result, FAIL(result, OutErrorCode, OutErrorMessage));
    
    //DEBUG
    // if(makeGatewayCall and ~isNewGateway, output(pvs_in, named('QSENT_Gateway_in'),extend));
    // if(makeGatewayCall and ~isNewGateway, output(pvs_gw_rslts, named('QSENT_Gateway_rslt'),extend));
    // if(makeGatewayCall and isNewGateway, output(pvs_in_new, named('QSENTV2_Gateway_in'),extend));
    // if(makeGatewayCall and isNewGateway, output(pvs_gw_rslts_new, named('QSENTV2_Gateway_rslt'),extend));
    // if(makeGatewayCall, output(OutResult, named('OutResult'),extend));
    RETURN OutResult;
END;
