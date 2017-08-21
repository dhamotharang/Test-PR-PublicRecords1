IMPORT Buzzsaw;
ds := CHOOSEN(Buzzsaw.File_uip_location_std, 1000000);

j1 := JOIN(ds, Buzzsaw.Index_uip_location_std, KEYED(LEFT.IP =RIGHT.IP), TRANSFORM(RIGHT));
OUTPUT(j1);