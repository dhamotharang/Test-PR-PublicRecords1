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

import AutoStandardI, iesp, FLAccidents_Ecrash, Risk_Indicators, lib_stringlib, ut, Gateway;
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
	
	Layouts.AgencyDateRecord getAgencyLastUploadDates(FLAccidents_Ecrash.Key_eCrashv2_agencyId_sentdate L) := TRANSFORM
		SELF.lastUploadDate := L.MaxSent_to_hpcc_date;
		SELF.agencyID := L.jurisdiction_nbr;
	END;
	
	/*Layout_AgencyPropertyResponse.LastReportUploadDate setLastReportDate(Layouts.AgencyDateRecord L) := TRANSFORM
		SELF.Year := (INTEGER) L.lastUploadDate[1..4];
		SELF.Month := (INTEGER) L.lastUploadDate[5..6];
		SELF.Day := (INTEGER) L.lastUploadDate[7..8];
	END;
	*/
	Layout_AgencyPropertyResponse GenerateResponse(Layouts.AgencyDateRecord L) := TRANSFORM
	  SELF.LastReportUploadDate.Year := (INTEGER) L.lastUploadDate[1..4];
		SELF.LastReportUploadDate.Month := (INTEGER) L.lastUploadDate[5..6];
		SELF.LastReportUploadDate.Day := (INTEGER) L.lastUploadDate[7..8];
		
	END;
	
	DeltaSqlString := 'select date_format(max(date_added),"%Y%m%d") as last_upload_date from delta_ec.delta_key where agency_id = "'+InAgencyID+'" and is_deleted = 0';
	
	agencyDeltaLastUploadDate := DeltaBaseService.GetAgencyLastReportDate(DeltaSqlString);
	
	
	agencyLastUploadKey :=  CHOOSEN(FLAccidents_Ecrash.Key_eCrashv2_agencyId_sentdate(keyed(jurisdiction_nbr=InAgencyID)), 1);// Change the keyed field
	agencyLastUploadDate := PROJECT(agencyLastUploadKey,getAgencyLastUploadDates(LEFT));
	
	agencyData := TOPN(agencyDeltaLastUploadDate + agencyLastUploadDate , 1, -lastUploadDate); 	
//	lastUploaddate := PROJECT(agencyData, setLastReportDate(LEFT));	
	
	Result := PROJECT(agencyData, GenerateResponse(LEFT));
	
	RETURN OUTPUT(Result, named('Results'));
	
END;