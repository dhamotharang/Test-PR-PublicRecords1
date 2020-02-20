//From Gong_Neustar.Key_History_Address, Gong_Neustar.Key_FCRA_History_Address
IMPORT data_services, $;

rec := $.layouts.i_history_address;

keyed_fields := RECORD
  rec.prim_name;
  rec.st;
  rec.z5;
  rec.prim_range;
  rec.sec_range;
  rec.current_flag;
  rec.business_flag;
END;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_history_address_fcra,
                                     $.names().i_history_address); 

EXPORT key_history_address (integer data_category = 0) := 
         INDEX (keyed_fields, {rec - keyed_fields}, fname(data_category));