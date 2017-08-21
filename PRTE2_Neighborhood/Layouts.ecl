IMPORT PRTE2_Neighborhood, Address_Attributes, ACA, FBI_UCR;

EXPORT Layouts := MODULE

	EXPORT l_ACA	:= RECORD
		string12		geolink;
		qstring10 	geo_lat;
		qstring11 	geo_long;
		recordof(ACA.key_aca_addr);
	END;
	
	EXPORT l_neighborhoodstats	:= RECORD
		string12 geolink;
		unsigned2 neighborhood_vacant_properties;
		unsigned2 neighborhood_business_count;
		unsigned2 neighborhood_sfd_count;
		unsigned2 neighborhood_mfd_count;
		unsigned2 neighborhood_collegeaddr_count;
		unsigned2 neighborhood_seasonaladdr_count;
		unsigned4 neighborhood_pobox_count;
		unsigned2 nod;
		unsigned2 nod_1yr;
		unsigned2 nod_2yr;
		unsigned2 nod_3yr;
		unsigned2 nod_4yr;
		unsigned2 nod_5yr;
		unsigned2 foreclosures;
		unsigned2 foreclosures_1yr;
		unsigned2 foreclosures_2yr;
		unsigned2 foreclosures_3yr;
		unsigned2 foreclosures_4yr;
		unsigned2 foreclosures_5yr;
		unsigned2 deed_transfers;
		unsigned2 deed_transfers_1yr;
		unsigned2 deed_transfers_2yr;
		unsigned2 deed_transfers_3yr;
		unsigned2 deed_transfers_4yr;
		unsigned2 deed_transfers_5yr;
		unsigned2 release_lis_pendens;
		unsigned2 release_lis_pendens_1yr;
		unsigned2 release_lis_pendens_2yr;
		unsigned2 release_lis_pendens_3yr;
		unsigned2 release_lis_pendens_4yr;
		unsigned2 release_lis_pendens_5yr;
		unsigned1 liens_recent_unreleased_count;
		unsigned1 liens_historical_unreleased_count;
		unsigned1 liens_recent_released_count;
		unsigned1 liens_historical_released_count;
		unsigned1 eviction_recent_unreleased_count;
		unsigned1 eviction_historical_unreleased_count;
		unsigned1 eviction_recent_released_count;
		unsigned1 eviction_historical_released_count;
		unsigned4 occupant_owned_count;
		unsigned4 cnt_building_age;
		unsigned4 ave_building_age;
		unsigned4 cnt_purchase_amount;
		unsigned4 ave_purchase_amount;
		unsigned4 cnt_mortgage_amount;
		unsigned4 ave_mortgage_amount;
		unsigned4 cnt_assessed_amount;
		unsigned4 ave_assessed_amount;
		unsigned8 cnt_building_area;
		unsigned8 ave_building_area;
		unsigned8 cnt_price_per_sf;
		unsigned8 ave_price_per_sf;
		unsigned8 cnt_no_of_buildings_count;
		unsigned8 ave_no_of_buildings_count;
		unsigned8 cnt_no_of_stories_count;
		unsigned8 ave_no_of_stories_count;
		unsigned8 cnt_no_of_rooms_count;
		unsigned8 ave_no_of_rooms_count;
		unsigned8 cnt_no_of_bedrooms_count;
		unsigned8 ave_no_of_bedrooms_count;
		unsigned8 cnt_no_of_baths_count;
		unsigned8 ave_no_of_baths_count;
		unsigned8 cnt_no_of_partial_baths_count;
		unsigned8 ave_no_of_partial_baths_count;
		unsigned4 total_property_count;
		unsigned1 bk_cnt;
		unsigned1 bk_1yr;
		unsigned1 bk_2yr;
		unsigned1 bk_3yr;
		unsigned1 bk_4yr;
		unsigned1 bk_5yr;
		unsigned1 bk_ch7_cnt;
		unsigned1 bk_ch11_cnt;
		unsigned1 bk_ch12_cnt;
		unsigned1 bk_ch13_cnt;
		unsigned1 bk_discharged_cnt;
		unsigned1 bk_dismissed_cnt;
		unsigned1 bk_pro_se_cnt;
		unsigned1 bk_business_flag_cnt;
		unsigned1 bk_corp_flag_cnt;
	END;
	
	EXPORT l_business	:= RECORD
		unsigned6		rcid	:= 0;
		unsigned6		bdid	:= 0;
		string2  		source;
		qstring34		source_group;
		string3  		pflag;
		unsigned6		group1_id	:= 0;
		qstring34 	vendor_id;
		unsigned4 	dt_first_seen;
		unsigned4 	dt_last_seen;
		unsigned4 	dt_vendor_first_reported;
		unsigned4 	dt_vendor_last_reported;
		qstring120 	company_name;
		qstring10 	prim_range;
		string2   	predir;
		qstring28 	prim_name;
		qstring4  	addr_suffix;
		string2   	postdir;
		qstring5  	unit_desig;
		qstring8  	sec_range;
		qstring25 	city;
		string2   	state;
		unsigned3 	zip;
		unsigned2 	zip4;
		string3   	county;
		string4   	msa;
		qstring10 	geo_lat;
		qstring11 	geo_long;
		unsigned6 	phone;
		unsigned2 	phone_score	:= 0;
		unsigned4 	fein := 0;
		boolean   	current;
		boolean	  	dppa;
		string7			geo_blk;
		string12		geolink;
		string1			geo_match;
	END;
	
	EXPORT l_Fbi_cius	:= RECORD
		FBI_UCR.layouts.layout_CIUS_city;
	END;
	
	EXPORT l_GeoLinkDistance	:= RECORD
		string12 geolink1;
		string12 geolink2;
		unsigned2 dist_100th;
	END;
	
	EXPORT l_geoblk_latlon	:= RECORD
		qstring12 geolink;
		integer4 lat1000;
		real4 lat;
		real4 lon;
	END;
	
	EXPORT l_GeoblkInfo	:= RECORD
		string12 geolink;
		string10 lat;
		string11 long;
	END;
	
END;