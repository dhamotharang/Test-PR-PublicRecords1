IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_VT._Dataset(pUseOtherEnvironment).InputTemplate + tag;
	
		EXPORT DomLLCBus    							:= tools.mod_FilenamesInput(Template('dom_llc_bus::vt'), 				pversion);
		EXPORT DomLLCPrn    							:= tools.mod_FilenamesInput(Template('dom_llc_prn::vt'), 				pversion);
		EXPORT DomMBEBus   						 		:= tools.mod_FilenamesInput(Template('dom_mbe_bus::vt'), 				pversion);
		EXPORT DomMBEPrn    							:= tools.mod_FilenamesInput(Template('dom_mbe_prn::vt'), 				pversion);
		EXPORT DomNPCBus    							:= tools.mod_FilenamesInput(Template('dom_npc_bus::vt'), 				pversion);
		EXPORT DomNPCPrn    							:= tools.mod_FilenamesInput(Template('dom_npc_prn::vt'), 				pversion);
		EXPORT DomProfBus   							:= tools.mod_FilenamesInput(Template('dom_prof_bus::vt'),	 			pversion);
		EXPORT DomProfPrn   							:= tools.mod_FilenamesInput(Template('dom_prof_prn::vt'), 			pversion);
		EXPORT ForLLCBus    							:= tools.mod_FilenamesInput(Template('for_llc_bus::vt'), 				pversion);
		EXPORT ForLLCPrn    							:= tools.mod_FilenamesInput(Template('for_llc_prn::vt'), 				pversion);
		EXPORT ForNPCBus    							:= tools.mod_FilenamesInput(Template('for_npc_bus::vt'), 				pversion);
		EXPORT ForNPCPrn    							:= tools.mod_FilenamesInput(Template('for_npc_prn::vt'), 				pversion);
		EXPORT ForProfBus  						 		:= tools.mod_FilenamesInput(Template('for_prof_bus::vt'), 			pversion);
		EXPORT ForProfPrn   							:= tools.mod_FilenamesInput(Template('for_prof_prn::vt'), 			pversion);
   	EXPORT PshipsBus 							    := tools.mod_FilenamesInput(Template('pships_bus::vt'), 		    pversion);
		EXPORT PshipsPrn 					     		:= tools.mod_FilenamesInput(Template('pships_prn::vt'), 		    pversion);
		EXPORT TrdNamesBus  							:= tools.mod_FilenamesInput(Template('trade_names_bus::vt'), 		pversion);
		EXPORT TrdNamesPrn  							:= tools.mod_FilenamesInput(Template('trade_names_prn::vt'), 		pversion);
		EXPORT TrdNamesOwn  							:= tools.mod_FilenamesInput(Template('trade_names_owners::vt'), pversion);

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 	  := Corp2_Raw_VT._Dataset(pUseOtherEnvironment).FileTemplate + tag;

		EXPORT DomLLCBus    						:= tools.mod_FilenamesBuild(Template('dom_llc_bus::vt'), 				pversion);
		EXPORT DomLLCPrn    						:= tools.mod_FilenamesBuild(Template('dom_llc_prn::vt'), 				pversion);
		EXPORT DomMBEBus   						 	:= tools.mod_FilenamesBuild(Template('dom_mbe_bus::vt'), 				pversion);
		EXPORT DomMBEPrn    						:= tools.mod_FilenamesBuild(Template('dom_mbe_prn::vt'),				pversion);
		EXPORT DomNPCBus    						:= tools.mod_FilenamesBuild(Template('dom_npc_bus::vt'), 				pversion);
		EXPORT DomNPCPrn    						:= tools.mod_FilenamesBuild(Template('dom_npc_prn::vt'), 				pversion);
		EXPORT DomProfBus   						:= tools.mod_FilenamesBuild(Template('dom_prof_bus::vt'),			 	pversion);
		EXPORT DomProfPrn   						:= tools.mod_FilenamesBuild(Template('dom_prof_prn::vt'), 			pversion);
		EXPORT ForLLCBus    						:= tools.mod_FilenamesBuild(Template('for_llc_bus::vt'), 				pversion);
		EXPORT ForLLCPrn    						:= tools.mod_FilenamesBuild(Template('for_llc_prn::vt'), 				pversion);
		EXPORT ForNPCBus    						:= tools.mod_FilenamesBuild(Template('for_npc_bus::vt'), 				pversion);
		EXPORT ForNPCPrn    						:= tools.mod_FilenamesBuild(Template('for_npc_prn::vt'), 				pversion);
		EXPORT ForProfBus  						 	:= tools.mod_FilenamesBuild(Template('for_prof_bus::vt'), 			pversion);
		EXPORT ForProfPrn   						:= tools.mod_FilenamesBuild(Template('for_prof_prn::vt'), 			pversion);
		EXPORT PshipsBus 						    := tools.mod_FilenamesBuild(Template('pships_bus::vt'), 	    	pversion);
		EXPORT PshipsPrn 						    := tools.mod_FilenamesBuild(Template('pships_prn::vt'), 		    pversion);
		EXPORT TrdNamesBus  						:= tools.mod_FilenamesBuild(Template('trade_names_bus::vt'),		pversion);
		EXPORT TrdNamesPrn  						:= tools.mod_FilenamesBuild(Template('trade_names_prn::vt'), 		pversion);
		EXPORT TrdNamesOwn  						:= tools.mod_FilenamesBuild(Template('trade_names_owners::vt'), pversion);

		EXPORT dAll_DomLLCBus    				:= DomLLCBus.dAll_filenames;
		EXPORT dAll_DomLLCPrn    				:= DomLLCPrn.dAll_filenames;
		EXPORT dAll_DomMBEBus   				:= DomMBEBus.dAll_filenames;
		EXPORT dAll_DomMBEPrn    				:= DomMBEPrn.dAll_filenames;
		EXPORT dAll_DomNPCBus    				:= DomNPCBus.dAll_filenames;
		EXPORT dAll_DomNPCPrn    				:= DomNPCPrn.dAll_filenames;
		EXPORT dAll_DomProfBus   				:= DomProfBus.dAll_filenames;
		EXPORT dAll_DomProfPrn   				:= DomProfPrn.dAll_filenames;
		EXPORT dAll_ForLLCBus    				:= ForLLCBus.dAll_filenames;
		EXPORT dAll_ForLLCPrn    				:= ForLLCPrn.dAll_filenames;
		EXPORT dAll_ForNPCBus    				:= ForNPCBus.dAll_filenames;
		EXPORT dAll_ForNPCPrn    				:= ForNPCPrn.dAll_filenames;
		EXPORT dAll_ForProfBus  				:= ForProfBus.dAll_filenames;
		EXPORT dAll_ForProfPrn   				:= ForProfPrn.dAll_filenames;
		EXPORT dAll_PshipsBus 				  := PshipsBus.dAll_filenames;
		EXPORT dAll_PshipsPrn 				  := PshipsPrn.dAll_filenames;
		EXPORT dAll_TrdNamesBus  				:= TrdNamesBus.dAll_filenames;
		EXPORT dAll_TrdNamesPrn  				:= TrdNamesPrn.dAll_filenames;
		EXPORT dAll_TrdNamesOwn  				:= TrdNamesOwn.dAll_filenames;
	
	END;
	
  EXPORT dAll_filenames 						:= Base.dAll_DomLLCBus 		+
																			 Base.dAll_DomLLCPrn 		+
																			 Base.dAll_DomMBEBus 		+
																			 Base.dAll_DomMBEPrn 		+
																			 Base.dAll_DomNPCBus 		+
																			 Base.dAll_DomNPCPrn 		+
																			 Base.dAll_DomProfBus 	+	
																			 Base.dAll_DomProfPrn 	+
																			 Base.dAll_ForLLCBus 		+
																			 Base.dAll_ForLLCPrn 		+
																			 Base.dAll_ForNPCBus 		+
																			 Base.dAll_ForNPCPrn 		+
																			 Base.dAll_ForProfBus 	+
																			 Base.dAll_ForProfPrn 	+
																			 Base.dAll_PshipsBus    +
																			 Base.dAll_PshipsPrn    +
																			 Base.dAll_TrdNamesBus 	+
																			 Base.dAll_TrdNamesPrn 	+
																			 Base.dAll_TrdNamesOwn;

END;