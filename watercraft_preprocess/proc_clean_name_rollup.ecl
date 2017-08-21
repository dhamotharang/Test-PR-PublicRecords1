//Input all raw common mapping files and process through NID and rollup to get latest record.  Final output will be used in the Watercraft build input
IMPORT watercraft, watercraft_preprocess, ut, lib_StringLib, AID, NID, Address, PromoteSupers;
#option('multiplePersistInstances',FALSE);

ds_raw_base := dataset('~thor_data400::in::watercraft_search_common',Watercraft_preprocess.Layout_Watercraft_Search_Common,flat);

dJoined
 := Watercraft_preprocess.Map_AK_raw_to_Search
 +  Watercraft_preprocess.Map_AL_raw_to_Search
 +	Watercraft_preprocess.Map_AR_raw_to_Search
 +	Watercraft_preprocess.Map_AZ_raw_to_Search
 +	Watercraft_preprocess.Map_CT_raw_to_Search
 +	Watercraft_preprocess.Map_FL_raw_to_Search
 +	Watercraft_preprocess.Map_GA_raw_to_Search
 +	Watercraft_preprocess.Map_IA_raw_to_Search
 +	Watercraft_preprocess.Map_KS_raw_to_Search
 +	Watercraft_preprocess.Map_KY_raw_to_Search
 +	Watercraft_preprocess.Map_MA_raw_to_Search
 +	Watercraft_preprocess.Map_ME_raw_to_Search
 +	Watercraft_preprocess.Map_MI_raw_to_Search
 +	Watercraft_preprocess.Map_MO_raw_to_Search
 +	Watercraft_preprocess.Map_MS_raw_to_Search
 +	Watercraft_preprocess.Map_ND_raw_to_Search
 +	Watercraft_preprocess.Map_NE_raw_to_Search
 +	Watercraft_preprocess.Map_NM_raw_to_Search
 +	Watercraft_preprocess.Map_OH_raw_to_Search
 +	Watercraft_preprocess.Map_OR_raw_to_Search
 +	Watercraft_preprocess.Map_TX_raw_to_Search
 +	Watercraft_preprocess.Map_VA_raw_to_Search
 +	Watercraft_preprocess.Map_WA_raw_to_Search
 +	Watercraft_preprocess.Map_WI_raw_to_Search
 //+	Watercraft_preprocess.Map_WY_raw_to_Search - new layout for 2015_Q1
 +	Watercraft_preprocess.Map_WY_raw_to_Search_new
 +	Watercraft_preprocess.Map_CG_raw_to_Search;

//Temporarily create full_name field for name cleaning to accomodate both parsed and full names
l_tempFull	:= RECORD
	Watercraft_preprocess.Layout_Watercraft_Search_Common;
	string tempFullName;
END;

d_tempFull	:= project(dJoined, transform(l_tempFull,
																self.tempFullName := IF(left.state_origin = 'AZ' and left.name_format = 'P' and left.orig_name_first = '' and left.orig_name_last <> '',left.orig_name,
																												IF(left.name_format = 'P',
																													StringLib.StringCleanSpaces(left.orig_name_first+' '+left.orig_name_middle+' '+left.orig_name_last+' '+left.orig_name_suffix),
																													left.orig_name));
																self.name_format	:= IF(left.name_format = 'P','F',left.name_format);
																self := left; self := [];)) : persist('~persist::watercraft::ConcatFullName');
											
DedupTempName := Dedup(Sort(Distribute(d_tempFull, Hash32(watercraft_key, state_origin, tempFullName)),state_origin, watercraft_key, tempFullName, local), record);

NID.Mac_CleanFullNames(DedupTempName,clean_wc_names,tempFullName,includeInRepository:=false, normalizeDualNames:=true,_nameorder := name_format);

// Clean names
person_flags	:= ['P', 'D'];
Bus_flags   	:= ['B', 'U', 'T', 'I']; 		
Watercraft_preprocess.Layout_Watercraft_Search_Common mapCleanName(clean_wc_names L, integer1 C) := TRANSFORM,
	skip(c = 2 and trim(L.cln_fname2 + L.cln_lname2,left,right) = '')
	tempName1						:= if(L.nametype IN person_flags, L.cln_title + L.cln_fname + L.cln_mname + L.cln_lname + L.cln_suffix,'');
	tempName2						:= if(L.cln_fname2 <> '' or L.cln_lname2 <> '', L.cln_title2 + L.cln_fname2 + L.cln_mname2 + L.cln_lname2 + L.cln_suffix2,'');
	self.clean_pname		:= choose(C,tempName1,tempName2);
	self.company_name		:= if(L.nametype IN Bus_flags, StringLib.StringCleanSpaces(L.orig_name),'');
	self.dob						:= if(self.company_name <> '','',L.dob);
	self := L;
	self := [];
END;

d_NID	:= NORMALIZE(clean_wc_names,IF(left.cln_fname <> left.cln_fname2 or left.cln_lname <> left.cln_lname2,2,1),mapCleanName(left,counter)) : persist('~persist::watercraft::CleanName');

//Rollup to capture most current record and latest last_seen_date
BOOLEAN basefileexists	:=	nothor(fileservices.GetSuperFileSubCount('~thor_data400::in::watercraft_search_common')) > 0;

ds_combined := IF(basefileexists,d_NID + ds_raw_base,d_NID);
ds_distrib := sort(distribute(ds_combined, HASH(state_origin,watercraft_key,clean_pname,company_name)),
									state_origin,
									watercraft_key,
									clean_pname,
									company_name,
									prep_address_last_situs,
									dob,
									-date_vendor_last_reported,
									local);

Watercraft_preprocess.Layout_Watercraft_Search_Common xformCombined(ds_distrib L, ds_distrib R)	:= TRANSFORM
	self.date_first_seen	:=	(string)ut.EarliestDate((integer)L.date_first_seen,(integer)R.date_first_seen);
	self.date_last_seen		:=	MAX(R.date_last_seen);
	self.date_vendor_first_reported		:= (string)ut.EarliestDate((integer)L.date_vendor_first_reported,(integer)R.date_vendor_first_reported);
	self.date_vendor_last_reported		:= MAX(R.date_vendor_last_reported);
	self := L;
END;
	
RollupAll	:=	ROLLUP(ds_distrib, xformCombined(LEFT,RIGHT),
											state_origin,
											watercraft_key,
											clean_pname,
											company_name,
											dob,
											prep_address_last_situs,
											local);

PromoteSupers.MAC_SF_BuildProcess(RollupAll,'~thor_data400::in::watercraft_search_common',build_wc_raw_out,2, /*csvout*/false, /*compress*/true);

EXPORT proc_clean_name_rollup := build_wc_raw_out;