import doxie,ut, Data_Services;

export Key_FBI := 
 index(dataset([],{string25  FBI_NBR,string15  booking_sid}),
       {fbi_nbr},{booking_sid},
       Data_Services.Data_location.Prefix('Appriss') +'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::fbi' );

