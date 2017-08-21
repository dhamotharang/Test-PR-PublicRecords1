// NumberOfSingleFamilyDwellingsByGeolink.ecl
import advo;
ADVO_BASE := advo.Key_Addr1(Address_Type = '1', Residential_or_Business_Ind = 'A');

geolink_rec := RECORD
   string12 geolink := ADVO_BASE.st+ADVO_BASE.county+ADVO_BASE.geo_blk;
   unsigned num_sfds := count(group)
END;

EXPORT NumberOfSingleFamilyDwellingsByGeolink :=
   table(ADVO_BASE
         , geolink_rec
         , st+county+geo_blk
   ) : persist('~thor_data400::persist::PropertyFieldFillinByLA2::NumberOfSingleFamilyDwellingsByGeolink');
