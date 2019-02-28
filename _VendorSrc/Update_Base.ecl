IMPORT misc, ut, address, lib_stringlib, STD;

EXPORT Update_Base (string filedate, boolean pUseProd = false) := MODULE

	EXPORT VendorSrc_Base := FUNCTION

 	 // OldData							:= Misc.Files_VendorSrc(pVersion).OldData;
	// PrevBase						  := Misc.Files_VendorSrc(pVersion).Combined_Base;
	// NewBank							:= Misc.Files_VendorSrc(pVersion).Bankruptcy;
	// NewLien							:= Misc.Files_VendorSrc(pVersion).Lien;
	 // NewRiskview					:= Misc.Files_VendorSrc(pVersion).RiskviewFFD;
	
	
	// OldVendorSrc				  := Misc.Files_VendorSrc(pVersion).OldVendorSrc;
	// Market_Restrict			:= Misc.Files_VendorSrc(pVersion).Market_restrict;
 // Court_Locations 		  := Misc.Files_VendorSrc('').Court_Locations;
	// MasterList      		  := Misc.Files_VendorSrc('').MasterList;
 // CollegeLocator     	:= Misc.Files_VendorSrc('').CollegeLocator;	
	
	

	//Base	                    := _VendorSrc.StandardizeInputFile(filedate, pUseProd).Base;
	CleanBankFile	            := _VendorSrc.StandardizeInputFile(filedate, pUseProd).BankInput;
	CleanLienFile	            := _VendorSrc.StandardizeInputFile(filedate, pUseProd).LienInput;
	CleanRiskViewFile       	:= _VendorSrc.StandardizeInputFile(filedate, pUseProd).RiskviewFFDInput;
	FixedRiskViewFile       	:= _VendorSrc.StandardizeInputFile(filedate, pUseProd).RiskviewFFDInput;
	CleanMasterList      		  := _VendorSrc.StandardizeInputFile(filedate, pUseProd).MasterListInput;
	//NewOldFormatFile	        := _VendorSrc.StandardizeInputFile(filedate, pUseProd).NewLien;
	CleanCourt_LocationsFile	:= _VendorSrc.StandardizeInputFile(filedate, pUseProd).CourtLocatorInput;
	//CleanOldFormatFile	      := _VendorSrc.StandardizeInputFile(filedate, pUseProd).NewLien;
	//CleanOldFormat_w_flag     := JOIN(sort(distribute(CleanOldFormatFile,hash(source_code)),source_code, local), Market_Restrict,
										            // LEFT.source_code=RIGHT.source_code,
										            // transform(Misc.Layout_VendorSrc.MergedSrc_Base, 
											        	// SELF.market_restrict_flag	:= RIGHT.marketingrestricted,
											        	// SELF				:= LEFT),
											        	// LEFT OUTER, LOOKUP);

	temp_layout	:= RECORD										// only needed temporarily to treat the base as an update, not a full refresh - intention is to be a full refresh at some point
		Misc.Layout_VendorSrc.MergedSrc_Base;	// but for the interim, we need to treat as an update to make sure that data that currently exists in the old base file
		STRING	record_type;									// does not get lost.
	END;

	HistOldData	:= project ((OldData + PrevBase(input_file_id not in ['PROFLIC','MARI'])),
														transform({temp_layout},
															SELF.record_type := 'H',
															SELF	:= LEFT));
															
	CrimSourceData := PROJECT(misc.Files_VendorSrc('').dsCrimSources, CleanCrimSources(LEFT));
	pMasterList := PROJECT(MasterList(LNfileCategory<>'',LNsourcetCode<>'',vendorName<>'',address1<>'',city<>'',state<>'',zipcode<>''), CleanMasterList(LEFT));
	pCollegeLocator := PROJECT(CollegeLocator(LNfileCategory<>'',LNsourcetCode<>'',vendorName<>'',address1<>'',city<>'',state<>'',zipcode<>''), CleanMasterList(LEFT));



// ****** New base file
	
	NewBaseData	:= CleanBankFile + CleanLienFile + FixedRiskViewFile + CleanOldFormat_w_flag 
										+ CleanCourt_LocationsFile + CrimSourceData + pMasterList
										+ pCollegeLocator;
	
	MarkCurrent	:= project (NewBaseData,
														transform({temp_layout},
															SELF.record_type	:= 'C',
															SELF	:= LEFT));
															
	OldAndNew	:= HistOldData + MarkCurrent;
	
		string75 filterThisOut := 'DENOTES DATA THAT IS SO OLD, NO SOURCE IS KNOWN';

	SortOldAndNew := SORT(distribute(OldAndNew(source_code<>filterThisOut), hash(item_source, source_code)),item_source, source_code,input_file_id,LOCAL);
										
	temp_layout t_rollup (SortOldAndNew L, SortOldAndNew R) := TRANSFORM
			SELF						 							:= IF(L.record_type = 'C', L, R);
	END;

	RolledBase := ROLLUP(SortOldAndNew,
										left.item_source	=	right.item_source and
										left.source_code	=	right.source_code and
										left.input_file_id=	right.input_file_id,
										t_rollup(LEFT,RIGHT),LOCAL);	

	NewBaseFile   :=project(RolledBase
													,transform({NewBaseData}
															,SELF.item_source:=if(left.item_source='','VENDOR',left.item_source)
															,SELF:=LEFT));


	RETURN NewBaseFile;
END; 

END;