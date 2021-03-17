IMPORT DX_Gateway, Riskwise, Doxie, Suppress;

EXPORT parser_netacuity := MODULE

    SHARED NetAcuity_W_SourceID := RECORD
        Riskwise.Layout_IPAI;
        UNSIGNED4 Global_SID := 0;
    END;

    EXPORT NetAcuityOptOuts(DATASET(riskwise.Layout_IPAI) input_ds, Doxie.IDataAccess mod_access, BOOLEAN RunSuppressMacro) := FUNCTION
        ds_with_sourceid := PROJECT(input_ds, 
        TRANSFORM(NetAcuity_W_SourceID, 
        SELF.Global_SID := DX_Gateway.Constants.NetAcuity.Global_SID;
        SELF := LEFT;
        ));

        suppressed_ds := IF(RunSuppressMacro, Suppress.MAC_SuppressSource(ds_with_sourceid, mod_access), ds_with_sourceid);

        output_ds := PROJECT(suppressed_ds, TRANSFORM(riskwise.Layout_IPAI, SELF:= LEFT;));

        // OUTPUT(ds_with_sourceid, named('ds_with_sourceid'));
        // OUTPUT(suppressed_ds, named('suppressed_ds'));
        // OUTPUT(output_ds, named('output_ds'));

        RETURN output_ds;
    END; // AppendSuppressedFlag end

END; // Module end
