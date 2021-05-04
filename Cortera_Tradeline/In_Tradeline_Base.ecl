
EXPORT In_Tradeline_Base(string8 																					pVersion,
												 dataset(Cortera_Tradeline.Layout_Delete)					dsSprayDelsFile = $.Files().Input.Tradeline_Dels.Using,
												 dataset(Cortera_Tradeline.Layout_Tradeline_Base)	dsTradelinBase  = $.Files().Base.Tradeline.Qa												 
		) := function

		return $.proc_delete_records(pVersion, ,dsSprayDelsFile, dsTradelinBase);
		
END;
