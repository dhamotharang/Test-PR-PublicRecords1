IMPORT PRTE2_Watercraft, Watercraft, PRTE2, ut, Address, STD, AID_Support, AID, RoxieKeyBuild;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT proc_build_base(STRING fileVersion) := FUNCTION

//Alpharetta Base file - Input base file put out by Insurance PRTE process
ds_Alpha_Base	:= PRTE2_Watercraft.Files.Alpha_Base(watercraft_key <> '');

//Spreadsheet updated by Data Insight
ds_Boca_in := PRTE2_Watercraft.Files.Boca_in(watercraft_key <> '');

//Clean invalid characters from input fields
PRTE2.CleanFields(ds_Alpha_Base, dsCleanAlphaOut);
PRTE2.CleanFields(ds_Boca_in, dsCleanBocaOut);
									
//Boca Base file
PRTE2_Watercraft.Layouts.Base_new xfrmBoca(PRTE2_Watercraft.Layouts.Base_Boca L) := TRANSFORM
	tempLienZip1			:= STD.Str.Filter(L.lien_1_zip,'1234567890');
	self.lien_1_zip		:= IF(trim(tempLienZip1) <> '' AND length(trim(tempLienZip1)) < 5, INTFORMAT((integer)tempLienZip1,5,1), tempLienZip1);
	tempLienZip2			:= STD.Str.Filter(L.lien_2_zip,'1234567890');
	self.lien_2_zip		:= IF(trim(tempLienZip2) <> '' AND length(trim(tempLienZip2)) < 5, INTFORMAT((integer)tempLienZip2,5,1), tempLienZip1);
	self.orig_zip 		:= IF(trim(L.orig_zip) <> '' AND length(trim(L.orig_zip)) < 5, INTFORMAT((integer)L.orig_zip,5,1), L.orig_zip);
	self.coastguard_flag		:= IF(L.source_code = 'CG', 'Y','');
	self.persistent_record_id := hash64(trim(L.watercraft_key,left,right)+','+
																		trim(L.watercraft_id,left,right)+','+
																		trim(L.state_origin,left,right)+','+
																		trim(L.source_code,left,right)+','+
																		trim(L.st_registration,left,right)+','+
																		trim(L.county_registration,left,right)+','+
																		trim(L.registration_number,left,right)+','+
																		trim(L.hull_number,left,right)+','+
																		trim(L.propulsion_code,left,right)+','+
																		trim(L.propulsion_description,left,right)+','+
																		trim(L.vehicle_type_code,left,right)+','+
																		trim(L.vehicle_type_description,left,right)+','+
																		trim(L.fuel_code,left,right)+','+
																		trim(L.fuel_description,left,right)+','+
																		trim(L.hull_type_code,left,right)+','+
																		trim(L.hull_type_description,left,right)+','+
																		trim(L.use_code,left,right)+','+
																		trim(L.use_description,left,right)+','+
																		trim(L.model_year,left,right)+','+
																		trim(L.watercraft_name,left,right)+','+
																		trim(L.watercraft_class_code,left,right)+','+
																		trim(L.watercraft_class_description,left,right)+','+
																		trim(L.watercraft_make_code,left,right)+','+
																		trim(L.watercraft_make_description,left,right)+','+
																		trim(L.watercraft_model_code,left,right)+','+
																		trim(L.watercraft_model_description,left,right)+','+
																		trim(L.watercraft_length,left,right)+','+
																		trim(L.watercraft_width,left,right)+','+
																		trim(L.watercraft_weight,left,right)+','+
																		trim(L.watercraft_color_1_code,left,right)+','+
																		trim(L.watercraft_color_1_description,left,right)+','+
																		trim(L.watercraft_color_2_code,left,right)+','+
																		trim(L.watercraft_color_2_description,left,right)+','+
																		trim(L.watercraft_toilet_code,left,right)+','+
																		trim(L.watercraft_toilet_description,left,right)+','+
																		trim(L.watercraft_number_of_engines,left,right)+','+
																		trim(L.watercraft_hp_1,left,right)+','+
																		trim(L.watercraft_hp_2,left,right)+','+
																		trim(L.watercraft_hp_3,left,right)+','+
																		trim(L.engine_number_1,left,right)+','+
																		trim(L.engine_number_2,left,right)+','+
																		trim(L.engine_number_3,left,right)+','+
																		trim(L.engine_make_1,left,right)+','+
																		trim(L.engine_make_2,left,right)+','+
																		trim(L.engine_make_3,left,right)+','+
																		trim(L.engine_model_1,left,right)+','+
																		trim(L.engine_model_2,left,right)+','+
																		trim(L.engine_model_3,left,right)+','+
																		trim(L.engine_year_1,left,right)+','+
																		trim(L.engine_year_2,left,right)+','+
																		trim(L.engine_year_3,left,right)+','+
																		trim(L.coast_guard_documented_flag,left,right)+','+
																		trim(L.coast_guard_number,left,right)+','+
																		trim(L.registration_date,left,right)+','+
																		trim(L.registration_expiration_date,left,right)+','+
																		trim(L.registration_status_code,left,right)+','+
																		trim(L.registration_status_description,left,right)+','+
																		trim(L.registration_status_date,left,right)+','+
																		trim(L.registration_renewal_date,left,right)+','+
																		trim(L.decal_number,left,right)+','+
																		trim(L.transaction_type_code,left,right)+','+
																		trim(L.transaction_type_description,left,right)+','+
																		trim(L.title_state,left,right)+','+
																		trim(L.title_status_code,left,right)+','+
																		trim(L.title_status_description,left,right)+','+
																		trim(L.title_number,left,right)+','+
																		trim(L.title_issue_date,left,right)+','+
																		trim(L.title_type_code,left,right)+','+
																		trim(L.title_type_description,left,right)+','+
																		trim(L.additional_owner_count,left,right)+','+
																		trim(L.lien_1_indicator,left,right)+','+
																		trim(L.lien_1_name,left,right)+','+
																		trim(L.lien_1_date,left,right)+','+
																		trim(L.lien_1_address_1,left,right)+','+
																		trim(L.lien_1_address_2,left,right)+','+
																		trim(L.lien_1_city,left,right)+','+
																		trim(L.lien_1_state,left,right)+','+
																		trim(L.lien_1_zip,left,right)+','+
																		trim(L.lien_2_indicator,left,right)+','+
																		trim(L.lien_2_name,left,right)+','+
																		trim(L.lien_2_date,left,right)+','+
																		trim(L.lien_2_address_1,left,right)+','+
																		trim(L.lien_2_address_2,left,right)+','+
																		trim(L.lien_2_city,left,right)+','+
																		trim(L.lien_2_state,left,right)+','+
																		trim(L.lien_2_zip,left,right)+','+
																		trim(L.state_purchased,left,right)+','+
																		trim(L.purchase_date,left,right)+','+
																		trim(L.dealer,left,right)+','+
																		trim(L.purchase_price,left,right)+','+
																		trim(L.new_used_flag,left,right)+','+
																		trim(L.watercraft_status_code,left,right)+','+
																		trim(L.watercraft_status_description,left,right)+','+
																		trim(L.history_flag,left,right)+','+
																		trim(L.coastguard_flag,left,right)+','+
																		trim(L.signatory ,left,right));
	self := L;
	self := [];
