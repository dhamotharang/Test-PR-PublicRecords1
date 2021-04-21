EXPORT MAC_Indicators(infile,outfile) := MACRO
IMPORT doxie_files,SexOffender;
  #uniquename(setHasCriminalConviction)
  RECORDOF(infile) %setHasCriminalConviction%(RECORDOF(infile) L,RECORDOF(doxie_files.Key_Offenders()) R) := TRANSFORM
    SELF.HasCriminalConviction:=L.HasCriminalConviction OR R.sdid!=0;
    SELF:=L;
  END;

  #uniquename(crimRecs)
  %crimRecs% := JOIN(infile,doxie_files.Key_Offenders(),KEYED((UNSIGNED)LEFT.UniqueId=RIGHT.sdid),
    %setHasCriminalConviction%(LEFT,RIGHT),LEFT OUTER,LIMIT(10000,SKIP),KEEP(1));

  #uniquename(setIsSexualOffender)
  RECORDOF(infile) %setIsSexualOffender%(RECORDOF(infile) L,RECORDOF(SexOffender.Key_SexOffender_DID()) R) := TRANSFORM
    SELF.IsSexualOffender:=L.IsSexualOffender OR R.did!=0;
    SELF:=L;
  END;

  outfile := JOIN(%crimRecs%,SexOffender.Key_SexOffender_DID(),KEYED((UNSIGNED)LEFT.UniqueId=RIGHT.did),
    %setIsSexualOffender%(LEFT,RIGHT),LEFT OUTER,LIMIT(10000,SKIP),KEEP(1));
ENDMACRO;
