//-----------------------------------------------------------------------------
// Procedure that takes the Acquireweb Business input files, joins them together and
// determines the AID and DID information

IMPORT  Acquireweb_Plus, ut, address, DID_Add, NID, AID, AID_Support,std, PromoteSupers;
#WORKUNIT('name', 'Acquireweb Business Email Build');
#CONSTANT(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
#STORED('did_add_force','thor');

EXPORT Proc_build_business_base(STRING version) := FUNCTION
	dsBase						:= Acquireweb_Plus.Files.Business_w_BIP;
  ipaddress_file_in := Acquireweb_Plus.files.Email_IPAddress;
	
	IngestPrep	:= Acquireweb_Plus.prep_business_ingest;

	ingestMod		:= Acquireweb_Plus.Ingest(,,dsBase,IngestPrep);
	new_base		:= ingestMod.AllRecords;
	
	//Populate current_rec based on whether or not record is in the new input file as this is a full replace
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
	PopCurrentRec	:= Project(new_base, TRANSFORM(layouts.Business_Base,
																							SELF.current_rec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); SELF := LEFT; SELF:= [];));
	
	//Send only cleanable names to cleaner
	ValidNames	:= PopCurrentRec(TRIM(firstname) != TRIM(lastname) AND (TRIM(firstname) != '' AND TRIM(lastname) != ''));
	InvNames	:= PopCurrentRec(TRIM(firstname) = TRIM(lastname) OR (TRIM(firstname) = '' OR TRIM(lastname) = ''));
	
	NID.Mac_CleanParsedNames(ValidNames, FileClnName, 
													firstname:=FirstName, lastname:=LastName, middlename := clean_mname, namesuffix := clean_name_suffix
													,includeInRepository:=false, normalizeDualNames:=false, useV2 := true);
	
	//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B'];
	InvName_flags	:= ['I'];
	
	ValidClnName	:= Project(FileClnName, TRANSFORM(layouts.Business_Base,
																									BOOLEAN IsName	:=	LEFT.nametype IN person_flags OR
																																			(LEFT.nametype = 'U' AND trim(LEFT.cln_fname) != '' AND TRIM(LEFT.cln_lname) != ''); 
																									SELF.clean_title				:=	IF(IsName, LEFT.cln_title, '');
																									SELF.clean_fname				:=	IF(IsName, LEFT.cln_fname, LEFT.firstname);
																									SELF.clean_mname				:=	IF(IsName, LEFT.cln_mname, '');
																									SELF.clean_lname				:=	IF(IsName, LEFT.cln_lname, LEFT.lastname);
																									SELF.clean_name_suffix	:=	IF(IsName, LEFT.cln_suffix, '');
																									SELF.clean_cname				:=  LEFT.companyname;
																									SELF := LEFT));
																									
	InvClnName	:= Project(InvNames, TRANSFORM(layouts.Business_Base,
																						SELF.clean_title				:=	'';
																						SELF.clean_fname				:=	'';
																						SELF.clean_mname				:=	'';
																						SELF.clean_lname				:=	'';
																						SELF.clean_name_suffix	:=	'';
																						SELF.clean_cname				:=  LEFT.companyname;
																						SELF := LEFT));
	
	//Combine clean name files
	rsCleanName := ValidClnName + InvClnName;
	
  // Take the individual file and add fields for the cleaned name and the fields
  // to pass into the AID macro
  layout_busi_clean	:= RECORD
    Acquireweb_Plus.layouts.Business_Base;
    STRING Prep_Address_Situs;
    STRING Prep_Address_Last_Situs;
    UNSIGNED8 RawAID	:= 0;
  END;
	
	layout_busi_clean xfrmAddr(rsCleanName L):=TRANSFORM
		clnFullAddr									:= STD.Str.CleanSpaces(L.address1 +' '+ L.address2);
    SELF.Prep_Address_Situs			:= Address.fn_addr_clean_prep(clnFullAddr,'first');
    SELF.Prep_Address_Last_Situs:= Address.fn_addr_clean_prep(L.city
																															+	IF(L.city <> '',', ','') + L.state
																															+	' ' + TRIM(L.Zip+L.Zip4), 'last');
		SELF				:= L;
		SELF				:= [];
  end;
	
	AddrPrep	:= PROJECT(rsCleanName,xfrmAddr(LEFT)):persist('~thor_data400::in::Acquireweb_Email::Business_Addrclean');
	
	rsAID_NoAddr		:=	AddrPrep(TRIM(Prep_Address_Situs) = '' OR TRIM(Prep_Address_Last_Situs) = '' 
																OR STD.Str.Find(Prep_Address_Situs, '@', 1) > 0 OR LENGTH(Zip)<5 OR TRIM(state) = '');
	rsAID_Addr			:=	AddrPrep(TRIM(Prep_Address_Situs) != '' AND TRIM(Prep_Address_Last_Situs) != ''
																AND STD.Str.Find(Prep_Address_Situs, '@', 1) = 0 AND LENGTH(Zip) = 5 AND TRIM(state) != '');

  // Call the AID macro to get the cleaned address information
  UNSIGNED4 lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
  AID.MacAppendFromRaw_2Line(rsAID_Addr, Prep_Address_Situs, Prep_Address_Last_Situs, RawAID, busi_aid, lFlags);

  // Get standardized Name and Address fields
  Acquireweb_Plus.layouts.Business_Base tProjectClean(busi_aid L):=TRANSFORM
    SELF.awid                       := L.awid;
    SELF.DID                        := 0;
    SELF.DID_Score                  := 0;
    SELF.date_vendor_first_reported := L.date_vendor_first_reported;
    SELF.date_vendor_last_reported  := L.date_vendor_last_reported;
    SELF.date_first_seen            := '';
    SELF.date_last_seen             := '';
    SELF.clean_prim_range           := L.aidwork_acecache.prim_range;
    SELF.clean_predir               := L.aidwork_acecache.predir;
    SELF.clean_prim_name            := L.aidwork_acecache.prim_name;
    SELF.clean_addr_suffix          := L.aidwork_acecache.addr_suffix;
    SELF.clean_postdir              := L.aidwork_acecache.postdir;
    SELF.clean_unit_desig           := L.aidwork_acecache.unit_desig;
    SELF.clean_sec_range            := L.aidwork_acecache.sec_range;
    SELF.clean_p_city_name          := L.aidwork_acecache.p_city_name;
    SELF.clean_v_city_name          := L.aidwork_acecache.v_city_name;
    SELF.clean_st                   := L.aidwork_acecache.st;
    SELF.clean_zip                  := L.aidwork_acecache.zip5;
    SELF.clean_zip4                 := L.aidwork_acecache.zip4;
    SELF.clean_cart                 := L.aidwork_acecache.cart;
    SELF.clean_cr_sort_sz           := L.aidwork_acecache.cr_sort_sz;
    SELF.clean_lot                  := L.aidwork_acecache.lot;
    SELF.clean_lot_order            := L.aidwork_acecache.lot_order;
    SELF.clean_dbpc                 := L.aidwork_acecache.dbpc;
    SELF.clean_chk_digit            := L.aidwork_acecache.chk_digit;
    SELF.clean_rec_type             := L.aidwork_acecache.rec_type;
    SELF.clean_county               := L.aidwork_acecache.county;
    SELF.clean_geo_lat              := L.aidwork_acecache.geo_lat;
    SELF.clean_geo_long             := L.aidwork_acecache.geo_long;
    SELF.clean_msa                  := L.aidwork_acecache.msa;
    SELF.clean_geo_blk              := L.aidwork_acecache.geo_blk;
    SELF.clean_geo_match            := L.aidwork_acecache.geo_match;
    SELF.clean_err_stat             := L.aidwork_acecache.err_stat;
    SELF.aid                        := L.aidwork_rawaid;
    SELF                            := L;
    SELF                            := [];
  END;
	
	rsCleanAIDGoodAddr		:= PROJECT(busi_aid,tProjectClean(LEFT)):persist('~thor_data400::Acquireweb_Email::Business_Aid');
	
	Acquireweb_Plus.layouts.Business_Base tNoAddrClean(rsAID_NoAddr L):=TRANSFORM
		cl_addr			:= Address.CleanAddress182(L.Prep_Address_Situs, TRIM(L.city) + ' ' + TRIM(L.state) + ' ' + TRIM(L.Zip));
    SELF.awid                       := L.awid;
    SELF.DID                        := 0;
    SELF.DID_Score                  := 0;
    SELF.date_vendor_first_reported := L.date_vendor_first_reported;
    SELF.date_vendor_last_reported  := L.date_vendor_last_reported;
    SELF.date_first_seen            := '';
    SELF.date_last_seen             := '';
    SELF.clean_prim_range           := cl_addr[1..10];
    SELF.clean_predir               := cl_addr[11..12];
    SELF.clean_prim_name            := cl_addr[13..40];
    SELF.clean_addr_suffix          := cl_addr[41..44];
    SELF.clean_postdir              := cl_addr[45..46];
    SELF.clean_unit_desig           := cl_addr[47..56];
    SELF.clean_sec_range            := cl_addr[57..64];
    SELF.clean_p_city_name          := cl_addr[65..89];
    SELF.clean_v_city_name          := cl_addr[90..114];
    SELF.clean_st                   := cl_addr[115..116];
    SELF.clean_zip                  := cl_addr[117..121];
    SELF.clean_zip4                 := cl_addr[122..125];
    SELF.clean_cart                 := cl_addr[126..129];
    SELF.clean_cr_sort_sz           := cl_addr[130];
    SELF.clean_lot                  := cl_addr[131..134];
    SELF.clean_lot_order            := cl_addr[135];
    SELF.clean_dbpc                 := cl_addr[136..137];
    SELF.clean_chk_digit            := cl_addr[138];
    SELF.clean_rec_type             := cl_addr[139..140];
    SELF.clean_county               := cl_addr[141..145];
    SELF.clean_geo_lat              := cl_addr[146..155];
    SELF.clean_geo_long             := cl_addr[156..166];
    SELF.clean_msa                  := cl_addr[167..170];
    SELF.clean_geo_blk              := cl_addr[171..177];
    SELF.clean_geo_match            := cl_addr[178];
    SELF.clean_err_stat             := cl_addr[179..182];
    SELF.aid                        := L.RawAID;
    SELF                            := L;
    SELF                            := [];
  END;
	
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, tNoAddrClean(LEFT));
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr;

  // Find DIDs with a score of 75 or better
  matchset:=['A','Z'];  
  DID_Add.MAC_Match_Flex(rsCleanAIDGood,matchset,foo,foo,clean_fname,
    clean_mname,clean_lname,clean_name_suffix,clean_prim_range,
    clean_prim_name,clean_sec_range,clean_zip,
    clean_st,foo,DID,Acquireweb_Plus.layouts.Business_Base,true,DID_Score,75,rsCleanAID_DID);
		
	bdid_matchset	:= ['A'];
	Business_Header_SS.MAC_Add_BDID_Flex(rsCleanAID_DID												// Input Dataset
																			,bdid_matchset												// BDID Matchset what fields to match on
																			,clean_cname													// company_name
																			,clean_prim_range       							// prim_range
																			,clean_prim_name	        						// prim_name
																			,clean_zip             								// zip5
																			,clean_sec_range         							// sec_range
																			,clean_st	              							// state
																			,''																			// phone
																			,''																		// fein
																			,''																		// bdid
																			,Acquireweb_Plus.Layouts.Base_w_bip		// output layout
																			,FALSE 																// output layout has bdid score field?
																			,''																		// bdid_score
																			,dsBIP_out														// Output Dataset
																			,																			// default threshold
																			,																			// use prod version of superfiles
																			,														 					// default is to hit prod from dataland, and on prod hit prod.	
																			,[BIPV2.IDconstants.xlink_version_BIP]// create BIP keys only
																			,																			// url
																			,Email																// email 
																			,clean_v_city_name										// city
																			,clean_fname													// fname
																			,																			// mname
																			,clean_lname													// lname
																			,																			// contact ssn
																			,source																// Source  MDR.sourceTools
																			,awid																	// Source_Record_Id
																			,																			// Src_Matching_is_priorty
																			);
												
  // Append IPAddress to the new_acquireweb data
	Acquireweb_Plus.Layouts.Base_w_bip AppendIPAddress(dsBIP_out L,ipaddress_file_in R):=TRANSFORM
    SELF.ipaddress := R.ipaddress;
    SELF:=L;
    SELF:=[];
  END;
  ds_append_IPAddress	:=	JOIN(dsBIP_out, ipaddress_file_in,
															TRIM(LEFT.zip)+TRIM(LEFT.ZIP4) = TRIM(RIGHT.zip)+TRIM(RIGHT.ZIP4),
															AppendIPAddress(LEFT,RIGHT),LEFT OUTER,LOCAL);
	

  PromoteSupers.Mac_SF_BuildProcess(ds_append_IPAddress(trim(AWID,left,right)<>'AWID'), '~thor_data200::base::acquireweb_business_w_bip',build_base,3,,true);
	
	RETURN SEQUENTIAL(build_base, ingestMod.DoStats);
END;
