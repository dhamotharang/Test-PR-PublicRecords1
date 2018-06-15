EXPORT RmFlags(s) := FUNCTIONMACRO 
    LoadXml('<xml/>');
    LOCAL __src := s;

    #EXPORTXML(fields, RECORDOF(s))
    #DECLARE(IsDataset)       // Stack of Y/N tracking whether field is in a dataset
    #DECLARE(InDataset)       // Indicates field is directly in a dataset
    #DECLARE(BeginRecord)     // Indicates a record just began
    #DECLARE(Prefix)          // A prefix of the names of all parent elements of this field (period seperated)
    #DECLARE(Parent)          // The name of the record containing this field
    #DECLARE(Code)            // The ECL created here
    #SET(IsDataset, 'N')
    #SET(BeginRecord, FALSE)
    #SET(Prefix, '__src')
    #SET(Code, 'TABLE(__src, {')
    #FOR(fields)
      #FOR(field)
        #IF(NOT REGEXFIND('_flags$',%'@label'%,NOCASE))
          #IF (%@IsRecord%=1)
            #SET(Parent, %'@label'%)
            #SET(Prefix, %'Prefix'%+'.'+%'@label'%)
            #SET(IsDataset, 'N' + %'IsDataset'%)
          #END
          // Track whether this is the beginning of a record
          #SET(BeginRecord, %@IsRecord%=1)
            #IF (%@IsDataset%=1)
                #IF (NOT REGEXFIND('{$',%'Code'%) )
                  #APPEND(Code,',')
                #END
                #APPEND(Code, 'DATASET ' + %'@label'% + ' := TABLE(' + %'Prefix'% + '.' + %'@label'% + ', {')
            #ELSE
              #IF (%BeginRecord%)
                #IF (NOT REGEXFIND('{$',%'Code'%) )
                  #APPEND(Code,',')
                #END
                #APPEND(Code, '{')
              #END
              #IF (%@IsEnd%=0 AND %@IsRecord%=0)
                #IF (NOT REGEXFIND('{$',%'Code'%))
                  #APPEND(Code,',')
                #END
                #APPEND(Code, 'TYPEOF(' + %'Prefix'% + '.' + %'@label'% + ') ' + %'@label'% + ' := ' + %'Prefix'% + '.' + %'@label'%)
              #END
            #END
          // Track nested datasets
          #IF (%@IsDataset%=1)
            #SET(Prefix, %'Prefix'%+'.'+%'@label'%)
            #SET(IsDataset, 'Y' + %'IsDataset'%)
          #END
          #SET(InDataset, %'IsDataset'%[1] = 'Y')
      
          // Process the end of a record or dataset
          #IF (%@IsEnd%=1 AND %InDataset%)
            #APPEND(Code, '})')
          #END
          #IF (%@IsEnd%=1 AND NOT %InDataset%)
            #APPEND(Code, '} ' + %'Parent'%)
          #END
      
          // Pop information off the stacks
          #IF (%@IsEnd%=1)
            #SET(Prefix, REGEXREPLACE('^(.*)\\.[^.]+$', %'Prefix'%, '$1'))
            #SET(Parent, REGEXREPLACE('^.*\\.([^.]+)$', %'Prefix'%, '$1'))
            #SET(IsDataset, %'IsDataset'%[2..])
          #END
        #END
      #END
    #END

    #APPEND(Code, '})')

//    #ERROR(%'Code'%)
    RETURN #EXPAND(%'Code'%);
   // RETURN %'Code'%;
  ENDMACRO;
