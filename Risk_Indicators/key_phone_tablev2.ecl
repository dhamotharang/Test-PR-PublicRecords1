import Gong_v2,doxie;

r := risk_indicators.Phone_Tablev2(); 

export key_phone_tablev2 := index(r,{phone10},{r},Gong_v2.thor_cluster + 'key::phone_tablev2_'+doxie.Version_SuperKey);