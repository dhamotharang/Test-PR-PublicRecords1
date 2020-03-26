import FraudGovPlatform;
Export RDP_In_RDP := Function 
		
   result := project( FraudGovPlatform.Files().Sprayed.RDP, 
    transform(FraudGovPlatform.Layouts.Sprayed.RDP, SELF := LEFT;SELF := []));
   
	return (result);
end;