IMPORT vendor_Src, ut, address, lib_stringlib, STD,Data_services;

EXPORT UpdateBase (STRING filedate, BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT VendorSrc_Base := FUNCTION
	
   CleanBankFile	          := Vendor_Src.StandardizeInputFile(filedate, pUseProd).Bank;
	 CleanLienFile	          := Vendor_Src.StandardizeInputFile(filedate, pUseProd).Lien;
	 FixedRiskViewFile        := Vendor_Src.StandardizeInputFile(filedate, pUseProd).RiskviewFFD;
	 CleanCourtLocatorFile	  := Vendor_Src.StandardizeInputFile(filedate, pUseProd).CourtLocator;
	 CollegeLocator          	:= Vendor_Src.StandardizeInputFile(filedate, pUseProd).CollegeLocator;	
	 MasterList      		      := Vendor_Src.StandardizeInputFile(filedate, pUseProd).MasterList;
	 
 	 
NewBaseData	:= CleanBankFile + CleanLienFile + FixedRiskViewFile + CleanCourtLocatorFile + MasterList + CollegeLocator; //+ Files().base.qa;
                                                                                                                              
				
DistNewBaseFile := DISTRIBUTE(NewBaseData, HASH(input_file_id, source_code));

SortedNewBaseFile := SORT(DistNewBaseFile,input_file_id, source_code,LOCAL);


temp_layout	:= RECORD										
		Vendor_Src.Layouts.MergedSrc_Base;	
END;	
	
	
temp_layout t_rollup(SortedNewBaseFile L, SortedNewBaseFile R) := TRANSFORM
SELF := IF(L.date_added>R.date_added,L,R);
END;
	

RolledBase := ROLLUP(SortedNewBaseFile,
                    LEFT.input_file_id = RIGHT.input_file_id AND
										LEFT.source_code = RIGHT.source_code,
										t_rollup(LEFT, RIGHT),LOCAL);


NewBaseFile   :=PROJECT(RolledBase,TRANSFORM({NewBaseData}
										,SELF.item_source:=IF(LEFT.source_code='','VENDOR',LEFT.source_code)
										,SELF:=LEFT));

	
RETURN NewBaseFile;
END;
END;

