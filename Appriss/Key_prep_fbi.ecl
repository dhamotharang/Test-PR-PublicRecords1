import doxie,ut;

layout_slim:=RECORD
string25  FBI_NBR;	
string15  booking_sid;
END;

layout_slim tSlim(file_bookings_base L):= TRANSFORM
SELf.fbi_nbr   := trim(L.fbi_nbr,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
df := PROJECT(file_bookings_base(fbi_nbr <> ''),tSlim(LEFT));

export Key_prep_fbi := 
 index(df,{fbi_nbr},{booking_sid},
         '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::fbi' );
