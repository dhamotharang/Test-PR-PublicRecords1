
import FCRA,sshah,ln_propertyv2;

/* layout_name := RECORD
      qstring20 fname;
      qstring20 lname;
     END;
   
   unsigned2 max_embedded := 100;
   
   layout_fares := RECORD
      string12 ln_fare_id;
     END;
*/

/* RECORD
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
     DATASET(layout_name) buyers{maxcount(max_embedded)};
     DATASET(layout_name) sellers{maxcount(max_embedded)};
     DATASET(layout_fares) fares{maxcount(max_embedded)};
     unsigned8 __internal_fpos__;
    END;
*/
 
 
/*  layout_key_out := RECORD
    
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
    // DATASET(layout_name) buyers{maxcount(max_embedded)};
     qstring20 buyers_fname;
      qstring20 buyers_lname;
    
     //DATASET(layout_name) sellers{maxcount(max_embedded)};
   	qstring20 seller_fname;
      qstring20 seller_lname;
     //DATASET(layout_fares) fares{maxcount(max_embedded)};
   	string12 fares_ln_fare_id;
   	
     //unsigned8 __internal_fpos__;
    END;
    Key_in :=ln_propertyv2.Key_Prop_Address_FCRA_V4;
    layout_key_out makerecord (key_in L) := transform
    self.prim_range:=l.prim_range;
    self.prim_name:=l.prim_name;
   self.sec_range:=l.sec_range;
   self.zip:=l.zip;
   self.suffix:=l.suffix;
   self.predir:=l.predir;
   self.postdir:=l.postdir;
   self.roll_count:=l.roll_count;
   self.ad:=l.ad;
   self.occupant_owned:=l.occupant_owned;
   self.purchase_date:=l.purchase_date;
   self.built_date:=l.built_date;
   self.purchase_amount:=l.purchase_amount;
   self.mortgage_amount:=l.mortgage_amount;
   self.mortgage_date:=l.mortgage_date;
   self.mortgage_type:=l.mortgage_type;
   self.type_financing:=l.type_financing;
   self.first_td_due_date:=l.first_td_due_date;
   self.assessed_amount:=l.assessed_amount;
   self.assessed_total_value:=l.assessed_total_value;
   self.property_count:=l.property_count;
   self.property_total:=l.property_total;
   self.property_owned_purchase_total:=l.property_owned_purchase_total;
   self.property_owned_purchase_count:=l.property_owned_purchase_count;
   self.property_owned_assessed_total:=l.property_owned_assessed_total;
   self.property_owned_assessed_count:=l.property_owned_assessed_count;
   self.date_first_seen:=l.date_first_seen;
   self.date_last_seen:=l.date_last_seen;
   self.standardized_land_use_code:=l.standardized_land_use_code;
   self.building_area:=l.building_area;
   self.no_of_buildings:=l.no_of_buildings;
   self.no_of_stories:=l.no_of_stories;
   self.no_of_rooms:=l.no_of_rooms;
   self.no_of_bedrooms:=l.no_of_bedrooms;
   self.no_of_baths:=l.no_of_baths;
   self.no_of_partial_baths:=l.no_of_partial_baths;
   self.garage_type_code:=l.garage_type_code;
   self.parking_no_of_cars:=l.parking_no_of_cars;
   self.style_code:=l.style_code;
   self.assessed_value_year:=l.assessed_value_year;
   self.ln_fares_id:=l.ln_fares_id;
   self.unit_desig:=l.unit_desig;
   self.p_city_name:=l.p_city_name;
   self.st:=l.st;
   self.zip4:=l.zip4;
   self.county:=l.county;
   self.geo_blk:=l.geo_blk;
   self.buyers_fname:=l.buyers.fname;
   self.buyers_lname:=l.buyers.lname;
   self.seller_fname:=l.sellers.fname;
   self.seller_lname:=l.sellers.lname;
   self.fares_ln_fare_id:=l.fares.ln_fare_id;
   end;
   
   EXPORT file_FCRA_Keys1_prop_Address := project(key_in,makerecord(left));
   
*/

key_in := ln_propertyv2.Key_Prop_Address_FCRA_V4 ;



layout_Keys_out := RECORD
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
  qstring20 buyer_fname;
   qstring20 buyer_lname;
   qstring20 sellers_fname;
   qstring20 sellers_lname;
   string12 ln_fare_id;

  
end;




 layout_Keys_out makekey (key_in l) := transform
self := l;
self.buyer_fname := 'Buyers First Name';
self.buyer_lname := 'Buyers Last Name';
self.sellers_fname := 'Sellers First Name';
self.sellers_lname := 'Sellers Last Name';
self.ln_fare_id    := 'Fares ID';
end;

EXPORT file_FCRA_Keys1:=project(key_in,makekey(left));
//end;
//output(Key_out);


