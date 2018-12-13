import ln_propertyv2;
import $;

prop_in:=ln_propertyv2.ln_propertyv2_as_source().p_rollup;
prop_at:=project( prop_in , $.Layout_Linking_Attribute_Property);

d_prop_all := distribute(prop_at,hash(ln_fares_id));
 
prop_attrib := dedup(  sort(   d_prop_all, did,dt_last_seen,src,local), did,dt_last_seen,src);

EXPORT fn_Linking_Attribute_Property := prop_attrib;
