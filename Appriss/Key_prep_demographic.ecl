import doxie,ut, data_services;

layout_slim:=RECORD
String1   KEY_GENDER;	
string3   KEY_RACE;
unsigned4 DATE_OF_BIRTH;
unsigned2 KEY_HGT;	
unsigned2 KEY_WGT;	
string5   KEY_HAIR;	
string5   KEY_EYE;
string15  booking_sid;
END;

layout_slim tSlim(file_bookings_base L):= TRANSFORM
self.key_gender :=trim(L.key_gender,left,right)[1..1];
self.key_race   :=trim(L.key_race,left,right);
self.DATE_OF_BIRTH        := (unsigned)trim(L.DATE_OF_BIRTH,left,right);
self.key_hgt    := (unsigned)trim(L.key_hgt,left,right);
self.key_wgt    := (unsigned)trim(L.key_wgt,left,right);
self.key_hair   :=trim(L.key_hair,left,right);
self.key_eye    :=trim(L.key_eye,left,right);

self.booking_sid:=trim(L.booking_sid,left,right);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
df := PROJECT(file_bookings_base(key_gender <> '' and key_race <> '' ),tSlim(LEFT));
//key_gender <> '' or key_race <> '' or DATE_OF_BIRTH <> 0 or key_hgt <> 0 or  key_wgt <> '0'  
export Key_prep_demographic := 
 index(df,{key_gender,key_race,DATE_OF_BIRTH,key_hgt,key_wgt},{key_hair,key_eye,booking_sid},
         data_services.data_location.prefix() + 'thor_200::key::appriss::'+ doxie.Version_SuperKey+'::demographic' );
