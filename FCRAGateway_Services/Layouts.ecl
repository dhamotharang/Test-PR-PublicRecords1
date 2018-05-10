//Layouts for FCRA Credit Gateway Services.
import iesp, Royalty;

EXPORT Layouts := MODULE

	//this shoudl be code map
	EXPORT error_code := RECORD
		INTEGER code;
		STRING message;
	END;

	EXPORT gateway_common := RECORD
		unsigned6 lexID;
		integer status;
	END;

	EXPORT compliance_out := RECORD
		boolean is_suppressed_by_alert;
		DATASET(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts;
		DATASET(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements;
		unsigned6 lexID;
	END;

	EXPORT equifax_ems := MODULE

		EXPORT fault_rec := RECORD
			STRING  Source   := XMLTEXT('faultactor');
			INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
			STRING  Location := XMLTEXT('Location');
			STRING  Message  := XMLTEXT('faultstring');
		END;

		EXPORT gateway_out := RECORD(gateway_common)
			iesp.equifax_ems.t_EquifaxEmsResponse response;
		END;

		//This is the gateway response with royalties and consumer statements/alerts from personcontext
		EXPORT service_out := RECORD(gateway_out)
			DATASET(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts,
			DATASET(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements,
			iesp.share.t_CodeMap unique_validation;
		END;

		EXPORT records_out := RECORD(service_out)
			DATASET(Royalty.Layouts.Royalty) royalties;
		END;
	END;
END;