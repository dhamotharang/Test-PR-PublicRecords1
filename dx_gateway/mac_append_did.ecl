// -------------------------------------------------------------------------
// This macro is called by the parser and it is part of the interface between 
// thor and roxie.
// -------------------------------------------------------------------------
export mac_append_did(ds_in, ds_out, mod_access, append_did_local = TRUE) := MACRO

  // Option to append DID remotely is here just for convenience to faciliate testing on 1-ways.
  // It triggers a remote call to DidVille.Did_Batch_Service_Raw to resolve LexID. 
  // By default, all queries will be deployed with LOCAL option.
  // For testing with remote option, set dx_gateway.Constants.DID_APPEND_LOCAL=FALSE
  
  #uniquename(layout_append_did)
  %layout_append_did% := RECORD(dx_gateway.Layouts.common_optout)
    unsigned seq_orig;
  END;

  #uniquename(ds_in_seq)
  %ds_in_seq% := project(ds_in, TRANSFORM(%layout_append_did%, self.seq_orig := left.seq; self.seq := COUNTER; self := left));

  #uniquename(ds_in_nodids)
  %ds_in_nodids% := %ds_in_seq%(did = 0); 

  #IF(append_did_local)
    import didville, AutoKeyI;
    #uniquename(ds_in_append_local)
    didville.MAC_DidAppend(%ds_in_nodids%, %ds_in_append_local%, true, ''); // <-- weird syntax error here if I try %ds_in%(did = 0) directly.
    ds_out := join(%ds_in_seq%, %ds_in_append_local%, 
      left.seq = right.seq AND
      right.score >= dx_gateway.Constants.DID_SCORE_THRESHOLD, 
      TRANSFORM(dx_gateway.Layouts.common_optout, 
        self.seq := left.seq_orig;
        self.did := if(right.did > 0, right.did, left.did);
        self.error_code := if(right.did > 0, left.error_code, AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT), 
        self := left), 
      LEFT OUTER, KEEP(1), LIMIT(0)); 
  #ELSE
    import dx_gateway,batchshare,gateway;

    #uniquename(didville_params)
		%didville_params% := MODULE(PROJECT(BatchShare.IParam.getBatchParams(),Gateway.IParam.DidVilleParams,OPT))
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
			EXPORT UNSIGNED3 DidScoreThreshold := 80;
		END;
    #uniquename(ds_in_remote)
    %ds_in_remote% := project(%ds_in_nodids%, transform(dx_gateway.Layouts.common_did_append_remote,
      self.acctno := (string) left.seq;
      self.orig_acctno := (string) left.seq;
      self.name_first := left.fname;
      self.name_middle := left.mname;
      self.name_last := left.lname;
      self.name_suffix := left.suffix;
      self := left));
    #uniquename(ds_out_remote)  
    BatchShare.MAC_AppendDidVilleDID(%ds_in_remote%, %ds_out_remote%, %didville_params%, dx_gateway.Constants.DID_SCORE_THRESHOLD);
    ds_out := join(%ds_in_seq%, %ds_out_remote%, 
      left.seq = (unsigned) right.acctno,
      transform(dx_gateway.Layouts.common_optout,
        self.seq := left.seq_orig;
        self.did := if(right.did > 0, right.did, left.did);
        self.error_code := if(right.did > 0, left.error_code, AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT), 
        self := left), 
      LEFT OUTER, KEEP(1), LIMIT(0)); 
  #END
ENDMACRO;
