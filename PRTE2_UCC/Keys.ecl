IMPORT doxie, bipv2, ut, Data_Services, autokeyb2, PRTE2_UCC, UCCV2;

EXPORT Keys := MODULE

	//Bdid
	BdidSlim		  := TABLE(Files.Party_base(Bdid>0), {Bdid,tmsid,rmsid}); 
	BdidDedup    	:= DEDUP(SORT(BdidSlim, Bdid,tmsid,rmsid), Bdid,tmsid,rmsid);
	
	EXPORT key_bdid := INDEX(BdidDedup,{Bdid},{tmsid,rmsid},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::bdid');
	
	//Bdid_w_Type
	BdidTypeSlim		:= TABLE(Files.Party_base(Bdid>0), {Bdid,tmsid,rmsid,party_type});
	BdidTypeDedup   := DEDUP(SORT(BdidTypeSlim, Bdid,tmsid,rmsid,party_type), Bdid,tmsid,rmsid,party_type);
	
	EXPORT key_bdid_w_type := INDEX(BdidTypeDedup, {Bdid,party_type},{tmsid,rmsid},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::bdid_w_type');
	
	//DID
	DidSlim		  := TABLE(Files.Party_base(did>0), {did,tmsid,rmsid}); 
	DidDedup    := DEDUP(SORT(DidSlim, did,tmsid,rmsid), did,tmsid,rmsid);
	
	EXPORT key_did := INDEX(DidDedup,{did},{tmsid,rmsid},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::did');
	
	//Did_w_Type
	EXPORT key_did_w_type(boolean isFCRA = FALSE) := FUNCTION
	
		DidTypeSlim		:= TABLE(Files.Party_base(did>0), {did,tmsid,rmsid,party_type});
		DidTypeDedup   := DEDUP(SORT(DidTypeSlim, did,tmsid,rmsid,party_type), did,tmsid,rmsid,party_type);
	
	RETURN INDEX(DidTypeSlim,{did,party_type},{tmsid,rmsid},
								IF(IsFCRA, 
											PRTE2_UCC.Constants.KEY_PREFIX + 'fcra::',
											PRTE2_UCC.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::did');
	END;
	
	//Filing_number
	dfilingnum		    := TABLE(Files.Main_base(filing_number<>''), {filing_number,tmsid,rmsid});

	recordof(dfilingnum) tranFilingNumber(Files.Main_base pInput) := TRANSFORM
		self.filing_number	:= pInput.orig_filing_number;
		self								:= pInput;
	END;	
			 
	dFiling := dfilingnum +
						PROJECT(Files.Main_base(orig_filing_number<>''), tranFilingNumber(left));
	dFilingDedup := DEDUP(SORT(dFiling, filing_number, tmsid, rmsid),filing_number,tmsid, rmsid);
						
	EXPORT key_filing_number := INDEX(dFilingDedup,{filing_number},{tmsid,rmsid}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::filing_Number');

	//RMSID
	dRMSIDDedup := DEDUP(SORT(Files.Main_base, RMSID, TMSID), RMSID, TMSID);
	
	EXPORT key_RMSID  := INDEX(dRMSIDDedup,{RMSID},{TMSID}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::rmsid');	
	
	//Main RMSID
	EXPORT Key_rmsid_main(boolean  IsFCRA = FALSE) := FUNCTION
	
	RETURN INDEX(Files.Main_base,{tmsid,rmsid},{Files.Main_base},
							IF(IsFCRA, 
											PRTE2_UCC.Constants.KEY_PREFIX + 'fcra::',
											PRTE2_UCC.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::main_rmsid');
	END;
	
	//Party RMSID
	EXPORT key_rmsid_party(boolean  IsFCRA = FALSE) := FUNCTION
	
	Layout_Party_linkids := RECORD
		uccv2.Layout_UCC_Common.Layout_Party_with_aid - [source_rec_id, prep_addr_line1, prep_addr_last_line, rawaid, aceaid];
	END;
	
	PartySlim 	:= PROJECT(Files.Party_base, Layout_Party_linkids);
	dPartySort	:= sort(dedup(sort(PartySlim, tmsid,rmsid,fname,lname,mname,prim_name,prim_range,company_name,party_type),
                       tmsid,fname,lname,mname,prim_name,prim_range,company_name),tmsid,rmsid);
	
	RETURN INDEX(dPartySort,{tmsid,rmsid},{PartySlim},
							IF(IsFCRA, 
											PRTE2_UCC.Constants.KEY_PREFIX + 'fcra::',
											PRTE2_UCC.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::party_rmsid');
	END;
	
	// Party RMSID Linkids
	PartySort := sort(dedup(sort(Files.Party_base, tmsid,rmsid,fname,lname,mname,prim_name,prim_range,company_name,party_type),
                       tmsid,fname,lname,mname,prim_name,prim_range,company_name),tmsid,rmsid);
	
	
	//Linkids
	EXPORT Key_LinkIds := MODULE
		EXPORT  out_SuperKeyName  := Constants.KEY_PREFIX + doxie.Version_SuperKey + '::linkids'; //SuperKeyName

		BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Party_base, out_key, out_SuperKeyName);
		export Key := out_key;
			
			//DEFINE THE INDEX ACCESS
		export kFetch2(
				dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
				string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	 //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																															//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																														 //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
				unsigned2 ScoreThreshold = 0,										  //Applied at lowest leve of ID
				joinLimit=25000,
				unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
									) :=FUNCTION

				BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out_fetch, Level, joinLimit, JoinType);
				return out_fetch;	
		END;
	END;
	
	//Build Autokeys
	EXPORT proc_build_autokey(string filedate) := FUNCTION
	
	AutoKeyB2.MAC_Build (Files.SearchAutokey,
					person_name.fname,person_name.mname,person_name.lname,
					ssn,
					zero,
					zero,
					person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					party_bits,
					DID,
					company_name,
					fein,
					zero,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					bdid,
					Constants.ak_keyname,
					Constants.ak_logical(filedate),
					outaction,false,
					[],true,Constants.ak_typeStr,true,,,zero) 

	AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname, mymove)

	retval := sequential(outaction,mymove);

	RETURN retval;

	END;
	
	
END;
												 		