export MAC_ChooseJoinType(mainfile,valuefile,field_name,trans_name) := MACRO

            if ( false and count(valuefile)*sizeof(valuefile)<10000000, join(mainfile,valuefile,left.field_name=right.field_name,trans_name(left,right),lookup, left outer),
                                            join(mainfile,valuefile,left.field_name=right.field_name,trans_name(left,right), left outer, hash) )
  endmacro;