END;

pBoca	:= PROJECT(dsCleanBocaOut, xfrmBoca(left));

fPrevRecs	:= pBoca(trim(cust_name) = ''); //previous production records
fNewRecs	:= pBoca(trim(cust_name) != ''); //New added records
	
//Clean name/business/address
lCleanAddr	:= RECORD
	PRTE2_Watercraft.Layouts.Base_new;
	STRING prep_address_first;
	STRING prep_address_last;
END;

lCleanAddr	AddFullAddr(fNewRecs L) := TRANSFORM
	self.prep_address_first := Address.fn_addr_clean_prep(TRIM(L.orig_address_1)+' '+TRIM(L.orig_address_2), 'first'); 
	self.prep_address_last 	:= Address.fn_addr_clean_prep(TRIM(L.orig_city)+ ', '+TRIM(L.orig_state)+' '+TRIM(L.orig_zip), 'last');
	self	:= L;
	self	:= [];
END;

PrepAddr	:= PROJECT(fNewRecs, AddFullAddr(LEFT));

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(PrepAddr, prep_address_first, prep_address_last, RawAID, addr_clean, lFlags);
	
//Clean names, map clean address fields	
PRTE2_Watercraft.Layouts.Base_New CleanNameAddr(addr_clean L) := TRANSFORM
	self.orig_name					:= ut.CleanSpacesAndUpper(L.orig_name);
	//Clean name for new records only
	tempName 								:= Address.CleanPersonFML73_fields(L.orig_name);
	self.title							:= IF(trim(L.orig_fein) = '',tempName.title,'');
	self.fname							:= IF(trim(L.orig_fein) = '',tempName.fname,'');
	self.mname							:= IF(trim(L.orig_fein) = '',tempName.mname,'');
	self.lname							:= IF(trim(L.orig_fein) = '',tempName.lname,'');
	self.name_suffix				:= IF(trim(L.orig_fein) = '',tempName.name_suffix,'');
	self.name_cleaning_score:= IF(trim(L.orig_fein) = '',tempName.name_score,'');
	self.company_name				:= IF(trim(L.orig_fein) != '',ut.CleanSpacesAndUpper(L.orig_name),'');
	
	//clean address
	self.prim_range     :=  l.AIDWork_ACECache.prim_range;
	self.predir         :=  l.AIDWork_ACECache.predir;
	self.prim_name      :=  l.AIDWork_ACECache.prim_name;;
	self.suffix    			:=  l.AIDWork_ACECache.addr_suffix;
	self.postdir        :=  l.AIDWork_ACECache.postdir;
	self.unit_desig	   	:=	l.AIDWork_AceCache.unit_desig;
	self.sec_range      :=  l.AIDWork_ACECache.sec_range;
	self.p_city_name    :=  l.AIDWork_ACECache.p_city_name;
	self.v_city_name    :=  l.AIDWork_ACECache.v_city_name;
	self.st             :=  l.AIDWork_ACECache.st;
	self.zip5           :=  l.aidwork_acecache.zip5;
	self.zip4           :=  l.aidwork_acecache.zip4;
	self.cart		       	:=	l.AIDWork_AceCache.cart;
	self.cr_sort_sz	   	:=	l.AIDWork_AceCache.cr_sort_sz;
	self.lot		       	:=	l.AIDWork_AceCache.lot;
	self.lot_order		  :=	l.AIDWork_AceCache.lot_order;
	self.dpbc		       	:=	l.AIDWork_AceCache.dbpc;
	self.chk_digit		  :=	l.AIDWork_AceCache.chk_digit;
	self.rec_type	      :=	l.AIDWork_AceCache.rec_type;
	self.county	       	:=	l.AIDWork_AceCache.county;
	self.geo_lat		   	:=	l.AIDWork_AceCache.geo_lat;
	self.geo_long		   	:=	l.AIDWork_AceCache.geo_long;
	self.msa			   		:=	l.AIDWork_AceCache.msa;
	self.geo_blk		   	:=	l.AIDWork_AceCache.geo_blk;
	self.geo_match		  :=	l.AIDWork_AceCache.geo_match;
	self.err_stat		   	:=	l.AIDWork_AceCache.err_stat;
	self.RawAID	   			:=	l.AIDWork_RawAID;
	self := L;
	self := [];
