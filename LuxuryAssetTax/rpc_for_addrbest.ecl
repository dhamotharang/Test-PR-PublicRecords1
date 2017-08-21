IMPORT AddrBest;

EXPORT rpc_for_addrbest( DATASET(AddrBest.Layout_BestAddr.Batch_in) batch_in ) :=
	FUNCTION

		f_out := PIPE(batch_in
				, 'roxiepipe' +
				' -iw ' + SIZEOF(AddrBest.Layout_BestAddr.Batch_in) +
				' -vip' +
				' -t 10' +
				' -ow ' + SIZEOF(AddrBest.Layout_BestAddr.batch_out_final) +
				' -b 100' +
				' -mr 2' +
				' -h ' + ' roxiethor.sc.seisint.com:9856' + 
				' -r Results' +
				' -q "<AddrBest.BestAddress_Batch_Service format=\'raw\'>' +
				'<batch_in id=\'id\' format=\'raw\'></batch_in>' +
				'</AddrBest.BestAddress_Batch_Service>"'
				, AddrBest.Layout_BestAddr.batch_out_final);
		
		RETURN f_out; // layout is UNSIGNED4 + UNSIGNED6
	END;