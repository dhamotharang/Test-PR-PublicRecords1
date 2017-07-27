IMPORT BIPV2;

EXPORT files_CommonBase := MODULE

	/*----------------- Special Layouts --------------------------------*/
	EXPORT l_history := RECORD
		BIPV2.CommonBase.Layout.rcid;
		BIPV2.KeySuffix_mod2.ds.versionDate;
		BIPV2.CommonBase.Layout.ingest_status;
		BIPV2.CommonBase.Layout.source;
		BIPV2.CommonBase.Layout.source_record_id;
		BIPV2.CommonBase.Layout.vl_id;
		BIPV2.CommonBase.Layout.DotID;
		BIPV2.CommonBase.Layout.EmpID;
		BIPV2.CommonBase.Layout.POWID;
		BIPV2.CommonBase.Layout.ProxID;
		BIPV2.CommonBase.Layout.SELEID;
		BIPV2.CommonBase.Layout.LGID3;
		BIPV2.CommonBase.Layout.OrgID;
		BIPV2.CommonBase.Layout.UltID;
		BIPV2.CommonBase.Layout.dt_first_seen;
		BIPV2.CommonBase.Layout.dt_last_seen;
		BIPV2.CommonBase.Layout.dt_vendor_first_reported;
		BIPV2.CommonBase.Layout.dt_vendor_last_reported;
	END;
	
	
	/*----------------- Filename Prefixes --------------------------------*/
	EXPORT filePrefix := '~thor_data400::bipv2::internal_linking::';
	
	
	/*----------------- SuperFile References ----------------------------------*/
	EXPORT FILE_BUILDING	:= filePrefix + 'building';
	EXPORT DS_BUILDING   	:= DATASET(FILE_BUILDING, BIPV2.CommonBase.Layout, THOR, OPT);
	
	EXPORT FILE_HISTORY		:= filePrefix + 'history';
	EXPORT KEY_HISTORY   	:= INDEX(l_history, FILE_HISTORY, OPT);
	
	
	/*----------------- Key Build -----------------------------------------*/
	EXPORT BuildHistoryKey(DATASET(BIPV2.CommonBase.Layout) ds, STRING ver, BOOLEAN over=false) := FUNCTION
		FILE_LOGICAL	:= FILE_HISTORY + '::' + ver;
		
		del_super	:= FileServices.RemoveSuperFile(FILE_HISTORY, FILE_LOGICAL);
		
		ds_hist		:= PROJECT(ds, TRANSFORM(l_history, SELF.versionDate:=ver, SELF:=LEFT));
		idx_hist	:= INDEX(ds_hist, {ds_hist}, FILE_LOGICAL);
		bld_hist	:= IF(over, BUILD(idx_hist,OVERWRITE), BUILD(idx_hist));
		
		add_super	:= FileServices.AddSuperFile(FILE_HISTORY, FILE_LOGICAL);
		
		RETURN IF(over, SEQUENTIAL(del_super,bld_hist,add_super), SEQUENTIAL(bld_hist,add_super));
	END;
	
	
	/*----------------- SuperFile Updates --------------------------------*/
	EXPORT updateBuilding(STRING inFile) := FUNCTION
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, FALSE);
	END;
	EXPORT clearBuilding := PARALLEL(
		FileServices.ClearSuperFile(FILE_BUILDING)
	);
	
	EXPORT updateHistory(STRING inFile) := FUNCTION
		RETURN FileServices.AddSuperFile(FILE_HISTORY,inFile);
	END;
	EXPORT removeHistory(STRING inFile) := FUNCTION
		isNeeded := EXISTS(FileServices.SuperFileContents(FILE_HISTORY)(name=inFile));
		RETURN IF(isNeeded,FileServices.RemoveSuperFile(FILE_HISTORY,inFile));
	END;
	EXPORT clearHistory := FileServices.ClearSuperFile(FILE_HISTORY);
	
END;