//Verfify that 1000 Name Records are cleaned OK

my_ds := _certification.TestFile_BuildNames;
sample_out := output(enth(my_ds,50));

znames_score:= sum(my_ds,(integer)clean_name[71..73]);

boolean within_tolerance(integer val, integer score, integer percent):= FUNCTION
low:=score - score*(percent/100);
high:=score+score*(percent/100);
return if((high >= val and val >= low),true, false);
END;
integer tolerance:= 5;// _certification.setup.tolerance;

OK:='1000 CLEAN NAMES TEST SUCCESSFUL';

test_result := output(IF(
      within_tolerance(znames_score,100000,tolerance),
      OK ,
      'VERIFY Names Failed'
			));
			

export Verify_NameClean := sequential(sample_out,test_result);
