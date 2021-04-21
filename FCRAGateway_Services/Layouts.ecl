//Layouts for FCRA Credit Gateway Services.
import iesp, Royalty;

EXPORT Layouts := MODULE

  EXPORT fault_rec := RECORD
    STRING  Source   := XMLTEXT('faultactor');
    INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
    STRING  Location := XMLTEXT('Location');
    STRING  Message  := XMLTEXT('faultstring');
  END;

  EXPORT consumer_data := RECORD
      DATASET(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts;
      DATASET(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements;
      iesp.share_fcra.t_FcraConsumer Consumer;
  END;

  //These get added to FCRA Gateway responses for compliance with Dempsey.
  EXPORT dempsey_compliance := RECORD
    consumer_data;
    iesp.share.t_CodeMap unique_validation;
  END;

  EXPORT compliance_out := RECORD
    boolean is_suppressed_by_alert;
    consumer_data;
  END;

  EXPORT equifax_ems := MODULE

    EXPORT lexID_appended_report := RECORD(iesp.equifax_ems.t_CreditReportRecord)
      unsigned6 resolved_lexID;
      iesp.share.t_Address parsed_Address; // add parsed address fields from equifax report to output
    END;

    EXPORT CreditReportRecord := record
      iesp.equifax_ems.t_CreditReportRecord;
      dataset(iesp.share.t_CodeMap) Validations;
    END;

    EXPORT EmsResponse := RECORD
      iesp.equifax_ems.t_EmsResponse - CreditReports;
      dataset(CreditReportRecord) CreditReports;
    END;

    EXPORT EquifaxEmsResponse := record
      iesp.share.t_ResponseHeader _Header;
      EmsResponse emsResponse;
    END;

    EXPORT gateway_out := RECORD
      EquifaxEmsResponse response;
    END;

    //This is the gateway response with royalties, alerts from personContext, and uniqueValidation
    EXPORT records_out := RECORD(gateway_out)
      dempsey_compliance;
      Royalty.Layouts.Royalty royalties;
    END;

  END;

  EXPORT tu_fraud_alert := MODULE

    EXPORT gateway_out := RECORD
      unsigned6 lexID;
      iesp.tu_fraud_alert.t_TuFraudAlertResponse response;
    END;

    EXPORT records_out := RECORD(gateway_out)
      DATASET(Royalty.Layouts.Royalty) royalties;
    END;

  END;

END;
