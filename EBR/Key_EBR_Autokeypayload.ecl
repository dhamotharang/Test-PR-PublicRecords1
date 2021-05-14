import autokeyb,doxie,EBR, BIPV2;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_autokey_payload_delta_rid
// ---------------------------------------------------------------

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


fakepf := dataset([],layout_autokeyready);

//fakepf := liensv2.file_SearchAutokey(dataset([],LiensV2.Layout_liens_party));
autokeyb.MAC_FID_Payload(fakepf,'','','','','','','','','',0,bdid,EBR.constants('00000000').Str_autokeyName+'Payload',plk,'');

export Key_EBR_AutokeyPayload := plk;