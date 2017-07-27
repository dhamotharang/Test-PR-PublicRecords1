IMPORT NID;
 
ds := PROJECT( DATASET( NID.Set_NamesNew, {string41 word}) , TRANSFORM({STRING21 Nickname, STRING20 name},
                         SELF.Nickname := LEFT.word[1..21] ; 
                         SELF.name     := TRIM(LEFT.word[22..],LEFT,RIGHT); 
                         )
                 ); 
                   
EXPORT Dictionary_NamesNew := DICTIONARY(ds , {Nickname => name});
