
import address;

export assorted_layouts := MODULE
	
	shared unwanted_addr_fields := record
		  address.layout_clean182.county;
			address.layout_clean182.msa;
			string18 county_name;
			dataset(liensv2_services.layout_lien_party_phone) phones{maxcount(5)};
	end;

	export matched_party_name_rec := RECORD
	 LiensV2_Services.layout_lien_party_name-name_score ;
	END;
	
	export matched_party_address_rec := RECORD
	 liensv2_services.layout_lien_party_address-unwanted_addr_fields ;
	END;
	
	export matched_party_rec := record
	  string1 party_type;
		matched_party_name_rec parsed_party;
		matched_party_address_rec  address;
	end;



END;