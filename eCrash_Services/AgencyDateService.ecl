/*--SOAP--
<message name="AgencyDateService">
  <part name="GetAgencyPropertiesRequest" type="tns:XmlDataSet" cols="200" rows="20" />
  <part name="GetAgencyPropertiesResponse" type="tns:XmlDataSet" cols="200" rows="20" />
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>  
*/
/*--INFO-- Ecrash Agency Date Service -- 
   Input:  iesp.getagencyproperties.t_GetAgencyPropertiesRequest (xml)
   Output: iesp.getagencyproperties.t_GetAgencyPropertiesResponse (xml)
*/

import eCrash_Services,AutoStandardI, iesp, dx_eCrash, Risk_Indicators, lib_stringlib, ut, Gateway;
EXPORT AgencyDateService() := FUNCTION

  Layout_AgencyPropertyRequest := iesp.getagencyproperties.t_GetAgencyPropertiesRequest;
	Layout_AgencyPropertyResponse := iesp.getagencyproperties.t_GetAgencyPropertiesResponse;
	
	AgencyDataRequest :=	DATASET([], Layout_AgencyPropertyRequest) : STORED('GetAgencyPropertiesRequest', FEW);
	Request	:=	AgencyDataRequest[1]; 
	
	GatewaysIn := dataset([], Risk_Indicators.Layout_Gateways_In) : stored ('Gateways', FEW);
	
	STRING DeltabaseEspNameGateway := 'DeltaBaseSql';	
	STRING SqlSearchEspUrlGateway := GatewaysIn(servicename = 'delta_ec')[1].url;	
	
	InModuleDeltaBase := MODULE(PROJECT(AutoStandardI.GlobalModule(), IParam.searchrecords, OPT))
		EXPORT STRING200 SqlSearchEspURL := SqlSearchEspUrlGateway;
		EXPORT STRING SqlSearchEspNAME := DeltabaseEspNameGateway;
  END;
	
	DeltaBaseService := eCrash_Services.DeltaBaseSoapCall(InModuleDeltaBase);
	InAgencyID 		:= Request.Options.AgencyId;
	InSourceID 		:= Request.Options.SourceID;
	IsSourceIDInput := InSourceID <>'' ;
	
	eCrash_Services.Layouts.AgencyDateRecord getAgencyLastUploadDates(dx_eCrash.Key_AgencyIdSentDate L) := TRANSFORM
		SELF.lastUploadDate := L.MaxSent_to_hpcc_date;
		SELF.agencyID := L.jurisdiction_nbr;
		SELF.sourceID := L.contrib_source;
	END;
	
	Layout_AgencyPropertyResponse GenerateResponse(Layouts.AgencyDateRecord L) := TRANSFORM
	  SELF.LastReportUploadDate.Year := (INTEGER) L.lastUploadDate[1..4];
		SELF.LastReportUploadDate.Month := (INTEGER) L.lastUploadDate[5..6];
		SELF.LastReportUploadDate.Day := (INTEGER) L.lastUploadDate[7..8];
		
	END;
	
	DeltaSqlStringWsourceid := 'select date_format(max(date_added),"%Y%m%d") as last_upload_date from delta_ec.delta_key where agency_id = "'+InAgencyID+'" and contrib_source = "'+InSourceID+'" and is_deleted = 0';
	DeltaSqlStringWOsourceid := 'select date_format(max(date_added),"%Y%m%d") as last_upload_date from delta_ec.delta_key where agency_id = "'+InAgencyID+'" and is_deleted = 0';
	
	DeltaSqlString := IF(IsSourceIDInput,DeltaSqlStringWsourceid,DeltaSqlStringWOsourceid);
	agencyDeltaLastUploadDate := DeltaBaseService.GetAgencyLastReportDate(DeltaSqlString);
	
	
	agencyLastUploadKey :=  CHOOSEN(dx_eCrash.Key_AgencyIdSentDate(keyed(jurisdiction_nbr=InAgencyID) and if(IsSourceIDInput,contrib_source = InSourceID,TRUE) ), eCrash_Services.Constants.MAX_SOURCES_PER_AGENCY);
	agencyLastUploadDate := PROJECT(agencyLastUploadKey,getAgencyLastUploadDates(LEFT));
	
	agencyData := TOPN(agencyDeltaLastUploadDate + agencyLastUploadDate , 1, -lastUploadDate); 	
	
	Result := PROJECT(agencyData, GenerateResponse(LEFT));
	
	// OUTPUT(agencyDeltaLastUploadDate, named('agencyDeltaLastUploadDate'));
	// OUTPUT(agencyLastUploadKey, named('agencyLastUploadKey'));
	
	RETURN OUTPUT(Result, named('Results'));
	
END;