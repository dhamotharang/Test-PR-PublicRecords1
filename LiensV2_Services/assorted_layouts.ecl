
IMPORT address;

EXPORT assorted_layouts := MODULE
  
  SHARED unwanted_addr_fields := RECORD
    address.layout_clean182.county;
    address.layout_clean182.msa;
    STRING18 county_name;
    DATASET(liensv2_services.layout_lien_party_phone) phones{MAXCOUNT(5)};
  END;

  EXPORT matched_party_name_rec := RECORD
   LiensV2_Services.layout_lien_party_name-name_score ;
  END;
  
  EXPORT matched_party_address_rec := RECORD
   liensv2_services.layout_lien_party_address-unwanted_addr_fields ;
  END;
  
  EXPORT matched_party_rec := RECORD
    STRING1 party_type;
    matched_party_name_rec parsed_party;
    matched_party_address_rec address;
  END;



END;
