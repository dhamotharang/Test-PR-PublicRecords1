EXPORT FromFlat := MODULE

    EXPORT BuildMapping(from, to, source, dest, nullval, frule) := FUNCTIONMACRO
        LOADXML('<xml/>');
        #DECLARE(f)
        #DECLARE(ktype)
        #DECLARE(ftype)
        #DECLARE(ctype)
        #DECLARE(caster)
        #SET(f, '')
        #IF(nullval = 'EPOCH')
          #IF(frule='')
            #APPEND(f,'SELF.'+dest+':=KEL.Era.FromField((KEL.typ.kdate)LEFT.'+source+');')
          #ELSE
            #APPEND(f,'SELF.'+dest+':=KEL.Era.FromField2((STRING)LEFT.'+source+','+frule+');')
          #END    
        #ELSEIF(nullval = 'DATE')
          #IF(frule='')
            #APPEND(f,'SELF.'+dest+':=KEL.Routines.DateFromField((KEL.typ.kdate)LEFT.'+source+');')
          #ELSE
            #APPEND(f,'SELF.'+dest+':=KEL.Routines.DateFromField2((STRING)LEFT.'+source+','+frule+');')
          #END        
        #ELSEIF(nullval = 'PERMITS' OR nullval = 'NA')
          #APPEND(f,'SELF.'+dest+':=LEFT.'+source+';')
        #ELSE
          #APPEND(f,'SELF.'+dest+'.v:=')
          #IF(nullval != '')
              #SET(kType, #GETDATATYPE(#EXPAND('(TYPEOF('+to+'.'+dest+'.v))\'\'')))
              #SET(fType, #GETDATATYPE(#EXPAND(from + '.' + source)))
              #SET(cType, #GETDATATYPE(#EXPAND(nullval)))
              #SET(caster,'')
              // bypass the cast if both the ECL field and the NULL constant are STRINGs
              #IF(NOT REGEXFIND('^(?:q|var)?string\\d*|utf8*|unicode*|varunicode*$', %'fType'%) OR %'cType'%[1..6]<>'string')
                  #SET(caster,'(TYPEOF('+to+'.'+dest+'.v))')
              #END
              // report an error if an integer field is given a string null
              #IF(%'kType'%[1..7]='integer' AND %'fType'%[1..7]='integer' AND %'cType'%[1..6]='string')
                  #ERROR('KEL INTEGER property '+dest+' (from ECL INTEGER '+source+') cannot be given a NULL of type STRING (\''+nullval+'\'}')
                  RETURN '';
              #END
              #APPEND(f,'IF('+%'caster'%+'LEFT.'+source+'='+nullval+',__DefaultFromItem('+to+'.'+dest+'.v),'+'(TYPEOF('+to+'.'+dest+'.v))LEFT.'+source+');')
              #APPEND(f,'SELF.'+dest+'.f:=')
              #APPEND(f,'IF('+%'caster'%+'LEFT.'+source+'='+nullval+',__NullFlag,__NotNullFlag);')
          #ELSE
              #APPEND(f,'(TYPEOF('+to+'.'+dest+'.v))LEFT.'+source+';')
              #APPEND(f,'SELF.'+dest+'.f:=')
              #APPEND(f,'__NotNullFlag;')
          #END
        #END

        RETURN %'f'%;
    ENDMACRO;

    EXPORT BuildMappingFromSpec(to, from, source, spec) := FUNCTIONMACRO
        LOADXML('<xml/>');
        #DECLARE(f)
        #DECLARE(dests)
        #DECLARE(dest)
        #DECLARE(nullval)
        #DECLARE(frule)
        #SET(f, '')
        #IF(REGEXFIND('(,|^)'+source+'\\([^)]*\\)(,|$)', spec, NOCASE))
            #SET(dests, REGEXFIND('(,|^)'+source+'\\(([^)]*)\\)(,|$)', spec, 2, NOCASE))
            #LOOP
                #IF(REGEXFIND('^([^:|]+)(:([^:|]+))?(:([^:|]+))?(\\||$)', %'dests'%))
                    #SET(dest,    REGEXFIND('^([^:|]+)(:([^:|]+))?(:([^:|]+))?(\\||$)', %'dests'%, 1))
                    #SET(nullval, REGEXFIND('^([^:|]+)(:([^:|]+))?(:([^:|]+))?(\\||$)', %'dests'%, 3))
                    #SET(frule,   REGEXFIND('^([^:|]+)(:([^:|]+))?(:([^:|]+))?(\\||$)', %'dests'%, 5))
                    #APPEND(f, KEL.FromFlat.BuildMapping(to, from, source, %'dest'%, %'nullval'%, %'frule'%))
                    #SET(dests, REGEXFIND('^[^|]*(\\|(.*))?$', %'dests'%, 2))
                #ELSE
                    #BREAK
                #END
            #END
        #END
        RETURN %'f'%;
    ENDMACRO;

    EXPORT BuildFromFlat(from,to,spec):=FUNCTIONMACRO
        LOADXML('<xml/>');
        #DECLARE(f) #SET(f,'PROJECT('+#TEXT(from)+',TRANSFORM('+#TEXT(to)+',')
        #DECLARE(prefix) #SET(prefix, '')
        #DECLARE(indataset) #SET(indataset, 0)
        #DECLARE(label)
        #DECLARE(mapping)
        #DECLARE(found)  #SET(found, 0)
        #DECLARE(dests)
        #DECLARE(property) #SET(property,'')
        #DECLARE(propertylist) #SET(propertylist,',')
        #DECLARE(duplicate) #SET(duplicate, FALSE)
        #DECLARE(dupproperty)
        #EXPORTXML(fields,RECORDOF(from))
        #FOR(fields)
          #FOR(Field)
            #IF(%{@isRecord}%=1 AND %indataset%=0)
              #SET(prefix, %'prefix'%+%'{@label}'%+'.')
            #ELSEIF(%{@isRecord}%=1 AND %indataset%>0)
              #SET(indataset, %indataset%+1)
            #ELSEIF(%{@isDataset}%>0)
              #SET(indataset, %indataset%+1)
            #ELSEIF(%{@isEnd}%=1 AND %indataset%>=1)
              #SET(indataset, %indataset%-1)
            #ELSEIF(%{@isEnd}%=1)
              #SET(prefix, REGEXFIND('^(.*\\.)?[^.]+\\.', %'prefix'%, 1, NOCASE))
            #ELSEIF(%indataset%>=1)
              // Skip everything in child datasets
            #ELSE
              #SET(label, %'prefix'%+%'{@label}'%)
              #SET(mapping, KEL.FromFlat.BuildMappingFromSpec(#TEXT(from), #TEXT(to), %'label'%, spec))
              #APPEND(f, %'mapping'%)
              #IF(%'mapping'% != '')
                #SET(found, 1)
                #SET(dests, REGEXFIND('(,|^)'+%'label'%+'\\(([^)]*)\\)(,|$)', spec, 2, NOCASE))
                #LOOP
                    #IF(REGEXFIND('^([^:|]+)(:([^:|]+))?(:([^:|]+))?(\\||$)', %'dests'%))
                        #SET(property, REGEXFIND('^([^:|]+)(:([^:|]+))?(:([^:|]+))?(\\||$)', %'dests'%, 1))
                        #IF(REGEXFIND(','+%'property'%+',', %'propertylist'%,NOCASE))
                            #SET(duplicate, TRUE)
                            #SET(dupproperty,%'property'%)
                        #ELSE
                            #APPEND(propertylist,%'property'%+',')
                        #END
                        #SET(dests, REGEXFIND('^[^|]*(\\|(.*))?$', %'dests'%, 2))
                    #ELSE
                        #BREAK
                    #END
                #END
              #END
            #END
          #END
        #END
        #APPEND(f,'SELF:=[]))')
        #IF(%found%=0)
            #WARNING('KEL program used no fields from this input')
        #END
        #IF(%duplicate%)
            #ERROR('Can not map '+%'dupproperty'% +' to multiple fields of one dataset');
        #END
        RETURN %'f'%;

    ENDMACRO;

    EXPORT Convert(from,to,spec):=FUNCTIONMACRO
        RETURN #EXPAND(KEL.FromFlat.BuildFromFlat(from,to,spec));
    ENDMACRO;

    EXPORT ReducedRecord(from,fieldlist):=FUNCTIONMACRO
    // build a record with the same 'shape' as *from* but with only the fields from *fieldlist*
        LOADXML('<xml/>');
        #DECLARE(f) #SET(f,'')
        #DECLARE(prefix) #SET(prefix, '')
        #DECLARE(recName)
        #DECLARE(indataset) #SET(indataset, 0)
        #EXPORTXML(fields,RECORDOF(from))
        // walk the 'from' structure building the shape elements
        #FOR(fields)
          #FOR(Field)
            #IF(%{@isRecord}%=1 AND %indataset%=0)
              #SET(prefix, %'prefix'%+%'{@label}'%+'.')
              #APPEND(f, '{')
            #ELSEIF(%{@isRecord}%=1 AND %indataset%>0)
              #SET(indataset, %indataset%+1)
            #ELSEIF(%{@isDataset}%>0)
              #SET(indataset, %indataset%+1)
            #ELSEIF(%{@isEnd}%=1 AND %indataset%>=1)
              #SET(indataset, %indataset%-1)
            #ELSEIF(%{@isEnd}%=1)
              #SET(recName, REGEXFIND('^(.*\\.)?([^.]+)\\.', %'prefix'%, 2, NOCASE))
              #SET(prefix,  REGEXFIND('^(.*\\.)?([^.]+)\\.', %'prefix'%, 1, NOCASE))
              #APPEND(f, '}'+%'recName'%+';')
            #ELSEIF(%indataset%>=1)
              // Skip everything in child datasets
            #ELSE
              // do we need this field?  If so generate it.
              #IF(REGEXFIND(','+%'prefix'%+%'{@label}'%+',', ','+fieldList+',', NOCASE))
                #APPEND(f, #TEXT(from)+'.'+%'prefix'%+%'{@label}'% + ';')
              #END  
            #END
          #END
        #END
        // now get rid of any empty records
        #LOOP
          #IF(REGEXFIND('\\{\\}[a-z0-9_]+;', %'f'%, NOCASE))
            #SET(f, REGEXREPLACE('\\{\\}[a-z0-9_]+;', %'f'%, '', NOCASE))
          #ELSE
            #BREAK
          #END
        #END
        // get rid of the trailing semicolon 
        RETURN REGEXREPLACE(';$', %'f'%, '', NOCASE);
    ENDMACRO;

    EXPORT TopLevelNames(from):=FUNCTIONMACRO
    // build a list of top level names from the specified record
        LOADXML('<xml/>'); 
        #DECLARE(f) #SET(f,'')
        #DECLARE(nest) #SET(nest, 0)
        #DECLARE(indataset) #SET(indataset, 0)
        #EXPORTXML(fields,RECORDOF(from))
        #FOR(fields)
          #FOR(Field)
            #IF(%{@isRecord}%=1 AND %indataset%=0)
              #IF(%nest%=0)
                #APPEND(f, %'{@label}'% + ',')
              #END
              #SET(nest, %nest%+1)
            #ELSEIF(%{@isRecord}%=1 AND %indataset%>0)
              #SET(indataset, %indataset%+1)
            #ELSEIF(%{@isDataset}%>0)
              #SET(indataset, %indataset%+1)
            #ELSEIF(%{@isEnd}%=1 AND %indataset%>=1)
              #SET(indataset, %indataset%-1)
            #ELSEIF(%{@isEnd}%=1)
              #SET(nest, %nest%-1)
            #ELSEIF(%indataset%>=1)
            #ELSEIF(%nest%=0)
              #APPEND(f, %'{@label}'% + ',')
            #END
          #END
        #END
        // get rid of the trailing comma so the generated ECL looks 'normal'
        RETURN REGEXREPLACE(',$', %'f'%, '', NOCASE);
    ENDMACRO;

 END;
