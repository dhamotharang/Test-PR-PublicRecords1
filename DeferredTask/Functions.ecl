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
        
        DeferredTask.Layouts.FlattenedDTERequestInfoLayoutWTaskExs xFormFlat(DTERecs L) := TRANSFORM
        SELF.ErrorMessage := L.ErrorMessage;
        SELF.ErrorCode := (STRING)L.ErrorCode;
        SELF.InputTransactionID := L.Response.InputTransactionID;
        SELF.DteRequestStatus := L.Response.DteRequestStatus;
        SELF.TaskExs := L.Response.DteRequest.TaskExs;
        END;
        
        FlattenDTERecs := PROJECT(DTERecs, xFormFlat(LEFT));
        
        DeferredTask.Layouts.FlattenedDTERequestInfoLayoutWFlatTaskExs normalizeChildDS(FlattenDTERecs L, iesp.dte_share.t_TaskExtended R) := TRANSFORM
        SELF.ErrorMessage := L.ErrorMessage;
        SELF.ErrorCode := L.ErrorCode;
        SELF.InputTransactionID := L.InputTransactionID;
        SELF.DteRequestStatus := L.DteRequestStatus;
        SELF.TaskID := R.TaskID;
        SELF.IsTaskTimedOut := R.IsTaskTimedOut;
        SELF.TaskErrorCode := R.TaskErrorCode;
        SELF.TaskErrorDescription := R.TaskErrorDescription;
        SELF.ResponseOpaqueContent := R.ResponseOpaqueContent;
        SELF.TaskDescription := R.TaskDescription;
        SELF.TaskStatus := R.TaskStatus;
        SELF.RequestOpaqueContent := R.RequestOpaqueContent;
        END;

        NormedDTERecs := NORMALIZE(FlattenDTERecs, LEFT.TaskExs,normalizeChildDS(LEFT,RIGHT));
        
        OutLayout := RECORD
        DeferredTask.Layouts.FlattenedDTERequestInfoLayoutWFlatTaskExs;
        DATASET(DeferredTask.Layouts.ResponseOpaqueContentLayout) ResponseJSON;
        END;

        ParsedJSON := PROJECT(NormedDTERecs, TRANSFORM(OutLayout, 
        SELF.ResponseJSON := ParseResponseOpaqueContent(LEFT.ResponseOpaqueContent);
        SELF := LEFT;
        SELF := []));
        
        RETURN ParsedJSON;
    END; // ParseGetRequestInfo END
    
END; // Functions Module END