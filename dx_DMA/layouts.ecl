import dx_common;
EXPORT layouts :=
module
    EXPORT	Base	:=
    record
        string3		Source;
        string10	PhoneNumber;		
    END;
    
    EXPORT	Building	:=
    record
        string3		Source;
        string10	PhoneNumber;
        dx_common.layout_metadata.dt_effective_first;
        dx_common.layout_metadata.dt_effective_last;
        dx_common.layout_metadata.delta_ind; 
    END;
    EXPORT delta_keyfield :=
    RECORD
        string10	PhoneNumber;
    END;
    EXPORT Delta_payload := 
    record
        string10	PhoneNumber;
        dx_common.layout_metadata.dt_effective_first;
        dx_common.layout_metadata.dt_effective_last;
        dx_common.layout_metadata.delta_ind; 
    END;
END;