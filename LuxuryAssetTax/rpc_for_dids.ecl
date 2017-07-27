IMPORT Didville, did_add;

EXPORT rpc_for_dids( DATASET(DidVille.Layout_Did_Batch.Out) batch_in ) :=
	FUNCTION

		UCase := StringLib.StringToUpperCase;
		
		DidVille.Layout_Did_Batch.In xfm_to_inbatch(DidVille.Layout_Did_Batch.Out l) :=
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

		f_out := PIPE(f_in
				, 'roxiepipe' +
				' -iw ' + SIZEOF(DidVille.Layout_Did_Batch.In) +
				' -vip' +
				' -t 10' +
				' -ow ' + SIZEOF(DidVille.Layout_Did_Batch.Out) +
				' -b 100' +
				' -mr 2' +
				' -h ' + ' roxiethor.sc.seisint.com:9856' + 
				' -r Result' +
				' -q "<DidVille.DID_Batch_Service format=\'raw\'><Fuzzies>ZN</Fuzzies><Deduped>TRUE</Deduped>' +
				'<did_batch_in id=\'id\' format=\'raw\'></did_batch_in>' +
				'</DidVille.DID_Batch_Service>"'
				, DidVille.Layout_Did_Batch.Out);
		
		RETURN f_out; 
	END;