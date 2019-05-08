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
															
MyRec := RECORD
Vendor_Src.Layouts.Base;
END;

PrevBase := DATASET('~thor_data400::base::vendor_src::father', MyRec, thor);
NewBase := DATASET('~thor_data400::base::vendor_src::built', MyRec, thor);

MyOutRec := RECORD
	PrevBase.source_code;
	INTEGER CNT := COUNT(GROUP);
END;

MyTable := TABLE(PrevBase,MyOutRec,source_code);
RecSort := SORT(MyTable, -cnt, source_code);
OUTPUT(RecSort,NAMED('PrevBase'));
PrevBaseCount:=COUNT(RecSort);
OUTPUT(PrevBaseCount, NAMED('PrevBaseSource_Code_Count'));

OUTPUT(PrevBase(source_code in SET (MyTable (cnt > 1), source_code)),NAMED('Source_Records_For_Multiple_SOurce_Code'));


MyOutRec2 := RECORD
	NewBase.source_code;
	INTEGER CNT := COUNT(GROUP);
END;

MyTable2 := TABLE(NewBase,MyOutRec2,source_code);
RecSort2 := SORT(MyTable2, source_code);
OUTPUT(RecSort2,NAMED('NewBase'));
NewBaseCount:=COUNT(RecSort2);
OUTPUT(NewBaseCount, NAMED('NewBaseSource_Code_Count'));


j := JOIN(MyTable, MyTable2,
          LEFT.source_code=RIGHT.source_code,
					TRANSFORM(MyRec,
					SELF.source_code := IF(LEFT.source_code<>'', LEFT.source_code, RIGHT.source_code);
					SELF:=LEFT;
					SELF:=[];
	      ));
OUTPUT(j,NAMED('Inner_Join'));
InnerJoinCount:=COUNT(j);
OUTPUT(InnerJoinCount, NAMED('Inner_Join_Source_Code_Count'));


BaseComparison := PrevBaseCount<=NewBaseCount;


isBuild := VersionControl.IsValidVersion(pversion) AND BaseComparison <> FALSE;

EXPORT All :=
					  IF (isBuild
								,full_build
								,OUTPUT('No Valid version parameter passed or source_code do not match previous base source_code, skipping base build')
								): 
								success(IF ( isBuild,Send_Email_BuildBase(pversion,pUseProd).BuildSuccess,Send_Email_BuildBase(pversion,pUseProd).BuildFailure));
				        
END;