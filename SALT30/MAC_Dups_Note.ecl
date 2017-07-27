// Temporary workaround to accomodate 5th parameter
// Dedup the records heading into an external linking batch
// Note the tied to the name and case of UniqueId
export MAC_Dups_Note(infile,outformat,outfile,outdups,uniqueIDField='uniqueid') := MACRO
#uniquename(r0)
  %r0% := RECORD
	  infile;
		SALT30.UIDType __shadow_ref := infile.uniqueIDField;
	END;
#uniquename(wider)
  %wider% := SORT( TABLE(infile,%r0%),EXCEPT uniqueIDField,__shadow_ref, SKEW(1));
#uniquename(tra)
  %r0% %tra%(%wider% le,%wider% ri) := 	TRANSFORM
	  SELF.__shadow_ref := IF ( TRUE
#EXPORTXML(AllFields, RECORDOF(infile))
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
	outfile := PROJECT(%noted%(uniqueIDField=__shadow_ref),TRANSFORM(outformat,SELF := LEFT));
  outdups := TABLE(%noted%(uniqueIDField<>__shadow_ref),{uniqueIDField,__shadow_ref});	
  ENDMACRO;
