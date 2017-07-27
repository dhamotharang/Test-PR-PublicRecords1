import doxie,ut;
layout_slim:=RECORD
unsigned6 did;
string15 booking_sid;
END;

layout_slim tSlim(file_bookings_base L):= TRANSFORM
self.did:= L.did;
self.booking_sid:=TRIM(L.booking_sid);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
df := PROJECT(file_bookings_base(did <> 0 ),tSlim(LEFT));

export key_appriss_did := 
 index(df,{did},{booking_sid},
         '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::did' );




