import demo_data;
import vehiclev2;

file_in:= dataset('~thor::base::demo_data_file_vehiclev2_main_prodcopy',vehiclev2.Layout_Base_main,flat);

recordof(file_in) scrambleIt(file_in L):= TRANSFORM
//--------------------  Jayants Changes ------------------------------------- 
self.ORIG_vin := fn_scramblePII('VIN',L.ORIG_VIN);
self.vina_VIN:= fn_scramblePII('VIN',L.VINA_VIN);
self:=L;

END;



export scramble_vehiclev2_main := dedup(sort(PROJECT(file_in(source_code='AE'), scrambleIt(LEFT)),record),all);
