


import Codes,ut,_control;
//codes_local:=dataset('~foreign::' + _control.IPAddress.prod_thor_dali + '::' + 'thor_data400::base::codes_v3',{Codes.layout_codes_v3,unsigned8 __fpos { virtual (fileposition)}},flat);

codes_local:=dataset('~thor_data400::base::codes_v3',{Codes.layout_codes_v3,unsigned8 __fpos { virtual (fileposition)}},flat);

export codesV3_file_in := codes_local;

