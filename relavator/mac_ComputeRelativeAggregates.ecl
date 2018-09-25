EXPORT mac_ComputeRelativeAggregates(OutGraph, distance_threshold) := FUNCTIONMACRO 

rAlertList := RECORD
  OutGraph.cluster_id;
	INTEGER2 TotalCnt := COUNT(GROUP);
	INTEGER2 FirstDegrees := COUNT(GROUP,OutGraph.Degree > 0 AND OutGraph.Degree <= 1.0);
	INTEGER3 SecondDegrees := COUNT(GROUP,OutGraph.Degree > 1.0);
	REAL4 Cohesivity := AVE(GROUP,OutGraph.Degree);
END;

// compute cluster aggregate counts for all persons within threshold_distance of input people.
RETURN TABLE(OutGraph, rAlertList, cluster_id, MERGE);

ENDMACRO;
