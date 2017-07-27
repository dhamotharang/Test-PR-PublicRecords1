IMPORT NID;

ds := PROJECT( DATASET( NID.Set_NamesV1, {string41 word}) , TRANSFORM({STRING21 Nickname, STRING20 name},
                         SELF.Nickname := LEFT.word[1..21] ; 
                         SELF.name     := TRIM(LEFT.word[22..],LEFT,RIGHT); 
                         )
                 ); 
                   
EXPORT Dictionary_NamesV1 := DICTIONARY(ds , {Nickname => name});
