IMPORT corp2_raw_il, tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	EXPORT Input := MODULE

		EXPORT Template(STRING tag) 	:= Corp2_Raw_IL._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Daily := MODULE
			EXPORT Master								:= tools.mod_FilenamesInput(Template('daily_master::il'), pversion);
		END;

		EXPORT Monthly := MODULE
			EXPORT AssumedNames     		:= tools.mod_FilenamesInput(Template('monthly_corpnames::il'), pversion);
			EXPORT Master								:= tools.mod_FilenamesInput(Template('monthly_master::il'), pversion);
			EXPORT Stock    						:= tools.mod_FilenamesInput(Template('monthly_stock::il'),	pversion);
		END;
		
		EXPORT LLC := MODULE
			EXPORT Master						   	:= tools.mod_FilenamesInput(Template('llc::il'), pversion);
		END;
		
		EXPORT LP := MODULE
			EXPORT Master						   	:= tools.mod_FilenamesInput(Template('lp::il'), pversion);		
		END;
	
	END; //end Input



	EXPORT Base := MODULE
		EXPORT Template(STRING tag) 	:= Corp2_Raw_IL._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Daily := MODULE
			EXPORT MasterRaw						:= tools.mod_FilenamesBuild(Template('daily_master::il'), pversion);
			EXPORT AssumedNames			    := tools.mod_FilenamesBuild(Template('daily_corpnames_subfile::il'), pversion);
			EXPORT Master								:= tools.mod_FilenamesBuild(Template('daily_master_subfile::il'), pversion);		
			EXPORT Stock    						:= tools.mod_FilenamesBuild(Template('daily_stock_subfile::il'), pversion);
			EXPORT dAll_MasterRaw				:= MasterRaw.dAll_filenames;
			EXPORT dAll_AssumedNames		:= AssumedNames.dAll_filenames;
			EXPORT dAll_Master					:= Master.dAll_filenames;
			EXPORT dAll_Stock						:= Stock.dAll_filenames;

		END;

		EXPORT Monthly := MODULE
			EXPORT AssumedNames			    := tools.mod_FilenamesBuild(Template('monthly_corpnames::il'), pversion);
			EXPORT Master								:= tools.mod_FilenamesBuild(Template('monthly_master::il'), pversion);		
			EXPORT Stock    						:= tools.mod_FilenamesBuild(Template('monthly_stock::il'), pversion);
			EXPORT dAll_AssumedNames		:= AssumedNames.dAll_filenames;
			EXPORT dAll_Master					:= Master.dAll_filenames;
			EXPORT dAll_Stock	 					:= Stock.dAll_filenames;
		END;
		
		EXPORT LLC := MODULE
			EXPORT Master							  := tools.mod_FilenamesBuild(Template('llc::il'), pversion);
			EXPORT dAll_Master					:= Master.dAll_filenames;
		END;

		EXPORT LP := MODULE
			EXPORT Master								:= tools.mod_FilenamesBuild(Template('lp::il'), pversion);
			EXPORT dAll_Master					:= Master.dAll_filenames;
		END;
		
	END; //end Base



	EXPORT InputBase := MODULE

		EXPORT Template(STRING tag) 	:= Corp2_Raw_IL._Dataset(pUseOtherEnvironment).FileTemplate + tag;

		EXPORT Daily := MODULE
			EXPORT MasterRaw						:= tools.mod_FilenamesInput(Template('daily_master::il'), pversion);
			EXPORT AssumedNames			    := tools.mod_FilenamesInput(Template('daily_corpnames_subfile::il'), pversion);
			EXPORT Master								:= tools.mod_FilenamesInput(Template('daily_master_subfile::il'), pversion);		
			EXPORT Stock    						:= tools.mod_FilenamesInput(Template('daily_stock_subfile::il'), pversion);			
		END;
		
		EXPORT Monthly := MODULE
			EXPORT AssumedNames			    := tools.mod_FilenamesInput(Template('monthly_corpnames::il'), pversion);
			EXPORT Master								:= tools.mod_FilenamesInput(Template('monthly_master::il'), pversion);		
			EXPORT Stock    						:= tools.mod_FilenamesInput(Template('monthly_stock::il'), pversion);
		END;
		
		EXPORT LLC := MODULE
			EXPORT Master							  := tools.mod_FilenamesInput(Template('llc::il'), pversion);
		END;

		EXPORT LP := MODULE
			EXPORT Master								:= tools.mod_FilenamesInput(Template('lp::il'), pversion);
		END;
		
	END; //end InputBase
	
	EXPORT dAll_filenames_daily			:= Base.Daily.MasterRaw.dAll_filenames			+
																		 Base.Daily.AssumedNames.dAll_filenames		+
																		 Base.Daily.Master.dAll_filenames					+
																		 Base.Daily.Stock.dAll_filenames;
																		 
	EXPORT dAll_filenames_monthly		:= Base.Monthly.dAll_AssumedNames						+
																		 Base.Monthly.dAll_Master									+
																		 Base.Monthly.dAll_Stock;

	EXPORT dAll_filenames_llc				:= Base.LLC.dAll_Master;

	EXPORT dAll_filenames_lp				:= Base.LP.dAll_Master;
	
	EXPORT dAll_filenames						:= dAll_filenames_daily 										+ 
																		 dAll_filenames_monthly 									+
																		 dAll_filenames_llc 											+
																		 dAll_filenames_lp;
																		 
END; //end Filenames