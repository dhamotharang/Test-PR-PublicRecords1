EXPORT mParentChild := MODULE

//-----------------------------------------------------------------------------
// Macro that takes a flat dataset as input and produces a new dataset that 
// has grouped together fields designated by the user into child datasets.
// The user passes the following parameters:
//   dIn         : The original flat dataset
//   sKeyfields  : Comma-delimited list of the key fields (i.e. the fields that
//     the final dataset will roll up on)
//   sChildren   : String containing the child dataset definitions, in the form
//     'layoutname:fieldname,fieldname;layoutname:fieldname;...' where 
//     layoutname are the names of the fields that contain the datasets, and 
//     fieldname are the names of the existing fields that will go in them.
//   dOut        : The name of the dataset into which to place the final table
//   iRecordmax  : [OPTIONAL] MAXLENGTH value to assign the resulting table
//   bBreadcrumbs: [OPTIONAL] Boolean indicating whether to leave breadcrumbs
//     in the child datasets (essentially record markers that enable the user
//     to re-constitute the results back into the original flat pattern)
//   bKeepOthers : [OPTIONAL] Boolean indicating whether to keep any fields
//     not referenced in the keys or children.  If so, each such field will
//     be kept in its own separate child dataset of the same name as the field.
//
//   If the user sets bKeepOthers to TRUE, and passes an empty string ('') as
//   the sChildren parameter, the macro will roll up every non-key field
//   individually.
//
//  EXAMPLE:
//  The user may call the macro with a line such as this:
//    mParentChild.macCreateChildren(dOrigData,'id,category','names:fname,lname;addresses:street,apt,city,state;phones:phone_number',dResults,10000,true);
//
//  This will produce a dataset with a the following layout:
//    RECORD,MAXLENGTH(10000)
//      TYPEOF(dOrigData.id) id;
//      TYPEOF(dOrigData.category) category;
//      DATASET(lnames) names;
//      DATASET(laddresses) addresses;
//      DATASET(lphones) phones;
//    END;
//
//  The three child datasets will include the fields specified in
//  the sChildren string and in this case they will each also have a field
//  named "_breadcrumbs" comprised of a set of unsigned integers because the
//  value "true" was passed to bBreadcrumbs.
//  Since the last parameter (bKeepOthers) was left blank, any additional
//  fields in the original dataset will be discarded.
//
//-----------------------------------------------------------------------------
EXPORT macCreateChildren(dIn,sKeyfields,sChildren,dOut,iRecordmax='4096',bBreadcrumbs='(BOOLEAN)FALSE',bKeepOthers='(BOOLEAN)FALSE'):=MACRO
  LOADXML('<xml/>');
  #UNIQUENAME(d)
  #DECLARE(inlayoutdef) 
  #DECLARE(keys)            #SET(keys,'')
  #DECLARE(notreferenced)   #SET(notreferenced,'')
  #DECLARE(condition)       #SET(condition,'')
  #DECLARE(outerassignment) #SET(outerassignment,'')
  #DECLARE(fieldname)       #SET(fieldname,'')
  #DECLARE(childlayouts)    #SET(childlayouts,'')
  #DECLARE(slims)           #SET(slims,'')
  #DECLARE(slimrolled)      #SET(slimrolled,'')
  #DECLARE(childproject)    #SET(childproject,'')
  #DECLARE(childrollups)    #SET(childrollups,'')
  #DECLARE(childjoins)      #SET(childjoins,'')
  #DECLARE(firstchild)      #SET(firstchild,'')
  #DECLARE(lastchild)       #SET(lastchild,'')
  #DECLARE(hashclause)      #SET(hashclause,'HASH32('+sKeyfields+')')
  #DECLARE(rowmax)          #SET(rowmax,',MAXLENGTH('+(UNSIGNED)iRecordmax+') ')
  #EXPORT(inlayoutdef,RECORDOF(dIn))
  
  // First pass to get all the strings needed with the key fields
  LOADXML(%'inlayoutdef'%,'fieldlist');
  #FOR(fieldlist)
    #FOR(Field)
      #IF(REGEXFIND(%'{@label}'%,sKeyfields,NOCASE))
        #APPEND(keys,'TYPEOF('+#TEXT(%d%)+'.'+%'{@label}'%+') '+%'{@label}'%+';')
        #APPEND(condition,'LEFT.'+%'{@label}'%+'=RIGHT.'+%'{@label}'%+' AND ')
        #APPEND(outerassignment,'SELF.'+%'{@label}'%+':=IF((STRING)LEFT.'+%'{@label}'%+' IN [\'\',\'0\'],RIGHT.'+%'{@label}'%+',LEFT.'+%'{@label}'%+');')
      #END
      #IF(REGEXFIND(%'{@label}'%,sKeyfields,NOCASE)=FALSE AND REGEXFIND('(,|:)'+%'{@label}'%+'(,|;|$)',sChildren,NOCASE)=FALSE)
        #APPEND(notreferenced,%'{@label}'%+':'+%'{@label}'%+';')
      #END
    #END
  #END
  #SET(condition,%'condition'%[..LENGTH(%'condition'%)-5])
  
  // If the user requested to keep the non-referenced fields, then add those
  // to the list of children, one field per child
  #UNIQUENAME(sChildDef)
  %sChildDef%:=sChildren+';'+#IF(bKeepOthers) %'notreferenced'% #ELSE '' #END;
  
  // If the user requested breadcrumbs, add them to the infile now
  #UNIQUENAME(dDist)
  %dDist%:=DISTRIBUTE(dIn,#EXPAND(%'hashclause'%));
  #IF(bBreadcrumbs)
    #UNIQUENAME(dWithBreadcrumb)
    %dWithBreadcrumb%:=TABLE(%dDist%,{%dDist%;UNSIGNED2 _breadcrumb:=0;},LOCAL);
    %d%:=ITERATE(%dWithBreadcrumb%,TRANSFORM(RECORDOF(%dWithBreadcrumb%),SELF._breadcrumb:=IF(#EXPAND(%'condition'%),LEFT._breadcrumb+1,1);SELF:=RIGHT;),LOCAL);
  #ELSE
    %d%:=%dDist%;
  #END
  
  // Second pass to construct all of the layouts and datasets needed to build
  // the children and pull them together into a unified dataset with one row
  // for each key combination.
  #UNIQUENAME(dSlim)
  #UNIQUENAME(dRolled)
  #UNIQUENAME(dRollup)
  #UNIQUENAME(lJoin)
  #UNIQUENAME(dJoin)
	#UNIQUENAME(l)
  #FOR(fieldlist)
    #FOR(Field)
      #IF(REGEXFIND('(,|:)'+%'{@label}'%+'(,|;|$)',%sChildDef%,NOCASE))
        #SET(fieldname,REGEXFIND('(^|;)([^:;]+):([^;]*)'+%'{@label}'%,%sChildDef%,2,NOCASE))
        #IF(REGEXFIND(#TEXT(%l%)+%'fieldname'%,%'childlayouts'%))
          #SET(childlayouts,REGEXFIND('(^(.*)('+#TEXT(%l%)+%'fieldname'%+')([^}])+)',%'childlayouts'%,1,NOCASE)+'TYPEOF('+#TEXT(%d%)+'.'+%'{@label}'%+') '+%'{@label}'%+';'+%'childlayouts'%[LENGTH(REGEXFIND('(^(.*)('+#TEXT(%l%)+%'fieldname'%+')([^}])+)',%'childlayouts'%,1,NOCASE))+1..])
          #SET(childproject,REGEXFIND('^((.*)(SELF.'+%'fieldname'%+':=DATASET)([^}]+))(?=([}]))',%'childproject'%,1,NOCASE)+',LEFT.'+%'{@label}'%+%'childproject'%[LENGTH(REGEXFIND('^((.*)(SELF.'+%'fieldname'%+':=DATASET)([^}]+))(?=([}]))',%'childproject'%,1,NOCASE))+1..])
        #ELSE
          #APPEND(childlayouts,#TEXT(%l%)+%'fieldname'%+':={'+#IF((UNSIGNED)iRecordmax<>4096) %'rowmax'% #ELSE '' #END+#IF(bBreadcrumbs) 'SET OF UNSIGNED2 _breadcrumbs:=[];' #ELSE '' #END+'TYPEOF('+#TEXT(%d%)+'.'+%'{@label}'%+') '+%'{@label}'%+';};\n')
          #APPEND(slims,#TEXT(%dSlim%)+%'fieldname'%+'01:=SORT(TABLE('+#TEXT(%d%)+',{'+#IF((UNSIGNED)iRecordmax<>4096) %'rowmax'% #ELSE '' #END+sKeyfields+','+REGEXFIND('(?<=('+%'fieldname'%+':))([^;]+)',%sChildDef%,2,NOCASE)+#IF(bBreadcrumbs) ',SET OF UNSIGNED2 _breadcrumbs:=[_breadcrumb]' #ELSE '' #END+'}),RECORD,LOCAL)((STRING)'+REGEXREPLACE(',',REGEXFIND('(?<=('+%'fieldname'%+':))([^;]+)',%sChildDef%,2,NOCASE),' NOT IN [\'\',\'0\'] OR (STRING)')+' NOT IN [\'\',\'0\']);\n')
          #IF(bBreadcrumbs)
            #APPEND(slimrolled,#TEXT(%dRolled%)+%'fieldname'%+'01:=ROLLUP('+#TEXT(%dSlim%)+%'fieldname'%+'01,TRANSFORM(RECORDOF('+#TEXT(%dSlim%)+%'fieldname'%+'01),SELF._breadcrumbs:=LEFT._breadcrumbs+RIGHT._breadcrumbs;SELF:=LEFT;),'+sKeyfields+','+REGEXFIND('(?<=('+%'fieldname'%+':))([^;]+)',%sChildDef%,2,NOCASE)+',LOCAL);\n')
          #ELSE
            #APPEND(slimrolled,#TEXT(%dRolled%)+%'fieldname'%+'01:=DEDUP('+#TEXT(%dSlim%)+%'fieldname'%+'01,LOCAL);\n')
          #END

          #APPEND(childproject,#TEXT(%dSlim%)+%'fieldname'%+':=PROJECT('+#TEXT(%dRolled%)+%'fieldname'%+'01,TRANSFORM({'+#IF((UNSIGNED)iRecordmax<>4096) %'rowmax'% #ELSE '' #END+%'keys'%+'DATASET('+#TEXT(%l%)+%'fieldname'%+') '+%'fieldname'%+';},SELF.'+%'fieldname'%+':=DATASET([{'+#IF(bBreadcrumbs) 'LEFT._breadcrumbs,' #ELSE '' #END+'LEFT.'+%'{@label}'%+'}],'+#TEXT(%l%)+%'fieldname'%+');SELF:=LEFT;));\n')
          #APPEND(childrollups,#TEXT(%dRollup%)+%'fieldname'%+':=ROLLUP('+#TEXT(%dSlim%)+%'fieldname'%+','+%'condition'%+',TRANSFORM(RECORDOF('+#TEXT(%dSlim%)+%'fieldname'%+'),SELF.'+%'fieldname'%+':=LEFT.'+%'fieldname'%+'+RIGHT.'+%'fieldname'%+';SELF:=LEFT;),LOCAL);\n')
          #IF(%'lastchild'%='')
            #SET(firstchild,%'fieldname'%)
          #ELSE
            #APPEND(childjoins,#TEXT(%lJoin%)+%'fieldname'%+':={'+#IF((UNSIGNED)iRecordmax<>4096) %'rowmax'% #ELSE '' #END + #IF(%'firstchild'%='') #TEXT(%lJoin%)+%'lastchild'% #ELSE 'RECORDOF('+#TEXT(%dRollup%)+%'firstchild'%+')' #END+' OR RECORDOF('+#TEXT(%dRollup%)+%'fieldname'%+')};\n')
            #APPEND(childjoins,#TEXT(%dJoin%)+%'fieldname'%+':=JOIN('+ #IF(%'firstchild'%='') #TEXT(%dJoin%)+%'lastchild'% #ELSE #TEXT(%dRollup%)+%'firstchild'% #END+','+#TEXT(%dRollup%)+%'fieldname'%+','+%'condition'%+',TRANSFORM('+#TEXT(%lJoin%)+%'fieldname'%+','+%'outerassignment'%+'SELF:=LEFT;SELF:=RIGHT;),FULL OUTER,LOCAL);\n')
            #SET(firstchild,'')
          #END
          #SET(lastchild,%'fieldname'%)
        #END
      #END
    #END
  #END
  
  // Series of expands to take the group of strings constructed during the
  // second pass above run declare them as layouts and datasets
  #EXPAND(%'childlayouts'%)
  #EXPAND(%'slims'%)
  #EXPAND(%'slimrolled'%)
  #EXPAND(%'childproject'%)
  #EXPAND(%'childrollups'%)
  #EXPAND(%'childjoins'%)

  // The output dataset is the final one defined in the above #EXPAND calls
  dOut:=#EXPAND(#IF(%'firstchild'%='') #TEXT(%dJoin%)+%'lastchild'% #ELSE #TEXT(%dRollup%)+%'fieldname'% #END );
ENDMACRO;

//-----------------------------------------------------------------------------
//  Macro that takes a grouped dataset created by the macCreateChildren macro
//  and reconstitutes the data back to the original format.  The user passes
//  two parameters:
//    dIn  : The name of the dataset to reconstitute
//    dOut : The name to assign the resulting dataset
//
//  The user MUST have passed TRUE to the boolean bBreadcrumbs in
//  macCreateChildren in order for this macro to work.
//
//  The output from this macro may not be identical to the original before
//  grouping.  E.g. any fields that may have been dropped when grouping
//  will not be recovered.
//
//  EXAMPLE:
//  Assuming we have dResults from the example in the comments of
//  macCreateChildren, then calling this:
//
//    mParentChild.macReconstitute(dResults,dWholeAgain);
//
//  ...will create a flat dataset dWholeAgain that is similar to the original.
//  However, if the original had more fields than were referenced in the
//  example then those will have been discarded.  To keep them, the user should
//  pass another TRUE value as the last parameter to macCreateChildren,
//  instructing the macro to keep all non-referenced fields
//
//-----------------------------------------------------------------------------
EXPORT macReconstitute(dIn,dOut):=MACRO
  LOADXML('<xml/>');
  #DECLARE(keydefs)         #SET(keydefs,'')
  #DECLARE(keylist)         #SET(keylist,'')
  #DECLARE(keycondition)    #SET(keycondition,'')
  #DECLARE(hashclause)      #SET(hashclause,'HASH32(')
  #DECLARE(inchild)         #SET(inchild,'')
  #DECLARE(normed)          #SET(normed,'')
  #DECLARE(keytable)        #SET(keytable,'_dKeyTable:=DEDUP(SORT(DISTRIBUTE(')
  #DECLARE(joins)           #SET(joins,'')
  #DECLARE(lastdataset)     #SET(lastdataset,'_dKeyTable')
  #DECLARE(inlayoutdef) 
  #EXPORT(inlayoutdef,RECORDOF(dIn))
  LOADXML(%'inlayoutdef'%,'fieldlist');
  
  // First pass to construct the key definitions and the definitions for the 
  // child datasets
  #FOR(fieldlist)
    #FOR(Field)
      #IF(%'{@isDataset}'%='')
        #IF(%'{@isEnd}'%='')
          #IF(%'inchild'%='')
            #APPEND(keydefs,'TYPEOF('+#TEXT(dIn)+'.'+%'{@label}'%+') '+%'{@label}'%+';')
            #APPEND(keylist,%'{@label}'%+';')
            #APPEND(keycondition,'LEFT.'+%'{@label}'%+'=RIGHT.'+%'{@label}'%+' AND ')
            #APPEND(hashclause,%'{@label}'%+'+')
          #END
        #ELSE
          #SET(inchild,'')
        #END
      #ELSE
        #SET(inchild,%'{@label}'%)
      #END
    #END
  #END
  #SET(hashclause,%'hashclause'%[..LENGTH(%'hashclause'%)-1]+')')
  #SET(keycondition,%'keycondition'%[..LENGTH(%'keycondition'%)-5])

  // Second pass to create the dataset definitions to pull apart the child
  // datasets, normalize them and re-join them to the final output
  #FOR(fieldlist)
    #FOR(Field)
      #IF(%'{@isDataset}'%<>'')
        #APPEND(normed,'_d'+%'{@label}'%+':=DISTRIBUTE(NORMALIZE('+#TEXT(dIn)+',LEFT.'+%'{@label}'%+',TRANSFORM({'+%'keydefs'%+'RECORDOF('+#TEXT(dIn)+'.'+%'{@label}'%+');},SELF:=RIGHT;SELF:=LEFT;)),'+%'hashclause'%+');\n')
        #APPEND(keytable,'NORMALIZE(TABLE(_d'+%'{@label}'%+',{'+%'keylist'%+'_bc:=DATASET(_breadcrumbs,{UNSIGNED2 crumb;});},LOCAL),LEFT._bc,TRANSFORM({'+%'keydefs'%+'UNSIGNED2 _rowid;},SELF._rowid:=RIGHT.crumb;SELF:=LEFT;),LOCAL)+')
        #APPEND(joins,'_d'+%'{@label}'%+'join:=JOIN('+%'lastdataset'%+',_d'+%'{@label}'%+','+%'keycondition'%+' AND LEFT._rowid IN RIGHT._breadcrumbs,TRANSFORM({RECORDOF('+%'lastdataset'%+') OR RECORDOF(_d'+%'{@label}'%+') AND NOT [_breadcrumbs];},SELF:=LEFT;SELF:=RIGHT;),LEFT OUTER,LOCAL);\n')
        #SET(lastdataset,'_d'+%'{@label}'%+'join')
      #END
    #END
  #END
  #SET(keytable,%'keytable'%[..LENGTH(%'keytable'%)-1]+','+%'hashclause'%+'),RECORD,LOCAL),LOCAL);')

  #EXPAND(%'normed'%)
  #EXPAND(%'keytable'%)
  #EXPAND(%'joins'%)

  dOut:=PROJECT(#EXPAND(%'lastdataset'%),RECORDOF(#EXPAND(%'lastdataset'%)) AND NOT [_rowid]);
ENDMACRO;

END;

