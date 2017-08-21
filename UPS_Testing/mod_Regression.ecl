export mod_Regression := MODULE
	// Need to resolve each Autonomy response into a Roxie ADL

	export autnQueries := UPS_Testing.File_AutonomyRegression.keyed_records;
	export autnQueryLayout := UPS_Testing.File_AutonomyRegression.keyed_layout;
	export autnEntities := UPS_Testing.File_AutonomyEntities.keyed_records;
	export autnEntityLayout := UPS_Testing.File_AutonomyEntities.keyed_layout;
	export autnNames := UPS_Testing.File_AutonomyNames.keyed_records;
	export autnNameLayout := UPS_Testing.File_AutonomyNames.keyed_layout;
	export autnAddrs := UPS_Testing.File_AutonomyAddrs.keyed_records;
	export autnAddrLayout := UPS_Testing.File_AutonomyAddrs.keyed_layout;

	export autnResponse := RECORD
		UNSIGNED queryNo;
		UNSIGNED respNo;
		DATASET(autnNameLayout) names {MAXCOUNT(20)};
		DATASET(autnAddrLayout) addrs {MAXCOUNT(20)};
	END;

	export autnQueryAndResponse := RECORD(autnQueryLayout)
		DATASET(autnResponse) responses {MAXCOUNT(20)};
	END;

	// get a query by query number, including all fielded inputs.
	export autnQueryLayout fn_GetQuery(UNSIGNED inQueryNo) := FUNCTION
		queries := autnQueries(queryNo = inQueryNo);

		autnQueryLayout toQueryLayout(queries L) := TRANSFORM
			SELF := L;
		END;

		return PROJECT(queries[1], toQueryLayout(LEFT));  // queryNo <i>should</i> be unique  :)
	END;

	// given a query number and a sequence number, fetch the response.
	export autnResponse fn_GetResponseBySeqNo(UNSIGNED inQueryNo, UNSIGNED inSeqNo) := FUNCTION
		entities := autnEntities(queryNo = inQueryNo AND seqNo = inSeqNo);

		respNo := entities[1].respNo;
		names := PROJECT(autnNames(seqNo = inSeqNo), autnNameLayout);
		addrs := PROJECT(autnAddrs(seqNo = inSeqNo), autnAddrLayout);
		resp := ROW( { inQueryNo, respNo, names, addrs }, autnResponse);

		emptyResponse := ROW( { 0, 0, [], [] }, autnResponse);
		return if(COUNT(entities) = 1, resp, emptyResponse);
	END;

	// fetch a single response for the given query and response numbers
	export autnResponse fn_GetResponse(UNSIGNED inQueryNo, UNSIGNED inRespNo) := FUNCTION
		entities := autnEntities(queryNo = inQueryNo AND respNo = inRespNo);
		
		lookupSeqNo := entities[1].seqNo;
		names := PROJECT(autnNames(seqNo = lookupSeqNo), autnNameLayout);
		addrs := PROJECT(autnAddrs(seqNo = lookupSeqNo), autnAddrLayout);
		resp := ROW( { inQueryNo, inRespNo, names, addrs }, autnResponse);
		
		emptyResponse := ROW( { 0, 0, [], [] }, autnResponse);
		return if(COUNT(entities) = 1, resp, emptyResponse);
	END;

	// fetch the responses for the given query
	export DATASET(autnResponse) fn_GetResponses(UNSIGNED inQueryNo) := FUNCTION
		entities := autnEntities(queryno = inQueryNo);

		autnResponse EntityToAutnResponse(entities L) := TRANSFORM
			SELF.queryNo := L.queryNo;
			SELF.respNo := L.respno;
			
			autnNameLayout toNames(autnNames L) := TRANSFORM
				SELF := L;
			END;

			autnAddrLayout toAddrs(autnAddrs L) := TRANSFORM
				SELF := L;
			END;
			
			names := PROJECT(autnNames(seqNo = L.seqNo), toNames(LEFT));
			addrs := PROJECT(autnAddrs(seqNo = L.seqNo), toAddrs(LEFT));
			SELF.names := SORT(names, NameNo);
			SELF.addrs := SORT(addrs, AddrNo);
		END;

		responses := PROJECT(entities, EntityToAutnResponse(LEFT));
		return IF(EXISTS(entities), SORT(responses, respNo), 
																DATASET( [], autnResponse));
	END;

	// given a query number, fetch a query (the inputs) and its responses.
	export autnQueryAndResponse fn_GetQueryAndResponse(UNSIGNED inQueryNo) := FUNCTION
		query := fn_GetQuery(inQueryNo);
		responses := fn_GetResponses(inQueryNo);

		rval := ROW( { query.QueryNo,   // UNSIGNED4 QueryNo;
									 query.fname,     // STRING26 fname;
									 query.mname,     // STRING26 mname;
									 query.lname,     // STRING64 lname;
									 query.street,    // STRING60 street;
									 query.city,      // STRING60 City;
									 query.state,     // STRING2 State;
									 query.zip,       // STRING10 Zip;
									 query.phone,     // STRING10 Phone;
									 query.querytype, // STRING8 QueryType;
									 responses }, autnQueryAndResponse);

		nullRval := ROW( { '', '', '', '', '', '', '', '', '', '', DATASET([], autnResponse) }, autnQueryAndResponse);

		// return IF(COUNT(queries) = 1, rval, nullRval);									
		return rval;
	END;
	
	// fetches all queries (including inputs) plus responses.
	export DATASET(autnQueryAndResponse) fn_GetAllQueriesWithResponses() := FUNCTION
		queries := SORT(PROJECT(autnQueries, {autnQueries.queryNo} ), queryNo);

		autnQueryAndResponse getResponsesTransform(queries L) := TRANSFORM
			q := L.queryNo;
			SELF := fn_GetQueryAndResponse(q);
		END;
		
		resp := PROJECT(queries, getResponsesTransform(LEFT));
		return resp;
	END;

	// fetches all responses, including query number and response number.
	export DATASET(autnResponse) fn_GetAllResponses() := FUNCTION
		queries := CHOOSEN(SORT(PROJECT(autnQueries, { autnQueries.queryNo }), queryNo), 100);
		
		basicEntity := RECORD
			UNSIGNED queryNo;
			UNSIGNED respNo;
		END;
		
		basicEntity QueryToEntityJoinTransform(autnQueries q, autnEntities e) := TRANSFORM
			SELF.queryNo := q.queryNo;
			SELF.respNo := e.respNo;
		END;
		
		entities := JOIN(autnQueries, autnEntities, LEFT.queryNo = RIGHT.queryNo, QueryToEntityJoinTransform(LEFT, RIGHT));
		
		autnResponse fetchResponse(entities e) := TRANSFORM
			resp := fn_GetResponse(e.queryNo, e.respNo);
			
			SELF.names := resp.names;
			SELF.addrs := resp.addrs;
			SELF := e;
		END;
		
		return PROJECT(entities, fetchResponse(LEFT));
	END;

END;