IMPORT BatchShare, LN_PropertyV2, LN_PropertyV2_Services;

EXPORT fn_getParties(DATASET(HomesteadExemptionV2_Services.Layouts.fidSrchRec) fids) := FUNCTION

	acctnoRawPartyRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		LN_PropertyV2_Services.layouts.parties.raw_source;
	END;

	partyParentRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		LN_PropertyV2_Services.layouts.fid.ln_fares_id;
		LN_PropertyV2_Services.layouts.core.fid_type;
	END;

	acctnoPartyEntityRec:=RECORD
		partyParentRec;
		LN_PropertyV2_Services.layouts.parties.tmp1.dt_last_seen;
		LN_PropertyV2_Services.layouts.parties.tmp1.addr_type;
		LN_PropertyV2_Services.layouts.parties.pparty.party_type;
		LN_PropertyV2_Services.layouts.parties.pparty.party_type_name;
		LN_PropertyV2_Services.layouts.parties.entity;
	END;

	rollParties(DATASET(acctnoPartyEntityRec) preSortedEntities) := FUNCTION

		partyChildRec:=RECORD
			LN_PropertyV2_Services.layouts.fid.ln_fares_id;
			LN_PropertyV2_Services.layouts.parties.pparty.party_type;
			LN_PropertyV2_Services.layouts.parties.pparty.party_type_name;
			DATASET(LN_PropertyV2_Services.layouts.parties.entity) entity;
		END;

		acctnoParentChildRec:=RECORD
			partyParentRec;
			partyChildRec;
		END;

		acctnoPartyRec:=RECORD
			partyParentRec;
			DATASET(partyChildRec) parties;
		END;

		acctnoParentChildRec rollEntities(acctnoPartyEntityRec L,DATASET(acctnoPartyEntityRec) R) := TRANSFORM
			SELF.entity:=PROJECT(R,TRANSFORM(LN_PropertyV2_Services.layouts.parties.entity,SELF:=LEFT,SELF:=[]));
			SELF:=L;
		END;

		acctnoPartyRec rollParties(acctnoParentChildRec L,DATASET(acctnoParentChildRec) R) := TRANSFORM
			SELF.parties:=PROJECT(R,TRANSFORM(partyChildRec,SELF:=LEFT,SELF:=[]));
			SELF:=L;
		END;

		grpEntities := GROUP(preSortedEntities,acctno,fid_type,ln_fares_id,party_type);
		rolEntities := ROLLUP(grpEntities,GROUP,rollEntities(LEFT,ROWS(LEFT)));
		srtParties  := SORT(rolEntities,acctno,fid_type,ln_fares_id);
		grpParties  := GROUP(srtParties,acctno,fid_type,ln_fares_id);

		RETURN ROLLUP(grpParties,GROUP,rollParties(LEFT,ROWS(LEFT)));
	END;

	acctnoPartyEntityRec slimPartyRecs(acctnoRawPartyRec L) := TRANSFORM
		fid_type:=LN_PropertyV2.fn_fid_type(L.ln_fares_id);
		SELF.fid_type:=fid_type;
		party_type:=L.source_code_1;
		SELF.addr_type:=L.source_code_2;
		SELF.party_type:=party_type;
		SELF.party_type_name:=LN_PropertyV2_Services.party_type_named(fid_type,party_type);
		SELF.did:=IF(L.did!=0,(STRING12)L.did,'');
		SELF.bdid:=IF(L.bdid!=0,(STRING12)L.bdid,'');
		SELF:=L;
	END;

	acctnoPartyEntityRec setPropertyRecs(acctnoPartyEntityRec L) := TRANSFORM
		SELF.acctno:=L.acctno;
		SELF.ln_fares_id:=L.ln_fares_id;
		SELF.fid_type:=L.fid_type;
		SELF.addr_type:=L.addr_type;
		SELF.party_type:='P';
		SELF.party_type_name:='Property';
		SELF:=[];
	end;

	rawParties:=JOIN(fids,LN_PropertyV2.key_search_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
		TRANSFORM(acctnoRawPartyRec,SELF:=LEFT,SELF:=RIGHT,SELF:=[]),
		LIMIT(LN_PropertyV2_Services.consts.MAX_PARTIES,SKIP));

	tmpParties1 := PROJECT(rawParties,slimPartyRecs(LEFT));
	ds_addrType_P := tmpParties1(addr_type='P');       // property addr recs
	ds_addrType_N := tmpParties1(addr_type!='P');      // non-property addr recs
	ds_addrType_X := JOIN(ds_addrType_P,ds_addrType_N, // propagate recs with no property addr duplicate
		LEFT.ln_fares_id=RIGHT.ln_fares_id AND
		LEFT.party_type=RIGHT.party_type,LEFT ONLY);
	tmpParties2 := ds_addrType_N+ds_addrType_X;
	// tmpParties2 := PROJECT(ds_addrType_P,setPropertyRecs(LEFT))+ds_addrType_N+ds_addrType_X;
	dupSrtParties := DEDUP(SORT(tmpParties2,acctno,fid_type,ln_fares_id,party_type,-dt_last_seen,RECORD),RECORD);

	// OUTPUT(rawParties,NAMED('rawParties'));
	// OUTPUT(tmpParties1,NAMED('tmpParties1'));
	// OUTPUT(ds_addrType_P,NAMED('ds_addrType_P'));
	// OUTPUT(ds_addrType_N,NAMED('ds_addrType_N'));
	// OUTPUT(ds_addrType_X,NAMED('ds_addrType_X'));
	// OUTPUT(tmpParties2,NAMED('tmpParties2'));
	// OUTPUT(dupSrtParties,NAMED('dupSrtParties'));

	RETURN rollParties(dupSrtParties);
END;
