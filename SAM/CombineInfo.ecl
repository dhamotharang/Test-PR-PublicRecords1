/*
This will combine additional information pieces

*/
import Worldcheck_Bridger;
EXPORT CombineInfo(DATASET(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo) additionalinfo) := FUNCTION
	ds := DEDUP(SORT(additionalinfo,type,information,comments),type,information,comments);

	ds1 := ROLLUP(ds, TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo,
						self.comments := LEFT.comments + '; ' + RIGHT.comments;
						self := left;
					),
					type, information);
	return ds1;
END;