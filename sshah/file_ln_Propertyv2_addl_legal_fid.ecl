//EXPORT file_ln_Propertyv2_addl_legal_fid := 'todo';
//EXPORT file_fcra_keys := 'todo';

import FCRA,sshah,ln_propertyv2;

                       //export key1 :=  project(FCRA.key_override_ibehavior.consumer,layout_fcra_keys.key1);
											 //export key2 :=  project(fcra.Key_Override_Property.ownership,layout_fcra_keys.key2);
											 //export key3:=   project (fcra.Key_Override_Property.deed, layout_fcra_keys.key3);
											 export file_ln_Propertyv2_addl_legal_fid:= project(ln_propertyv2.key_addl_legal_fid(true),sshah.layout_ln_Propertyv2_addl_legal_fid);
                       // key3 :=  fcra.Key_Override_Property.deed;;
                       // key4 :=  fcra.key_override_sexoffender.so_main;
											 // key5 :=  advo.key_addr1_fcra;
											 

