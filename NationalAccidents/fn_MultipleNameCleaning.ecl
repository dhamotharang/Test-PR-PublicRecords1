Import NID, NID_Support;

EXPORT fn_MultipleNameCleaning (DATASET (Layouts_NAccidentsInquiry.ORDER_COMBINED) BaseFile) := FUNCTION
	
  NewBase_Rec := RECORD
    RECORDOF(BaseFile);
    UNSIGNED8 Record_Id;
  END;
	
  NewBase_Rec Trans (BaseFile L, INTEGER C) := TRANSFORM
    SELF.Record_Id := C;
    SELF := L;
  END;
  NewBase := PROJECT(BaseFile, Trans(LEFT,COUNTER));
	
  dNewBase := DISTRIBUTE(NewBase, HASH32(Record_ID));
	
  rTmpRawNameRecord	:= RECORD
    UNSIGNED8 Record_Id;
    UNSIGNED2 Name_Sequence;
    STRING20  First_Name;
    STRING15  Middle_Name;
    STRING20  Last_Name;
    STRING3   Suffix;	
  END;
	
  rTmpRawNameRecord Norm (dNewBase L, INTEGER C) := TRANSFORM
    SELF.Name_Sequence  := C;
    SELF.First_Name     := CHOOSE (C, L.First_Name_1, L.First_Name_2, L.First_Name_3);
    SELF.Middle_Name    := CHOOSE (C, L.Middle_Name_1, L.Middle_Name_2, L.Middle_Name_3);
    SELF.Last_Name      := CHOOSE (C, L.Last_Name_1, L.Last_Name_2, L.Last_Name_3);
    SELF.Suffix         := '';
    SELF                := L;
  END;
  NormNames := NORMALIZE(dNewBase, 3, Norm(LEFT,COUNTER));	
	
  FNormNames := NormNames(First_Name != '' OR Middle_Name != '' OR Last_Name != '');		
	
  NID.Mac_CleanParsedNames(FNormNames, NIDNames, First_Name, Middle_Name, Last_Name, Suffix);
	
  dNIDNames := DISTRIBUTE(NIDNames, HASH32(Record_ID));
  sNIDNames := SORT(dNIDNames, Record_ID, Name_Sequence, LOCAL);
	
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
  NewBase_Rec DenormThem(dNewBase L, sNIDNames R ) := TRANSFORM
    isNotBlank                := R.cln_lname != '' OR R.cln_fname != '' OR R.cln_mname != '' OR R.cln_suffix = '';
        
    SELF.NID                  := IF (R.Name_Sequence=1, R.NID, L.NID);
    SELF.Title                := IF (isNotBlank AND R.Name_Sequence=1, R.cln_Title, L.Title);
    SELF.LName                := IF (isNotBlank AND R.Name_Sequence=1, R.cln_Lname, L.LName);
    SELF.FName                := IF (isNotBlank AND R.Name_Sequence=1, R.cln_Fname, L.FName);
    SELF.MName                := IF (isNotBlank AND R.Name_Sequence=1, R.cln_Mname, L.MName);
    SELF.Suffix               := IF (isNotBlank AND R.Name_Sequence=1, R.cln_Suffix, L.Suffix);
        
    SELF.NID2                 := IF (R.Name_Sequence=2, R.NID, L.NID2);
    SELF.Title2               := IF (isNotBlank AND R.Name_Sequence=2, R.cln_Title, L.Title2);
    SELF.LName2               := IF (isNotBlank AND R.Name_Sequence=2, R.cln_Lname, L.LName2);
    SELF.FName2               := IF (isNotBlank AND R.Name_Sequence=2, R.cln_Fname, L.FName2);
    SELF.MName2               := IF (isNotBlank AND R.Name_Sequence=2, R.cln_Mname, L.MName2);
    SELF.Suffix2              := IF (isNotBlank AND R.Name_Sequence=2, R.cln_Suffix, L.Suffix2);
        
    SELF.NID3                 := IF (R.Name_Sequence=3, R.NID, L.NID3);
    SELF.Title3               := IF (isNotBlank AND R.Name_Sequence=3, R.cln_Title, L.Title3);
    SELF.LName3               := IF (isNotBlank AND R.Name_Sequence=3, R.cln_Lname, L.LName3);
    SELF.FName3               := IF (isNotBlank AND R.Name_Sequence=3, R.cln_Fname, L.FName3);
    SELF.MName3               := IF (isNotBlank AND R.Name_Sequence=3, R.cln_Mname, L.MName3);
    SELF.Suffix3              := IF (isNotBlank AND R.Name_Sequence=3, R.cln_Suffix, L.Suffix3);
        
    SELF                      := L;
  END;
  dCleanName                  := DENORMALIZE(dNewBase, sNIDNames, LEFT.Record_Id = RIGHT.Record_Id, 
                                             DenormThem(LEFT, RIGHT), LOCAL);
														 
  CleanName                   := PROJECT(dCleanName, {RECORDOF(Basefile)});	
	
  RETURN CleanName;
END;