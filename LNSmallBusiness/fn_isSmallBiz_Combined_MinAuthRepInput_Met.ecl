IMPORT iesp;

EXPORT fn_isSmallBiz_Combined_MinAuthRepInput_Met ( iesp.smallbusinessanalytics.t_SBAAuthRep AuthorizedRep1,
                                                    iesp.smallbusinessanalytics.t_SBAAuthRep AuthorizedRep2,
                                                    iesp.smallbusinessanalytics.t_SBAAuthRep AuthorizedRep3
                                                  ):= 
  FUNCTION
    // If ANY Authorized Representative information is provided, the following 
    // combinations are the min requirements: 
    // The full name 
    //   OR: UniqueID   
    //   OR: Both First and Last are populated  
    // PLUS one of the following:
    //   - Auth Rep, Street Address and Zip
    //   - Auth Rep SSN
    //   - Auth Rep Street Address, City and State
    isPopulated_MinAuthRepSearchReqMet := 
      ((AuthorizedRep1.UniqueID != ''  OR
        ((AuthorizedRep1.Name.Full != '' OR
          (AuthorizedRep1.Name.First != '' AND AuthorizedRep1.Name.Last != '')) 
          AND
         (AuthorizedRep1.SSN != '' OR
          (AuthorizedRep1.Address.StreetAddress1 != '' AND AuthorizedRep1.Address.Zip5 != '' ) OR
          (AuthorizedRep1.Address.StreetAddress1 != '' AND AuthorizedRep1.Address.City != '' AND AuthorizedRep1.Address.State != '' ))
        ))
      OR 
       (AuthorizedRep2.UniqueID != ''  OR
        ((AuthorizedRep2.Name.Full != '' OR 
         (AuthorizedRep2.Name.First != '' AND AuthorizedRep2.Name.Last != '')) 
         AND
        (AuthorizedRep2.SSN != '' OR
         (AuthorizedRep2.Address.StreetAddress1 != '' AND AuthorizedRep2.Address.Zip5 != '' ) OR
         (AuthorizedRep2.Address.StreetAddress1 != '' AND AuthorizedRep2.Address.City != '' AND AuthorizedRep2.Address.State != '' ))
        ))
      OR 
       (AuthorizedRep3.UniqueID != ''  OR
        ((AuthorizedRep3.Name.Full != '' OR 
         (AuthorizedRep3.Name.First != '' AND AuthorizedRep3.Name.Last != '')) 
         AND
        (AuthorizedRep3.SSN != '' OR
         (AuthorizedRep3.Address.StreetAddress1 != '' AND AuthorizedRep3.Address.Zip5 != '' ) OR
         (AuthorizedRep3.Address.StreetAddress1 != '' AND AuthorizedRep3.Address.City != '' AND AuthorizedRep3.Address.State != ''))
        ))
     );

    RETURN isPopulated_MinAuthRepSearchReqMet;
    
  END;  // end function