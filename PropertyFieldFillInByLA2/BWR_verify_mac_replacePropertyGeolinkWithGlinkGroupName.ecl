// BWR_verify_mac_replacePropertyGeolinkWithGlinkGroupName.ecl
import PropertyFieldFillInByLA2;
/* ================================================================================================
This code has two parts. First geolinks having few SFDs (less 500) are replaced with geo-groups
and 2ndly, the geo-groups that are substituted for geolinks are verified (II below).

The output of this BWR is to the workunit and is evidence that the replacement of geolinks with
group geolinks worked.
================================================================================================== */
date := '20110809';
pversion := date;
#WORKUNIT('name','GEOLINK REPLACED WITH GEO GROUP NAME. '+date);
/*=================================================================================
 I. Get SFDs for GA and replace geolinks with group geolinks so most (maybe all) geolinks
    have at least 500 SFDs in them.
===================================================================================*/
PersistFilename := '~thor_data400::persist::PropertyFieldFillInByLA2::getSingleResidentProperitiesWithHedonicData::GA';

GA_BaseWithHedonicData:=PropertyFieldFillInByLA2.getSingleResidentProperitiesWithHedonicData(['GA'], PersistFilename );


UniqueIdWithPropertyRec := RECORD
  unsigned seqno := 0;
  recordof(GA_BaseWithHedonicData)
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

r0 := RECORD
  string12 ogeolink:='';
  boolean PropInBoth:=false;
  recordof(GA_BaseWithHedonicData)
END;

r1 := RECORD
  string12 geolink;
  string12 ogeolink:='';
  unsigned8 cleanaid;
  boolean PropInBoth:=false;
END;

r0 fillR0( recordof(GA_BaseWithHedonicData) r ) := TRANSFORM
   self.ogeolink := r.geolink;
   self := r;
END;

PropertiesEssentialFields :=
  project(GA_BaseWithHedonicData
          ,fillR0(left)
  );

layout_glinkglink := RECORD
  string12 geolink1;
  string12 geolink2;
  real8 distance;
  unsigned8 num_sfds1;
  unsigned8 num_sfds2;
 END;

ggd_sfds := dataset('~thor_data400::persist::propertyfieldfillinbyla2::geolinktogeolinkdistanceandsfdscount',layout_glinkglink,THOR);

PropertyFieldFillInByLA2.mac_replacePropertyGeolinkWithGlinkGroupName(
     PropertiesEssentialFields
     , WithGroupGlink_GA_BaseWithHedonicData
     , PropertyFieldFillinByLA2.GroupGeoBlockDS(ggd_sfds)
);
output(count(PropertiesEssentialFields),named('GA_records_before_replace'));
output(count(WithGroupGlink_GA_BaseWithHedonicData),named('GA_records_after_replace'));

output(count(table(PropertiesEssentialFields,{PropertiesEssentialFields.geolink,c:=count(group)},geolink)),named('GA_geolinks_before_replace'));
output(count(table(WithGroupGlink_GA_BaseWithHedonicData,{WithGroupGlink_GA_BaseWithHedonicData.geolink,c:=count(group)},geolink)),named('GA_geolinks_after_replace'));
/* ================================================================================================
II. THE FOLLOWING CODE verifies that the geolinks were replaced by glinkgroupnames correctly.
    Here is what it does:
    CHECK1. It checks to make sure that every property in the inputted set is in the result set at least once.
    CHECK2. It checks to make sure that each property in the result set has only one value for each ogeolink.
    CHECK3. It makes sure that the number of times a property occurs in the result set is also the
            number of different geolinks that it has in the result set (i.e. a cleanaid occurs only
            once in any geolink).
    CHECK4. For both the BEFORE replacement and AFTER replacement datasets, we output the number of geolinks
            with less than 500 SFDs. We want/expect that the AFTER dataset will have fewer geolinks with
            less than 500 SFDs.
================================================================================================== */

//-----------------------------------------------------------------------------------------------
// First setup beforeDS and afterDS

r1 projectToR1( recordof(WithGroupGlink_GA_BaseWithHedonicData) r ) := TRANSFORM
  self.geolink := r.geolink;
  self.ogeolink := r.ogeolink;
  self.cleanaid := r.cleanaid;
  self. PropInBoth := false;
