import doxie,ut, Data_Services;

export Key_DL := 
 index(dataset([],{ string25  DLNUMBER, string15  booking_sid}),
       {dlnumber},{booking_sid},
       Data_Services.Data_location.Prefix('Appriss') +'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::dl' );


