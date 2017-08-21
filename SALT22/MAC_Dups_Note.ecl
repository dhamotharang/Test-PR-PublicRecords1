// Dedup the records heading into an external linking batch
// Note the tied to the name and case of UniqueId
export MAC_Dups_Note(infile,outformat,outfile,outdups) := MACRO
#uniquename(r0)
  %r0% := RECORD
	  infile;
		SALT22.UIDType __shadow_ref := infile.UniqueId;
	END;
#uniquename(wider)
  %wider% := SORT( TABLE(infile,%r0%),EXCEPT UniqueId,__shadow_ref );
#uniquename(tra)
  %r0% %tra%(%wider% le,%wider% ri) := 	TRANSFORM
	  SELF.__shadow_ref := IF ( TRUE
#EXPORTXML(AllFields, RECORDOF(infile))
	#FOR (AllFields)
		#FOR (Field)
		  #IF(Stringlib.StringToLowerCase(%'@name'%)<>'uniqueid')
	AND le.%@name%=ri.%@name%
	    #END
		#END
	#END
		,le.__shadow_ref,ri.UniqueId );
	  SELF := ri;
	END;
	#uniquename(noted)
  %noted% := ITERATE(%wider%,%tra%(LEFT,RIGHT));
	outfile := PROJECT(%noted%(UniqueId=__shadow_ref),TRANSFORM(outformat,SELF := LEFT));
  outdups := TABLE(%noted%(UniqueId<>__shadow_ref),{UniqueId,__shadow_ref});	
  ENDMACRO;