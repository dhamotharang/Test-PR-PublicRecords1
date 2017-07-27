import doxie,ut, Data_Services;

export Key_AgencyOri_StateCd :=  index(dataset([],{string20  AGENCY_ORI,string2   STATE_CD,string15  booking_sid}),
                                 {AGENCY_ORI,STATE_CD},{booking_sid},
                                 Data_Services.Data_location.Prefix('Appriss') +'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::AgencyStateCd' );