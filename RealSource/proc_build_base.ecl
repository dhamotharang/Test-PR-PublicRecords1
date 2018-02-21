IMPORT	ut, AID, AID_Support, DID_Add, address, NID, STD, PromoteSupers,
							PRTE2, Anchor; //using a cleaning functions in these repositories;
#workunit('name', 'RealSource Email Build');
// #constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
// #STORED('did_add_force','thor');
				
EXPORT proc_build_base(STRING8 version) := FUNCTION

	dsBase					:= RealSource.Files.base_out;
	IngestPrep	:= RealSource.prep_ingest_file;

	ingestMod		:= RealSource.Ingest(,,dsBase,IngestPrep);
	new_base			:= ingestMod.AllRecords_NoTag;
	
	NID.Mac_CleanParsedNames(new_base, FileClnName, 
																										firstname:=FirstName, lastname:=LastName, middlename := MiddleInit, namesuffix := Suffix
																										,includeInRepository:=true, normalizeDualNames:=true);
	

	InputFileClnName	:= Project(FileClnName, TRANSFORM(RealSource.Layouts.Base,
																											self.clean_title				:=	left.cln_title;
																											self.clean_fname				:=	left.cln_fname;
																											self.clean_mname				:=	left.cln_mname;
																											self.clean_lname				:=	left.cln_lname;
																											self.clean_name_suffix	:=	left.cln_suffix;
																											self.clean_cname				:= IF(trim(self.clean_fname) = '' and trim(self.clean_lname) = '',
																																																				STD.Str.CleanSpaces(left.FirstName+' '+left.MiddleInit+' '+left.LastName),'');
																											SELF := LEFT));
																										
		//AID process
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
	RealSource.Layouts.Base tProjectAIDClean_prep(RealSource.Layouts.Base pInput) := TRANSFORM
	  clnFullAddr	:= STD.Str.CleanSpaces(pInput.address);
		self.Append_Prep_Address_Situs			:=	Address.fn_addr_clean_prep(clnFullAddr, 'first');
		self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.ZipCode+pInput.ZipPlus4, 'last');
		self := pInput;
	END;

	rsAIDCleanName	:= PROJECT(InputFileClnName ,tProjectAIDClean_prep(LEFT))(TRIM(EMAIL) <> ''); //removes invalid records
	
	rsAID_NoAddr		:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) = '' OR TRIM(Append_Prep_Address_Last_Situs) = '' OR
																																	STD.Str.Find(Append_Prep_Address_Situs, '@', 1) > 0);
	rsAID_Addr			:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) != '' AND TRIM(Append_Prep_Address_Last_Situs) != '');
	
	AID.MacAppendFromRaw_2Line(rsAID_Addr,Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, RawAID,
																											rsCleanAID, lAIDFlags);	
	
	RealSource.Layouts.Base tProjectClean(rsCleanAID pInput) := TRANSFORM
				SELF.prim_range    := pInput.aidwork_acecache.prim_range;
    SELF.predir        := pInput.aidwork_acecache.predir;
    SELF.prim_name     := pInput.aidwork_acecache.prim_name;
    SELF.addr_suffix   := pInput.aidwork_acecache.addr_suffix;
    SELF.postdir       := pInput.aidwork_acecache.postdir;
    SELF.unit_desig    := pInput.aidwork_acecache.unit_desig;
    SELF.sec_range     := pInput.aidwork_acecache.sec_range;
    SELF.p_city_name   := pInput.aidwork_acecache.p_city_name;
    SELF.v_city_name   := pInput.aidwork_acecache.v_city_name;
    SELF.st            := pInput.aidwork_acecache.st;
    SELF.zip           := pInput.aidwork_acecache.zip5;
    SELF.zip4          := pInput.aidwork_acecache.zip4;
    SELF.cart          := pInput.aidwork_acecache.cart;
    SELF.cr_sort_sz    := pInput.aidwork_acecache.cr_sort_sz;
    SELF.lot           := pInput.aidwork_acecache.lot;
    SELF.lot_order     := pInput.aidwork_acecache.lot_order;
    SELF.dbpc          := pInput.aidwork_acecache.dbpc;
    SELF.chk_digit     := pInput.aidwork_acecache.chk_digit;
    SELF.rec_type      := pInput.aidwork_acecache.rec_type;
    SELF.county        := pInput.aidwork_acecache.county;
    SELF.geo_lat       := pInput.aidwork_acecache.geo_lat;
    SELF.geo_long      := pInput.aidwork_acecache.geo_long;
    SELF.msa           := pInput.aidwork_acecache.msa;
    SELF.geo_blk       := pInput.aidwork_acecache.geo_blk;
    SELF.geo_match     := pInput.aidwork_acecache.geo_match;
    SELF.err_stat      := pInput.aidwork_acecache.err_stat;
    SELF.rawaid        := pInput.aidwork_rawaid;
    SELF  													:= pInput;		
	END;

	RealSource.Layouts.Base tProjectNoAddrClean(rsAID_NoAddr pInput) := TRANSFORM
		cl_addr	:= Address.CleanAddress182(pInput.Append_Prep_Address_Situs, TRIM(pInput.city) + ' ' + TRIM(pInput.state) + ' ' + TRIM(pInput.ZipCode)+TRIM(pInput.ZipPlus4));
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
													RealSource.Layouts.Base, 
													true, DID_score,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsCleanAID_DID);
													
		PromoteSupers.Mac_SF_BuildProcess(rsCleanAID_DID,RealSource.thor_cluster+'base::email::RealSource',build_base,3,,true);

	RETURN SEQUENTIAL(build_base, ingestMod.DoStats);	
	
END;