import FraudGovPlatform;
Export DEDI_In_DEDI := Function 
		
   result := project( FraudGovPlatform.Files().Sprayed.DisposableEmailDomains, 
    transform(FraudGovPlatform.Layouts.Sprayed.DisposableEmailDomains, SELF := LEFT;SELF := []));
   
	return (result);
end;