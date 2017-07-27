/*--SOAP--
<message name="BestService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular Proxid.*/
EXPORT BestService := MACRO
  IMPORT SALT28,BIPV2_ProxID_mj6;
STRING20 Proxidstr := ''  : STORED('Proxid');
SALT28.UIDType uid := (SALT28.UIDType)Proxidstr;
TheData := PROJECT(BIPV2_ProxID_mj6.Keys(BIPV2_ProxID_mj6.In_DOT_Base).InData(Proxid=uid),BIPV2_ProxID_mj6.Layout_DOT_Base);
s := GLOBAL(PROJECT(BIPV2_ProxID_mj6.Keys(TheData).Specificities_Key,BIPV2_ProxID_mj6.Layout_Specificities.R)[1]);
CM := BIPV2_ProxID_mj6.Best(TheData,s,TRUE);
OUTPUT(CM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_np,NAMED('BestBy_cnp_name_prim_name_derived_v_city_name_st_zip'));
OUTPUT(CM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child_np,NAMED('BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child'));
OUTPUT(CM.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best_np,NAMED('BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best'));
OUTPUT(CM.SINGLEPRIMRANGE_tab_prim_range,NAMED('Tab_SINGLEPRIMRANGE_prim_range'));
OUTPUT(CM.SINGLEPRIMRANGE_method_prim_range,NAMED('Method_SINGLEPRIMRANGE_prim_range'));
ENDMACRO;
