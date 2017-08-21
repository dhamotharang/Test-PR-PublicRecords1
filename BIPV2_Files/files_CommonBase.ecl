IMPORT BIPV2;

EXPORT files_CommonBase := MODULE

	/*----------------- Special Layouts --------------------------------*/
	EXPORT l_history := RECORD
		BIPV2.CommonBase.Layout.rcid;
		BIPV2.KeySuffix_mod2.ds.versionDate;
		BIPV2.CommonBase.Layout AND NOT [
			rcid
			,cnt_rcid_per_dotid
			,cnt_dot_per_proxid
			,cnt_prox_per_lgid3
			,cnt_prox_per_powid
			,cnt_dot_per_empid
			,source_docid
			,company_address_type_derived
			,company_org_structure_derived
			,company_name_status_derived
			,company_status_derived
			,contact_status_derived
			,iscontact
			,title
			,fname
			,mname
			,lname
			,name_suffix
			,name_score
			,iscorp
			,company_name
			,company_name_type_raw
			,company_name_type_derived
			,cnp_hasnumber
			,cnp_name
			,cnp_number
			,cnp_store_number
			,cnp_btype
			,cnp_component_code
			,cnp_lowv
			,cnp_translated
			,cnp_classid
			,company_rawaid
			,company_aceaid
			,prim_range
			,prim_range_derived
			,predir
			,prim_name
			,prim_name_derived
			,addr_suffix
			,postdir
			,unit_desig
			,sec_range
			,p_city_name
			,v_city_name
			,st
			,zip
			,zip4
			,cart
			,cr_sort_sz
			,lot
			,lot_order
			,dbpc
			,chk_digit
			,rec_type
			,fips_state
			,fips_county
			,geo_lat
			,geo_long
			,msa
			,geo_blk
			,geo_match
			,err_stat
			,corp_legal_name
			,dba_name
			,foreign_corp_key
			,unk_corp_key
			,company_address_type_raw
			,company_fein
			,best_fein_indicator
			,company_phone
			,phone_type
			,company_org_structure_raw
			,company_incorporation_date
			,company_sic_code1
			,company_sic_code2
			,company_sic_code3
			,company_sic_code4
			,company_sic_code5
			,company_naics_code1
			,company_naics_code2
			,company_naics_code3
			,company_naics_code4
			,company_naics_code5
			,company_ticker
			,company_ticker_exchange
			,company_foreign_domestic
			,company_url
			,company_inc_state
			,company_charter_number
			,company_name_status_raw
			,company_status_raw
			,phone_score
			,duns_number
			,contact_type_raw
			,contact_job_title_raw
			,contact_ssn
			,contact_dob
			,contact_status_raw
			,contact_email
			,contact_email_username
			,contact_email_domain
			,contact_phone
			,from_hdr
			,company_department
			,contact_type_derived
			,contact_job_title_derived
			,is_vanity_name_derived
		];
	END;

	export RemovedRec := {
		typeof(BIPV2.CommonBase.Layout.dt_last_seen) dt_removed,
		string reason_removed,
		BIPV2.CommonBase.Layout,
	};
	
	/*----------------- Filename Prefixes --------------------------------*/
	EXPORT filePrefix := '~thor_data400::bipv2::internal_linking::';
	
	
	/*----------------- SuperFile References ----------------------------------*/
	EXPORT FILE_BUILDING	:= filePrefix + 'building';
	EXPORT DS_BUILDING   	:= DATASET(FILE_BUILDING, BIPV2.CommonBase.Layout, THOR, OPT);
	
	EXPORT FILE_HISTORY		:= filePrefix + 'history';
	export HistorySubName(string ver) := FILE_HISTORY + '::' + ver;
	EXPORT KEY_HISTORY   	:= INDEX(l_history, FILE_HISTORY, OPT);
	export HistoryKey(string name = FILE_HISTORY, dataset(recordof(l_history)) ds = dataset([], l_history))
		:= index(ds, {ds}, name);
	
	export FILE_REMOVED := filePrefix + 'removed';
	export FILE_REMOVED_LOGICAL(string suffix) := FILE_REMOVED + '::' + suffix;
	export DS_REMOVED := dataset(FILE_REMOVED, removedRec, thor, opt);
	
	/*----------------- Key Build -----------------------------------------*/
	EXPORT BuildHistoryKey(DATASET(BIPV2.CommonBase.Layout) ds, STRING ver, BOOLEAN over=false) := FUNCTION
		FILE_LOGICAL	:= HistorySubName(ver);
		
		del_super	:= FileServices.RemoveSuperFile(FILE_HISTORY, FILE_LOGICAL);
		
		ds_hist		:= PROJECT(ds, TRANSFORM(l_history, SELF.versionDate:=ver[1..8], SELF:=LEFT));
		idx_hist	:= HistoryKey(FILE_LOGICAL, ds_hist);
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
	
	export updateRemoved(string inFile) := FileServices.AddSuperFile(FILE_REMOVED, inFile);
	export removeRemoved(string inFile) := FileServices.RemoveSuperFile(FILE_REMOVED, inFile);


	/*----------------- Dataset Build --------------------------------*/
	export BuildRemoved(dataset(BIPV2.CommonBase.Layout) ds, string reason,
	                    string dateRemoved = WORKUNIT[2..9],  string fnSuffix = '') := function

		fnLogical := FILE_REMOVED_LOGICAL(if(fnSuffix != '', fnSuffix, dateRemoved));
		dsRemove := project(ds, transform(removedRec,
				self.dt_removed := (typeof(removedRec.dt_removed)) dateRemoved,
				self.reason_removed := reason,
				self := left));
		
		outLogical := output(dsRemove,, fnLogical, compressed);

		return sequential(outLogical, updateRemoved(fnLogical));

	end;

END;