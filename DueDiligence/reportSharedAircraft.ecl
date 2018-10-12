IMPORT BIPv2, codes, DueDiligence, faa, iesp, STD;

/*
	Following Keys being used:
			faa.key_aircraft_info
*/
EXPORT reportSharedAircraft(DATASET(DueDiligence.LayoutsInternalReport.SharedAircraftLayout) inAir) := FUNCTION

  //grab number of engines and manufacture info
	aircraftInfo := JOIN(inAir, faa.key_aircraft_info(),
                          LEFT.manufactureModelCode = RIGHT.code,
                          TRANSFORM(DueDiligence.LayoutsInternalReport.SharedAircraftLayout,
                                    SELF.NumberOfEngines := (INTEGER)RIGHT.number_of_engines;
                                    SELF.additionalDetails.detailType := STD.Str.ToUpperCase(codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(RIGHT.type_aircraft));
                                    
                                    SELF := LEFT),
                          LEFT OUTER,
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
									
	//group slimmed dataset by seq and linkIDs so counter can count per grouping
  sortAir := SORT(aircraftInfo, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
	groupAir := GROUP(sortAir, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
  
  //make sure we limit the report data with defined max
  limitAircraft := DueDiligence.Common.GetMaxRecords(groupAir, iesp.Constants.DDRAttributesConst.MaxAircraft);
  
  
  
  RETURN limitAircraft;
END;