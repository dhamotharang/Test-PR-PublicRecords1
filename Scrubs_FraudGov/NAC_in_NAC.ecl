import FraudGovPlatform,NAC;
Export NAC_In_NAC := Function 
		
   result := project( FraudGovPlatform.Files().Sprayed.NAC, 
    transform(NAC.Layouts.MSH, SELF := LEFT;SELF := []));
   
	return (result);
end;