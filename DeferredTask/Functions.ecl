IMPORT DeferredTask, IESP;

EXPORT Functions := MODULE;

	EXPORT ParseResponseOpaqueContent(STRING JSONString) := FUNCTION
	
		OutLayout := DeferredTask.Layouts.ResponseOpaqueContentLayout;
	
		OutLayout HandleException() :=
			TRANSFORM
			SELF.ErrorCode := FAILMESSAGE;
			SELF := [];
		END;
	 
		rec := FROMJSON(OutLayout, JSONString, ONFAIL(HandleException()));
		
		RETURN rec;
	END; // ParseResponseOpaqueContent END
  
    EXPORT ParseGetRequestInfo(DATASET({STRING ErrorMessage, INTEGER ErrorCode, IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoResponseEx}) DTERecs) := FUNCTION
        
        OutLayout := RECORD
        iesp.dte_getrequestinfo.t_DTEGetRequestInfoResponseEx;
        DATASET(DeferredTask.Layouts.ResponseOpaqueContentLayout) ResponseJSON;
        END;

        ParsedJSON := PROJECT(DTERecs, TRANSFORM(OutLayout, 
        SELF.ResponseJSON := ParseResponseOpaqueContent(LEFT.response.DTERequest.TaskExs[1].ResponseOpaqueContent);
        SELF := LEFT;
        SELF := []));
        
        RETURN ParsedJSON;
    END; // ParseGetRequestInfo END
    
END; // Functions Module END