﻿IMPORT	ut, AID, AID_Support, DID_Add, address, NID, STD, PromoteSupers, PRTE2; //using a cleaning function in this repository;
#WORKUNIT('name', 'Anchor Email Build');
//#CONSTANT(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
//#STORED('did_add_force','thor');
				
EXPORT proc_build_base(STRING version) := FUNCTION
	
	dsBase			:= Anchor.Files.base_out;
	IngestPrep	:= Anchor.prep_ingest_file;

	ingestMod		:= Anchor.Ingest(,,dsBase,IngestPrep);
	new_base		:= ingestMod.AllRecords;
	
	//Populate current_rec based on whether or not record is in the new input file as this is a full replace
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
	PopCurrentRec	:= Project(new_base, TRANSFORM(Anchor.Layouts.Base, self.current_rec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); self := LEFT; SELF:= [];));
	
	NID.Mac_CleanParsedNames(PopCurrentRec, FileClnName, 
													firstname:=FirstName, lastname:=LastName, middlename := clean_mname, namesuffix := clean_name_suffix
													,includeInRepository:=true, normalizeDualNames:=true, useV2 := true);
	
	//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B'];
	InvName_flags	:= ['I'];
	
	//output invalid names to send to source for review
	InvalidName := FileClnName(nametype IN InvName_flags OR (nametype = 'U' AND trim(cln_fname) = '' AND TRIM(cln_lname) = '' AND ~REGEXFIND('TRUST',fullname)));
	pToRawLayout	:= PROJECT(InvalidName, Anchor.Layouts.Raw);
	OUTPUT(pToRawLayout,,'~thor_data400::out::Anchor_invalid_names_'+version, OVERWRITE, __COMPRESSED__);
	OUTPUT(COUNT(InvalidName),NAMED('TotalInvalidRecords_'+version));
	
	InputFileClnName	:= Project(FileClnName(nametype != 'I'), TRANSFORM(Anchor.Layouts.Base,
																																			BOOLEAN IsName	:=	LEFT.nametype IN person_flags OR
																																													(LEFT.nametype = 'U' AND trim(LEFT.cln_fname) != '' AND TRIM(LEFT.cln_lname) != ''); 
																																			SELF.clean_title				:=	IF(IsName, LEFT.cln_title, '');
																																			SELF.clean_fname				:=	IF(IsName, LEFT.cln_fname, '');
																																			SELF.clean_mname				:=	IF(IsName, LEFT.cln_mname, '');
																																			SELF.clean_lname				:=	IF(IsName, LEFT.cln_lname, '');
																																			SELF.clean_name_suffix	:=	IF(IsName, LEFT.cln_suffix, '');
																																			SELF.clean_cname				:=  IF(LEFT.nametype IN business_flags OR (LEFT.nametype = 'U' AND NOT IsName),
																																																		STD.Str.CleanSpaces(LEFT.FirstName+' '+LEFT.LastName), '');
																																			SELF := LEFT));
																										
		//AID process
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
	Anchor.Layouts.Base tProjectAIDClean_prep(Anchor.Layouts.Base pInput) := TRANSFORM
	  clnFullAddr	:= STD.Str.CleanSpaces(pInput.address_1 +' '+ pInput.address_2);
		self.Append_Prep_Address_Situs			:=	Address.fn_addr_clean_prep(clnFullAddr, 'first');
		self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.ZipCode, 'last');
		self := pInput;
	END;

	rsAIDCleanName	:= PROJECT(InputFileClnName ,tProjectAIDClean_prep(LEFT));
	
	rsAID_NoAddr		:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) = '' OR TRIM(Append_Prep_Address_Last_Situs) = '' OR
																																	STD.Str.Find(Append_Prep_Address_Situs, '@', 1) > 0);
	rsAID_Addr			:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) != '' AND TRIM(Append_Prep_Address_Last_Situs) != '');
	
		AID.MacAppendFromRaw_2Line(rsAID_Addr,Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, RawAID,
																											rsCleanAID, lAIDFlags);	
	
	Anchor.Layouts.Base tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.predir               := pInput.aidwork_acecache.predir;
    SELF.prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.postdir              := pInput.aidwork_acecache.postdir;
    SELF.unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.st                   := pInput.aidwork_acecache.st;
    SELF.zip                  := pInput.aidwork_acecache.zip5;
    SELF.zip4                 := pInput.aidwork_acecache.zip4;
    SELF.cart                 := pInput.aidwork_acecache.cart;
    SELF.cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.lot                  := pInput.aidwork_acecache.lot;
    SELF.lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.dbpc                 := pInput.aidwork_acecache.dbpc;
    SELF.chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.county               := pInput.aidwork_acecache.county;
    SELF.geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.msa                  := pInput.aidwork_acecache.msa;
    SELF.geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid               			:= pInput.aidwork_rawaid;
    SELF  													:= pInput;		
	END;

	Anchor.Layouts.Base tProjectNoAddrClean(rsAID_NoAddr pInput) := TRANSFORM
		cl_addr			:= Address.CleanAddress182(pInput.Append_Prep_Address_Situs, TRIM(pInput.city) + ' ' + TRIM(pInput.state) + ' ' + TRIM(pInput.ZipCode));
		SELF.prim_range  	:=  cl_addr[1..10];
		SELF.predir  					:=  cl_addr[11..12];
		SELF.prim_name  		:=  cl_addr[13..40];
		SELF.addr_suffix  :=  cl_addr[41..44];
		SELF.postdir  				:=  cl_addr[45..46];
		SELF.unit_desig  	:=  cl_addr[47..56];
		SELF.sec_range  		:=  cl_addr[57..64];
		SELF.p_city_name  :=  cl_addr[65..89];
		SELF.v_city_name  :=  cl_addr[90..114];
		SELF.st  									:=  cl_addr[115..116];
		SELF.zip  								:=  cl_addr[117..121];
		SELF.zip4  							:=  cl_addr[122..125];
		SELF.cart  							:=  cl_addr[126..129];
		SELF.cr_sort_sz  	:=  cl_addr[130];
		SELF.lot  								:=  cl_addr[131..134];
		SELF.lot_order  		:=  cl_addr[135];
		SELF.dbpc  							:=  cl_addr[136..137];
		SELF.chk_digit  		:=  cl_addr[138];
		SELF.rec_type  			:=  cl_addr[139..140];
		SELF.county  					:=  cl_addr[141..145];
		SELF.geo_lat  				:=  cl_addr[146..155];
		SELF.geo_long  			:=  cl_addr[156..166];
		SELF.msa  								:=  cl_addr[167..170];
		SELF.geo_blk  				:=  cl_addr[171..177];
		SELF.geo_match  		:=  cl_addr[178];
		SELF.err_stat  			:=  cl_addr[179..182];
		SELF  												:= pInput;		
	END;
	
	rsCleanAIDGoodAddr		:= PROJECT(rsCleanAID, tProjectClean(LEFT));
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, tProjectNoAddrClean(LEFT));
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr;

	//Flip names before DID process
	ut.mac_flipnames(rsCleanAIDGood,clean_fname,clean_mname,clean_lname,rsAIDCleanFlipNames);

	matchset :=['A','D','Z'];

	did_Add.MAC_Match_Flex(rsAIDCleanFlipNames, matchset,
													foo, dob, clean_fname, clean_mname, clean_lname, clean_name_suffix, 
													prim_range, prim_name, sec_range, zip, st, foo,
													DID,   			
													Anchor.Layouts.Base, 
													true, DID_score,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsCleanAID_DID);
													
		PromoteSupers.Mac_SF_BuildProcess(rsCleanAID_DID, Anchor.thor_cluster+'base::email::Anchor',build_base,3,,true);
	
	RETURN SEQUENTIAL(build_base, ingestMod.DoStats);

END;
	
	