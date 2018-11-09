IMPORT BatchShare;

EXPORT AccuityBankData_Layouts := MODULE

	EXPORT batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING20 routing_transit_nbr;
		STRING32 state;
		STRING10 edge_region;
	END;

	EXPORT batch_wrk := RECORD
		batch_in;
		STRING20 orig_acctno;
		Batchshare.Layouts.ShareErrors;
		STRING9 in_routing_nbr;
		STRING2 in_state;
		STRING2 in_region;
		STRING9 routing_number;
		STRING2 routing_state;
	END;

	EXPORT batch_out := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING24 ultimate_bank_in_state;
		STRING24 geotriangulation;
	END;

END;