END;

ClnBocaBase	:= PROJECT(addr_clean, CleanNameAddr(left));

//Append ID's
PRTE2_Watercraft.Layouts.Base_New AddLinkID(ClnBocaBase L) := TRANSFORM
	self.bdid						:= IF(trim(L.company_name) != '', (string)Prte2.fn_AppendFakeID.bdid(L.company_name, L.prim_range, L.prim_name, L.v_city_name, L.st, L.zip5, L.cust_name),'');
	self.DID						:= IF(trim(L.lname) != '', (string)prte2.fn_AppendFakeID.did(L.fname, L.lname, L.link_ssn, L.link_dob, L.cust_name), '');

	vLinkingIds := prte2.fn_AppendFakeID.LinkIds(L.company_name, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip5, L.cust_name);
	self.powid	:= vLinkingIds.powid;
	self.proxid	:= vLinkingIds.proxid;
	self.seleid	:= vLinkingIds.seleid;
	self.orgid	:= vLinkingIds.orgid;
	self.ultid	:= vLinkingIds.ultid;
	self := L;
	self := [];
END;

pBocaBase	:= PROJECT(ClnBocaBase, AddLinkID(LEFT)) + fPrevRecs;

RoxieKeyBuild.Mac_SF_BuildProcess_V2(pBocaBase, PRTE2_Watercraft.Constants.BASE_PREFIX, 'boca', fileVersion, build_base, 3);	

