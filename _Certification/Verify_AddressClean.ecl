// Verify that the address clean is OK
import _certification;

boolean within_tolerance(integer val, integer score, integer percent):= FUNCTION
low:=score - score*(percent/100);
high:=score+score*(percent/100);
return if((high >= val and val >= low),true, false);
END;
integer tolerance:= 5;//_certification.setup.tolerance;

clean_ds:=_Certification.TestFile_BuildAddresses;
sample_out := output(enth(clean_ds,50));

validset:=['S','E'];
hash_score:=sum(clean_ds,if(clean_address[179..179] in validset, 1, 0));

test_result:=output(if (within_tolerance(hash_score,1000,tolerance)  ,count(TestFile_BuildAddresses)+' ADDRESS CLEANING TEST SUCCESSFUL','VERIFY AdressClean FAILED'));
export Verify_AddressClean := sequential(sample_out,test_result);
