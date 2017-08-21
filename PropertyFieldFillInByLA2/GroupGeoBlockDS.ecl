// GroupGeoBlockDS.ecl RESTORED from 2011-08-01T19_16_20Z.ecl

import PropertyFieldFillinByLA2;

EXPORT GroupGeoBlockDS( dataset(PropertyFieldFillinByLA2.layouts.layout_GlinkGlinkDistNumSFDs) 
																ggd_sfds=PropertyFieldFillinByLA2.GeoLinkToGeoLinkDistanceAndSFDsCount()) 
																:= FUNCTION


min_sfds := 500;
layout_glinkglink := RECORD
  string12 geolink1;
  string12 geolink2;
  real8 distance;
  unsigned8 num_sfds1;
  unsigned8 num_sfds2;
 END;

//ggd_sfds := dataset('~thumphrey::persist::glinkglinkdistnumsfdsds',layout_glinkglink,THOR);

base_rec := RECORD
  ggd_sfds.geolink1;
  string12 geolink2:=ggd_sfds.geolink1;
  real8 distance := 0;
  ggd_sfds.num_sfds1;
  unsigned8 num_sfds2 := ggd_sfds.num_sfds1;
END;
baseGeolinkDS := 
   table(ggd_sfds
         ,base_rec
         ,geolink1
   );

groupGeoblockRec := PropertyFieldFillinByLA2.layouts.layout_groupGeoblock;
groupGeoblockRec projectToGroupGeoblockRec( layout_glinkglink r ) := TRANSFORM
   self.GlinkGroupName := r.geolink1;
   self.mem_geolink := r.geolink2;
   self := r;
END;
x := 
  project(
          sort(
               distribute(
                          ggd_sfds + baseGeolinkDS
                          , hash64(geolink1)
               )
               ,geolink1,distance,geolink2
               ,local
          )
          ,projectToGroupGeoblockRec(LEFT)
  );

groupGeoblockRec makeGeoBlockGroups( groupGeoblockRec l, groupGeoblockRec r ) := TRANSFORM
   group_county := IF(l.GlinkGroupName='','',l.GlinkGroupName[1..5]);
   new_entry_county := r.mem_geolink[1..5];
   self.total_sfds :=
      IF(l.GlinkGroupName<>r.GlinkGroupName
         , r.num_sfds2
         , IF((l.total_sfds >= min_sfds) or (group_county<>new_entry_county)
              ,skip
              ,l.total_sfds + r.num_sfds2
           )
      );
   self := r;
END;
ggb := 
  sort(
       iterate(
               sort(
                    iterate(x
                            ,makeGeoBlockGroups(LEFT,RIGHT)
                            ,local
                    )
                    , GlinkGroupName, -total_sfds
                    , local
               )
               ,transform(groupGeoblockRec
                          ,self.total_sfds :=
                                IF(left.GlinkGroupName<>RIGHT.GlinkGroupName
                                   ,right.total_sfds
                                   ,left.total_sfds
                                )
                          ,self := right;
                )
               ,local
       )
       ,GlinkGroupName,distance
       ,local
  ) : persist('~thor_data400::persist::PropertyFieldFillinByLA2::GroupGeoBlockDS');

return ggb;
END;