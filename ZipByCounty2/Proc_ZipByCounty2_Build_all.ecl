

import _control;

export Proc_ZipByCounty2_Build_all (string filedate) := function


	doQuarterly	:= ZipByCounty2.Spray_Input('edata12',filedate);
	

	buildAll	:= ZipByCounty2.proc_buildZipByCounty2(filedate);
	
  build_key := ZipByCounty2.Proc_ZipbyCounty2_buildKey(filedate);
	
	QA_sample  := ZipByCounty2.New_records_sample; 
	
	return sequential(doQuarterly,buildAll,build_key/*,QA_sample*/);
	
end;