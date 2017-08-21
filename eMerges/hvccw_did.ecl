import AID, didville, DID_Add, header_slimsort, ut, watchdog, fair_isaac, mdr, header;

export hvccw_did(dataset(emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout) dHuntCCW)	:=
function

	// Append sequence number to normalize records so as to pass to the AddressID macro
	rAppendAID_layout	:=
	record
		emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout;
		string1		addressInd						:=	'';
		AID.Common.xAID	Append_RawAID		:=	0;
		string100	Append_Prep_Address1;
		string50	Append_Prep_Address2;
		string10	AID_ACEClean_prim_range;
		string2		AID_ACEClean_predir;
		string28	AID_ACEClean_prim_name;
		string4		AID_ACEClean_addr_suffix;
		string2		AID_ACEClean_postdir;
		string10	AID_ACEClean_unit_desig;
		string8		AID_ACEClean_sec_range;
		string25	AID_ACEClean_p_city_name;
		string25	AID_ACEClean_v_city_name;
		string2		AID_ACEClean_st;
		string5		AID_ACEClean_zip;
		string4		AID_ACEClean_zip4;
		string4		AID_ACEClean_cart;
		string1		AID_ACEClean_cr_sort_sz;
		string4		AID_ACEClean_lot;
		string1		AID_ACEClean_lot_order;
		string2		AID_ACEClean_dbpc;
		string1		AID_ACEClean_chk_digit;
		string2		AID_ACEClean_record_type;
		string2		AID_ACEClean_ace_fips_st;
		string3		AID_ACEClean_fipscounty;
		string10	AID_ACEClean_geo_lat;
		string11	AID_ACEClean_geo_long;
		string4		AID_ACEClean_msa;
		string7		AID_ACEClean_geo_blk;
		string1		AID_ACEClean_geo_match;
		string4		AID_ACEClean_err_stat;
	end;

	rAppendAID_layout	tAppendAID(dHuntCCW pInput)	:=
	transform
		self	:=	pInput;
		self	:=	[];
	end;

	dHuntCCW_AppendAID	:=	project(dHuntCCW, tAppendAID(left));

	// Normalize records by address
	rAppendAID_layout	tNormalizeAddr(dHuntCCW_AppendAID pInput, integer cntAddr)	:=
	transform
		self.addressInd						:=	choose(cntAddr, 'R', 'M', 'C');
		self.Append_Prep_Address1	:=	choose(cntAddr, pInput.Append_Prep_ResAddress1, pInput.Append_Prep_MailAddress1, pInput.Append_Prep_CASSAddress1);
		self.Append_Prep_Address2	:=	choose(cntAddr, pInput.Append_Prep_ResAddress2, pInput.Append_Prep_MailAddress2, pInput.Append_Prep_CASSAddress2);
		self.Append_RawAID				:=	choose(cntAddr, pInput.Append_ResRawAID, pInput.Append_MailRawAID, pInput.Append_CASSRawAID);
		self											:=	pInput;
	end;

	dHuntCCW_NormalizeAddr	:=	normalize(dHuntCCW_AppendAID, 3, tNormalizeAddr(left, counter), local);

	dHuntCCW_Addrpopulated		:=	dHuntCCW_NormalizeAddr(Append_Prep_Address2	!=	'');
	dHuntCCW_AddrNotPopulated	:=	dHuntCCW_NormalizeAddr(Append_Prep_Address2	=		'');
	
	// Append Clean Address to the record
	unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
																AID.Common.eReturnValues.ACECacheRecords;
			
	AID.MacAppendFromRaw_2Line(	dHuntCCW_Addrpopulated,
															Append_Prep_Address1,
															Append_Prep_Address2,
															Append_RawAID,
															dHuntCCW_AppendCleanAddr,
															lAIDAppendFlags
														);
	
	rAppendDID_layout	:=
	record
		unsigned6 did				:= 0;
		unsigned2 did_score	:= 0;
		rAppendAID_layout;
	end;

	rAppendDID_layout tAddDID(dHuntCCW_AppendCleanAddr pInput):=
	transform
		self.Append_RawAID						:=	pInput.AIDWork_RawAID;
		self.AID_ACEClean_prim_range	:=	pInput.AIDWork_AceCache.prim_range;
		self.AID_ACEClean_predir			:=	pInput.AIDWork_AceCache.predir;
		self.AID_ACEClean_prim_name		:=	pInput.AIDWork_AceCache.prim_name;
		self.AID_ACEClean_addr_suffix	:=	pInput.AIDWork_AceCache.addr_suffix;
		self.AID_ACEClean_postdir			:=	pInput.AIDWork_AceCache.postdir;
		self.AID_ACEClean_unit_desig	:=	pInput.AIDWork_AceCache.unit_desig;
		self.AID_ACEClean_sec_range		:=	pInput.AIDWork_AceCache.sec_range;
		self.AID_ACEClean_p_city_name	:=	pInput.AIDWork_AceCache.p_city_name;
		self.AID_ACEClean_v_city_name	:=	pInput.AIDWork_AceCache.v_city_name;
		self.AID_ACEClean_st					:=	pInput.AIDWork_AceCache.st;
		self.AID_ACEClean_zip					:=	pInput.AIDWork_AceCache.zip5;
		self.AID_ACEClean_zip4				:=	pInput.AIDWork_AceCache.zip4;
		self.AID_ACEClean_cart				:=	pInput.AIDWork_AceCache.cart;
		self.AID_ACEClean_cr_sort_sz	:=	pInput.AIDWork_AceCache.cr_sort_sz;
		self.AID_ACEClean_lot					:=	pInput.AIDWork_AceCache.lot;
		self.AID_ACEClean_lot_order		:=	pInput.AIDWork_AceCache.lot_order;
		self.AID_ACEClean_dbpc				:=	pInput.AIDWork_AceCache.dbpc;
		self.AID_ACEClean_chk_digit		:=	pInput.AIDWork_AceCache.chk_digit;
		self.AID_ACEClean_record_type	:=	pInput.AIDWork_AceCache.rec_type;
		self.AID_ACEClean_ace_fips_st	:=	pInput.AIDWork_AceCache.county[1..2];
		self.AID_ACEClean_fipscounty	:=	pInput.AIDWork_AceCache.county[3..5];
		self.AID_ACEClean_geo_lat			:=	pInput.AIDWork_AceCache.geo_lat;
		self.AID_ACEClean_geo_long		:=	pInput.AIDWork_AceCache.geo_long;
		self.AID_ACEClean_msa					:=	pInput.AIDWork_AceCache.msa;
		self.AID_ACEClean_geo_blk			:=	pInput.AIDWork_AceCache.geo_blk;
		self.AID_ACEClean_geo_match		:=	pInput.AIDWork_AceCache.geo_match;
		self.AID_ACEClean_err_stat		:=	pInput.AIDWork_AceCache.err_stat;
		self 													:=	pInput;
	end;

	dHuntCCW_AppendCleanAID	:=	project(dHuntCCW_AppendCleanAddr,tAddDID(left));
	dHuntCCW_NoAID					:=	project(	dHuntCCW_AddrNotPopulated,
																				transform(	rAppendDID_layout,
																										self	:=	left;
																										self	:=	[];
																									)
																			);
	//add Header src
	dHuntCCW_CombinedAID	:=	dHuntCCW_AppendCleanAID	+	dHuntCCW_NoAID;
	
	rHeaderSource_layout	:=
	record
		header_slimsort.Layout_Source;
		rAppendDID_layout;
	end;

	DID_Add.Mac_Set_Source_Code(dHuntCCW_CombinedAID, rHeaderSource_layout, 'EM', dHuntCCW_AppendDID_Src)

	matchset := ['A','D','P','Z','G'];

	//DID file
	DID_Add.MAC_Match_Flex(	dHuntCCW_AppendDID_Src,
													matchset,
													junk,
													dob_str_in,
													fname, mname, lname, name_suffix,
													AID_ACEClean_prim_range, AID_ACEClean_prim_name,
													AID_ACEClean_sec_range, AID_ACEClean_zip, AID_ACEClean_st,
													phone,
													did, rHeaderSource_layout, true, did_score, 
													75, dHuntCCW_DID_Src_Out, true, src
												)

	//remove source
	dHuntCCW_DIDOut := project(dHuntCCW_DID_Src_Out, transform(rAppendDID_layout, self := left));

	rAppendDID_layout tFormatThem(rAppendDID_layout pInput)	:=
	transform
		self.DID_out			:=	if(pInput.did = 0,'',regexreplace('^[0]+$', intformat(pInput.did, 12, 1), ''));
		self.score				:=	regexreplace('^[0]+$', intformat(pInput.did_score,3,1), '');
		self.best_ssn			:=	'';
		self							:=	pInput;
	end;

	dHuntCCW_CleanDID	:= project(dHuntCCW_DIDOut,	tFormatThem(left));

	dWatchdog		:=	watchdog.File_Best;

	rAppendDID_layout getssn(dWatchdog le, dHuntCCW_CleanDID ri) := transform
		self.best_ssn	:= regexreplace('^[0]+$', intformat((integer)le.ssn,9,1), '');
		self					:= ri;
	end;

	dHuntCCW_DID_SSN	:=	join(	distribute(dWatchdog,hash(did)),
															distribute(dHuntCCW_CleanDID(did_out != ''),hash((integer)did_out)),
															left.did = (integer)right.did_out,
															getssn(LEFT,RIGHT),
															right outer,
															local
														) +
												dHuntCCW_CleanDID(did_out = '') : persist('~thor_data400::persist::emerges::hunt_ccw_did');
						
	return	dHuntCCW_DID_SSN;
end;