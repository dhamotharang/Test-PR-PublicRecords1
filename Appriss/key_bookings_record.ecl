import doxie,ut;

df:=DATASET('~thor_data400::temp::Appriss::bookings_payloadformat',layout_payload_booking,FLAT);
export key_bookings_record := index(df,{booking_sid},
            
       {df},
               //ut.foreign_prod + 'thor_data400::key::Appriss::bookings::records_' 
							 '~thor_200::key::appriss::'+ doxie.Version_SuperKey+ '::bookings_id');