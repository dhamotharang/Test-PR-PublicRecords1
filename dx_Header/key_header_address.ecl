IMPORT data_services, _Control;
IMPORT $;
#IF(_Control.Environment.onVault) IMPORT vault; #END;


keyed_fields := RECORD
  $.layouts.i_header_address.prim_name;
  $.layouts.i_header_address.zip;
  $.layouts.i_header_address.prim_range;
  $.layouts.i_header_address.sec_range;
END;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_header_address_fcra,
                                     $.names().i_header_address); 

EXPORT key_header_address (integer data_category = 0) :=
#IF(_Control.Environment.onVault)
    vault.dx_header.key_header_address(data_category);
#ELSE
    INDEX (keyed_fields, $.layouts.i_header_address, fname(data_category));
#END;
