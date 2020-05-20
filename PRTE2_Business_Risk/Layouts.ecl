
EXPORT layouts := MODULE

               export address_siccode := record 
                       string5 z5;
                       string28 prim_name;
                       string4 suffix;
                       string2 predir;
                       string2 postdir;
                       string10 prim_range;
                       string8 sec_range;
                       string8 sic_code;
                       string2 source;
               end;
               
               export Business_Risk_bdid := RECORD
                       unsigned8 bdid;
                       qstring5 zip;
                       qstring10 prim_range;
                       qstring28 prim_name;
                       qstring4 addr_suffix;
                       string2 predir;
                       string2 postdir;
                       qstring5 unit_desig;
                       qstring8 sec_range;
                       qstring25 city;
                       string2 state;
                       string5 zip4;
                       string7 geo_blk;
                       string13 geolink;
                       string7 streetlink;
                       string3 pflag;
                       unsigned4 dt_first_seen;
                       unsigned4 dt_last_seen;
                       string3 county;
                       string4 msa;
                       qstring10 geo_lat;
                       qstring11 geo_long;
                       boolean current;
                       string2 source;
                       qstring81 match_company_name;
                       qstring20 match_branch_unit;
                       qstring25 match_geo_city;
                       integer4 business_count;
                       integer4 legal_srv_cnt;
                       integer4 hr_biz_cnt;
                       boolean incorp_srv;
                       boolean credit_rpr_srv;
                       boolean hr_drug_trfc_zip;
                       string1 address_type;
                       string1 mixed_address_usage;
                       string1 residential_or_business_ind;
                       string1 dnd_indicator;
                       string1 address_style_flag;
                       string1 owgm_indicator;
                       string1 drop_indicator;
                       boolean deliverable;
                       boolean occupant_owned;
                       unsigned1 property_count;
                       unsigned1 property_total;
                       string standardized_land_use_code;
                       unsigned8 building_area;
                       unsigned8 no_of_buildings;
                       unsigned8 no_of_stories;
                       unsigned8 no_of_rooms;
                       unsigned8 no_of_bedrooms;
                       integer4 undel_sec_range;
                       integer4 undel_bus_sec_range;
                       integer4 num_undel_sec_ranges;
                       real8 bdid_to_sqft_ratio;
                       boolean prop_sfd;
                       boolean potential_shelf_address;
                       boolean potential_shell_address;
               end;
               
               export hri_address_siccode := RECORD
                       string5 z5;
                       string28 prim_name;
                       string4 suffix;
                       string2 predir;
                       string2 postdir;
                       string10 prim_range;
                       string8 sec_range;
                       string8 sic_code;
                       string2 source;
               end;
               
               export hri_address := RECORD
                       string5 z5;
                       string28 prim_name;
                       string4 suffix;
                       string2 predir;
                       string2 postdir;
                       string10 prim_range;
                       string8 sec_range;
                       unsigned3 dt_first_seen;
                       string4 sic_code;
                       string120 company_name;
                       string25 city;
                       string2 state;
                       string2 source;
               end;
               
               export hri_sic := RECORD
                       string4 sic_code;
                       string5 z5;
                       string10 lat;
                       string11 long;
                       string10 prim_range;
                       string2 predir;
                       string28 prim_name;
                       string4 suffix;
                       string2 postdir;
                       string5 unit_desig;
                       string8 sec_range;
                       string25 city;
                       string2 state;
                       string4 z4;
                       unsigned8 bdid;
                       string2 source;
               end;
               
END;
