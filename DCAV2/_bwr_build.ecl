import _control;

pversion						:= '20120910'															            ;
pDirectory					:= '/prod_data_build_13/eval_data/dca/test/20120718'		;

#workunit('name', DCAV2._Constants().Name + ' Build ' + pversion);
DCAV2.Build_All(
	 pversion					
	,pDirectory				
);
