import doxie,ut, Data_Services;

export Key_Gang := 
 index(dataset([],{string25  GANG,string15  booking_sid}),
       {GANG},{booking_sid},
       Data_Services.Data_location.Prefix('Appriss') +'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::gang' );
