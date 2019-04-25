import ut, doxie;

isFCRA := false;
rolled_props := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA);

Key_Prop_Address_V4 := 
										index (rolled_props(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID),
													 {prim_range, prim_name, sec_range, zip, suffix, predir, postdir},
													 {rolled_props},
													 '~thor_data400::key::ln_propertyv2::' + 20170310 + '::addr.full_v4');


//ds := index(dataset([],layout),{prim_range,prim_name,sec_range,zip,suffix,predir,postdir },{layout -{prim_range, prim_name,sec_range, zip, suffix,predir,postdir}},'~thor_data400::key::ln_propertyv2::20170310::addr.full_v4');

ds := pull ( Key_Prop_Address_V4());
output(choosen(ds,1000));

Key_Prop_Address_V4_old := 
										index (rolled_props(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID),
													 {prim_range, prim_name, sec_range, zip, suffix, predir, postdir},
													 {rolled_props},
													 '~thor_data400::key::ln_propertyv2::' + 20170302 + '::addr.full_v4');

//ds := index(dataset([],layout),{prim_range,prim_name,sec_range,zip,suffix,predir,postdir },{layout -{prim_range, prim_name,sec_range, zip, suffix,predir,postdir}},'~thor_data400::key::ln_propertyv2::20170310::addr.full_v4');

ds_old := pull ( Key_Prop_Address_V4_old());
output(choosen(ds_old,1000));

layout_name := RECORD
   qstring20 fname;
   qstring20 lname;
  END;

layout_fares := RECORD
   string12 ln_fare_id;
  END;

lay := RECORD
  string10 prim_range;
  string28 prim_name;
  string8 sec_range;
  string5 zip;
  string4 suffix;
  string2 predir;
  string2 postdir;
  unsigned1 roll_count;
  string1 ad;
  boolean occupant_owned;
  unsigned4 purchase_date;
  unsigned4 built_date;
  unsigned4 purchase_amount;
  unsigned4 mortgage_amount;
  unsigned4 mortgage_date;
  string5 mortgage_type;
  string4 type_financing;
  string8 first_td_due_date;
  unsigned4 assessed_amount;
  unsigned4 assessed_total_value;
  unsigned1 property_count;
  unsigned1 property_total;
  unsigned5 property_owned_purchase_total;
  unsigned2 property_owned_purchase_count;
  unsigned5 property_owned_assessed_total;
  unsigned2 property_owned_assessed_count;
  unsigned4 date_first_seen;
  unsigned4 date_last_seen;
  string standardized_land_use_code;
  unsigned8 building_area;
  unsigned8 no_of_buildings;
  unsigned8 no_of_stories;
  unsigned8 no_of_rooms;
  unsigned8 no_of_bedrooms;
  unsigned8 no_of_baths;
  unsigned8 no_of_partial_baths;
  string garage_type_code;
  unsigned8 parking_no_of_cars;
  string style_code;
  string4 assessed_value_year;
  string12 ln_fares_id;
  string10 unit_desig;
  string25 p_city_name;
  string2 st;
  string4 zip4;
  string3 county;
  string7 geo_blk;
  DATASET(layout_name) buyers{maxcount(100)};
  DATASET(layout_name) sellers{maxcount(100)};
  DATASET(layout_fares) fares{maxcount(100)};
  unsigned8 __internal_fpos__;
 END;


// join_lay := RECORD
	// lay results;
// END;


// cmpr := record, maxlength(50000)
	// DATASET(join_lay) res;
// end;

ds_clean_new := project(ds, transform(lay, self := left; self := [])); 
ds_clean_old := project(ds_old, transform(lay, self := left; self := [])); 


COUNT(ds);
COUNT(ds_old);

ds_diff        := JOIN(ds_clean_new, ds_clean_old, 
										LEFT.prim_range = RIGHT.prim_range 
										and LEFT.prim_name = RIGHT.prim_name 
										and LEFT.sec_range = RIGHT.sec_range 
										and LEFT.zip = RIGHT.zip 
										and LEFT.suffix = RIGHT.suffix 
										and LEFT.predir = RIGHT.predir 
										and LEFT.postdir = RIGHT.postdir 
										and LEFT.buyers <> RIGHT.buyers 
										and left.sellers <> right.sellers
										and left.fares <> right.fares,
									transform({dataset(lay) res}, self.res := left + right));
									// TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
ds_diff;

all_match        := JOIN(ds, ds_old, LEFT = RIGHT);
left_only_match  := JOIN(ds, ds_old, LEFT = RIGHT, LEFT ONLY);
right_only_match := JOIN(ds, ds_old, LEFT = RIGHT, RIGHT ONLY);

all_match;
left_only_match;
right_only_match;