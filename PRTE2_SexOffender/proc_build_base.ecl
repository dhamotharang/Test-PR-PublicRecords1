IMPORT PRTE2_SexOffender, SexOffender, PRTE2, PromoteSupers, Address, ut, AID, AID_Support;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT proc_build_base := FUNCTION

	//Input
	dSexOffender	:= PRTE2_SexOffender.Files.Offender_in;
	dSexOffense		:= PRTE2_SexOffender.Files.Offense_in;
	
//Added clean address fields.  Not currently populated in Prod base key, but needed for ENH and Autokeys
	unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	AID.MacAppendFromRaw_2Line(dSexOffender, registration_address_1, registration_address_2, RawAID, addr_clean, lFlags);
	
	PRTE2_SexOffender.Layouts.Offender_in CleanAddr(addr_clean l) := TRANSFORM
		self.RawAID	   			:=	l.AIDWork_RawAID;
		self.prim_range     :=  l.AIDWork_ACECache.prim_range;
		self.predir         :=  l.AIDWork_ACECache.predir;
		self.prim_name      :=  l.aidwork_acecache.prim_name;;
		self.addr_suffix    :=  l.AIDWork_ACECache.addr_suffix;
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
		self.dbpc		       	:=	l.AIDWork_AceCache.dbpc;
		self.chk_digit		  :=	l.AIDWork_AceCache.chk_digit;
		self.rec_type	      :=	l.AIDWork_AceCache.rec_type;
		self.county	       	:=	l.AIDWork_AceCache.county;
		self.geo_lat		   	:=	l.AIDWork_AceCache.geo_lat;
		self.geo_long		   	:=	l.AIDWork_AceCache.geo_long;
		self.msa			   		:=	l.AIDWork_AceCache.msa;
		self.geo_blk		   	:=	l.AIDWork_AceCache.geo_blk;
		self.geo_match		  :=	l.AIDWork_AceCache.geo_match;
		self.err_stat		   	:=	l.AIDWork_AceCache.err_stat;
		self	:= l;
	END;
	
	pClnAddrOffender	:= PROJECT(addr_clean, CleanAddr(LEFT));
	
	//Filter out new records for name cleaning and DID
	NewOffenderRecs	:= pClnAddrOffender(trim(cust_name) != '');
	
	PRTE2_SexOffender.Layouts.Offender_in ClnName(NewOffenderRecs l) := TRANSFORM
		self.ssn 					:= IF(trim(l.ssn) <> '', l.ssn, 
															IF(trim(l.ssn_appended) <> '',l.ssn_appended, l.link_ssn));
		self.dob					:= IF(l.dob <> '', l.dob, l.link_dob);
		self.name_orig		:= ut.CleanSpacesAndUpper(l.name_orig);
		self.registration_address_1	:= ut.CleanSpacesAndUpper(l.registration_address_1);
		self.registration_address_2	:= ut.CleanSpacesAndUpper(l.registration_address_2);
		
		//Clean name
		ClnName						:= Address.CleanPersonFML73_fields(l.name_orig);
		self.fname				:= ClnName.fname;
		self.mname				:= ClnName.mname;
		self.lname				:= ClnName.lname;
		self.name_suffix	:= ClnName.name_suffix;

		//Add DID
		self.did						:= IF(trim(L.cust_name) = '', l.DID,
															prte2.fn_AppendFakeID.did(self.fname, self.lname, self.ssn, self.dob, l.cust_name));
		self	:= l;
	END;
	
	pNewRecs				:= PROJECT(NewOffenderRecs, ClnName(LEFT));
	SexOffenderAll	:= pClnAddrOffender(trim(cust_name) = '') + pNewRecs;
	
	//Add persistent_id to all records
	PRTE2_SexOffender.Layouts.Offender_in AddOfdrPersist(SexOffenderAll l) := TRANSFORM
		self.offender_persistent_id := hash64(trim(l.seisint_primary_key,left,right)+trim(l.fname,left,right)+trim(l.mname,left,right)+trim(l.lname,left,right)+trim(l.dob,left,right)+trim(l.dob_aka,left,right));
		self	:= l;
	END;
	
	pSexOffender 	:= PROJECT(SexOffenderAll, AddOfdrPersist(left));
	dedOffender		:= DEDUP(SORT(pSexOffender, did, seisint_primary_key, name_orig),ALL);
	
	PRTE2_SexOffender.Layouts.Offense_in AddOffPersist(dSexOffense l) := TRANSFORM
		String 	filterField(String s) := FUNCTION
			return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		END;
	
		Vconviction_date 						:= filterField(l.conviction_date);
		Voffense_date 							:= filterField(l.offense_date);
		Voffense_code_or_statute		:= filterField(l.offense_code_or_statute);
		Vcourt_case_number 					:= filterField(l.court_case_number);
		Vvictim_gender							:= filterField(l.victim_gender);
		Vvictim_age 								:= filterField(l.victim_age);
		Voffense_description 				:= filterField(l.offense_description);
		Vsentence_description 			:= filterField(l.sentence_description);
		self.offense_persistent_id 	:= hash64(trim(l.seisint_primary_key, left, right) + Vconviction_date + Voffense_date + Voffense_code_or_statute + Vcourt_case_number + Vvictim_gender + Vvictim_age + Voffense_description + Vsentence_description);	
		self := l;
	END;
	
	pOffense := PROJECT(dSexOffense, AddOffPersist(left));
	dedOffense	:= DEDUP(SORT(pOffense, seisint_primary_key),ALL);
	
	PromoteSupers.Mac_SF_BuildProcess(dedOffender, Constants.BASE_PREFIX +'sex_offender_main', build_offender_base);
	PromoteSupers.Mac_SF_BuildProcess(dedOffense, Constants.BASE_PREFIX +'sex_offender_offenses', build_offense_base);
	
RETURN SEQUENTIAL(build_offender_base, build_offense_base);
	
END;
	