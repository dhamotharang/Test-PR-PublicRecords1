import Address, AddrBest;

export addBestAddrInfo(DATASET(LuxuryAssetTax.Layouts.outputRec) input) := FUNCTION

	rec := RECORD
		qstring20 acctno;
		unsigned6 did;
	END;

	rec extractDid(LuxuryAssetTax.Layouts.outputRec L) := TRANSFORM
		SELF.acctno := '';
		SELF.did := L.out.reg_1_did;
	END;

	didList := DEDUP(SORT(PROJECT(input, extractDid(LEFT)), did), did);

	AddrBest.Layout_BestAddr.Batch_in xfm(rec L, INTEGER cnt) := TRANSFORM
		SELF.acctno := (qstring20) cnt;
		SELF.did := L.did;
		SELF := [];
	END;

	ds_input := PROJECT(didList, xfm(LEFT, COUNTER));

	bestAddress := LuxuryAssetTax.rpc_for_addrbest(ds_input);

	LuxuryAssetTax.Layouts.outputRec addBestAddrInfo(LuxuryAssetTax.Layouts.outputRec L, AddrBest.Layout_BestAddr.batch_out_final R) := TRANSFORM
		SELF.out.Best_First_Name := R.name_first;
		SELF.out.Best_Middle_Name := R.name_middle;
		SELF.out.Best_Last_Name := R.name_last;
		SELF.out.Best_SSN := R.ssn;
		SELF.out.Best_Address := Address.Addr1FromComponents(R.prim_range, 
																											R.predir, 
																											R.prim_name,
																											R.suffix, 
																											R.postdir, 
																											R.unit_desig, 
																											R.sec_range);		
		SELF.out.Best_City := R.p_city_name;
		SELF.out.Best_State := R.st;
		SELF.out.Best_Zipcode := IF(R.zip4 <>'', R.z5 + '-' + R.zip4, R.z5);
		SELF.out.Best_Date_First_Seen := R.addr_dt_first_seen;
		SELF.out.Best_Date_Last_Seen := R.addr_dt_last_seen;
		SELF := L;
	END;

	out := JOIN(input, bestAddress, LEFT.out.reg_1_did = RIGHT.did, addBestAddrInfo(LEFT, RIGHT), LEFT OUTER);
	
  return out;
END;