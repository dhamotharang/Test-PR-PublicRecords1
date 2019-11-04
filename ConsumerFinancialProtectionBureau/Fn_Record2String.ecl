//turns record into comma delimited string of attributes
export Fn_Record2String(target_rec) := functionmacro
    #uniquename(CommaString);
    #uniquename(FieldCount);
    #SET(CommaString,'');
    #SET(FieldCount,0);
    #EXPORTXML(FieldList, target_rec);
    #FOR(FieldList)
        #FOR(field)
            #IF(%FieldCount%>0)
                #APPEND(CommaString,',');
            #END
            #SET(fieldCount, %fieldCount% + 1);
            #APPEND(CommaString,%'@name'%);
        #END
    #END
    return %'CommaString'%;
endmacro;