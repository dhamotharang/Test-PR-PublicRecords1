// mac_replacePropertyGeolinkWithGlinkGroupName.ecl
/*
   IMPORTANT NOTE: 
   
   THIS ONLY WORKS WHEN THE INPUTTED DATASET, Properties, HAS ALL THE SFDs FOR EVERY STATE WITH AT
   LEAST ONE SFD IN THE INPUTTED DATASET.
   
   Here is what this MACRO is suppose to do:
   
   1. Make a dataset that is a list of all the geoblocks in the inputted properties (Properties).
      The result should be one record for each different geoblock in Properties and ONLY one.

   2. Make a dataset that contains a) all GlinkGroupsDS records that have a mem_geolink that is the
      same as one of the geolinks in the list created by step 1, and b) all geoblocks
      in the list created by step 1 that match NO mem_geolink of any record of GlinkGroupsDS.
      In addition, the above dataset must be deduped on  GlinkGroupName since the JOIN that creates
      it can result in two or more records with the same GlinkGroupName.

   3. Make a dataset that contains: a) all GlinkGroupsDS records that have a GlinkGroupName in the
      dataset created in step 2, and b) all records of the dataset created in step 2 that have no
      GlinkGroupName in GlinkGroupsDS.
      
      (NOTE. The dataset created by step 3 should contain only ONE record for each GlinkGroupName,
       mem_geolink combo.)

   4. Make a dataset whose record layout is recordof(Properties) and where the resultant dataset has
      a record for each property record whose geolink matches a mem_geolink of the dataset created in 
      step 3. Plus, the resultant dataset has GlinkGroupName as geolink and mem_geolink as ogeolink.

*/
EXPORT mac_replacePropertyGeolinkWithGlinkGroupName( 
            Properties
            ,WithGroupGlink_PropertiesDS
            ,GlinkGroupsDS='PropertyFieldFillinByLA2.GroupGeoBlockDS()'
       ) := MACRO


Properties_dedup :=
dedup(
				sort(
               distribute(
                          Properties
                        , hash64(geolink)
                      )
                      , geolink
                      , local
                 )
                 , geolink
                 , local
           );


temp_layout := RECORD
  string12 GlinkGroupName;
  string12 mem_geolink;
  string1 InGlinkGroup := '';
END;

temp_layout projectToGlinkGroupRec( recordof(Properties_dedup) rght ) := TRANSFORM
   self.GlinkGroupName := rght.geolink;
   self.mem_geolink := rght.geolink;
END;

/*
   1. Make a dataset that is a list of all the geoblocks in the inputted properties (Properties).
      The result should be one record for each different geoblock.
*/

ListOfGeolinksInProperties := project(Properties_dedup, projectToGlinkGroupRec(LEFT));
// ListOfGeolinksInProperties :=
   // project(
           // dedup(
                 // sort(
                      // distribute(
                                 // Properties
                                 // , hash64(geolink)
                      // )
                      // , geolink
                      // , local
                 // )
                 // , geolink
                 // , local
           // )
           // , projectToGlinkGroupRec(LEFT)
   // );
output(count(ListOfGeolinksInProperties),named('n_geolinks_before_mac_replace'));


GlinkGroupsDS_dist := distribute(GlinkGroupsDS, hash64(mem_geolink));
ListOfGeolinksInProperties_dist := distribute(ListOfGeolinksInProperties,hash64(mem_geolink));

temp_layout getGlinkGroups( recordof(GlinkGroupsDS_dist) lft, temp_layout rght ) := TRANSFORM
   self.InGlinkGroup := IF(lft.GlinkGroupName='','N','Y');
   self.GlinkGroupName := IF(lft.GlinkGroupName='',rght.GlinkGroupName,lft.GlinkGroupName);
   self.mem_geolink := IF(lft.mem_geolink='',rght.mem_geolink,lft.mem_geolink);
END;

