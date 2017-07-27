IMPORT Accurint_Acclogs, autokeyb2;

EXPORT AutoKeyIds(IParam.SearchInterface input) := FUNCTION

			//****** SEARCH THE AUTOKEYS
		str_autokeyname := Accurint_AccLogs.str_AutokeyName;		
		typestr := 'AK';		
		set of string1 skip_set := [];  
		
		ids := autokeyb2.get_IDs (str_autokeyname, typestr, skip_set, true, true, 
			CaseConnect_Services.MFetch, CaseConnect_Services.MFetchB); 		

		recIds := PROJECT(ids, TRANSFORM (Layouts.AccLogId, 
						self.record_id := left.id))	;	
		
	RETURN recIds;

END;