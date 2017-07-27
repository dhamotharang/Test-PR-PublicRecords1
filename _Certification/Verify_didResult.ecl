import didville, did_add;
did_Add.MAC_Match_hash_roxie(_Certification.TestFile_Dids, my_did_results);
sample_out := output(enth(my_did_results(did not in [835059233,0]),50));

valid_did := count(my_did_results(did <> 0));

test_result := output(if(valid_did <= 500,'VERIFY DID TEST FAILED','VERIFY DID TEST SUCCESSFUL'));

export Verify_didResult := sequential(sample_out,test_result);
