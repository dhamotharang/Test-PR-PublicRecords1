EXPORT Append_CleanAddress ( 
    dataset(FraudGovPlatform.Layouts.Base.Main) FileBase ) 
:= FUNCTION
            
    slim_in := Project( FileBase, TRANSFORM( fraudgovplatform.Layouts.Base.AddressCache, SELF := LEFT, SELF := [] ) );

    CleanedAddresses :=  fraudgovplatform.mac_Append_CleanAddresses(slim_in);  

    CleanedRecs := join(
            FileBase, 
            CleanedAddresses, 
                LEFT.street_1 = RIGHT.street_1 and 
                LEFT.street_2 = RIGHT.street_2  and 
                LEFT.city = RIGHT.city  and  
                LEFT.state = RIGHT.state and 
                LEFT.zip = RIGHT.zip,
            TRANSFORM(FraudGovPlatform.Layouts.Base.Main, 
                isFound := IF(  LEFT.street_1 = RIGHT.street_1 and 
                                LEFT.street_2 = RIGHT.street_2  and 
                                LEFT.city = RIGHT.city  and  
                                LEFT.state = RIGHT.state and 
                                LEFT.zip = RIGHT.zip, 
                            TRUE, FALSE);
                SELF.Clean_Address := IF( isFound , RIGHT.Clean_Address, LEFT.Clean_Address) ,
                SELF.address_1 := IF( isFound , RIGHT.address_1, LEFT.address_1 ) ,
                SELF.address_2 := IF( isFound , RIGHT.address_2, LEFT.address_2 ),           
                SELF := LEFT),
            KEEP(1),LEFT OUTER
        );
    
    return( CleanedRecs );

END;