/*=================================================================================================
   2. Make a dataset that contains a) all GlinkGroupsDS records that have a mem_geolink that is the
      same as one of the geolinks in the list created by step 1, and b) all geolinks
      in the list created by step 1 that match NO mem_geolink of any record of GlinkGroupsDS.
      In addition, the above dataset must be deduped on  GlinkGroupName since the JOIN that creates
      it can result in two or more records with the same GlinkGroupName.
*/
x :=
   dedup(
          sort(
               distribute(
                          join(GlinkGroupsDS_dist, ListOfGeolinksInProperties_dist
                               // distribute(GlinkGroupsDS, hash64(mem_geolink))
                               // , distribute(ListOfGeolinksInProperties,hash64(mem_geolink))
                               , left.mem_geolink=right.mem_geolink
															 , getGlinkGroups(LEFT,RIGHT)
                               , RIGHT OUTER
                               , local
                          )
                          ,hash64(GlinkGroupName)
               )
               ,GlinkGroupName
               ,local
          )
          ,GlinkGroupName
          ,local
   );

GeolinksInBothPropertiesAndGlinkGroups := x(InGlinkGroup='Y');
GeolinksInPropertiesNotGlinkGroups := x(InGlinkGroup='N');
output(GeolinksInBothPropertiesAndGlinkGroups,,'~thor_data400::temp::PropertyFieldFillinByLA2::GlinkGroups',OVERWRITE);
output(GeolinksInPropertiesNotGlinkGroups,,'~thor_data400::temp::PropertyFieldFillinByLA2::NotGlinkGroups',OVERWRITE);


/*=================================================================================================
   3. Make a dataset that contains: a) all GlinkGroupsDS records that have a GlinkGroupName in the
      dataset created in step 2, i.e. GeolinksInBothPropertiesAndGlinkGroups, and b) all records of
      the dataset created by step 2 that have no GlinkGroupName in GlinkGroupsDS, that is,
      GeolinksInPropertiesNotGlinkGroups.
*/

AllMembersOfAllGlinkGroupsWithAMemberGeolinkInProperties := 
   dedup(
         sort(
              join(
                   distribute(GlinkGroupsDS_dist, hash64(GlinkGroupName))
                   ,distribute(GeolinksInBothPropertiesAndGlinkGroups, hash64(GlinkGroupName))
                   ,(left.GlinkGroupName=right.GlinkGroupName)
                   ,getGlinkGroups(left,right)
                   ,local
              )
              ,GlinkGroupName,mem_geolink
              ,local
         )
         ,GlinkGroupName,mem_geolink
         ,local
   ) + GeolinksInPropertiesNotGlinkGroups;


recordof(Properties) replacePropertyGeolinkWithGroupGeolink( recordof(Properties) lft, temp_layout rght ) := TRANSFORM
   self.ogeolink := lft.geolink;
   // self.geolink := rght.GlinkGroupName;
	 self.geolink := lft.geolink;
   self := lft;
END;

/*=================================================================================================
   4. Make a dataset whose record layout is recordof(Properties) and where the resultant dataset has
      a record for each property record whose geolink matches a mem_geolink of the dataset created in 
      step 3. Plus, the resultant dataset has GlinkGroupName as geolink and mem_geolink as ogeolink.

*/
WithGroupGlink_PropertiesDS := 
dedup(
		sort(
				distribute(
									join( 
                     distribute(Properties,hash64(geolink)) 
                     ,distribute(AllMembersOfAllGlinkGroupsWithAMemberGeolinkInProperties, hash64(mem_geolink))
                     ,LEFT.geolink=RIGHT.mem_geolink
                     ,replacePropertyGeolinkWithGroupGeolink(LEFT,RIGHT)
                     ,local
											)
										,hash64(geolink,cleanaid)
									)
					,geolink,cleanaid
					,local
				)
		  ,RECORD		
);
// output(AllMembersOfAllGlinkGroupsWithAMemberGeolinkInProperties,,'~thor_data400::temp::PropertyFieldFillinByLA2::WithGroupGlink_propertiesDS',OVERWRITE);
output(WithGroupGlink_PropertiesDS,,'~thor_data400::temp::PropertyFieldFillinByLA2::WithGroupGlink_PropertiesDS',OVERWRITE);
ENDMACRO;
