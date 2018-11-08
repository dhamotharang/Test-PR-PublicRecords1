/**
 *Cleans the set of field names of a dataset by applying any combination of three alterations.
 *<p>
 *This function cleans a dataset in three possible ways, of which any combination may be applied.  The
 *options are to remove fields whose name ends in "_flags" (e.g., KEL-generated null flag fields), remove
 *fields named "__recordcount" (e.g., the KEL-gererated record count field), and unmangle the field names.
 *By unmangle, we mean replace KEL-generated field names with the names used in the KEL program (remember ECL
 *is  not case sensitive, so fields will appear all lowercase).  If flag fields are not removed and field
 *names are  unmangled, the flag fields will be of the form "__origName_flags", where "origName" is the name
 *used in the KEL program. Unremoved record count fields are not affected by the unmangle option.
 *
 *@param s an ECL dataset (e.g., Q__q.Res0, with KEL-generated flag and record count fields, and mangled names)
 *@param flags a BOOLEAN parameter to specify whether or not to remove fields ending in "_flags"
 *@param counts a BOOLEAN parameter to specify whether or not to remove "__recordcount" fields
 *@param unmang a BOOLEAN parameter to specify whether or not to unmangle field names
 *@return the cleaned version of the input dataset
 */
EXPORT Clean(s, flags, counts, unmang) := FUNCTIONMACRO
    LoadXml('<xml/>');
    LOCAL __src := s;
    #EXPORTXML(fields, RECORDOF(s))
    #DECLARE(IsDataset)    #SET(IsDataset, 'N')         // Stack of Y/N tracking whether field is in a dataset
    #DECLARE(BeginRecord)  #SET(BeginRecord, FALSE)     // Indicates a record just began
    #DECLARE(Prefix)       #SET(Prefix, '__src')        // A prefix of the names of all parent elements of this field (period seperated)
    #DECLARE(Code)         #SET(Code, 'TABLE(__src, {') // The ECL created here
    #DECLARE(InDataset)       // Indicates field is directly in a dataset
    #DECLARE(Parent)          // The name of the record containing this field
    #FOR(fields)
      #FOR(field)
        #IF(NOT ((counts AND REGEXFIND('^__recordcount$',%'@label'%)) OR (flags AND REGEXFIND('_flags$',%'@label'%))))
          #IF(%@IsRecord%=1)
            #SET(Parent, %'@label'%)
            #SET(Prefix, %'Prefix'%+'.'+%'@label'%)
            #SET(IsDataset, 'N' + %'IsDataset'%)
          #END
          // Track whether this is the beginning of a record
          #SET(BeginRecord, %@IsRecord%=1)
            #IF(%@IsDataset%=1)
              #IF(NOT REGEXFIND('\\{$',%'Code'%) )
                #APPEND(Code,',')
              #END
              #IF(unmang)
                #APPEND(Code, 'DATASET ' + KEL.Unmangle(%'@label'%) + ' := TABLE(' + %'Prefix'% + '.' + %'@label'% + ', {')
              #ELSE
                #APPEND(Code, 'DATASET ' + %'@label'% + ' := TABLE(' + %'Prefix'% + '.' + %'@label'% + ', {')
              #END
            #ELSE
              #IF(%BeginRecord%)
                #IF(NOT REGEXFIND('\\{$',%'Code'%) )
                  #APPEND(Code,',')
                #END
                #APPEND(Code, '{')
              #END
              #IF(%@IsEnd%=0 AND %@IsRecord%=0)
                #IF(NOT REGEXFIND('\\{$',%'Code'%))
                  #APPEND(Code,',')
                #END
                #IF(unmang)
                  #APPEND(Code, 'TYPEOF(' + %'Prefix'% + '.' + %'@label'% + ') ' + KEL.Unmangle(%'@label'%) + ' := ' + %'Prefix'% + '.' + %'@label'%)
                #ELSE
                  #APPEND(Code, 'TYPEOF(' + %'Prefix'% + '.' + %'@label'% + ') ' + %'@label'% + ' := ' + %'Prefix'% + '.' + %'@label'%)
                #END
              #END
            #END
            // Track nested datasets
            #IF(%@IsDataset%=1)
              #SET(Prefix, %'Prefix'%+'.'+%'@label'%)
              #SET(IsDataset, 'Y' + %'IsDataset'%)
            #END
            #SET(InDataset, %'IsDataset'%[1] = 'Y')
            // Process the end of a record or dataset
            #IF(%@IsEnd%=1 AND %InDataset%)
              #APPEND(Code, '})')
            #END
            #IF(%@IsEnd%=1 AND NOT %InDataset%)
              #IF(unmang)
                #APPEND(Code, '} ' + KEL.Unmangle(%'Parent'%))
              #ELSE
                #APPEND(Code, '} ' + %'Parent'%)
              #END
            #END
            // Pop information off the stacks
            #IF(%@IsEnd%=1)
              #SET(Prefix, REGEXREPLACE('^(.*)\\.[^.]+$', %'Prefix'%, '$1'))
              #SET(Parent, REGEXREPLACE('^.*\\.([^.]+)$', %'Prefix'%, '$1'))
              #SET(IsDataset, %'IsDataset'%[2..])
            #END
          #END
        #END
      #END
    #APPEND(Code, '})')
    RETURN #EXPAND(%'Code'%);
ENDMACRO;
