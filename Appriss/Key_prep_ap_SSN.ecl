import doxie,ut;

layout_slim:=RECORD
string11  ap_ssn;	
string15  booking_sid;
END;

layout_slim tSlim(file_bookings_base L):= TRANSFORM
SELf.ap_ssn   :=trim(L.ap_ssn,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
df := PROJECT(file_bookings_base(ap_ssn <> '' ),tSlim(LEFT));

export Key_prep_ap_SSN := 
 index(df,{ap_ssn},{booking_sid},
         '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::ap_ssn' );

