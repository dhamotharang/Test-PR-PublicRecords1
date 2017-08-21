// GeoLinkToGeoLinkDistanceAndSFDsCount.ecl
import AddrFraud,PropertyFieldFillinByLA2;
EXPORT GeoLinkToGeoLinkDistanceAndSFDsCount(
                  dataset(recordof(AddrFraud.Key_Distance_GeoLinkToGeoLink)) Geolink2GeolinkDistance=AddrFraud.Key_Distance_GeoLinkToGeoLink
                  , dataset(recordof(PropertyFieldFillinByLA2.NumberOfSingleFamilyDwellingsByGeolink)) NumberOfSFDsByGeolink=PropertyFieldFillinByLA2.NumberOfSingleFamilyDwellingsByGeolink
) := FUNCTION
GlinkGlinkDist_rec := RECORD
  string12 geolink1;
  string12 geolink2;
  real distance;
END;

sortedby_geolink2_Distance_GeoLinkToGeoLink := 
   sort(
        distribute(
              project(
                      Geolink2GeolinkDistance
                      ,GlinkGlinkDist_rec
              )
              ,hash64(geolink2)
        )
        ,geolink2
        ,local
   );
//output(sortedby_geolink2_Distance_GeoLinkToGeoLink,named('sortedby_geolink2_Distance_GeoLinkToGeoLink'));

geolink_rec := RECORD
   string12 geolink;
   unsigned num_sfds;
END;

NumberOfSFDsForEachGeolink := 
   sort(
             distribute(
                   NumberOfSFDsByGeolink
                   ,hash64(geolink)
        )
        ,geolink
        ,local
   );
// output(NumberOfSFDsForEachGeolink,named('NumberOfSFDsForEachGeolink'));

GlinkGlinkDistNumSFDs_rec := PropertyFieldFillinByLA2.layouts.layout_GlinkGlinkDistNumSFDs;

GlinkGlinkDistNumSFDs_rec addNumSFDs1ToGeolinkToGeolinkWithDistance( GlinkGlinkDistNumSFDs_rec l, geolink_rec r ) := TRANSFORM
   self.num_sfds1 := r.num_sfds;
   self := l;
END;
   
GlinkGlinkDistNumSFDs_rec addNumSFDs2ToGeolinkToGeolinkWithDistance( GlinkGlinkDist_rec l, geolink_rec r ) := TRANSFORM
   self.num_sfds2 := r.num_sfds;
   self := l;
END;

GlinkGlinkDistNumSFDsDS :=
 join(
      sort(
           distribute(
                      join(
                           sortedby_geolink2_Distance_GeoLinkToGeoLink
                           , NumberOfSFDsForEachGeolink
                           , left.geolink2=right.geolink
                           , addNumSFDs2ToGeolinkToGeolinkWithDistance(LEFT,RIGHT)
                           , local
                      )
                      ,hash64(geolink1)
           )
           ,geolink1,distance
           ,local
      )
      , NumberOfSFDsForEachGeolink
      , left.geolink1=right.geolink
      , addNumSFDs1ToGeolinkToGeolinkWithDistance(LEFT,RIGHT)
      , local
 ) : persist('~thor_data400::persist::PropertyFieldFillinByLA2::GeoLinkToGeoLinkDistanceAndSFDsCount');

//output(count(GlinkGlinkDistNumSFDsDS),named('size_of_GlinkGlinkDistNumSFDsDS'));
//output(GlinkGlinkDistNumSFDsDS,named('GlinkGlinkDistNumSFDsDS'));
return GlinkGlinkDistNumSFDsDS;
END;