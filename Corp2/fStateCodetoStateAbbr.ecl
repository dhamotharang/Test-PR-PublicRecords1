layout_state_code :=
record

	string state_abbreviation;
	string state_code;

end;

dstate_code_mapping := dataset([

	 {'AK', '02'}
	,{'AL', '01'}
	,{'AR', '05'}
	,{'AZ', '04'}
	,{'CA', '06'}
	,{'CO', '08'}
	,{'CT', '09'}
	,{'DC', '11'}
	,{'DE', '10'}
	,{'FL', '12'}
	,{'GA', '13'}
	,{'HI', '15'}
	,{'IA', '19'}
	,{'ID', '16'}
	,{'IL', '17'}
	,{'IN', '18'}
	,{'KS', '20'}
	,{'KY', '21'}
	,{'LA', '22'}
	,{'MA', '25'}
	,{'MD', '24'}
	,{'ME', '23'}
	,{'MI', '26'}
	,{'MN', '27'}
	,{'MO', '29'}
	,{'MS', '28'}
	,{'MT', '30'}
	,{'NC', '37'}
	,{'ND', '38'}
	,{'NE', '31'}
	,{'NH', '33'}
	,{'NJ', '34'}
	,{'NM', '35'}
	,{'NV', '32'}
	,{'NY', '36'}
	,{'OH', '39'}
	,{'OK', '40'}
	,{'OR', '41'}
	,{'PA', '42'}
	,{'PR', '72'}
	,{'RI', '44'}
	,{'SC', '45'}
	,{'SD', '46'}
	,{'TN', '47'}
	,{'TX', '48'}
	,{'UT', '49'}
	,{'VA', '51'}
	,{'VI', '78'}
	,{'VT', '50'}
	,{'WA', '53'}
	,{'WI', '55'}
	,{'WV', '54'}
	,{'WY', '56'}
], layout_state_code);



export fStateCodetoStateAbbr(

	 string		pStateCode
	,boolean	pIsAbbreviation = false

) :=
function

	lfilter := if(pIsAbbreviation
								,dstate_code_mapping.state_abbreviation = pStateCode
								,dstate_code_mapping.state_code					= pStateCode
							);
	dfiltered := dstate_code_mapping(lfilter);
	
	returnresult := if(pIsAbbreviation
										,dfiltered[1].state_code
										,dfiltered[1].state_abbreviation
									);

	return if(count(dfiltered) != 0, returnresult, '');

end;
