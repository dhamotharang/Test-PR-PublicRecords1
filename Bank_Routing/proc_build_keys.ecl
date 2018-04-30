IMPORT RoxieKeyBuild,Bank_Routing;

EXPORT proc_build_keys(string filedate) := FUNCTION

 RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
  Bank_Routing.key_rtn,
  bank_routing.thor_cluster + 'key::bank_routing::@version@::RTN',
  bank_routing.thor_cluster + 'key::bank_routing::'+filedate+'::RTN',
  bank_routingRTNKeyOut); 

 RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
  bank_routing.thor_cluster + 'key::bank_routing::@version@::RTN',
  bank_routing.thor_cluster + 'key::bank_routing::'+filedate+'::RTN',
  mv_rtn_key_built);

 RoxieKeyBuild.Mac_SK_Move_V2(bank_routing.thor_cluster + 'key::bank_routing::@version@::RTN', 'Q', mv_rtn_key_QA);

 RETURN sequential(
  bank_routingRTNKeyOut,
  mv_rtn_key_built,
  mv_rtn_key_QA);

END;