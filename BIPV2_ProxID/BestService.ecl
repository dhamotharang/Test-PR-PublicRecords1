/*--SOAP--
<message name="BestService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular Proxid.*/
EXPORT BestService := MACRO
  IMPORT SALT311,BIPV2_ProxID;
  STRING20 Proxidstr := ''  : STORED('Proxid', FORMAT(SEQUENCE(1)));
  SALT311.UIDType uid := (SALT311.UIDType)Proxidstr;
TheData := PROJECT(LIMIT(BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).InData(Proxid=uid),BIPV2_ProxID.Config.JoinLimit),BIPV2_ProxID.Layout_DOT_Base);
s := GLOBAL(PROJECT(BIPV2_ProxID.Keys(TheData).Specificities_Key,BIPV2_ProxID.Layout_Specificities.R)[1]);
CM := BIPV2_ProxID.MAC_CreateBest(TheData, s, TRUE);
OUTPUT(CM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_np,NAMED('BestBy_cnp_name_prim_name_derived_v_city_name_st_zip'));
OUTPUT(CM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child_np,NAMED('BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child'));
OUTPUT(CM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best_np,NAMED('BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best'));
OUTPUT(CM.SINGLEPRIMRANGE_tab_prim_range_derived,NAMED('Tab_SINGLEPRIMRANGE_prim_range_derived'));
OUTPUT(CM.SINGLEPRIMRANGE_method_prim_range_derived,NAMED('Method_SINGLEPRIMRANGE_prim_range_derived'));
ENDMACRO;
