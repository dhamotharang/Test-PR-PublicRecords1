/*
  Collection of constant values and types for BIPV2 keys
*/
EXPORT Constants := MODULE
  // Common key prefix for BIPV2 keys. Foreign calls should be handled when declaring each index
  EXPORT str_key_prefix := '~key::bipv2::business_header';

  // Common fetch limit for BIP keys
  EXPORT fetch_limit := 10000;
END;