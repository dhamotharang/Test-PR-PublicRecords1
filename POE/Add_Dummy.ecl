export Add_Dummy(

	 string									pversion
	,dataset(layouts.base)	pRollupData

) :=
function

	dummy_dataset := dataset(
	[
		 {'DU',999999001001,0,0,0,20021124,pversion,'26-RVH9999999001001','','MARK','','MARSUPIAL','','0','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,0,0,0,'GENERAL PARTNER' ,0,0,'MARSUPIAL MANOR III','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,9366395412,0,0,0}
		,{'DU',999999001001,0,0,0,20021124,20050713,'26-RVH9999999001001','','MARK','','MARSUPIAL','','0','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,0,0,0,'MANAGING PARTNER',0,0,'MARSUPIAL MANOR III','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,9366395412,0,0,0}
	], layouts.base);	

	return pRollupData + dummy_dataset;

end;