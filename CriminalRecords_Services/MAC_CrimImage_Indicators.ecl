EXPORT MAC_CrimImage_Indicators(inrecs,outrecs) := MACRO
  IMPORT SexOffender_Services, ut;

  #uniquename(slim_layout);
  %slim_layout% := RECORD
    STRING12 did;
    BOOLEAN hasCriminalImages := FALSE;
    BOOLEAN hasSexualOffenderImages := FALSE;
  END;

  #uniquename(inrecs_slim);
  %inrecs_slim% := PROJECT(inrecs, TRANSFORM(%slim_layout%, SELF := LEFT));

  #uniquename(inrecs_slim_dedup);
  %inrecs_slim_dedup% := DEDUP(SORT(%inrecs_slim%, did), did);

  // criminal images section.
  #uniquename(hasCriminalImages);
    RECORDOF(%inrecs_slim_dedup%) %hasCriminalImages%(RECORDOF(%inrecs_slim_dedup%) L,RECORDOF(doxie_files.Key_Offenders()) R) := TRANSFORM
      SELF.hasCriminalImages:= R.image_link != '';
      SELF:=L;
  END;

  #uniquename(crimRecs);
  %crimRecs% := JOIN(%inrecs_slim_dedup%,doxie_files.Key_Offenders(),
                  KEYED((UNSIGNED6)LEFT.did=RIGHT.sdid),
                  %hasCriminalImages%(LEFT,RIGHT),
                  LIMIT(ut.limits.OFFENDERS_PER_DID,SKIP));

  //only need 1 record atmost
  #uniquename(crimRecs_dedup);
  %crimRecs_dedup% := DEDUP(SORT(%crimRecs%(hasCriminalImages),did), did);
    
  // sexoffender image section.
  #uniquename(sospks);
  %sospks% := JOIN(%inrecs_slim_dedup%, SexOffender.Key_SexOffender_DID(),
                KEYED((UNSIGNED6)LEFT.did=RIGHT.did),
                LIMIT(ut.limits.SOFFENDER_MAX,SKIP));

  #uniquename(hasSexualOffenderImages)
    RECORDOF(%sospks%) %hasSexualOffenderImages%(RECORDOF(%sospks%) L,RECORDOF(SexOffender.key_SexOffender_SPK()) R) := TRANSFORM
      SELF.hasSexualOffenderImages:= R.image_link != '';
      SELF:=L;
  END;

  #uniquename(sorec);
  %sorec% := JOIN(%sospks%, SexOffender.key_SexOffender_SPK(),
              KEYED(LEFT.seisint_primary_key=RIGHT.sspk),
              %hasSexualOffenderImages%(LEFT,RIGHT),
              LIMIT(SexOffender_Services.Constants.MAX_RECS_PERDID, SKIP));

  //only need 1 record atmost
  #uniquename(soRecs_dedup);
  %soRecs_dedup% := DEDUP(SORT(%sorec%(hasSexualOffenderImages),did), did);

  #uniquename(combinedRecs);
  %combinedRecs% := JOIN(inrecs, %crimRecs_dedup%,
                      LEFT.did = RIGHT.did,
                      TRANSFORM (RECORDOF(inrecs),
                        SELF.hasCriminalImages := RIGHT.hasCriminalImages,
                        SELF := LEFT),
                      LEFT OUTER, LIMIT(0), KEEP(1));

  outrecs := JOIN(%combinedRecs%, %soRecs_dedup%,
              LEFT.did = RIGHT.did,
              TRANSFORM (RECORDOF(inrecs),
                SELF.hasSexualOffenderImages := RIGHT.hasSexualOffenderImages,
                SELF := LEFT),
              LEFT OUTER, LIMIT(0), KEEP(1));
ENDMACRO;
