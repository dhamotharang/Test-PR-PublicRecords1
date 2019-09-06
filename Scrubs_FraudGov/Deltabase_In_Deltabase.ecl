import FraudGovPlatform;
Export Deltabase_In_Deltabase := Function 
		
   result := project( FraudGovPlatform.Files().Sprayed.Deltabase, 
    transform(FraudGovPlatform.Layouts.Sprayed.Deltabase, SELF := LEFT;SELF := []));
   
	return (result);
end;