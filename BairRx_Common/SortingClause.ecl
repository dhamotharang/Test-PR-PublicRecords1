IMPORT BairRx_Common;
EXPORT SortingClause := MODULE
	EXPORT Definition := {unsigned1 etype; boolean active; unsigned fid, boolean desc; boolean sort_by_distance; boolean default_criteria;};
	EXPORT DefaultClause := ROW({'', false, 0, false,false,false}, Definition);
	EXPORT Order := ENUM(UNSIGNED1, NONE=0, ASC=1, DESC=2);		
	EXPORT GetClause(string3 m, string clause) := FUNCTION
		cclause := IF(clause[1]='-', clause[2..], clause);
		etype := BairRx_Common.EID.TypeFromString(m);
		attr := BairRx_Common.AttributeMap(mode=m and map_data=cclause);
		FID := IF(exists(attr), attr[1].FID, BairRx_Common.AttributeMap(mode=m and default)[1].FID);
		sort_by_distance := stringlib.stringFind(cclause,'DISTANCE',1)>0; 	
		RETURN ROW({etype, cclause, FID, clause[1]='-',sort_by_distance,attr[1].default},Definition);	
	END;	
	EXPORT SlimTOPN(DATASET(BairRx_Common.Layouts.SearchRec) dRecs, Definition SC, unsigned max_recs) := 
		// This sorting assumes that dates are always the default sorting criteria. It is necessary to check that condition here 
		// to avoid inconsistent results because of the use of date field as a tie breaker.
		IF(SC.desc, TOPN(dRecs, max_recs, IF(SC.default_criteria, -date, if(SC.sort_by_distance, -distance, -slim_sort)), -date), 			
				TOPN(dRecs, max_recs, IF(SC.default_criteria, date, if(SC.sort_by_distance, distance, slim_sort)), -date));
	EXPORT CustomSort(dRecs, SC) := FUNCTIONMACRO
		IMPORT STD;
		dUpCaseRecs := PROJECT(dRecs, TRANSFORM(RECORDOF(dRecs), SELF.sort_str := STD.Str.ToUpperCase(LEFT.sort_str), SELF := LEFT));
		dSortRecs := IF(dRecs[1].sort_type=1, dUpCaseRecs, dRecs);
		dRecsSorted := IF(SC.desc, 
			SORT(dSortRecs, -IF(sort_type=0, sort_num, 0), -IF(sort_type=0, '', sort_str), -date),
			SORT(dSortRecs,  IF(sort_type=0, sort_num, 0),  IF(sort_type=0, '', sort_str), -date));
		RETURN IF(EXISTS(dRecs), dRecsSorted, dRecs); //if guarantees dRecs has entries so line 21 reference to 1st element for sort_type won't fail
	ENDMACRO;
END;