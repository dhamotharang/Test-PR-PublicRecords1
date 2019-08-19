import tools;
EXPORT fix_DOT_overlinking(
   dataset(layout_DOT_base) pDotbase          = in_dot_base
  ,boolean                  pCheckOverlinking = false
) :=
function
  //fix any overlinking of dots on active_duns_number, active_enterprise_number, or active_domestic_corp_key 
  //can be only 1 per dot
  dagg  := tools.mac_AggregateFieldsPerID(pDotbase ,dotid,['active_duns_number','active_enterprise_number','active_domestic_corp_key']);
  dfilt := dagg(count(active_duns_numbers) >1 or count(active_enterprise_numbers) > 1 or count(active_domestic_corp_keys) > 1 );
  
  dresetdots := join(
     pDotbase
    ,dfilt
    ,left.dotid = right.dotid
    ,transform(
       layout_DOT_base
      ,self.dotid := if(right.dotid != 0  ,left.rcid  ,left.dotid)
      ,self       := left
    )
    ,left outer
  );
  
  return if(pCheckOverlinking = true  ,dfilt  ,dresetdots);
end;
