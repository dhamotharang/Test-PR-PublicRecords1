IMPORT PRTE2_Neighborhood, PRTE2_Business_Risk, data_services;

EXPORT Constants := MODULE
    EXPORT KEY_PREFIX   := '~prte::key::Business_Header::';
    EXPORT dops_name    := 'BusinessHeaderKeys';
    EXPORT Bip_filename := (data_services.foreign_Prod + 'prte::key::bipv2::business_header::qa::linkids');
    EXPORT FID_FileName := (data_services.foreign_Prod + 'prte::key::ln_propertyv2::qa::assessor.fid');
    
    
    
END;