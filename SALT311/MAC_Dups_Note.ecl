// Temporary workaround to accomodate 5th parameter
// Dedup the records heading into an external linking batch
// Note the tied to the name and case of UniqueId
export MAC_Dups_Note(infile,outformat,outfile,outdups,uniqueIDField='uniqueid',meow_dedup='\'\'') := MACRO
#UNIQUENAME(ds_in)
#UNIQUENAME(ds_pass)
#UNIQUENAME(ds_repeat)
#UNIQUENAME(cnt)
%ds_repeat% := TABLE(infile,{uniqueIDField, UNSIGNED %cnt%:=COUNT(GROUP)},uniqueIDField)(%cnt%>1);
%ds_in% := 
	IF(meow_dedup='ALWAYS', infile,
	IF(meow_dedup='NEVER', DATASET([],RECORDOF(infile)),
	JOIN(infile,%ds_repeat%,LEFT.uniqueIDField=RIGHT.uniqueIDField,TRANSFORM(LEFT),LEFT ONLY,SMART) ));
%ds_pass% := 
	IF(meow_dedup='ALWAYS', DATASET([],RECORDOF(infile)),
	IF(meow_dedup='NEVER', infile,
	JOIN(infile,%ds_repeat%,LEFT.uniqueIDField=RIGHT.uniqueIDField,TRANSFORM(LEFT),SMART) ));
#uniquename(r0)
  %r0% := RECORD
	  %ds_in%;
		SALT311.UIDType __shadow_ref := %ds_in%.uniqueIDField;
	END;
#uniquename(wider)
  %wider% := SORT( TABLE(%ds_in%,%r0%),EXCEPT uniqueIDField,__shadow_ref, SKEW(1));
#uniquename(tra)
  %r0% %tra%(%wider% le,%wider% ri) := 	TRANSFORM
	  SELF.__shadow_ref := IF (
#EXPORTXML(AllFields, RECORDOF(%ds_in%))
#EXPAND(REGEXREPLACE('[|]',REGEXREPLACE('([^|]+)',REGEXREPLACE('¶_[^¶]+_¶',
	#FOR (AllFields)
		#FOR (Field)
			#IF(%'@isDataset'%='1' OR %'@isRecord'%='1')
				'¶_'+
			#ELSIF(%'@isEnd'%='1')
				'_¶'+
			#ELSIF(StringLib.StringToLowerCase(%'@name'%)<>StringLib.StringToLowerCase(#TEXT(uniqueIDField)))
        '|'+%'@name'%+
	    #END
		#END
	#END
'','')[2..],'le.$1=ri.$1'),' AND '))
		,le.__shadow_ref,ri.uniqueIDField );
	  SELF := ri;
	END;
	#uniquename(noted)
  %noted% := ITERATE(%wider%,%tra%(LEFT,RIGHT),LOCAL);
	outfile := PROJECT(%noted%(uniqueIDField=__shadow_ref),TRANSFORM(outformat,SELF := LEFT)) + PROJECT(%ds_pass%,TRANSFORM(outformat,SELF:=LEFT));
  outdups := TABLE(%noted%(uniqueIDField<>__shadow_ref),{uniqueIDField,__shadow_ref});	
  ENDMACRO;
