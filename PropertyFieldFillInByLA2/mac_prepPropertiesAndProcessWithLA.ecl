import PropertyFieldFillInByLA2;

/* 
  EXAMPLE EXECUTION OF LA.
    set_debug := 1;
    SomeStates := ['NY'];
    StatesLabel := 'NY';
    in_version := '20110729';
    mac_prepPropertiesAndProcessWithLA(in_version, SomeStates, StatesLabel, FilledInVars_NY_ADVO_BASE_with_Hedonics);
    output(count(FilledInVars_NY_ADVO_BASE_with_Hedonics),named('size_of_FilledInVars_NY_ADVO_BASE_with_Hedonics'));
*/
EXPORT mac_prepPropertiesAndProcessWithLA(
                                          in_version
                                          , SomeStates
                                          , StatesLabel
                                          , FilledInVars_ADVO_BASE_with_Hedonics
       ) := MACRO
			 

PersistFilename := '~thor_data400::persist::PropertyFieldFillInByLA2::getSingleResidentProperitiesWithHedonicData::'+StatesLabel;

ADVO_BASE_with_Hedonics:=PropertyFieldFillInByLA2.getSingleResidentProperitiesWithHedonicData(SomeStates, PersistFilename);
// PropertyFieldFillInByLA2.getSingleResidentProperitiesWithHedonicData(SomeStates, PersistFilename,ADVO_BASE_with_Hedonics );

// rLayout :=
// RECORD
  // unsigned8 seqno;
  // string12 geolink;
  // unsigned8 rawaid;
  // unsigned8 cleanaid;
  // string10 prim_range;
  // string2 predir;
  // string28 prim_name;
  // string4 addr_suffix;
  // string2 postdir;
  // string10 unit_desig;
  // string8 sec_range;
  // string25 p_city_name;
  // string25 v_city_name;
  // string2 st;
  // string5 zip;
  // string4 zip4;
  // string2 fips_county;
  // string3 county;
  // string10 geo_lat;
  // string11 geo_long;
  // string4 msa;
  // string7 geo_blk;
  // string1 geo_match;
  // string4 standardized_land_use_code;
  // string3 property_type_code;
  // unsigned4 buildingage;
  // unsigned4 assessedamount;
  // unsigned8 buildingarea;
  // real8 stories;
  // unsigned8 rooms;
  // unsigned8 bedrooms;
  // real8 baths;
  // unsigned4 fireplaces;
  // unsigned4 garage;
  // unsigned4 construction_type;
  // unsigned4 exterior_walls;
  // unsigned4 foundation;
  // unsigned4 roof_cover;
  // unsigned4 heating;
  // unsigned4 fuel_type;
  // unsigned4 air_conditioning_type;
  // unsigned4 floor_cover;
  // unsigned8 garage_sqft;
  // unsigned8 basement_sqft;
  // unsigned4 basement;
  // unsigned4 water;
  // unsigned4 sewer;
  // unsigned4 style;
  // unsigned4 pool;
 // END;

// ADVO_BASE_with_Hedonics:= '~thor_data400::temp::propertyfieldfillinbyla2::advobasewithhedonics', rLayout, thor);

UniqueIdWithPropertyRec := RECORD
  unsigned seqno := 0;
  recordof(ADVO_BASE_with_Hedonics)
END;

UniqueIdWithPropertyRec makeUniquePropertyID( UniqueIdWithPropertyRec l, UniqueIdWithPropertyRec r ) := TRANSFORM
   seqno :=
      IF( l.geolink <> r.geolink
          , 1
          , l.seqno+1
      );
   self.seqno := seqno;
   self.cleanaid := r.cleanaid;
   self := r;
   
END;

UniqueIdWithInPropertyDS :=
  iterate(
          sort(
               distribute(
                          project(ADVO_BASE_with_Hedonics, UniqueIdWithPropertyRec)
                          ,hash64(geolink)
               )
               ,geolink
               ,local
          )
          ,makeUniquePropertyID(LEFT,RIGHT)
          ,local
  );

layout_PropertyFillInVariables := PropertyFieldFillInByLA2.layout_PropertyFillInVariables;

//integer set_debug := 0 : stored('my_debug');
// /*
pversion := in_version + '_' + StatesLabel;
PropertyFieldFillInByLA2.mac_fillinPropertyVariables(pversion 
                                                    ,UniqueIdWithInPropertyDS
                                                    ,UniqueIdWithInPropertyDS
                                                    ,FilledInVars_ADVO_BASE_with_Hedonics
                                                   );
// */

LAFilledIn_Filename := '~thor_data400::base::PropertyFieldFillinByLA2::'+in_version+'::FilledInVars_ADVO_BASE_with_Hedonics';
output(FilledInVars_ADVO_BASE_with_Hedonics,,LAFilledIn_Filename,compressed,OVERWRITE);

ENDMACRO;
