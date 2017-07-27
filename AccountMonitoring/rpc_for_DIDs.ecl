// Remote Procedure Call (rpc)
// This attribute remotely calls the roxie batch service (using a RoxiePipe call) to 
// get the did for each new account monitoring record that is added to the portfolio.
// the batch call is made in slices of 100 records until all new records have a did.

IMPORT Didville, did_add;

EXPORT rpc_for_Dids( DATASET(layouts.DIDMetaRec) batch_in ) :=
	FUNCTION

		UCase := StringLib.StringToUpperCase;
		
		DidVille.Layout_Did_Batch.In xfm_to_inbatch(layouts.DIDMetaRec l) :=
			TRANSFORM
				SELF.seq         := l.seq;
				SELF.ssn         := (qSTRING9) UCase(l.ssn);
				SELF.dob         := (qSTRING8) UCase(l.dob);
				SELF.phone10     := (qstring10)UCase(l.phone10);
				SELF.title       := (qSTRING5) '';
				SELF.fname       := (qSTRING20)UCase(l.fname);
				SELF.mname       := (qSTRING20)UCase(l.mname);
				SELF.lname       := (qSTRING20)UCase(l.lname);
				SELF.suffix      := (qSTRING5) UCase(l.suffix);
				SELF.prim_range  := (qSTRING10)UCase(l.prim_range);
				SELF.predir      := (qSTRING2) UCase(l.predir);
				SELF.prim_name   := (qSTRING28)UCase(l.prim_name);
				SELF.addr_suffix := (qSTRING4) UCase(l.addr_suffix);
				SELF.postdir     := (qSTRING2) UCase(l.postdir);
				SELF.unit_desig  := (qSTRING10)UCase(l.unit_desig);
				SELF.sec_range   := (qSTRING8) UCase(l.sec_range);
				SELF.p_city_name := (qSTRING25)UCase(l.p_city_name);
				SELF.st          := (qSTRING2) UCase(l.st);
				SELF.z5          := (qSTRING5) UCase(l.z5);
				SELF.zip4        := (qSTRING4) UCase(l.zip4);
				self.acctno      := '';
			END;
			
		f_in     := PROJECT( batch_in, xfm_to_inbatch(LEFT) );

      // This is the remote call to the 'Roxiepipe' Batch service.
		f_out := PIPE(f_in
				, 'roxiepipe' +
				' -iw ' + SIZEOF(DidVille.Layout_Did_Batch.In) +
				' -vip' +
				' -t 4' +
				' -ow ' + SIZEOF(DidVille.Layout_Did_Batch.Out) +
				' -b 100' +
				' -mr 2' +
				' -h ' + did_add.Roxie_IP +       
				' -r Result' +                                   
				' -q "<DidVille.DID_Batch_Service format=\'raw\'><Fuzzies>ALL</Fuzzies><Deduped>TRUE</Deduped>' +
				'<did_batch_in id=\'id\' format=\'raw\'></did_batch_in>' +
				'</DidVille.DID_Batch_Service>"'
				, DidVille.Layout_Did_Batch.Out);

		best_out_slim := PROJECT( f_out, {DidVille.Layout_Did_Batch.Out.seq, DidVille.Layout_Did_Batch.Out.did} );

		RETURN best_out_slim; // layout is UNSIGNED4 + UNSIGNED6
	END;

/*  NOTES:
	roxiepipe = the executable we're calling
	iw = Input Width
	vip = Virtual IP
	t = # threads
	ow = output width
	b = # records in a batch
	mr = max retries
	h = ???  -- the URL to the Roxie batch service
	r = name of the results dataset (case sensitive!)
	q = query  -- and the SOAP variables & values used for that query
*/