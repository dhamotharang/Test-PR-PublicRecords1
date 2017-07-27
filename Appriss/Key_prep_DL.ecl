import doxie,ut;

layout_slim:=RECORD
string25  DLNUMBER;	
string15  booking_sid;
END;

layout_slim tSlim(file_bookings_base L):= TRANSFORM
SELf.dlnumber   :=trim(L.dlnumber,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
df := PROJECT(file_bookings_base(dlnumber <> '' ),tSlim(LEFT));

export Key_prep_DL := 
 index(df,{dlnumber},{booking_sid},
         '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::dl' );

