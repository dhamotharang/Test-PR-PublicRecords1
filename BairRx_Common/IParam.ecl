import Address, BairRx_Common, iesp, _validate, STD, ut;

EXPORT IParam := MODULE

	EXPORT CheckDatesValidity(STRING _StartDate, STRING _EndDate) := FUNCTION
			errorCode	:= MAP((INTEGER)_StartDate=0 OR _Validate.Date.fisvalid(_StartDate)=FALSE => BairRx_Common.STDError.NotValidStartDate,
											 (INTEGER)_EndDate=0 OR _Validate.Date.fisvalid(_EndDate)=FALSE => BairRx_Common.STDError.NotValidEndDate,
											_StartDate > _EndDate => BairRx_Common.STDError.InvalidDateRange,
											0);
			RETURN errorCode;
	END;

	EXPORT SearchParam := INTERFACE
		EXPORT DATASET(iesp.share.t_StringArrayItem) EIDs;
		EXPORT UNSIGNED1 SearchType;
		EXPORT UNSIGNED1 GeoSearchType;
		EXPORT REAL		BoxMinX;
		EXPORT REAL		BoxMinY;
		EXPORT REAL		BoxMaxX;
		EXPORT REAL		BoxMaxY;
		EXPORT REAL 	CLatitude; // centroid latitude
		EXPORT REAL 	CLongitude; // centroid longitude
		EXPORT REAL 	PLatitude; // pivot latitude
		EXPORT REAL 	PLongitude; // pivot longitude		
		EXPORT REAL 	Radius;
		EXPORT STRING Polygon;
		EXPORT STRING StartDate;
		EXPORT STRING EndDate;
		EXPORT STRING KeyWord;
		EXPORT STRING AgencyORI;
		EXPORT DATASET(BairRx_Common.Layouts.ModeContext) ModeContext;
		EXPORT DATASET(BairRx_Common.Layouts.ActiveModes) Active;
		EXPORT BOOLEAN ExcludeMainRecs;
		EXPORT BOOLEAN ExcludeDeltaRecs;
		EXPORT INTEGER DataProviderID;
		EXPORT BOOLEAN AgencyDataOnly;
		EXPORT BOOLEAN IncludeIncidentDetails; // for map search only
		EXPORT INTEGER LayerID := 0;
	END;	

	EXPORT ReportParam := INTERFACE
		EXPORT DATASET(iesp.share.t_StringArrayItem) EIDs;
		EXPORT STRING AgencyORI;
		EXPORT BOOLEAN ExcludeMainRecs;
		EXPORT BOOLEAN ExcludeDeltaRecs;
		EXPORT INTEGER DataProviderID;
	END;
	
	EXPORT getSearchParams(iesp.bair_share.t_BAIRBaseSearchBy searchBy, unsigned inSearchType, boolean inIncidentDetails = FALSE, boolean IsRAIDS = FALSE,unsigned inLayerId=0) := FUNCTION
		
		// -- BOX Coordinates
		REAL inMinX := (REAL) TRIM(searchBy.Location.Box.MinLongitude, LEFT, RIGHT);
		REAL inMinY := (REAL) TRIM(searchBy.Location.Box.MinLatitude, LEFT, RIGHT);
		REAL inMaxX := (REAL) TRIM(searchBy.Location.Box.MaxLongitude, LEFT, RIGHT);
		REAL inMaxY := (REAL) TRIM(searchBy.Location.Box.MaxLatitude, LEFT, RIGHT);
		
		// -- Pivot Point Radius Coordinates
		REAL PivotinLong := (REAL) TRIM(searchBy.Location.PivotLongitude, LEFT, RIGHT);
		REAL PivotinLat := (REAL) TRIM(searchBy.Location.PivotLatitude, LEFT, RIGHT);	
		
		// -- Point Radius Coordinates
		REAL inX := (REAL) TRIM(searchBy.Location.Longitude, LEFT, RIGHT);
		REAL inY := (REAL) TRIM(searchBy.Location.Latitude, LEFT, RIGHT);		
		
		// input by address is supported for convenience. not to be used by ATACRaids.
		inAddr 			:= searchBy.Location.Address;
		addr1 			:= inAddr.StreetAddress;
		addr2 			:= StringLib.StringCleanSpaces(inAddr.City+' '+inAddr.State+' '+inAddr.Zip);			
		CL 					:= Address.CleanAddressFieldsFips(Address.CleanAddress182(addr1, addr2));	
		
		// -- Polygon
		inPolygon :=  TRIM(searchBy.Location.Polygon, LEFT, RIGHT);	
		SET OF REAL pcentroid := BairRx_Common.WKT.Polygon.Centroid(inPolygon);
		
		//
		// -- Lat/Long from input address
		_allowclean := (inAddr.City <> '' AND inAddr.State <> '') OR inAddr.Zip <> '';
		addr_lat  := IF(CL.Geo_Lat<>'' AND CL.Geo_Long<>'', (REAL)CL.Geo_Lat, pcentroid[2]);
		addr_long := IF(CL.Geo_Lat<>'' AND CL.Geo_Long<>'', (REAL)CL.Geo_Long, pcentroid[1]);		
		
		//
		// Determine lat/long to use, if so indicated. The _allowclean iff statement prevents address cleaner from
		// being called if no valid address was provided
		inLat	 := IF(inX<>0 and inY<>0, inY, iff(_allowclean, addr_lat, 0));
		inLong := IF(inX<>0 and inY<>0, inX, iff(_allowclean, addr_long, 0));
		REAL inRadius := IF(searchBy.Location.Radius>0, MIN(searchBy.Location.Radius, BairRx_Common.Constants.MAX_RADIUS), 0.0);
		
		// -- DATES
		inStartDate := BairRx_Common.ECL2ESP.t_DateToString8(searchBy.StartDate);
		inEndDate := BairRx_Common.ECL2ESP.t_DateToString8(searchBy.EndDate); 				
			
		
		// set type of spatial search
		inGeoSearchType := MAP(			
			inLat <> 0 and inLong <> 0 and inRadius > 0 => Constants.GeoSearchType.PointRadius,			
			inPolygon <> '' or inLayerId <>0 => Constants.GeoSearchType.Polygon,
			inMinX<>0 and inMinY<>0 and inMaxX<>0 and inMaxY<>0 => Constants.GeoSearchType.Box,
			Constants.GeoSearchType.None);
		
		// centroid
		CLAT := MAP(
			inGeoSearchType = Constants.GeoSearchType.PointRadius => inLat,
			inGeoSearchType = Constants.GeoSearchType.Polygon => pcentroid[2],
			inGeoSearchType = Constants.GeoSearchType.Box => inMinY+(inMaxY - inMinY)/2,			
			0);
		CLON := MAP(
			inGeoSearchType = Constants.GeoSearchType.PointRadius => inLong,
			inGeoSearchType = Constants.GeoSearchType.Polygon => pcentroid[1],
			inGeoSearchType = Constants.GeoSearchType.Box =>  inMinX+(inMaxX - inMinX)/2,			
			0);
		
		err_daterange := CheckDatesValidity(inStartDate,inEndDate);
		
		invalid_polygon := inPolygon<>'' AND ~BairRx_Common.WKT.Polygon.IsValidWKT(inPolygon);
		
		_agencyORI := '' : STORED('AgencyORI');
		missing_ORI := _agencyORI = '' AND ~IsRAIDS; // Additional Check for IsRAIDS to ensure RaidsOnline and IOS apps do not fail as they do not pass ORI
		
		err_code := MAP(
			~EXISTS(searchBy.EntityIDs) and err_daterange > 0 => err_daterange, // No need to check dates if searching by EIDs
			invalid_polygon => BairRx_Common.STDError.InvalidPolygon,
			missing_ORI => BairRx_Common.STDError.MissingAgencyORI,
			0);		
			
			
		BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		validRequest := err_code = 0;	

		in_params := MODULE(SearchParam)
				// Line below is necessary to 'force' validation. Hacky, but it works...
			EXPORT DATASET(iesp.share.t_StringArrayItem) EIDs := IF(validRequest, searchBy.EntityIDs, dataset([],iesp. share.t_StringArrayItem)); 
			EXPORT UNSIGNED1 SearchType := inSearchType;																	
			EXPORT UNSIGNED1 GeoSearchType := inGeoSearchType;																	
			EXPORT INTEGER LayerId := inLayerId;																	
			EXPORT REAL		BoxMinX				:= inMinX;
			EXPORT REAL		BoxMinY				:= inMinY;
			EXPORT REAL		BoxMaxX				:= inMaxX;
			EXPORT REAL		BoxMaxY				:= inMaxY;
			EXPORT REAL 	CLatitude 		:= CLAT;
			EXPORT REAL 	CLongitude 		:= CLON;				
			EXPORT REAL 	PLatitude 		:= if(PivotinLat <> 0 and PivotinLong <> 0,PivotinLat,CLAT);
			EXPORT REAL 	PLongitude 		:= if(PivotinLat <> 0 and PivotinLong <> 0,PivotinLong,CLON);
			EXPORT REAL		Radius 				:= inRadius;
			EXPORT STRING Polygon 			:= inPolygon;
			EXPORT STRING StartDate 		:= inStartDate;
			EXPORT STRING EndDate 			:= inEndDate;
			EXPORT STRING KeyWord 			:= BairRx_Common.Functions.Trim2Upper(searchBy.KeyWord.Expression);
			EXPORT STRING AgencyORI			:= TRIM(IF(validRequest,_agencyORI, ''), LEFT, RIGHT); // if forces empty string check above
			EXPORT DATASET(BairRx_Common.Layouts.ModeContext) ModeContext := DATASET([], BairRx_Common.Layouts.ModeContext);
			EXPORT DATASET(BairRx_Common.Layouts.ActiveModes) Active := DATASET([], BairRx_Common.Layouts.ActiveModes);			
			EXPORT BOOLEAN ExcludeMainRecs := false : STORED('ExcludeMainRecs');
			EXPORT BOOLEAN ExcludeDeltaRecs := false : STORED('ExcludeDeltaRecs');
			EXPORT INTEGER DataProviderID := BairRx_Common.Functions.GetDataProviderByORI(IF(validRequest,_agencyORI,'')); // if forces empty string check above
			EXPORT BOOLEAN AgencyDataOnly := false : STORED('AgencyDataOnly');
			EXPORT BOOLEAN IncludeIncidentDetails := inIncidentDetails;
		END;


		// TO BE DONE:
		// 1. WGS84_SRID polygon validation 
		return in_params;
	
	END;	
	
	EXPORT getReportParams(iesp.bair_share.t_BAIRBaseReportBy reportBy, boolean IsRAIDS = FALSE) := FUNCTION
		
		_agencyORI := '' : STORED('AgencyORI');
		missing_ORI := _agencyORI = '' and ~IsRAIDS;
		err_code := IF(missing_ORI, BairRx_Common.STDError.MissingAgencyORI, 0);		
		BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		validRequest := err_code = 0;	
		
		in_params := MODULE(ReportParam)
			EXPORT DATASET(iesp.share.t_StringArrayItem) EIDs := IF(validRequest, reportBy.EntityIDs, dataset([],iesp. share.t_StringArrayItem));
			EXPORT STRING AgencyORI			:= TRIM(_agencyORI, LEFT, RIGHT);
			EXPORT BOOLEAN ExcludeMainRecs := false : STORED('ExcludeMainRecs');
			EXPORT BOOLEAN ExcludeDeltaRecs := false : STORED('ExcludeDeltaRecs');
			EXPORT INTEGER DataProviderID := BairRx_Common.Functions.GetDataProviderByORI(if(validRequest,_agencyORI, '')); // if forces empty string check above
		END;
	
		RETURN in_params;
	
	END;
	
	EXPORT SetInputSearchOptions (iesp.bair_share.t_BAIRBaseSearchOption options) := FUNCTION		
		_agencyORI := '' : STORED('AgencyORI');
		missing_ORI := _agencyORI = '';
		err_code := IF(missing_ORI, BairRx_Common.STDError.MissingAgencyORI, 0);		
		BairRx_Common.STDError.CFail(err_code <> 0, err_code);		
		validRequest := err_code = 0;	
		BairRx_Common.ECL2ESP.Marshall.Mac_Set(options);
		boolean agencyDataOnly := global(options).ReturnAgencyDataOnly;
		#stored('AgencyDataOnly', agencyDataOnly);		
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;	
	
	
	EXPORT SetInputSearchUser (iesp.bair_share.t_BAIRUser user) := FUNCTION
		string ORI := global(user).AgencyORI;
		#stored('AgencyORI', ORI);
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;	
	
	EXPORT SetInputContext (iesp.bair_share.t_BAIRContext BAIRContext) := FUNCTION			
		string TransactionId := global(BAIRContext).TransactionId;
		#stored('_TransactionId', TransactionId);
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;

END;