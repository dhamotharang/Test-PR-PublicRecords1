IMPORT FCRA, FFD, Gateway, iesp, Insurance_iesp;

EXPORT ConsumerRecords(iesp.fcraConsumer.t_SearchRequest srchReq) := FUNCTION

	ds_picklist_req := PROJECT(DATASET([srchReq],iesp.fcraConsumer.t_SearchRequest),
		TRANSFORM(iesp.person_picklist.t_PersonPickListRequest,SELF:=LEFT,SELF:=[]));
	ds_picklist_resp:=FCRA.getDidVilleRecords(ds_picklist_req[1]);
	Status := ds_picklist_resp[1]._Header.Status;
	UniqueId := IF(Status!=0,0,(UNSIGNED6)ds_picklist_resp[1].Records[1].UniqueId);
	DataGroup := IF(srchReq.options.IncludePersonContext,
		SET(srchReq.options.DataGroup,value),FFD.Constants.DataGroupSet.Person);

  ds_consumer_data := FFD.ConsumerInitiatedActivities.Get(UniqueId,
		FFD.FFDMask.Get(srchReq.options.FFDOptionsMask),
		FCRA.FCRAPurpose.Get(srchReq.options.FCRAPurpose),
		Gateway.Configuration.Get(),
		DataGroup,
		srchReq.options.isReseller,
		srchReq.options.IncludePersonContext)[1];

		response := PROJECT(ds_picklist_resp,TRANSFORM(iesp.fcraConsumer.t_SearchResponse,
			SELF.isSuppressed := ds_consumer_data.suppress_records,
			SELF.ConsumerAlerts := ds_consumer_data.ConsumerAlerts,
			SELF.ConsumerStatements := ds_consumer_data.ConsumerStatements,
			SELF.PersonContexts := PROJECT(ds_consumer_data.PersonContext,Insurance_iesp.personcontext.t_personcontextRecord),
			SELF.Consumer := FFD.MAC.PrepareConsumerRecord((STRING)UniqueId,TRUE,srchReq.SearchBy),
			SELF:=LEFT));

	// OUTPUT(srchReq,NAMED('srchReq'));
	// OUTPUT(ds_picklist_resp,NAMED('ds_picklist_resp'));
	// OUTPUT(ds_consumer_data,NAMED('ds_consumer_data'));

	RETURN response;
END;
