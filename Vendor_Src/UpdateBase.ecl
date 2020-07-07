IMPORT vendor_Src, ut, address, lib_stringlib, STD,Data_services;

EXPORT UpdateBase (STRING filedate, BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT VendorSrc_Base := FUNCTION
	
   CleanBankFile	          := Vendor_Src.StandardizeInputFile(filedate, pUseProd).Bank;
	 CleanLienFile	          := Vendor_Src.StandardizeInputFile(filedate, pUseProd).Lien;
	 OrbitFile                := Vendor_Src.StandardizeInputFile(filedate, pUseProd).OrbitFFD;
	 CleanCourtLocatorFile	  := Vendor_Src.StandardizeInputFile(filedate, pUseProd).CourtLocator;
	 CollegeLocator          	:= Vendor_Src.StandardizeInputFile(filedate, pUseProd).CollegeLocator;	
	 MasterList      		      := Vendor_Src.StandardizeInputFile(filedate, pUseProd).MasterList;
	 
 	 
NewBaseData	:= CleanBankFile + CleanLienFile + OrbitFile + CleanCourtLocatorFile + MasterList + CollegeLocator + Files().base.qa;
                                                                                                                              
				
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


NewBase   :=PROJECT(RolledBase,TRANSFORM({NewBaseData}
										,SELF.item_source:=IF(LEFT.source_code='','VENDOR',LEFT.source_code)
										,SELF:=LEFT));
										
																			
NoLexisNexis:=NewBase(~regexfind('\\s*(.*)LEXIS(.*)\\s*',display_name));

YesLexisNexis:=NewBase(regexfind('\\s*(.*)LEXIS(.*)\\s*',display_name));

LexisNexisTransform := PROJECT(YesLexisNexis,TRANSFORM({NewBaseData},
                              SELF.display_name:='LEXISNEXIS',
															SELF.clean_phone:='8884970011',
															SELF.prepped_addr1:='LEXISNEXIS CONSUMER CENTER P.O. BOX 105108',
															SELF.prepped_addr2:='ALPHARETTA, GA 30348-5108',
															SELF.prim_range:='105108',SELF.predir:='',
															SELF.prim_name:='P.O. BOX',SELF.addr_suffix:='',
															SELF.unit_desig:='',
															SELF.sec_range:='',
															SELF.p_city_name:='ALPHARETTA',
															SELF.v_city_name:='ALPHARETTA',
															SELF.st:='GA',
															SELF.zip:='30348',
															SELF.zip4:='5108',
															SELF.county:='13121',
															SELF.geo_lat:='34.093090',
															SELF.geo_long:='-84.245719',
															SELF.geo_blk:='0116211',
															SELF :=LEFT));

NewBaseFile:= NoLexisNexis + LexisNexisTransform;

RETURN NewBaseFile;
END;
END;


