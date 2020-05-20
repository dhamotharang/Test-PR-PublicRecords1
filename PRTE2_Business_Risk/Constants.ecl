IMPORT PRTE2_Neighborhood, data_services;

EXPORT Constants := MODULE
    EXPORT KEY_PREFIX   := '~prte::key::Business_Header::';
    EXPORT dops_name    := 'BusinessHeaderKeys';
    // EXPORT Bip_filename := (data_services.foreign_Prod + 'prte::key::bipv2::business_header::qa::linkids');
    EXPORT Bip_filename := (data_services.foreign_Prod + 'prte::key::bipv2::business_header::20200427::linkids');
    
    
    
END;