IMPORT PRTE2_Neighborhood, data_services;

EXPORT Constants := MODULE
    EXPORT KEY_PREFIX   := '~prte::key::neighborhood::';
    EXPORT dops_name    := 'NeighborhoodKeys';
    EXPORT Bip_filename := (data_services.foreign_Prod + 'prte::key::bipv2::business_header::qa::linkids');
END;