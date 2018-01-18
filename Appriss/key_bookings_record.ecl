import doxie,ut, data_services;

df:=DATASET('~thor_data400::temp::Appriss::bookings_payloadformat',layout_payload_booking,FLAT);
export key_bookings_record := index(df,{booking_sid},
            
       {df},
               			 data_services.data_location.prefix() + 'thor_200::key::appriss::'+ doxie.Version_SuperKey+ '::bookings_id');