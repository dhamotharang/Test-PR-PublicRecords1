EXPORT Append_CleanAdditionalAddress (
    dataset(Layouts.Base.Main) FileBase
) := FUNCTION

	slim_in := Project( FileBase , TRANSFORM( fraudgovplatform.Layouts.Base.AddressCache , 
        SELF.street_1           := LEFT.additional_address.street_1,
        SELF.street_2           := LEFT.additional_address.street_2,
        SELF.city               := LEFT.additional_address.city,
        SELF.state              := LEFT.additional_address.state,
        SELF.zip                := LEFT.additional_address.zip,      
        SELF.clean_address      := LEFT.additional_address.clean_address,
        SELF.address_1          := LEFT.additional_address.address_1,
        SELF.address_2          := LEFT.additional_address.address_2,            
        SELF := LEFT,
        SELF := []
    ), LOCAL );
   
    CleanedAddresses :=  fraudgovplatform.mac_Append_CleanAddresses(slim_in);  

    CleanedRecs := JOIN(
            FileBase, 
            CleanedAddresses, 
                LEFT.additional_address.street_1 = RIGHT.street_1 and 
                LEFT.additional_address.street_2 = RIGHT.street_2 and 
                LEFT.additional_address.city = RIGHT.city  and  
                LEFT.additional_address.state = RIGHT.state and 
                LEFT.additional_address.zip = RIGHT.zip,
            TRANSFORM(Layouts.Base.Main, 
                isFound := IF(  LEFT.additional_address.street_1 = RIGHT.street_1 and 
                                LEFT.additional_address.street_2 = RIGHT.street_2  and 
                                LEFT.additional_address.city = RIGHT.city  and  
                                LEFT.additional_address.state = RIGHT.state and 
                                LEFT.additional_address.zip = RIGHT.zip, 
                            TRUE, FALSE );
                SELF.additional_address.Clean_Address := IF( isFound , RIGHT.Clean_Address, LEFT.additional_address.Clean_Address ),
                SELF.additional_address.address_1 := IF( isFound , RIGHT.address_1, LEFT.additional_address.address_1 ),
                SELF.additional_address.address_2 := IF( isFound , RIGHT.address_2, LEFT.additional_address.address_2 ),
                SELF := LEFT),
            KEEP(1),LEFT OUTER
        );

    return( CleanedRecs );

END;