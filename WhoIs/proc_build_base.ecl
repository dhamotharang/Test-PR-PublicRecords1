IMPORT	ut, AID, AID_Support, DID_Add, Business_Header_SS, address, NID, STD, PromoteSupers,
							PRTE2, WhoIs; //using a cleaning functions in these repositories;
			
EXPORT proc_build_base(STRING8 version) := FUNCTION

	dsBase			:= WhoIs.Files.Base;
	IngestPrep	:= WhoIs.prep_ingest_file(country = 'UNITED STATES' and Domainname[1] = 'A');

	ingestMod		:= WhoIs.Ingest(,,dsBase,IngestPrep);
	new_base		:= ingestMod.AllRecords;

	//Populate current_rec based on whether or not record is in the new input file as this is a full replace
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
  PopCurrentRec	:= Project(new_base, TRANSFORM(WhoIs.Layouts.Base, SELF.current_rec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE);
								
	NID.Mac_CleanFullNames(PopCurrentRec, FileClnName, NAME
													,includeInRepository:=true, normalizeDualNames:=true, useV2 := true);
	
	//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B'];
	InvName_flags	:= ['I'];
		
	InputFileClnName	:= PROJECT(FileClnName,TRANSFORM(WhoIs.Layouts.Base,
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
																					
																					
		//AID process
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
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

	rsAIDCleanName	:= PROJECT(InputFileClnName ,tProjectAIDClean_prep(LEFT)); 
	
	rsAID_NoAddr		:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) = '' OR TRIM(Append_Prep_Address_Last_Situs) = '' 
																			OR STD.Str.Find(Append_Prep_Address_Situs, '@', 1) > 0 OR LENGTH(postalCode)<5 OR TRIM(state) = '');
	rsAID_Addr			:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) != '' AND TRIM(Append_Prep_Address_Last_Situs) != ''
																			AND STD.Str.Find(Append_Prep_Address_Situs, '@', 1) = 0 AND LENGTH(postalCode)>=5 AND TRIM(state) != '');

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
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr;																					

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Append the LexIds
	//////////////////////////////////////////////////////////////////////////////////////

	//Flip names before DID process
	matchset :=['A','P','Z'];

	did_Add.MAC_Match_Flex(rsCleanAIDGood        							// Input Dataset
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
													
	pDataset  := 	rsCleanAID_DID;//: persist('~thor_data400::in::WhoIs::CleanAID_DID');	
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- Append the LinkIds
	//////////////////////////////////////////////////////////////////////////////////////

		WhoIs.Layouts.UniqueId tAddUniqueId(WhoIs.Layouts.Base L, UNSIGNED8 cnt) :=	TRANSFORM
			SELF.unique_id		:= cnt;
			SELF							:= L;
		END;   
		
		dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT,COUNTER));
		
    dSlimInput	:= dAddUniqueId(clean_cname <> '');
    
 		//*** Match set for BIPing
		BIP_Matchset := ['A'];
		
		//**** External id macro that appends BIPV2 xlinkids
		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimInput     											// Input Dataset						
			,BIP_Matchset                         // BIP Matchset what fields to match on           
			,clean_cname          		            // company_name	              
			,prim_range             		          // prim_range		              
			,prim_name            		            // prim_name		              
			,zip              					          // zip5					              
			,sec_range            		            // sec_range		              
			,st               				            // state				              
			,''                                   // phone				              
			,''                                   // fein              
			,''            								        // bdid												
			,WhoIs.Layouts.UniqueId               // Output Layout 
			,FALSE                                // output layout has bdid score field?                       
			,''                                   // bdid_score                 
			,dBIPOut                              // Output Dataset   
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_only_set                 // Create LinkID's only
			,    																	// Url
			,email													      // Email
			,v_city_name             							// City
			,clean_fname											    // First Name
			,clean_mname											    // Middle Name
			,clean_lname											    // Last Name
		);
		
    dBIP_dist           := DISTRIBUTE(dBIPOut(Ultid 	!= 0 OR 
																	            OrgID 	!= 0 OR 
																	            ProxID 	!= 0 OR
																            	SELEID 	!= 0 OR
																	            POWID 	!= 0 OR 
																	            EmpID 	!= 0 OR 
																	            DotID 	!= 0), unique_id);
		dInput             := DISTRIBUTE(dAddUniqueId, unique_id);

		WhoIs.Layouts.Base tAssignLinkids(WhoIs.Layouts.UniqueId L,WhoIs.Layouts.UniqueId R) := TRANSFORM
			SELF.Ultid				:= R.Ultid;
			SELF.Ultscore			:= R.Ultscore;
			SELF.UltWeight		:= R.UltWeight;
			SELF.OrgID				:= R.OrgID;
			SELF.Orgscore			:= R.Orgscore;
			SELF.OrgWeight		:= R.OrgWeight;
			SELF.ProxID				:= R.ProxID;
			SELF.Proxscore		:= R.Proxscore;
			SELF.ProxWeight		:= R.ProxWeight;
			SELF.SELEID				:= R.SELEID;
			SELF.SELEScore		:= R.SELEScore;
			SELF.SELEWeight		:= R.SELEWeight;
			SELF.POWID				:= R.POWID;
			SELF.POWscore			:= R.POWscore;
			SELF.POWWeight		:= R.POWWeight;
			SELF.EmpID				:= R.EmpID;
			SELF.Empscore			:= R.Empscore;
			SELF.EmpWeight		:= R.EmpWeight;
			SELF.DotID				:= R.DotID;
			SELF.Dotscore			:= R.Dotscore;
			SELF.DotWeight		:= R.DotWeight;
			SELF 							:= L;
		END;

		full_update_LinkID := JOIN(dInput
												    ,dBIP_dist
												    ,LEFT.unique_id = RIGHT.unique_id
												    ,tAssignLinkids(LEFT, RIGHT)
												    ,LEFT OUTER
												    ,LOCAL);			
	
	PromoteSupers.Mac_SF_BuildProcess(full_update_LinkID,WhoIs.thor_cluster+'base::email::WhoIs_data',build_base,3,,true);
	RETURN build_base;																				

END;