import dx_common;
export layouts :=
module
    export	Base	:=
    record
        string3		Source;
        string10	PhoneNumber;		
    end;
    
    export	Building	:=
    record
        string3		Source;
        string10	PhoneNumber;
        UNSIGNED4 dt_effective_first;
        UNSIGNED4 dt_effective_last;
        UNSIGNED1 delta_ind; 
        UNSIGNED8 record_sid;
    end;
    export delta_keyfield :=
    RECORD
        string10	PhoneNumber;
    END;
    export Delta_payload := 
    record
        string10	PhoneNumber;
        UNSIGNED4 dt_effective_first;
        UNSIGNED4 dt_effective_last;
        UNSIGNED1 delta_ind; 
    end;
end;