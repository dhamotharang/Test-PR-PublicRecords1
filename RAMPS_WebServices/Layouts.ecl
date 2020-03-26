EXPORT Layouts := MODULE
	 
	SHARED rAppValues := RECORD
		STRING application {XPATH('application')};
		STRING name {XPATH('name')};
		STRING value {XPATH('value')};
	END;
	SHARED rResults := RECORD
		STRING name {XPATH('name')};
		STRING value {XPATH('value')};
		STRING fileName {XPATH('filename')};
		STRING total {XPATH('total')};
	END;
	SHARED rWorkunit := RECORD
		STRING wuid {XPATH('wuid')};
		STRING owner {XPATH('owner')};
		STRING cluster {XPATH('cluster')};
		STRING jobName {XPATH('jobname')};
		STRING stateId {XPATH('stateID')};
		STRING state {XPATH('state')};
		STRING totalThorTime {XPATH('totalThorTime')};
		DATASET(rResults) results {XPATH('results')};
		DATASET(rAppValues) appValues {XPATH('applicationValues')};
		INTEGER errorCount {XPATH('errorCount')};
		INTEGER warningCount {XPATH('warningCount')};
		INTEGER infoCount {XPATH('infoCount')};
		INTEGER resultCount {XPATH('resultCount')};
	END;
	SHARED rResponse := RECORD
		STRING UUID{XPATH('uuid')};
		STRING username {XPATH('username')}; 
		STRING workunitId {XPATH('workunitId')}; 
		rWorkunit workunit {XPATH('workunit')};
		STRING failed {XPATH('failed')};
		STRING running {XPATH('running')};
		STRING connectionURL {XPATH('connectionURL')}; 
		STRING compositionUuid {XPATH('compositionUuid')}; 
		STRING paused {XPATH('paused')}; 
		STRING complete {XPATH('complete')}; 
		STRING compositionName {XPATH('compositionName')}; 
	END;

	EXPORT rRunCompositionOut := RECORD
		dataset(rResponse) response {XPATH('response')};
	END;
END;