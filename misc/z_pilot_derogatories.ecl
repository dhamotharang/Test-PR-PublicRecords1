import faa,doxie,doxie_files,sexoffender;

// current pilots list(s) 
// for:
// 1.       Sex Offender
// 2.       Criminal Convictions
// with counts, broken down by State to aid with the analysis.



pilots := sort(distribute(faa.file_airmen_data_out,hash((unsigned) did_out)),(unsigned) did_out,local);
sors := pull(sexoffender.Key_SexOffender_DID);
crims:= pull(doxie_files.key_offenders(data_type='1'));

layout_provider_with_flags := record 
recordof(pilots);
boolean has_sor := false;
boolean has_crim := false;
end;


//********************  MACRO ******************************
mac_find_did(ds_left,ds_right,right_did,has_fld,joined_ds) := MACRO
#uniquename(find_did)
layout_provider_with_flags %find_did%(ds_left L, ds_right R) := TRANSFORM
self.has_fld:= if( (integer) L.did_out<>0 and ((integer) L.did_out = (integer) R.right_did),true,false);
self:=L;
END;
#uniquename(ds_right_sorted)
%ds_right_sorted%:=sort(distribute(ds_right,hash((integer) right_did)),(integer) right_did,LOCAL);
joined_ds := JOIN(ds_left,%ds_right_sorted%, (integer) LEFT.did_out=(integer)RIGHT.right_did, %find_did%(LEFT,RIGHT),LEFT OUTER,LOCAL, KEEP(1));
ENDMACRO;
//******************** END MACRO ******************************

mac_find_did(pilots,sors,sdid,has_sor,pilots_with_sor);
mac_find_did(pilots_with_sor,crims,sdid,has_crim,pilots_with_crim);

export _pilot_derogatories := pilots_with_crim : persist('~thor400_84::persist::_pilot_derogatories');


