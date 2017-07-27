// Temporary workaround to accomodate 5th parameter
// Dedup the records heading into an external linking batch
// Note the tied to the name and case of UniqueId
export MAC_Dups_Note(infile,outformat,outfile,outdups,uniqueIDField='uniqueid',meow_dedup='\'\'') := MACRO
#UNIQUENAME(ds_in)
#UNIQUENAME(ds_pass)
#UNIQUENAME(ds_repeat)
#UNIQUENAME(cnt)
%ds_repeat% := TABLE(infile,{uniqueIDField, UNSIGNED %cnt%:=COUNT(GROUP)},uniqueIDField)(%cnt%>1);
%ds_in% := CASE(
	meow_dedup,
	'ALWAYS'	=> infile,
	'NEVER'		=> DATASET([],RECORDOF(infile)),
	JOIN(infile,%ds_repeat%,LEFT.uniqueIDField=RIGHT.uniqueIDField,TRANSFORM(LEFT),LEFT ONLY,SMART)
);
%ds_pass% := CASE(
	meow_dedup,
	'ALWAYS'	=> DATASET([],RECORDOF(infile)),
	'NEVER'		=> infile,
	JOIN(infile,%ds_repeat%,LEFT.uniqueIDField=RIGHT.uniqueIDField,TRANSFORM(LEFT),SMART)
);
#uniquename(r0)
  %r0% := RECORD
	  %ds_in%;
		SALT32.UIDType __shadow_ref := %ds_in%.uniqueIDField;
	END;
#uniquename(wider)
  %wider% := SORT( TABLE(%ds_in%,%r0%),EXCEPT uniqueIDField,__shadow_ref, SKEW(1));
#uniquename(tra)
  %r0% %tra%(%wider% le,%wider% ri) := 	TRANSFORM
	  SELF.__shadow_ref := IF ( TRUE
#EXPORTXML(AllFields, RECORDOF(%ds_in%))
#DECLARE(InChild)
#SET(InChild,0)
	#FOR (AllFields)
		#FOR (Field)
			#IF(%'@isDataset'%='1')
				#SET(InChild,1)
			#END
		  #IF(Stringlib.StringToLowerCase(%'@name'%)<>Stringlib.StringToLowerCase(#TEXT(uniqueIDField)) AND %InChild% = 0)
	AND le.%@name%=ri.%@name%
	    #END
			#IF(%'@isEnd'%='1')
				#SET(InChild,0)
			#END
		#END
	#END
		,le.__shadow_ref,ri.uniqueIDField );
	  SELF := ri;
	END;
	#uniquename(noted)
  %noted% := ITERATE(%wider%,%tra%(LEFT,RIGHT),LOCAL);
	outfile := PROJECT(%noted%(uniqueIDField=__shadow_ref),TRANSFORM(outformat,SELF := LEFT)) + PROJECT(%ds_pass%,TRANSFORM(outformat,SELF:=LEFT));
  outdups := TABLE(%noted%(uniqueIDField<>__shadow_ref),{uniqueIDField,__shadow_ref});	
  ENDMACRO;
