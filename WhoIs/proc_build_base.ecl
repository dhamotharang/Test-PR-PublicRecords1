IMPORT	ut, AID, AID_Support, DID_Add, Business_Header_SS, address, NID, STD, PromoteSupers, PRTE2, WhoIs, BIPV2; //using a cleaning functions in these repositories;
			
EXPORT proc_build_base(STRING8 version) := FUNCTION

	// dsBase			:= WhoIs.Files.Base;
	IngestPrep	:= WhoIs.prep_ingest_file;

	ingestMod		:= WhoIs.Ingest(,,/*dsBase*/,IngestPrep);
	new_base		:= ingestMod.AllRecords;

	//Populate current_rec based on whether or not record is in the new input file as this is a full replace
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
	PopCurrentRec	:= Project(new_base, TRANSFORM(WhoIs.Layouts.Base, SELF.current_rec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE);
																																				SELF := LEFT;
																																				SELF:= [];));
	
	ValidNamefile := PopCurrentRec(trim(Name,left,right)!= ''): persist('~thor_data400::in::WhoIs::ValidName');
	InvNamefile   := PopCurrentRec(trim(Name,left,right) = ''): persist('~thor_data400::in::WhoIs::InvalidName');
	
	NID.Mac_CleanFullNames(ValidNameFile, FileClnName, NAME
													,includeInRepository:=true, normalizeDualNames:=true, useV2 := true);
	
	//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B'];
	InvName_flags	:= ['I'];
		
	ValidClnName	:= Project(FileClnName,TRANSFORM(WhoIs.Layouts.Base,
																					BOOLEAN IsName	:=	LEFT.nametype IN person_flags OR
																														 (LEFT.nametype = 'U' AND trim(LEFT.cln_fname) != '' AND TRIM(LEFT.cln_lname) != ''); 
																					SELF.clean_title				:=	IF(IsName, LEFT.cln_title, '');
																					SELF.clean_fname				:=	IF(IsName, LEFT.cln_fname, '');
																					SELF.clean_mname				:=	IF(IsName, LEFT.cln_mname, '');
																					SELF.clean_lname				:=	IF(IsName, LEFT.cln_lname, '');
																					SELF.clean_name_suffix	:=	IF(IsName, LEFT.cln_suffix, '');
																					SELF.clean_cname				:=  IF(LEFT.nametype IN business_flags OR (LEFT.nametype = 'U' AND NOT IsName),
																																				STD.Str.CleanSpaces(LEFT.name),
																																				IF(LEFT.Organization != '',STD.Str.CleanSpaces(LEFT.Organization),''));
																					SELF := LEFT));
																					
	InvClnName	:= Project(InvNamefile, TRANSFORM(WhoIs.Layouts.Base,
																						SELF.clean_title				:=	'';
																						SELF.clean_fname				:=	'';
																						SELF.clean_mname				:=	'';
																						SELF.clean_lname				:=	'';
																						SELF.clean_name_suffix	:=	'';
																						SELF.clean_cname				:=  LEFT.Organization;
																						SELF := LEFT));
	//Combine clean name files
	rsCleanName := ValidClnName + InvClnName: persist('~thor_data400::in::WhoIs::CleanName');
																						
		//AID process
	WhoIs.Layouts.Base tProjectAIDClean_prep(WhoIs.Layouts.Base pInput) := TRANSFORM
	  FullAddr	  := STD.Str.CleanSpaces(TRIM(pInput.street1) +' '+TRIM(pInput.street2) +' '+TRIM(pInput.street3) +' '+TRIM(pInput.street4));
    clnFullAddr	:= MAP(NOT REGEXFIND('[A-Z]',FullAddr)=> '',
		                   NOT REGEXFIND('^(.*) (.*)',TRIM(FullAddr)) => '',
											 LENGTH(TRIM(FullAddr,ALL)) < 5 => '',
											 FullAddr);
		self.Append_Prep_Address_Situs			:=	Address.fn_addr_clean_prep(clnFullAddr, 'first');
		self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.postalCode, 'last');
		self := pInput;
	END;

	rsAIDCleanName	:= PROJECT(rsCleanName ,tProjectAIDClean_prep(LEFT)); 
	
	rsAID_NoAddr		:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) = '' OR TRIM(Append_Prep_Address_Last_Situs) = '' 
																			OR STD.Str.Find(Append_Prep_Address_Situs, '@', 1) > 0 OR LENGTH(postalCode)<5 OR TRIM(state) = '');
	rsAID_Addr			:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) != '' AND TRIM(Append_Prep_Address_Last_Situs) != ''
																			AND STD.Str.Find(Append_Prep_Address_Situs, '@', 1) = 0 AND LENGTH(postalCode)>=5 AND TRIM(state) != '');

	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	
	AID.MacAppendFromRaw_2Line(rsAID_Addr,Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, RawAID,
																											rsCleanAID, lAIDFlags);	
	
	WhoIs.Layouts.Base tProjectClean(rsCleanAID pInput) := TRANSFORM
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

	WhoIs.Layouts.Base tProjectNoAddrClean(rsAID_NoAddr pInput) := TRANSFORM
		cl_addr	:= Address.CleanAddress182(pInput.Append_Prep_Address_Situs, TRIM(pInput.city) + ' ' + TRIM(pInput.state) + ' ' + TRIM(pInput.postalCode));
		SELF.prim_range  	:=  cl_addr[1..10];
		SELF.predir  			:=  cl_addr[11..12];
		SELF.prim_name  	:=  cl_addr[13..40];
		SELF.addr_suffix  :=  cl_addr[41..44];
		SELF.postdir  		:=  cl_addr[45..46];
		SELF.unit_desig  	:=  cl_addr[47..56];
		SELF.sec_range  	:=  cl_addr[57..64];
		SELF.p_city_name  :=  cl_addr[65..89];
		SELF.v_city_name  :=  cl_addr[90..114];
		SELF.st  					:=  cl_addr[115..116];
		SELF.zip  				:=  cl_addr[117..121];
		SELF.zip4  				:=  cl_addr[122..125];
		SELF.cart  				:=  cl_addr[126..129];
		SELF.cr_sort_sz  	:=  cl_addr[130];
		SELF.lot  				:=  cl_addr[131..134];
		SELF.lot_order  	:=  cl_addr[135];
		SELF.dbpc  				:=  cl_addr[136..137];
		SELF.chk_digit  	:=  cl_addr[138];
		SELF.rec_type  		:=  cl_addr[139..140];
		SELF.county  			:=  cl_addr[141..145];
		SELF.geo_lat  		:=  cl_addr[146..155];
		SELF.geo_long  		:=  cl_addr[156..166];
		SELF.msa  				:=  cl_addr[167..170];
		SELF.geo_blk  		:=  cl_addr[171..177];
		SELF.geo_match  	:=  cl_addr[178];
		SELF.err_stat  		:=  cl_addr[179..182];
		SELF  						:= pInput;		
	END;	
	
	rsCleanAIDGoodAddr		:= PROJECT(rsCleanAID, tProjectClean(LEFT));
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, tProjectNoAddrClean(LEFT));
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr: persist('~thor_data400::in::WhoIs::CleanAIDGood');																					

	//Flip names before DID process
	matchset :=['A','P','Z'];

	did_Add.MAC_Match_Flex(rsCleanAIDGood        								// Input Dataset
													,matchset													// DID Matchset what fields to match on
													,foo															// SSN or Tax ID
													,foo															// DOB
													,clean_fname											// First Name
													,clean_mname											// Middle Name
													,clean_lname											// Last Name
													,clean_name_suffix 								// Suffix
													,prim_range												// Prim_range
													,prim_name												// Prim_name
													,sec_range												// Sec_range
													,zip															// zip5
													,st																// State
													,phone														// Phone
													,DID 															// DID  			
													,WhoIs.Layouts.Base 			        // Output Layout
													,TRUE															// has score field
													,DID_score												// did_score
													,75	  														// threshold 
													,rsCleanAID_DID										// Output Dataset
													);
	Input_BIP  := 	rsCleanAID_DID: persist('~thor_data400::in::WhoIs::CleanAID_DID');											
		//Add BIP fields
	bdid_matchset	:= ['A'];
	Business_Header_SS.MAC_Add_BDID_Flex(Input_BIP							    					// Input Dataset
																			,bdid_matchset												// BDID Matchset what fields to match on
																			,clean_cname													// company_name
																			,prim_range       										// prim_range
																			,prim_name	        									// prim_name
																			,zip             											// zip5
																			,sec_range         										// sec_range
																			,st	              										// state
																			,''																		// phone
																			,''																		// fein
																			,''																		// bdid
																			,WhoIs.Layouts.Base					// output layout
																			,FALSE 																// output layout has bdid score field?
																			,''																		// bdid_score
																			,dsBIP_out														// Output Dataset
																			,																			// default threshold
																			,																			// use prod version of superfiles
																			,														 					// default is to hit prod from dataland, and on prod hit prod.	
																			,[BIPV2.IDconstants.xlink_version_BIP]// create BIP keys only
																			,   																	// url
																			,     																// email 
																			,v_city_name													// city
																			,																			// fname
																			,																			// mname
																			,																			// lname
																			,																			// contact ssn
																			,																			// Source MDR.sourceTools
																			,rcid																	// Source_Record_Id
																			,																			// Src_Matching_is_priorty
																			);
			
	PromoteSupers.Mac_SF_BuildProcess(dsBIP_out,WhoIs.thor_cluster+'base::email::WhoIs_data',build_base,3,,true);
	RETURN build_base;																				

END;