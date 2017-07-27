import doxie,ut, Data_Services;

//ap_ssn - Appriss supplied ssn

export Key_ap_SSN := 
 index(dataset([],{string11  ap_ssn	, string15  booking_sid}),
       {ap_ssn},{booking_sid},
       Data_Services.Data_location.Prefix('Appriss') +'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::ap_ssn' );

