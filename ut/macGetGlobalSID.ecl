EXPORT macGetGlobalSid(dInFile, sDatasetName, SFieldName='', sGlobalSid) := FUNCTIONMACRO

  lOrbit3GlbSrcid := RECORD
    STRING  Dataset_Id;
    STRING  Dataset_Name;
    STRING  Source_Codes;
    STRING  Company_Name;
    STRING  Glb_Srcid;
    STRING  Build_Template_Name;
    STRING  Maxlevel;
    STRING  Roxie_Packages;
  END;
  dOrbitGlobalSid := DATASET('~THOR::BASE::ORBIT3::qa::GLB_SRCID_TEST', lOrbit3GlbSrcid, THOR);

  lDataGlobalSid := RECORD
    STRING DsShortName;
    STRING Field_Name;
    STRING Field_Value;
    STRING Dataset_Id;
    STRING Dataset_Name;
    STRING Global_SID;
  END;
  dDataGlobalSid := DATASET('~THOR::BASE::DATA::GLB_SRCID',lDataGlobalSid,CSV(HEADING(1)));

  dDataOrbitJoinSid := JOIN(
	  DEDUP(
      SORT(
        DISTRIBUTE(dOrbitGlobalSid,HASH32(Dataset_Id)),
        Dataset_Id,LOCAL
      ),
			Dataset_Id, LOCAL
		),
    SORT(
      DISTRIBUTE(dDataGlobalSid,HASH32(Dataset_Id)),
      Dataset_Id,LOCAL
    ),
    LEFT.Dataset_Id = RIGHT.Dataset_Id
  );

  dFilterGSidFile := dDataOrbitJoinSid(DsShortName = sDatasetName) : PERSIST('~persist::data::glb_srcid');
  
	lInRec := {RecordOf(dInFile)};

  #DECLARE(sFilter);
	#SET(sFilter, '');   
  #IF(SFieldName <> '')
	  #APPEND(sFilter, '(Field_Value = l.' + #TEXT(#EXPAND(SFieldName)) + ')')
	#END

  fFilterGlbSrcid (lInRec l) := FUNCTION
	  sGlbSrcid := dFilterGSidFile #IF(SFieldName <> '')#EXPAND(#TEXT(%sFilter%))#END;
    tGlobalSrcID := TABLE(sGlbSrcid, {Glb_Srcid, cnt:=COUNT(GROUP)},Glb_Srcid);

    aCheckDatasetDups := IF(EXISTS(tGlobalSrcID(cnt > 1 AND GLB_SRCID != '')), OUTPUT('***WARNING:Duplicate GLB_SRCID for Dataset ' + sDatasetName,NAMED('WarningDups')));
    aCheckGlobalSRCID := IF(EXISTS(tGlobalSrcID(GLB_SRCID = '')), OUTPUT('***WARNING:GLB_SRCID IS BLANK for Dataset ' + sDatasetName,NAMED('WarningBlanks'))); 
            
    ORDERED(aCheckDatasetDups, aCheckGlobalSRCID);

    RETURN tGlobalSrcID[1].Glb_Srcid;
	END;

  lInRec xGlobalSid(dInFile l) := TRANSFORM
    SELF.#EXPAND(sGlobalSid) := (unsigned4)fFilterGlbSrcid(l);
    SELF := l;
  END;

  dOutFile := project(dInFile,xGlobalSid(left));

  RETURN dOutFile;

ENDMACRO;
