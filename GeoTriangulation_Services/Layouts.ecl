IMPORT BatchServices, BatchShare;

EXPORT Layouts := MODULE

  EXPORT rec_batch_in := RECORD
    BatchServices.Layouts.layout_batch_common_acct; // acctno

    // Required fields -----v
    STRING20 bank_routing_number := '';  //length 20 in BatchServices.AccuityBankData_layouts.batch_in ??? 
    STRING45 ip_address          := '';
    
    // Address fields, Batch ktr process will clean/parse the unparsed customer address data into standard parts before
    // passing them into the query
    BatchServices.Layouts.layout_batch_common_address; //common KTR passed in address parts fields
    // These 2 will also be passed in by the batch ktr process because they are output from the address cleaner
    STRING10 latitude  := '';
    STRING11 longitude := '';
  END;
  
  EXPORT rec_batch_seq := RECORD
    rec_batch_in;
    STRING20 orig_acctno := '';  // Added by BatchShare.MAC_SequenceInput
    Batchshare.Layouts.ShareErrors;
  END;

  EXPORT rec_batch_out := RECORD
    rec_batch_in;   //input data to be returned in the output

    STRING24  ultimate_bank_in_state := ''; // possible values = Y, N, Null, Lacking min input, ABA not found
    STRING24  geotriangulation       := ''; // possible values = Match, No match, IP mismatch, Ultimate bank mismatch, Lacking minimum input, blank 
    STRING2   ValidationIpProblems   := ''; // possible values = -1, 0, 1 or 2
    STRING1   IPAddrExceedsInputAddr := ''; // possible values = 1 or blank
    
    // v---- IP Metadata related fields from the IPv4 key or IPv6 key
    STRING5   edge_country        :='';
    STRING10  edge_region         :='';
    STRING60  edge_city           :='';
    STRING10  edge_conn_speed     := '';
    STRING10  edge_latitude       := '';
    STRING10  edge_longitude      := '';
    STRING10  edge_postal_code    := '';
    UNSIGNED  edge_continent_code := 0;
    INTEGER   edge_gmt_offset     := 0;
    STRING200 isp_name            := '';
    STRING70  domain_name         := '';
    STRING15  proxy_type          := '';
    STRING15  proxy_description   := '';
    UNSIGNED  asn                 := 0;
    STRING200 asn_name            := '';
  END;

END;
