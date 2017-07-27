import doxie,ut;

layout_prep_gang_key tSlim(file_bookings_base L):= TRANSFORM
self.gang       :=trim(L.gang,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END; 

df := 	PROJECT(file_bookings_base(gang <> '' and regexfind('^UNKNOWN$|^UNK$|^[*]NONE$|^N$|^[?]*$|^[\\.\\/\\*0]*$',trim(gang),0)='') ,tSlim(LEFT));
distributed_file := distribute(df,hash(booking_sid)) : persist('persist::appriss::gang_key_prep');
processed_gang_names := processGangNames(distributed_file);

export Key_prep_gang :=  index(processed_gang_names,{gang},{booking_sid},
                               '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::gang' );
