//---------------------------------------------------------------------------
// macFieldRename
//
// FunctionMacro that can be used to rename fields in a layout on a bulk
// basis by adding or changing a prefix.
//
//   d          : The input layout or dataset
//   sNewPrefix : The new prefix to affix to each field name
//   sOldPrefix : The old prefix to replace
//   sFieldList : The list of specific fields to replace
//   bIsDataset : TRUE=(d=Dataset) FALSE=(d=layout)
//
// If an old prefix is present, then the macro ONLY puts the new prefix in
// place of the old one where the field begins with the old string.  Fields
// that are not prefixed with the old prefix will not be changed.
// You can provide a comma-delimited string in sFieldList, which will
// instruct the macro to only add or change the prefix for the specific
// fields in the list.
// 
//---------------------------------------------------------------------------
EXPORT macFieldRename(d,sNewPrefix,sOldPrefix='',sFieldList='',bIsDataset=FALSE):=FUNCTIONMACRO
  LOADXML('<xml/>');
  #DECLARE(f) #SET(f,'')
  #EXPORTXML(fields,RECORDOF(d))
  #FOR(fields)
    #FOR(Field)
      #IF((#TEXT(sFieldList)='' OR REGEXFIND('(,|\')'+%'{@label}'%+'(,|\')',#TEXT(sFieldList),NOCASE)) AND (#TEXT(sOldPrefix)='' OR REGEXFIND('^'+REGEXREPLACE('\'',#TEXT(sOldPrefix),''),%'{@label}'%,NOCASE)))
        #APPEND(f,':')
      #END
      #APPEND(f,#TEXT(d)+'.'+%'{@label}'%+';')
    #END
  #END
  
  #IF(bIsDataset)
      #SET(f,'TABLE('+#TEXT(d)+',{'+REGEXREPLACE(':[^.]+[.]('+REGEXREPLACE('\'',#TEXT(sOldPrefix),'')+')([^:;]+)',%'f'%,'TYPEOF('+#TEXT(d)+'.$1$2) '+sNewPrefix+'$2:=$1$2',NOCASE)+'})');
  #ELSE
      #SET(f,'{'+REGEXREPLACE(':[^.]+[.]('+REGEXREPLACE('\'',#TEXT(sOldPrefix),'')+')([^:;]+)',%'f'%,'TYPEOF('+#TEXT(d)+'.$1$2) '+sNewPrefix+'$2',NOCASE)+'}');
  #END
  
  RETURN %f%;
ENDMACRO;