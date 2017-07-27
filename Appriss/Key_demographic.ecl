import doxie,ut, Data_Services;

export Key_demographic := 
 index(dataset([],{String1   KEY_GENDER, string3   KEY_RACE,unsigned4  DATE_OF_BIRTH, 
                   unsigned2 KEY_HGT,    unsigned2 KEY_WGT,	
                   string5   KEY_HAIR,   string5   KEY_EYE, string15  booking_sid}),
       {key_gender,key_race,DATE_OF_BIRTH,key_hgt,key_wgt},{key_hair,key_eye,booking_sid},
       Data_Services.Data_location.Prefix('Appriss') +'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::demographic' );
