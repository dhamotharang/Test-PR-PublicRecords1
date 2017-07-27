/*2013-05-06T21:51:19Z (angela herzberg)
Bug 124044 (checked-in for review)
*/
import autokeyb,ut, BIPV2;

export proc_buildautokeys(string filedate) := function

layout_autokeyready :=record
layout_0010_header_base_slim;
string28 business_city;
string5 business_zip;
unsigned1 zero;
string1 zero1;
string1 zero2;
string1 zero3;
string1 zero4;
string1 zero5;
string1 zero6;
unsigned5 business_phone_number;
BIPV2.IDlayouts.l_xlink_ids;
end;

pre := EBR.File_0010_Header_Base;

filename := fileservices.getsuperfilesubname(EBR.FileName_0010_Header_Base,1);

//filedate := filename[length(filename)-14..length(filename)-14+7];


layout_autokeyready normcities(pre le,integer C):=transform
self.business_city := choose(C,le.city,if(le.city=le.p_city_name,skip,le.p_city_name),if(le.p_city_name=le.v_city_name or le.city=le.v_city_name,skip,le.v_city_name));
self := le;
self :=[];
end;

normedcities :=normalize(pre,if(left.v_city_name<>left.p_city_name or left.city <> left.p_city_name or left.city <> left.v_city_name,3,1),normcities(left,counter));

layout_autokeyready normzips(layout_autokeyready le,integer C):=transform
self.business_zip :=choose(C,le.zip,le.orig_zip);
self.business_phone_number :=(unsigned5)le.phone_number;
self :=le;
end;

normedzipscities := normalize(normedcities,if(left.orig_zip <> left.zip,2,1),normzips(left,counter)):persist('persist::EBR::proc_buildautokeys');



AutoKeyB.MAC_Build (normedzipscities,
					zero1,zero1,zero1,
					zero1,
					zero1,
					zero1,
					zero1,zero2,zero3,zero4,zero5,zero6,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					zero,
					company_name,
					zero,
					business_phone_number,
					prim_name,prim_range,state_code,business_city,business_zip,sec_range,
					bdid,
					EBR.constants(filedate).Str_autokeyName,
					EBR.constants(filedate).Str_autokeyLogical,
					outaction,false,
					(['C','F']),true,EBR.constants(filedate).str_TypeStr) 

AutoKeyB.MAC_AcceptSK_to_QA(EBR.constants(filedate).Str_autokeyName, mymove)
 
retval := sequential(outaction,mymove);

return retval;

end;