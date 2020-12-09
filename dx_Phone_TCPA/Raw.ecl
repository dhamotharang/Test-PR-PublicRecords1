IMPORT dx_Phone_TCPA;

EXPORT RAW := MODULE 

EXPORT GetWDNC_history (ds_in) := FUNCTIONMACRO
 
    LOCAL phone_WDNC_history := JOIN(ds_in , dx_Phone_TCPA.Key_TCPA_Phone_History(),
                                    KEYED(LEFT.phone = RIGHT.phone),
                                    TRANSFORM(dx_Phone_TCPA.Layout.i_tcpa_phone_history, SELF.phone := LEFT.phone; SELF:= RIGHT), 
                                    limit(10000, SKIP));
    RETURN phone_WDNC_history;
ENDMACRO;

END;