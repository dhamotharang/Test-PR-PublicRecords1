import doxie, ln_propertyv2, advo,data_services;

prop_stats_rec := RECORD
  string12 geolink;
  unsigned4 ave_occupant_owned;
  unsigned4 cnt_occupant_owned;
  unsigned4 ave_building_age;
  unsigned4 cnt_building_age;
  unsigned4 ave_purchase_amount;
  unsigned4 cnt_purchase_amount;
  unsigned4 ave_purchase_age;
  unsigned4 cnt_purchase_age;
  unsigned4 ave_mortgage_amount;
  unsigned4 cnt_mortgage_amount;
  unsigned4 ave_mortgage_age;
  unsigned4 cnt_mortgage_age;
  unsigned4 ave_assessed_amount;
  unsigned4 cnt_assessed_amount;
  unsigned8 ave_building_area;
  unsigned8 cnt_building_area;
  unsigned8 ave_price_per_sf;
  unsigned8 cnt_price_per_sf;
  unsigned8 ave_no_of_buildings_count;
  unsigned8 cnt_no_of_buildings_count;
  unsigned8 ave_no_of_stories_count;
  unsigned8 cnt_no_of_stories_count;
  unsigned8 ave_no_of_rooms_count;
  unsigned8 cnt_no_of_rooms_count;
  unsigned8 ave_no_of_bedrooms_count;
  unsigned8 cnt_no_of_bedrooms_count;
  unsigned8 ave_no_of_baths_count;
  unsigned8 cnt_no_of_baths_count;
  unsigned8 ave_no_of_partial_baths_count;
  unsigned8 cnt_no_of_partial_baths_count;
  unsigned4 ave_parking_no_of_cars;
  unsigned4 cnt_parking_no_of_cars;
  unsigned4 total_property_count;
 END;

// prop_stats := dataset(data_services.data_location.prefix() + 'thor400_88_staging::temp::ln_propertyv2_neighborhood_stats', prop_stats_rec, thor);
prop_stats := ln_propertyv2.NeighborhoodStats;

advo_stats_rec := RECORD
  string12 geolink;
  unsigned2 neighborhood_vacant_properties;
  unsigned2 neighborhood_business_count;
  unsigned2 neighborhood_sfd_count;
  unsigned2 neighborhood_mfd_count;
  unsigned2 neighborhood_collegeaddr_count;
  unsigned2 neighborhood_seasonaladdr_count;
  unsigned4 neighborhood_property_count;
 END;
 
// advo_stats := dataset(data_services.data_location.prefix() + 'thor400_88_staging::temp::advo_neighborhood_stats', advo_stats_rec, thor);
advo_stats := advo.NeighborhoodStats;

combined := record
	prop_stats_rec;
	advo_stats_rec - geolink; // geolink already in prop_stats layout
end;

j := join(prop_stats, advo_stats, left.geolink=right.geolink, 
		transform(combined, self.geolink := if(left.geolink='', right.geolink, left.geolink),
												self := left, 
												self := right), full outer);


export Key_Neighborhood_Stats_geolink := index(j,{geolink},{j},
																	data_services.data_location.prefix() + 'thor_data400::key::advo::'+doxie.Version_SuperKey+'::geolink');
																	