END;

beforeDS := project(PropertiesEssentialFields,projectToR1(LEFT));

afterDS := project(WithGroupGlink_GA_BaseWithHedonicData,projectToR1(LEFT));
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// CHECK1: DO ALL Properties in the original set of properties have at least one record in result?

r1 joinBoth(r0 l, r0 r ) := TRANSFORM
  self.PropInBoth := IF(r.cleanaid<>0, true, false);
  self.geolink := IF(r.cleanaid<>0, r.geolink, l.geolink);
  self.ogeolink := IF(r.cleanaid<>0, r.ogeolink, l.ogeolink);
  self.cleanaid := IF(r.cleanaid<>0, r.cleanaid, l.cleanaid);
END;

PropsInInputAndResult :=
   sort(
        distribute(
                   join(distribute(PropertiesEssentialFields,hash64(cleanaid))
                        ,distribute(WithGroupGlink_GA_BaseWithHedonicData,hash64(cleanaid))
                        ,LEFT.cleanaid=RIGHT.cleanaid
                        ,joinBoth(LEFT,RIGHT)
                        ,LEFT OUTER
                        ,local
                   )
                   ,hash64(cleanaid)
        )
        ,cleanaid
        ,local
   );

ZeroCleanaidInPropertiesEssentialFields := PropertiesEssentialFields(cleanaid=0);
output(count(ZeroCleanaidInPropertiesEssentialFields),named('CHECK1_number_of_zero_cleanaids_in_before'));
PropertiesNotInAFTER := PropsInInputAndResult(PropInBoth=false);
output(count(PropertiesNotInAFTER),named('CHECK1_Number_of_properties_in_BEFORE_but_not_AFTER'));
// END: CHECK1.
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// CHECK2: Make sure that each property in the result set has only one value for ogeolink.

CHECK2_BEFORE_rec := RECORD
  PropertiesEssentialFields.cleanaid;
  integer c := count(group);
END;

before_CountOfOgeolinksPerCleanaid :=
   sort(
        table(
              dedup(
                    sort(
                         distribute(PropertiesEssentialFields,hash64(cleanaid,ogeolink))
                         ,cleanaid,ogeolink
                         ,local
                    )
                    ,cleanaid,ogeolink
                    ,local
              )
              ,CHECK2_BEFORE_rec
              ,cleanaid
        )
        ,-c,cleanaid
   );
output(choosen(before_CountOfOgeolinksPerCleanaid,100),named('BEFORE_cleanaid_with_most_ogeolinks'));

CHECK2_rec := RECORD
  WithGroupGlink_GA_BaseWithHedonicData.cleanaid;
  integer c := count(group);
END;

/*
  This 1st distribute dataset with group glinks by hash64(cleanaid,ogeolink). Then it sorts locally
  by cleanaid, ogeolink and dedups by cleanaid, ogeolink. Then we count the number of
*/
after_CountOfOgeolinksPerCleanaid :=
   sort(
        table(
              dedup(
                    sort( 
                         distribute(WithGroupGlink_GA_BaseWithHedonicData,hash64(cleanaid,ogeolink))
                         ,cleanaid,ogeolink
                         ,local
                    )
                    ,cleanaid,ogeolink
                    ,local
              )
              ,CHECK2_rec
              ,cleanaid
        )
        ,-c,cleanaid
   );

IF(
   before_CountOfOgeolinksPerCleanaid[1].c > 1
   , output('PROBLEM: BEFORE. Some cleanaid have more than one ogeolink',named('CHECK2_Problem_BEFORE'))
   , output('BEFORE. ALL cleanaid have only one ogeolink',named('CHECK2_GOOD_BEFORE'))
);

IF(
   after_CountOfOgeolinksPerCleanaid[1].c > 1
   , output('PROBLEM: AFTER. Some cleanaid have more than one ogeolink',named('CHECK2_Problem_AFTER'))
   , output('AFTER. ALL cleanaid have only one ogeolink',named('CHECK2_GOOD_AFTER'))
);

