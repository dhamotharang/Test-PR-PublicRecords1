//Defines full build process
IMPORT _control, versioncontrol, Vendor_src;

EXPORT Build_Base(STRING pversion,BOOLEAN	pUseProd = FALSE) := MODULE
	
EXPORT build_base := Vendor_Src.UpdateBase(pversion, pUseProd).VendorSrc_Base;


VersionControl.macBuildNewLogicalFile(Filenames(pversion, pUseProd).base.new
																		 ,build_base
																		 ,Build_Base_File
																		 );
SHARED full_build	:= 
                 SEQUENTIAL(				
						 		 Build_Base_File
								,Promote.Promote_vendorsrc(pversion, pUseProd).buildfiles.New2Built);
	

BaseFileLayout := RECORD
Vendor_Src.Layouts.Base;
END;

PrevBase := Vendor_Src.Files().base.father;
NewBase  := Vendor_Src.Files().base.built;

PrevBaseLayout := RECORD
	PrevBase.source_code;
	PrevBase.input_file_id;
	INTEGER CNT := COUNT(GROUP);
END;

PrevBaseTable := TABLE(PrevBase,PrevBaseLayout,source_code, input_file_id);
PrevBaseRecSort := SORT(PrevBaseTable, source_code, input_file_id);
OUTPUT(PrevBaseRecSort,NAMED('PrevBaseSortedBySource_code_and_Input_file_id'));
PrevBaseRecCount:=COUNT(PrevBaseRecSort);
OUTPUT(PrevBaseRecCount, NAMED('PrevBaseSortedRecCnt'));

NewBaseLayout := RECORD
	NewBase.source_code;
	NewBase.input_file_id;
	INTEGER CNT := COUNT(GROUP);
END;

NewBaseTable := TABLE(NewBase,NewBaseLayout,source_code, input_file_id);
NewBaseRecSort := SORT(NewBaseTable, source_code, input_file_id);
OUTPUT(NewBaseRecSort,NAMED('NewBaseSortedBySource_code_and_Input_file_id'));
NewBaseRecCount:=COUNT(NewBaseRecSort);
OUTPUT(NewBaseRecCount, NAMED('NewBaseSortedRecCnt'));


j := JOIN(PrevBaseTable, NewBaseTable,
          LEFT.source_code=RIGHT.source_code AND LEFT.input_file_id=RIGHT.input_file_id,
					TRANSFORM(BaseFileLayout,
					SELF.source_code := IF(LEFT.source_code<>'', LEFT.source_code, RIGHT.source_code);
					SELF:=LEFT;
					SELF:=[];
	      ),LEFT ONLY);
OUTPUT(j,NAMED('PrevBaseAndNewBaseLeftOnlyJoin'));
InnerJoinCount:=COUNT(j);
OUTPUT(InnerJoinCount, NAMED('NotMatchingRecCnt'));


BaseComparison := PrevBaseRecCount<=NewBaseRecCount;

OUTPUT(BaseComparison,NAMED('IsNewBaseHaveSameOrMoreRecThanPrevBase'));


isBuild := VersionControl.IsValidVersion(pversion) AND BaseComparison <> FALSE;

EXPORT All :=
					  IF (isBuild
								,full_build
								,OUTPUT('No Valid version parameter passed or source_code do not match previous base source_code, skipping base build')
								): 
								success(IF ( isBuild,Send_Email_BuildBase(pversion,pUseProd).BuildSuccess,Send_Email_BuildBase(pversion,pUseProd).BuildFailure));
				        
END;