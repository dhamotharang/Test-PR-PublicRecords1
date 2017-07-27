import doxie,ut;

layout_slim:=RECORD
string25  state_id;	
string15  booking_sid;
END;

layout_slim tSlim(file_bookings_base L):= TRANSFORM
self.state_id   :=trim(L.state_id,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
df := PROJECT(file_bookings_base(state_id <> '' ),tSlim(LEFT));

export Key_prep_state_id := 
 index(df,{state_id},{booking_sid},
         '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::state_id' );
