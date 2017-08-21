//-----------------------------------------------------------------------------
// Child-creation macro to group together specific fields in a flat file
// and turn them into child records.  User passes the following:
//
//   dIn        : The name of the dataset to process
//   keyfields  : String containing a comma-delimited list of the key fields
//                (i.e. the fields that we will roll up on)
//   childname  : The name of the child dataset field in the new table
//   datafields : String containing a comma-delimited list of the fields to
//                include in the child dataset
//   dOut       : The name of the resulting dataset.
//   dAddTo     : (OPTIONAL) The name of a dataset to which the new children
//                are joined as part of the output
//   recordmax  : (OPTIONAL) The MAXLENGTH to apply to the resulting table
//                (default=4096)
//
// Resulting output is a dataset with each individual key field and a the
// child dataset that was created.  If a dataset was passed to "AddTo", then
// all of the additional fields in that dataset are also included.
//
// Example:
//  macGroupChildren(dOrigData,'id,category',names,'lname,fname',dNames);
//
//  Above line creates a dataset dNames with the following layout:
//  RECORD
//    TYPEOF(dOrigData.id) id;
//    TYPEOF(dOrigData.category) category;
//    DATASET({TYPEOF(dOrigData.lname) lname;TYPEOF(dOrigData.fname) fname;}) names;
//  END;
//
//  macGroupChildren(dOrigData,'id,category',phone_numbers,'phone_number',dPhoneNumbers);
//  macGroupChildren(dOrigData,'id,category',names,'lname,fname',dNames,dPhoneNumbers);
//
//  Above two lines create a dataset dNames with the following layout:
//  RECORD
//    TYPEOF(dOrigData.id) id;
//    TYPEOF(dOrigData.category) category;
//    DATASET({TYPEOF(dOrigData.phone_number) phone_number;}) phone_numbers;
//    DATASET({TYPEOF(dOrigData.lname) lname;TYPEOF(dOrigData.fname) fname;}) names;
//  END;
//-----------------------------------------------------------------------------
EXPORT macGroupChildren(dIn,keyfields,childname,datafields,dOut,dAddTo='DATASET([],{UNSIGNED i})',recordmax='4096'):=MACRO
  LOADXML('<xml/>');
  #DECLARE(layoutdef)
  #DECLARE(newlayout)
  #DECLARE(assignments)
  #DECLARE(keys)
  #DECLARE(condition)
	#DECLARE(outerassignment)
  #DECLARE(hashclause)
  #DECLARE(jointable)
	#DECLARE(rowmax)
  
  #SET(newlayout,'')
  #SET(assignments,'')
  #SET(keys,'')
  #SET(condition,'')
  #SET(hashclause,'HASH32('+REGEXREPLACE(',',keyfields,'+')+')')
	#SET(rowmax,',MAXLENGTH('+(UNSIGNED)recordmax+') ')
  
  #EXPORT(layoutdef,RECORDOF(dIn))
  LOADXML(%'layoutdef'%,'fieldlist');
  #FOR(fieldlist)
    #FOR(Field)
      #IF(REGEXFIND(StringLib.StringToUpperCase(%'{@label}'%),StringLib.StringToUpperCase(datafields)))
        #APPEND(newlayout,'TYPEOF('+#TEXT(dIn)+'.'+%'{@label}'%+') '+%'{@label}'%+';')
        #APPEND(assignments,'LEFT.'+%'{@label}'%+',')
      #ELSE
        #IF(REGEXFIND(StringLib.StringToUpperCase(%'{@label}'%),StringLib.StringToUpperCase(keyfields)))
          #APPEND(keys,'TYPEOF('+#TEXT(dIn)+'.'+%'{@label}'%+') '+%'{@label}'%+';')
          #APPEND(condition,'LEFT.'+%'{@label}'%+'=RIGHT.'+%'{@label}'%+' AND ')
					#APPEND(outerassignment,'SELF.'+%'{@label}'%+':=IF((STRING)LEFT.'+%'{@label}'%+' IN [\'\',\'0\'],RIGHT.'+%'{@label}'%+',LEFT.'+%'{@label}'%+');')
        #END
      #END
    #END
  #END
  
  #IF(#TEXT(dAddTo)[..10]='DATASET([]')
    #SET(jointable,'DATASET([],{'+%'keys'%+'})')
  #ELSE
    #SET(jointable,#TEXT(dAddTo))
  #END

  #UNIQUENAME(lChild)
  %lChild%:={#EXPAND(%'newlayout'%)};
  #UNIQUENAME(dReformatted)
  %dReformatted%:=PROJECT(dIn,TRANSFORM({#IF((UNSIGNED)recordmax<>4096) #EXPAND(%'rowmax'%) #END #EXPAND(%'keys'%)DATASET(%lChild%) childname;},SELF.childname:=DATASET([{#EXPAND(%'assignments'%[..LENGTH(%'assignments'%)-1])}],%lChild%);SELF:=LEFT;));
  #UNIQUENAME(dRolled)
  %dRolled%:=ROLLUP(DEDUP(SORT(DISTRIBUTE(%dReformatted%,#EXPAND(%'hashclause'%)),RECORD,LOCAL),LOCAL),#EXPAND(%'condition'%[..LENGTH(%'condition'%)-5]),TRANSFORM(RECORDOF(%dReformatted%),SELF.childname:=LEFT.childname+RIGHT.childname;SELF:=LEFT;),LOCAL);
  #UNIQUENAME(lJoined)
	%lJoined%:={#IF((UNSIGNED)recordmax<>4096) #EXPAND(%'rowmax'%) #END RECORDOF(#EXPAND(%'jointable'%)) OR RECORDOF(%dRolled%)};
  dOut:=JOIN(DISTRIBUTE(#EXPAND(%'jointable'%),#EXPAND(%'hashclause'%)),%dRolled%,#EXPAND(%'condition'%[..LENGTH(%'condition'%)-5]),TRANSFORM(%lJoined%,#EXPAND(%'outerassignment'%)SELF:=RIGHT;SELF:=LEFT;),FULL OUTER,LOCAL);
ENDMACRO;