//Add persistent_id to Alpharetta file for dedup purposes against Boca file as records overlap
pAlphaBase := PROJECT(dsCleanAlphaOut, TRANSFORM(PRTE2_Watercraft.Layouts.Base_New,SELF.persistent_record_id := hash64(trim(left.watercraft_key,left,right)+','+
																		trim(left.watercraft_id,left,right)+','+
																		trim(left.state_origin,left,right)+','+
																		trim(left.source_code,left,right)+','+
																		trim(left.st_registration,left,right)+','+
																		trim(left.county_registration,left,right)+','+
																		trim(left.registration_number,left,right)+','+
																		trim(left.hull_number,left,right)+','+
																		trim(left.propulsion_code,left,right)+','+
																		trim(left.propulsion_description,left,right)+','+
																		trim(left.vehicle_type_code,left,right)+','+
																		trim(left.vehicle_type_description,left,right)+','+
																		trim(left.fuel_code,left,right)+','+
																		trim(left.fuel_description,left,right)+','+
																		trim(left.hull_type_code,left,right)+','+
																		trim(left.hull_type_description,left,right)+','+
																		trim(left.use_code,left,right)+','+
																		trim(left.use_description,left,right)+','+
																		trim(left.model_year,left,right)+','+
																		trim(left.watercraft_name,left,right)+','+
																		trim(left.watercraft_class_code,left,right)+','+
																		trim(left.watercraft_class_description,left,right)+','+
																		trim(left.watercraft_make_code,left,right)+','+
																		trim(left.watercraft_make_description,left,right)+','+
																		trim(left.watercraft_model_code,left,right)+','+
																		trim(left.watercraft_model_description,left,right)+','+
																		trim(left.watercraft_length,left,right)+','+
																		trim(left.watercraft_width,left,right)+','+
																		trim(left.watercraft_weight,left,right)+','+
																		trim(left.watercraft_color_1_code,left,right)+','+
																		trim(left.watercraft_color_1_description,left,right)+','+
																		trim(left.watercraft_color_2_code,left,right)+','+
																		trim(left.watercraft_color_2_description,left,right)+','+
																		trim(left.watercraft_toilet_code,left,right)+','+
																		trim(left.watercraft_toilet_description,left,right)+','+
																		trim(left.watercraft_number_of_engines,left,right)+','+
																		trim(left.watercraft_hp_1,left,right)+','+
																		trim(left.watercraft_hp_2,left,right)+','+
																		trim(left.watercraft_hp_3,left,right)+','+
																		trim(left.engine_number_1,left,right)+','+
																		trim(left.engine_number_2,left,right)+','+
																		trim(left.engine_number_3,left,right)+','+
																		trim(left.engine_make_1,left,right)+','+
																		trim(left.engine_make_2,left,right)+','+
																		trim(left.engine_make_3,left,right)+','+
																		trim(left.engine_model_1,left,right)+','+
																		trim(left.engine_model_2,left,right)+','+
																		trim(left.engine_model_3,left,right)+','+
																		trim(left.engine_year_1,left,right)+','+
																		trim(left.engine_year_2,left,right)+','+
																		trim(left.engine_year_3,left,right)+','+
																		trim(left.coast_guard_documented_flag,left,right)+','+
																		trim(left.coast_guard_number,left,right)+','+
																		trim(left.registration_date,left,right)+','+
																		trim(left.registration_expiration_date,left,right)+','+
																		trim(left.registration_status_code,left,right)+','+
																		trim(left.registration_status_description,left,right)+','+
																		trim(left.registration_status_date,left,right)+','+
																		trim(left.registration_renewal_date,left,right)+','+
																		trim(left.decal_number,left,right)+','+
																		trim(left.transaction_type_code,left,right)+','+
																		trim(left.transaction_type_description,left,right)+','+
																		trim(left.title_state,left,right)+','+
																		trim(left.title_status_code,left,right)+','+
																		trim(left.title_status_description,left,right)+','+
																		trim(left.title_number,left,right)+','+
																		trim(left.title_issue_date,left,right)+','+
																		trim(left.title_type_code,left,right)+','+
																		trim(left.title_type_description,left,right)+','+
																		trim(left.additional_owner_count,left,right)+','+
																		trim(left.lien_1_indicator,left,right)+','+
																		trim(left.lien_1_name,left,right)+','+
																		trim(left.lien_1_date,left,right)+','+
																		trim(left.lien_1_address_1,left,right)+','+
																		trim(left.lien_1_address_2,left,right)+','+
																		trim(left.lien_1_city,left,right)+','+
																		trim(left.lien_1_state,left,right)+','+
																		trim(left.lien_1_zip,left,right)+','+
																		trim(left.lien_2_indicator,left,right)+','+
																		trim(left.lien_2_name,left,right)+','+
																		trim(left.lien_2_date,left,right)+','+
																		trim(left.lien_2_address_1,left,right)+','+
																		trim(left.lien_2_address_2,left,right)+','+
																		trim(left.lien_2_city,left,right)+','+
																		trim(left.lien_2_state,left,right)+','+
																		trim(left.lien_2_zip,left,right)+','+
																		trim(left.state_purchased,left,right)+','+
																		trim(left.purchase_date,left,right)+','+
																		trim(left.dealer,left,right)+','+
																		trim(left.purchase_price,left,right)+','+
																		trim(left.new_used_flag,left,right)+','+
																		trim(left.watercraft_status_code,left,right)+','+
																		trim(left.watercraft_status_description,left,right)+','+
																		trim(left.history_flag,left,right)+','+
																		trim(left.coastguard_flag,left,right)+','+
																		trim(left.signatory ,left,right));
																		SELF := left;
																		SELF := []));
																																			

