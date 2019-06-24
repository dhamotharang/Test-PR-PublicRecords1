IMPORT $, iesp, FFD, FCRA, UT;

EXPORT Functions :=
MODULE

  EXPORT GetMetadataESDL($.Layouts.ComplianceFlags compliance_flags,
                        $.Layouts.RecordIds record_ids,
                        DATASET(FFD.Layouts.StatementIdRec) statement_ids,
                        UNSIGNED subject_did,
                        STRING data_group) := 
  FUNCTION
    iesp.fcradataservice_common.t_FcraDataServiceMetadata xformMeta() := TRANSFORM
      SELF.RecID := record_ids;
      SELF.ComplianceFlags := compliance_flags;
      SELF.StatementID := statement_ids[1].StatementID;
      SELF.Datagroup := data_group;
      SELF.Lexid := (STRING) subject_did;
    END;
    RETURN ROW(xformMeta());
  END;

  EXPORT FCRADateIsOk (STRING8 _date, STRING8 _today) := ut.DaysApart(_date, _today) < ut.DaysInNYears(7);

END;