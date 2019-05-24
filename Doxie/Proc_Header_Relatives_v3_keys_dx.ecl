﻿import Infutor,Watchdog,Relationship,doxie_build,RoxieKeybuild,dx_Relatives_v3,data_services;

D2C_Relative       := distribute(Infutor.file_infutor_best, hash(did));// Infutor.infutor_best();
Marketing_Relative := distribute(Watchdog.Key_watchdog_marketing, hash(did));

isHeaderBuild:=false : stored('isHeaderBuild');

pv3:=Relationship.key_relatives_v3;

Relationship_key_relatives_v_built:= INDEX(pv3, {pv3.did1},{pv3},data_services.Data_Location.Relatives+'thor_data400::key::header::built::relatives_v3');

// choose key version
v3 := if(isHeaderBuild, Relationship_key_relatives_v_built, Relationship.key_relatives_v3);
                           
Header_Relative_v3_d1 := distribute(v3, hash(did1));

j1_D2C_Header_Relative := join(Header_Relative_v3_d1, D2C_Relative, left.did1 = right.did, transform(left), inner, local);
D2C_Header_Relative    := join(distribute(j1_D2C_Header_Relative, hash(did2)), D2C_Relative, left.did2 = right.did, transform(left), inner, local);

j1_Marketing_Header_Relative := join(Header_Relative_v3_d1, Marketing_Relative, left.did1 = right.did, transform(left), inner, local);
Marketing_Header_Relative    := join(distribute(j1_Marketing_Header_Relative, hash(did2)), Marketing_Relative, left.did2 = right.did, transform(left), inner, local);

export Proc_Header_Relatives_v3_keys_dx(string filedate) := function

   prefix := '~thor_data400::key::header::' + filedate + '::';
   name_D2C_Header_Relatives := prefix + 'D2C_Header_Relatives';
   name_Marketing_Header_Relatives := prefix + 'Marketing_Header_Relatives';
   
   RoxieKeybuild.MAC_build_logical(
         dx_Relatives_v3.key_D2C_Header_Relatives(),
         D2C_Header_Relative,
         dx_Relatives_v3.names('').i_D2C_Header_Relatives,
         name_D2C_Header_Relatives,
         D2C_Header_Relatives);
   
   RoxieKeybuild.MAC_build_logical(
         dx_Relatives_v3.key_Marketing_Header_Relatives(),
         Marketing_Header_Relative,
         dx_Relatives_v3.names('').i_Marketing_Header_Relatives,
         name_Marketing_Header_Relatives,
         Marketing_Header_Relatives);
         
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Relatives_v3.names('').i_D2C_Header_Relatives, name_D2C_Header_Relatives, mv_D2C_Header_Relatives);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Relatives_v3.names('').i_Marketing_Header_Relatives, name_Marketing_Header_Relatives, mv_Marketing_Header_Relatives);

   return sequential(
             D2C_Header_Relatives,
             Marketing_Header_Relatives,
             mv_D2C_Header_Relatives,
             mv_Marketing_Header_Relatives
             );
end;

