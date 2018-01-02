import doxie,ut, data_services;

layout_slim:=RECORD
string20  AGENCY_ORI;	
string2   STATE_CD;	
string15  booking_sid;
END;

layout_slim tSlim(file_bookings_base L):= TRANSFORM
self.AGENCY_ORI :=trim(L.AGENCY_ORI,left,right);
self.state_cd   :=trim(L.state_cd,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
df := PROJECT(file_bookings_base(AGENCY_ORI <> '' or state_cd <> '' ),tSlim(LEFT));

export Key_prep_Agencyori_StateCd :=  index(df,{agency_ori,state_cd},{booking_sid},
                                      data_services.data_location.prefix() + 'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::AgencyStateCd' );
