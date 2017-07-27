
export unsigned1 findRule( 
														boolean IsBestAddressBlank,
														boolean IsBestBlank,
														boolean IsBestEqualsInput,
														boolean IsBestAddressEqualsInput,
														boolean IsBestEqualsBestAddress
													) :=  function
		
				sameBest 			:= IsBestEqualsInput and not IsBestBlank ;
				sameBestAddress 			:= IsBestAddressEqualsInput and not IsBestAddressBlank;
				differentBest 	:= not IsBestEqualsInput and not IsBestBlank ;
				differentBestAddress	:= not IsBestAddressEqualsInput and not IsBestAddressBlank;

					
        ruleNumber  := map
												(
													sameBest 			and 	sameBestAddress => 1,
													sameBest 			and 	differentBestAddress => 2,
													sameBest 			and 	IsBestAddressBlank	=> 3,
													differentBest	and 	sameBestAddress => 4,
													differentBest and		differentBestAddress  and IsBestEqualsBestAddress => 5,
													differentBest and		IsBestAddressBlank => 6,
													IsBestBlank		and 	sameBestAddress => 7,
													IsBestBlank 	and		differentBestAddress => 8,
													IsBestBlank 	and		IsBestAddressBlank => 9,
													differentBest	and 	differentBestAddress 	=> 10,
													11
												);

		return(ruleNumber);
	end;