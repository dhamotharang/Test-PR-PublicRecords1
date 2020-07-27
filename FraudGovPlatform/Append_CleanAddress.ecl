IMPORT FraudShared;
EXPORT Append_CleanAddress ( 
    dataset(FraudShared.Layouts.Base.Main) FileBase,
    dataset(FraudShared.Layouts.Base.Main) Previous_Build = $.Files().Base.Main_Orig.QA
) := FUNCTION
    dFileBase := DISTRIBUTE(FileBase, hash32(record_id));
    dPrevious_Build	:= DISTRIBUTE(Previous_Build, HASH32(record_id));
    // New inputs
    New_Inputs := 
        JOIN(
            dFileBase, 
            dPrevious_Build,
            left.record_id = right.record_id, 
            LEFT ONLY,
            LOCAL);       

    Old_Inputs := 
        JOIN(
            dFileBase, 
            dPrevious_Build,
            left.record_id = right.record_id, 
            RIGHT OUTER,
            LOCAL); 
            
    slim_in := Project( New_Inputs, TRANSFORM( $.Layouts.Base.AddressCache, SELF := LEFT, SELF := [] ), LOCAL );

    CleanedAddresses :=  $.mac_Append_CleanAddresses(slim_in);  

    CleanedRecs := join(
            New_Inputs, 
            CleanedAddresses, 
                LEFT.street_1 = RIGHT.street_1 and 
                LEFT.street_2 = RIGHT.street_2  and 
                LEFT.city = RIGHT.city  and  
                LEFT.state = RIGHT.state and 
                LEFT.zip = RIGHT.zip,
            TRANSFORM(FraudShared.Layouts.Base.Main, 
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

    MergeRecs := FraudGovPlatform.fn_dedup_main( Old_Inputs + CleanedRecs );
    
    return( MergeRecs );

END;