//EXPORT file_fcra_keys := 'todo';

import FCRA,sshah,AutokeyB2,BankruptcyV2;
EXPORT file_FCRA_Keys:= module
                       //export key1 :=  project(FCRA.key_override_ibehavior.consumer,layout_fcra_keys.key1);
											 //export key2 :=  project(fcra.Key_Override_Property.ownership,layout_fcra_keys.key2);
											 //export key3:=   project (fcra.Key_Override_Property.deed, layout_fcra_keys.key3);
											 export AutoKeyB2_Key_Address := project(AutokeyB2.Key_Address(BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::'),sshah.layout_fcra_keys.AutoKeyB2_Key_Address);
                       // key3 :=  fcra.Key_Override_Property.deed;;
                       // key4 :=  fcra.key_override_sexoffender.so_main;
											 // key5 :=  advo.key_addr1_fcra;
											 


end;