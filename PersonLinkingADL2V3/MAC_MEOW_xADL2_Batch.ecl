export MAC_MEOW_xADL2_Batch(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_STATE = '',Input_ZIP = '',Input_ZIP4 = '',Input_COUNTY = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRS = '',OutFile,AsIndex='true') := MACRO
  #uniquename(ToProcess)
  #uniquename(TPRec)
  %TPRec% := record(PersonLinkingADL2V3.Process_xADL2_Layouts.InputLayout)
  end;
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(InFile le) := transform
    self.UniqueId := le.ref;
  #if (#TEXT(Input_NAME_SUFFIX)<>'')
    self.NAME_SUFFIX := (typeof(self.NAME_SUFFIX))le.Input_NAME_SUFFIX;
  #else
    self.NAME_SUFFIX := (typeof(self.NAME_SUFFIX))'';
  #end
  #if (#TEXT(Input_FNAME)<>'')
    self.FNAME := (typeof(self.FNAME))le.Input_FNAME;
  #else
    self.FNAME := (typeof(self.FNAME))'';
  #end
  #if (#TEXT(Input_MNAME)<>'')
    self.MNAME := (typeof(self.MNAME))le.Input_MNAME;
  #else
    self.MNAME := (typeof(self.MNAME))'';
  #end
  #if (#TEXT(Input_LNAME)<>'')
    self.LNAME := (typeof(self.LNAME))le.Input_LNAME;
  #else
    self.LNAME := (typeof(self.LNAME))'';
  #end
  #if (#TEXT(Input_PRIM_RANGE)<>'')
    self.PRIM_RANGE := (typeof(self.PRIM_RANGE))le.Input_PRIM_RANGE;
  #else
    self.PRIM_RANGE := (typeof(self.PRIM_RANGE))'';
  #end
  #if (#TEXT(Input_PRIM_NAME)<>'')
    self.PRIM_NAME := (typeof(self.PRIM_NAME))le.Input_PRIM_NAME;
  #else
    self.PRIM_NAME := (typeof(self.PRIM_NAME))'';
  #end
  #if (#TEXT(Input_SEC_RANGE)<>'')
    self.SEC_RANGE := (typeof(self.SEC_RANGE))le.Input_SEC_RANGE;
  #else
    self.SEC_RANGE := (typeof(self.SEC_RANGE))'';
  #end
  #if (#TEXT(Input_CITY)<>'')
    self.CITY := IF ( PersonLinkingADL2V3.Fields.Invalid_CITY((typeof(self.CITY))le.Input_CITY)=0,(typeof(self.CITY))le.Input_CITY,(typeof(self.CITY))'');
  #else
    self.CITY := (typeof(self.CITY))'';
  #end
  #if (#TEXT(Input_STATE)<>'')
    self.STATE := (typeof(self.STATE))le.Input_STATE;
  #else
    self.STATE := (typeof(self.STATE))'';
  #end
  #if (#TEXT(Input_ZIP)<>'')
    self.ZIP := (typeof(self.ZIP))le.Input_ZIP;
  #else
    self.ZIP := (typeof(self.ZIP))'';
  #end
  #if (#TEXT(Input_ZIP4)<>'')
    self.ZIP4 := (typeof(self.ZIP4))le.Input_ZIP4;
  #else
    self.ZIP4 := (typeof(self.ZIP4))'';
  #end
  #if (#TEXT(Input_COUNTY)<>'')
    self.COUNTY := (typeof(self.COUNTY))le.Input_COUNTY;
  #else
    self.COUNTY := (typeof(self.COUNTY))'';
  #end
  #if (#TEXT(Input_SSN5)<>'')
    self.SSN5 := (typeof(self.SSN5))le.Input_SSN5;
  #else
    self.SSN5 := (typeof(self.SSN5))'';
  #end
  #if (#TEXT(Input_SSN4)<>'')
    self.SSN4 := (typeof(self.SSN4))le.Input_SSN4;
  #else
    self.SSN4 := (typeof(self.SSN4))'';
  #end
  #if (#TEXT(Input_DOB)<>'')
    self.DOB := (typeof(self.DOB))le.Input_DOB;
  #else
    self.DOB := (typeof(self.DOB))'';
  #end
  #if (#TEXT(Input_PHONE)<>'')
    self.PHONE := (typeof(self.PHONE))le.Input_PHONE;
  #else
    self.PHONE := (typeof(self.PHONE))'';
  #end
  #if (#TEXT(Input_MAINNAME)<>'')
    self.MAINNAME := (typeof(self.MAINNAME))le.Input_MAINNAME;
  #else
    self.MAINNAME := (typeof(self.MAINNAME))'';
  #end
  #if (#TEXT(Input_FULLNAME)<>'')
    self.FULLNAME := (typeof(self.FULLNAME))le.Input_FULLNAME;
  #else
    self.FULLNAME := (typeof(self.FULLNAME))'';
  #end
  #if (#TEXT(Input_ADDR1)<>'')
    self.ADDR1 := (typeof(self.ADDR1))le.Input_ADDR1;
  #else
    self.ADDR1 := (typeof(self.ADDR1))'';
  #end
  #if (#TEXT(Input_LOCALE)<>'')
    self.LOCALE := (typeof(self.LOCALE))le.Input_LOCALE;
  #else
    self.LOCALE := (typeof(self.LOCALE))'';
  #end
  #if (#TEXT(Input_ADDRS)<>'')
    self.ADDRS := (typeof(self.ADDRS))le.Input_ADDRS;
  #else
    self.ADDRS := (typeof(self.ADDRS))'';
  #end
  end;
  #uniquename(fats)
  %fats% := project(InFile,%CleanT%(left));
  %ToProcess% := %fats%;
  // #uniquename(Output0)
  // PersonLinkingADL2V3.Key_PersonHeader_FLCST.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,FNAME,LNAME,CITY,STATE,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,ZIP,DOB,%Output0%,AsIndex)
  #uniquename(Output1)
  PersonLinkingADL2V3.Key_PersonHeader_LFZ.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,LNAME,FNAME,ZIP,CITY,PRIM_RANGE,PRIM_NAME,SSN5,SSN4,MNAME,SEC_RANGE,NAME_SUFFIX,DOB,%Output1%,AsIndex)
  // #uniquename(Output2)
  // PersonLinkingADL2V3.Key_PersonHeader_ADDRESS1.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP,FNAME,SEC_RANGE,LNAME,MNAME,DOB,%Output2%,AsIndex)
  // #uniquename(Output3)
  // PersonLinkingADL2V3.Key_PersonHeader_ADDRESS2.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,PRIM_NAME,PRIM_RANGE,ZIP,LNAME,SEC_RANGE,FNAME,MNAME,DOB,%Output3%,AsIndex)
  #uniquename(Output4)
  PersonLinkingADL2V3.Key_PersonHeader_ADDRESS3.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP,FNAME,MNAME,LNAME,DOB,SEC_RANGE,%Output4%,AsIndex)
  #uniquename(Output5)
  PersonLinkingADL2V3.Key_PersonHeader_S.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,SSN5,SSN4,FNAME,MNAME,LNAME,DOB,CITY,STATE,%Output5%,AsIndex)
  #uniquename(Output6)
	#uniquename(ToProcessSSN4)
	%ToProcessSSN4% := %ToProcess%((unsigned6)SSN5 = 0);
  PersonLinkingADL2V3.Key_PersonHeader_SSN4.MAC_ScoredFetch_Batch(%ToProcessSSN4%,UniqueId,SSN4,FNAME,LNAME,DOB,SSN5,%Output6%,AsIndex)
  #uniquename(Output7)
  PersonLinkingADL2V3.Key_PersonHeader_DO.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,DOB,LNAME,FNAME,STATE,CITY,SSN5,SSN4,MNAME,%Output7%,AsIndex)
  // #uniquename(Output8)
  // PersonLinkingADL2V3.Key_PersonHeader_DOBZIP.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,DOB,ZIP,FNAME,MNAME,LNAME,STATE,CITY,SSN5,SSN4,%Output8%,AsIndex)
  #uniquename(Output9)
  PersonLinkingADL2V3.Key_PersonHeader_PH.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,PHONE,FNAME,MNAME,LNAME,DOB,CITY,STATE,SSN5,SSN4,%Output9%,AsIndex)
  #uniquename(Output10)
  PersonLinkingADL2V3.Key_PersonHeader_ZPRF.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,ZIP,PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,DOB,%Output10%,AsIndex)
  // #uniquename(Output11)
  // PersonLinkingADL2V3.Key_PersonHeader_ZPNF.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,ZIP,PRIM_NAME,FNAME,LNAME,PRIM_RANGE,SEC_RANGE,DOB,%Output11%,AsIndex)
	#uniquename(Output12)
	PersonLinkingADL2V3.Key_PersonHeader_FLST.MAC_ScoredFetch_Batch(%ToProcess%,UniqueId,FNAME,LNAME,STATE,MNAME,DOB,CITY, %Output12%, AsIndex)
  #uniquename(All)
  //%All% := PersonLinkingADL2V3.Process_xADL2_Layouts.CombineAllScores(%Output0% + %Output1% + %Output2% + %Output3% + %Output4% + %Output5% + %Output6% + %Output7% + %Output8% + %Output9% + %Output10% + %Output11%);
	#uniquename(patched1)	
	
  //some code for testing on hthor
	// Output1i := %Output1% : independent;
	// Output4i := %Output4%  : independent;
	// Output5i := %Output5%  : independent;
	// Output6i := %Output6%  : independent;
	// Output7i := %Output7%  : independent;
	// Output9i := %Output9%  : independent;
	// Output10i := %Output10%	 : independent;	
	// Output12i := %Output12%  : independent;
	// ALLI := Output1i + Output4i + Output5i + Output6i + Output7i + Output9i + Output10i + Output12i;  
	// %patched1% := PersonLinkingADL2V3.PatchBug78402(ALLI);
	
	%patched1% := PersonLinkingADL2V3.PatchBug78402(%Output1% + %Output4% + %Output5% + %Output6% + %Output7% + %Output9% + %Output10% + %Output12%);
	#uniquename(patched2)	
	#uniquename(patched3)	
	#uniquename(inputs)	
	PersonLinkingADL2V3.PatchEditDistanceIssue().mac_FormInputs(%ToProcess%,%inputs%);
	%patched2% := PersonLinkingADL2V3.PatchEditDistanceIssue().ApplyIt(%patched1%,%inputs%);
	%patched3% := PersonLinkingADL2V3.DobForce(%patched2%, %ToProcess%);
	%All% := PersonLinkingADL2V3.Process_xADL2_Layouts.CombineAllScores(%patched3%);
	// %All% := PersonLinkingADL2V3.Process_xADL2_Layouts.CombineAllScores(%patched2%);
  OutFile := %All%;
ENDMACRO;
