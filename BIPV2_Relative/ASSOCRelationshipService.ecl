/*--SOAP--
<message name="ASSOCRelationshipService">
<part name="Proxid" type="xsd:unsignedInt"/>
<part name="Depth" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- Will follow ASSOC links up to N levels deep. Warning: High N could be slow and produce large datasets!*/
EXPORT ASSOCRelationshipService := MACRO
  IMPORT SALT25,BIPV2_Relative;
  UNSIGNED Proxid_val := 0 : stored('Proxid');
  UNSIGNED1 Depth := 1 : stored('Depth');
  BFile := BIPV2_Relative.In_DOT_Base;
  AllTree := CHOOSEN( BIPV2_Relative.Relationship_Links(BFile).ASSOCTree(Proxid_val,Depth), 100 ); // At most 100 relatives allowed
  BIPV2_Relative.match_candidates(BFile).layout_candidates into(BIPV2_Relative.Keys(BFile).Candidates le) := transform
    self := le;
  end;
  All_Rel_Recs := JOIN( AllTree,BIPV2_Relative.Keys(BFile).Candidates, left.Proxid2=right.Proxid, into(right) );
  k := BIPV2_Relative.Keys(BFile).Specificities_Key;
  BIPV2_Relative.Layout_Specificities.R s_into(k le) := transform
    self := le;
  end;
  s := global(project(k,s_into(left))[1]);
  Rolled := BIPV2_Relative.Debug(BFile,s).RolledEntities(All_Rel_Recs);
  Add_Linkage := JOIN(AllTree, Rolled, left.Proxid2=right.Proxid);
OUTPUT( CHOOSEN(Add_Linkage,1000),NAMED('Relative_Records'));
ENDMACRO;
