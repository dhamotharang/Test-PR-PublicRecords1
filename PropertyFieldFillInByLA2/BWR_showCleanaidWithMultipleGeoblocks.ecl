// BWR_showCleanaidWithMultipleGeoblocks.ecl
import ADVO;
SomeStates := ['CA','GA','KS'];
in_advo_base := advo.files(,true).file_cleaned_base;
ADVO_BASE := in_advo_base(Address_Type = '1', Residential_or_Business_Ind = 'A', geo_blk<>'', st in SomeStates);
//output(ADVO_BASE);

//=================== DEBUG CODE ============================
TABLE_rec := RECORD
  ADVO_BASE.cleanaid;
  integer c := count(group);
END;

ADVO_BASE_CountOfGeoblocksByCleanaid :=
   sort(
        table(
              dedup(
                    sort(
                         distribute(ADVO_BASE,hash64(cleanaid,geo_blk))
                         ,cleanaid,geo_blk
                         ,local
                    )
                    ,cleanaid,geo_blk
                    ,local
              )
              ,TABLE_rec
              ,cleanaid
        )
        ,-c,cleanaid
   );
output(choosen(ADVO_BASE_CountOfGeoblocksByCleanaid,1000),named('ADVO_BASE_CountOfGeoblocksByCleanaid'));

CHECK2_rec3 := RECORD
  integer c;
  ADVO_BASE;
END;

ADVO_BASE_MostFreqFirst :=
sort(
     join(
          sort(
               distribute(ADVO_BASE,hash64(cleanaid,geo_blk))
               ,cleanaid,geo_blk
               ,local
          )
          ,ADVO_BASE_CountOfGeoblocksByCleanaid
          ,left.cleanaid=right.cleanaid
          ,transform(CHECK2_rec3
                     ,self.c := right.c
                     ,self   := left
           )
          ,LOOKUP
     )
     ,-c,cleanaid,-date_last_seen
);

output(choosen(ADVO_BASE_MostFreqFirst,1000),{cleanaid,geo_blk,date_last_seen,geo_lat,geo_long},named('ADVO_BASE_MostFreqFirst'));
