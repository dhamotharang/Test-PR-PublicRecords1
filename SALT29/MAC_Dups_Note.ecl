// Dedup the records heading into an external linking batch
// Note the tied to the name and case of UniqueId
EXPORT MAC_Dups_Note(infile,outformat,outfile,outdups,uniqueIDField='uniqueid'):=MACRO
  LOADXML('<xml/>');
  #EXPORTXML(AllFields,RECORDOF(infile))
  #DECLARE(InChild) #SET(InChild,0)
  #DECLARE(HashFields) #SET(HashFields,'')
  #DECLARE(HashCalls) #SET(HashCalls,'')
  #DECLARE(ComparisonFields) #SET(ComparisonFields,'TRUE')
  #DECLARE(SortFields) #SET(SortFields,'')
  #FOR(AllFields)
    #FOR(Field)
      #IF(%'@isDataset'%='1')
        #SET(InChild,1)
        #APPEND(HashFields,'UNSIGNED __'+%'@name'%+'_hash;')
        #APPEND(HashCalls,'SELF.__'+%'@name'%+'_hash:=TABLE(LEFT.'+%'@name'%+',{UNSIGNED h:=SUM(GROUP,')
        #APPEND(ComparisonFields,' AND LEFT.__'+%'@name'%+'_hash=RIGHT.__'+%'@name'%+'_hash')
        #APPEND(SortFields,',__'+%'@name'%+'_hash')
      #ELSE
        #IF(%'@isEnd'%='1')
          #SET(InChild,0)
          #APPEND(HashCalls,'0);})[1].h;\n')
        #ELSE
          #IF(%InChild%=1)
            #APPEND(HashCalls,'HASH32('+%'@name'%+')+')
          #ELSE
            #IF(Stringlib.StringToLowerCase(%'@name'%)<>Stringlib.StringToLowerCase(#TEXT(uniqueIDField)))
              #APPEND(ComparisonFields,' AND LEFT.'+%'@name'%+'=RIGHT.'+%'@name'%)
              #APPEND(SortFields,','+%'@name'%)
            #END
          #END
        #END
      #END
    #END;
  #END;
  
  #UNIQUENAME(r0)
  %r0%:=RECORD
    infile;
    SALT29.UIDType __shadow_ref;
    %HashFields%
  END;
  #UNIQUENAME(wider)
  %wider%:=SORT(PROJECT(infile,TRANSFORM(%r0%,#IF(%'HashCalls'%<>'') %HashCalls% #END SELF.__shadow_ref:=LEFT.uniqueIDField;SELF:=LEFT;))%SortFields%,SKEW(1));
  #UNIQUENAME(noted)
  %noted%:=ITERATE(%wider%,TRANSFORM(RECORDOF(%wider%),SELF.__shadow_ref:=IF(%ComparisonFields%,LEFT.__shadow_ref,RIGHT.uniqueIDField);SELF:=RIGHT;),LOCAL);
  outfile:=PROJECT(%noted%(uniqueIDField=__shadow_ref),TRANSFORM(outformat,SELF := LEFT));
  outdups:=TABLE(%noted%(uniqueIDField<>__shadow_ref),{uniqueIDField,__shadow_ref});  

ENDMACRO;