/*
//================ BEFORE MOST FREQ =================================
CHECK2_rec3 := RECORD
  integer c;
  PropertiesEssentialFields;
END;

BeforeMostFreqFirst :=
sort(
     join(
          sort(
               distribute(PropertiesEssentialFields,hash64(cleanaid,ogeolink))
               ,cleanaid,ogeolink
               ,local
          )
          ,before_CountOfOgeolinksPerCleanaid
          ,left.cleanaid=right.cleanaid
          ,transform(CHECK2_rec3
                     ,self.c := right.c
                     ,self   := left
           )
          ,LOOKUP
     )
     ,-c,cleanaid,ogeolink
);

output(choosen(BeforeMostFreqFirst,1000),named('BEFORE_most_freq_cleanaid_ogeolink'));

//=============END BEFORE MOST FREQ =================================
CHECK2_rec2 := RECORD
  integer c;
  WithGroupGlink_GA_BaseWithHedonicData;
END;

AfterMostFreqFirst :=
sort(
     join(
          sort(
               distribute(WithGroupGlink_GA_BaseWithHedonicData,hash64(cleanaid,ogeolink))
               ,cleanaid,ogeolink
               ,local
          )
          ,after_CountOfOgeolinksPerCleanaid
          ,left.cleanaid=right.cleanaid
          ,transform(CHECK2_rec2
                     ,self.c := right.c
                     ,self   := left
           )
          ,LOOKUP
     )
     ,-c,cleanaid,ogeolink
);

output(choosen(AfterMostFreqFirst,1000),named('AFTER_most_freq_cleanaid_ogeolink'));
*/
// END CHECK2.
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//  CHECK3. It makes sure that the number of times a property occurs in the result set is also the
//          number of different geolinks that it has in the result set (i.e. a cleanaid occurs only
//          once in any geolink).
CHECK3_rec := RECORD
  WithGroupGlink_GA_BaseWithHedonicData.cleanaid;
  integer c := count(group);
END;

CountOfCleanaidsPerGeolink :=
   sort(
        table(
              sort(
                   distribute(WithGroupGlink_GA_BaseWithHedonicData,hash64(cleanaid,geolink))
                   ,cleanaid,geolink
                   ,local
              )
              ,CHECK3_rec
              ,cleanaid,geolink
        )
        ,-c
   );

IF(
   CountOfCleanaidsPerGeolink[1].c > 1
   , output('PROBLEM: Some cleanaid occur more than once in a geolink',named('CHECK3_Problem'))
   , output('ALL cleanaid occur only once in a geolink',named('CHECK3_GOOD'))
);

/*
CHECK3_AfterMostFreqFirst :=
sort(
     join(
          sort(
               distribute(WithGroupGlink_GA_BaseWithHedonicData,hash64(cleanaid,geolink))
               ,cleanaid,geolink
               ,local
          )
          ,CountOfCleanaidsPerGeolink
          ,left.cleanaid=right.cleanaid
          ,transform(CHECK2_rec2
                     ,self.c := right.c
                     ,self   := left
           )
          ,LOOKUP
     )
     ,-c,cleanaid,geolink
);

output(choosen(CHECK3_AfterMostFreqFirst,1000),named('CHECK3_AfterMostFreqFirst'));
*/
// END CHECK3.
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// CHECK4. For both the BEFORE replacement and AFTER replacement datasets, we output the number of geolinks
//         with less than 500 SFDs. We want/expect that the AFTER dataset will have fewer geolinks with
//         less than 500 SFDs.

before_rec := RECORD
   beforeDS.geolink;
   integer c := count(GROUP);
END;

after_rec := RECORD
   afterDS.geolink;
   integer c := count(GROUP);
END;

BeforeGeolinkSFDCounts :=
table(
      distribute(beforeDS,hash64(geolink))
      ,before_rec
      ,geolink
);

AfterGeolinkSFDCounts :=
table(
      distribute(afterDS,hash64(geolink))
      ,after_rec
      ,geolink
);

output('BEFORE Number Of geolinks with more than 500 SFDs: '+count(BeforeGeolinkSFDCounts(c>=500)),named('CHECK4_BEFORE'));
output('AFTER Number Of geolinks with more than 500 SFDs: '+count(AfterGeolinkSFDCounts(c>=500)),named('CHECK4_AFTER'));

// END CHECK4
//-----------------------------------------------------------------------------------------------

