import doxie,ut, Data_Services;

export Key_state_id :=  index(dataset([],{string25  state_id,string15  booking_sid}),
                             {state_id},{booking_sid},
                             Data_Services.Data_location.Prefix('Appriss') +'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::state_id' );

