IMPORT ut
		 , DID_Add
		 , header_slimsort
		 , address
		 , lib_stringlib
;

//Project the cmcprov file to the cmcprovSlim layout and distribute based on the gennum hash
rsCmcprovSlim			:=	PROJECT(files.cmcprov, layouts.cmcprovSlim);
rsCmcprovSlimDist	:=	DISTRIBUTE(rsCmcprovSlim,HASH(GENNUM));

//Project the cmcfed file(only records with populated SSN's) to the cmcfedSlim layout and distribute based on the gennum hash
rsCmcfedSlim			:=	PROJECT(files.cmcfed(TAX_TYPE = 'S' AND FED_TAXID != ''), layouts.cmcfedSlim);
rsCmcfedSlimDist	:=	DISTRIBUTE(rsCmcfedSlim,HASH(GENNUM));

//Now join the records based on the GENNUM
rsCmcprovCmcfedJoined	:=	JOIN(rsCmcprovSlimDist,
															 rsCmcfedSlimDist,
															 left.GENNUM = right.GENNUM,
															 LEFT OUTER,
															 local
															 );

rsCmcprovCmcfedJoinedDist	:=	DISTRIBUTE(rsCmcprovCmcfedJoined,HASH(GENNUM));
											
//Project the cmlpvad file to the cmlpvadSlim layout and distribute based on the gennum hash
rsCmlpvadSlim			:=	PROJECT(files.cmlpvad(ADDRID != ''), layouts.cmlpvadSlim);
rsCmlpvadSlimDist	:=	DISTRIBUTE(rsCmlpvadSlim,HASH(GENNUM));

//Now join the records based on the GENNUM
rsCmcprovCmcfedCmlpvadJoined	:=	JOIN(rsCmcprovCmcfedJoinedDist,
																			 rsCmlpvadSlimDist,
																			 left.GENNUM = right.GENNUM,
																			 INNER, //Only get records with addresses
																			 local
																			 );
						 
//Now redistribute joined records based on addrid
rsCmcprovCmcfedCmlpvadDist	:=	DISTRIBUTE(rsCmcprovCmcfedCmlpvadJoined,HASH(ADDRID));

//Project the cmcadd file to the cmcaddSlim layout and distribute based on the addrid hash
rsCmcaddSlim			:=	PROJECT(files.cmcadd, layouts.cmcaddSlim);
rsCmcaddSlimDist	:=	DISTRIBUTE(rsCmcaddSlim,HASH(ADDRID));

//Now join the records based on the ADDRID
rsCmcprovCmcfedCmlpvadCmcaddJoined	:=	JOIN(rsCmcprovCmcfedCmlpvadDist,
   																						 rsCmcaddSlimDist,
   																						 left.ADDRID = right.ADDRID,
   																						 LEFT OUTER,
   																						 local
   																						 );

rsCnldJoin := rsCmcprovCmcfedCmlpvadCmcaddJoined;

layouts.cnldJoinedRecClean tcnldClean(rsCnldJoin pInput)
   	 :=
   		 TRANSFORM
   			self.GENNUM					:=	pInput.GENNUM;
   			self.SSN						:=	pInput.FED_TAXID;
   			self.TELEPHONE			:=	StringLib.StringFindReplace(pInput.TELEPHONE, '0000000000', '');
   			self.DOB						:=	StringLib.StringFindReplace(pInput.DOBYEAR + pInput.DOBMONTH + pInput.DOBDAY, '00000000', '');
   			self.clean_name			:=	address.CleanPersonFML73(TRIM(TRIM(pInput.NAME_PREFX) + ' ' + TRIM(pInput.FIRST_NAME) + ' ' + TRIM(pInput.MID_NAME) + ' ' + TRIM(pInput.LAST_NAME) + ' ' + TRIM(pInput.NAME_SUFX)));
   			self.clean_address	:=	address.CleanAddress182(TRIM(TRIM(pInput.ADDRESS1) + ' ' + TRIM(pInput.ADDRESS2)), TRIM(TRIM(pInput.CITY) + ' ' + TRIM(pInput.STATE) + ' ' + TRIM(pInput.ZIP5) + ' ' + TRIM(pInput.ZIP4)));
   		END
   	;

rsCnldJoinClean	:=	PROJECT(rsCnldJoin, tcnldClean(left));

layouts.cnld_clean tcnldCleanParse(rsCnldJoinClean pInput)
	:=
		TRANSFORM
   		self.DID					:=	0;
			self.DID_Score		:=	0;
			self.GENNUM				:=	pInput.GENNUM;
   		self.SSN					:=	pInput.SSN;
   		self.TELEPHONE		:=	pInput.TELEPHONE;
   		self.DOB					:=	pInput.DOB;
   		self.FNAME				:=	pInput.clean_name[6..25];
 			self.MNAME				:=	pInput.clean_name[26..45];
  		self.LNAME				:=	pInput.clean_name[46..65];
   		self.NAME_SUFFIX	:=	pInput.clean_name[66..70];
   		self.PRIM_RANGE		:=	pInput.clean_address[1..10];
   		self.PRIM_NAME		:=	pInput.clean_address[13..40];
   		self.SEC_RANGE		:=	pInput.clean_address[57..64];
   		self.ST						:=	pInput.clean_address[115..116];
   		self.ZIP					:=	pInput.clean_address[117..121];
    END
	;
         
rsCnldCleanParse	:=	PROJECT(rsCnldJoinClean, tcnldCleanParse(left));

matchset	:=	['A','D','S','P','Z']; //Not sure what is best here
      
DID_Add.MAC_Match_Flex(rsCnldCleanParse, matchset,
											 SSN, DOB, FNAME, MNAME, LNAME, NAME_SUFFIX, 
											 PRIM_RANGE, PRIM_NAME, SEC_RANGE, ZIP, ST, TELEPHONE,
											 DID,
											 layouts.cnld_clean,
											 true, DID_Score, //these should default to zero in definition
											 75,	  //dids with a score below here will be dropped 	
											 rsCnldDid);
											 
DID_OUT	:=	rsCnldDid:PERSIST('~thor_200::persist::rsCnldDid');
rsCnldDidDist		:=	DISTRIBUTE(DID_OUT, HASH(DID));
rsDIDJoinUnique	:=	DEDUP(rsCnldDidDist, DID, LOCAL);

export proc_build_cnld_DID :=	rsDIDJoinUnique;