//Map to the three key files: Main, Search, Coastguard
pBocaMain	:= PROJECT(pBocaBase(source_code <> ''), TRANSFORM(Watercraft.Layout_Watercraft_Main_Base, 
																														SELF := LEFT;
																														SELF 	:= [];));
																			
pAlphaMain	:= PROJECT(pAlphaBase(source_code <> ''),
																	TRANSFORM(Watercraft.Layout_Watercraft_Main_Base, 
																						SELF := LEFT;
																						SELF := [];));
								
Main				:= DEDUP(SORT(pBocaMain + pAlphaMain, watercraft_key, sequence_key),RECORD);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(Main, PRTE2_Watercraft.Constants.BASE_PREFIX, 'main', fileVersion, build_main, 3);

pBocaSearch := PROJECT(pBocaBase(orig_name <> '' or (trim(fname + lname) <> '')),TRANSFORM(Watercraft.Layout_Watercraft_Search_Base, SELF := LEFT; SELF := [];));
																				
pAlphaSearch	:= PROJECT(pAlphaBase(source_code_search <> ''),
																		TRANSFORM(PRTE2_Watercraft.Layouts.Search, 
																							SELF.Source_code  := LEFT.source_code_Search;
																							SELF.history_flag  := LEFT.history_flag_Search;
																							SELF := LEFT;
																							SELF := [];));
								
Search		:= DEDUP(SORT(pBocaSearch + pAlphaSearch, watercraft_key, sequence_key, orig_name),RECORD, EXCEPT persistent_record_id);
							
RoxieKeyBuild.Mac_SF_BuildProcess_V2(Search, PRTE2_Watercraft.Constants.BASE_PREFIX, 'search', fileVersion, build_search, 3);

pBocaCG		:= PROJECT(pBocaBase(name_of_vessel <> '' or (source_code = 'CG' and hull_number <> '')), TRANSFORM(Watercraft.Layout_Watercraft_Coastguard_Base, 
																															SELF := LEFT;
																															SELF := [];));
																																
pAlphaCG	:= PROJECT(pAlphaBase(source_code_CG <> ''),
																		TRANSFORM(Watercraft.Layout_Watercraft_Coastguard_Base, 
																							SELF.Source_code  := LEFT.source_code_CG;
																							SELF := LEFT;
																							SELF := [];));

CoastGuard	:= DEDUP(SORT(pBocaCG + pBocaCG, watercraft_key, sequence_key),RECORD, EXCEPT persistent_record_id);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(CoastGuard, PRTE2_Watercraft.Constants.BASE_PREFIX, 'coastguard', fileVersion, build_cg, 3);

RETURN SEQUENTIAL(build_base, build_main, build_search, build_cg);

END;

