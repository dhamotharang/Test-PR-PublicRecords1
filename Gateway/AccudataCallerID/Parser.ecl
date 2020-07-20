IMPORT Doxie, dx_gateway, iesp, Phones, Suppress, STD;
EXPORT Parser := MODULE

  // Applies Opt Out suppression to the response.
  EXPORT CleanResponse(DATASET(iesp.accudata_accuname.t_AccudataCnamResponseEx) gw_resp,
    Doxie.IDataAccess mod_access) := FUNCTION

    seq_rec := RECORD(iesp.accudata_accuname.t_AccudataCnamResponseEx)
      unsigned4 seq;
    END;
    gw_resp_seq := PROJECT(gw_resp, TRANSFORM(seq_rec, SELF.seq := COUNTER, SELF := LEFT));

    dx_gateway.Layouts.common_optout create_request(seq_rec L) := TRANSFORM
        cleaned_name := Phones.Functions.ParseAccudataCallingName(L.response.AccudataReport.Reply.CallingName);
        SELF.fname := cleaned_name.fname;
        SELF.lname := cleaned_name.lname;
        SELF.phone10 := L.response.AccudataReport.Phone;
        SELF.global_sid := dx_gateway.Constants.AccudataCallerID.GLOBAL_SID;
        SELF.seq := L.seq;

        // The gateway doesn't provide more PII to retrieve a lexID.
        SELF := [];
    END;

    did_append_req := PROJECT(gw_resp_seq, create_request(LEFT));
    dx_gateway.mac_append_did(did_append_req, gw_resp_w_dids, mod_access, dx_gateway.Constants.DID_APPEND_LOCAL);
    gw_resp_suppressed := Suppress.MAC_FlagSuppressedSource(gw_resp_w_dids, mod_access);

    // Remove the reply field if suppressed, the rest is left for royalty calculation.
    gw_resp_cleaned := JOIN(gw_resp_suppressed, gw_resp_seq,
      LEFT.seq = RIGHT.seq,
      TRANSFORM(iesp.accudata_accuname.t_AccudataCnamResponseEx,
        SELF.response.AccudataReport.Reply := IF(NOT LEFT.is_suppressed, RIGHT.response.AccudataReport.Reply),
        SELF := RIGHT), KEEP(1));

    RETURN gw_resp_cleaned;
  END;

END;
