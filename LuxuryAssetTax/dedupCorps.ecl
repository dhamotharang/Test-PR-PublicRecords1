export dedupCorps(DATASET(LuxuryAssetTax.Layouts.outputRec) input) := FUNCTION

	sortedInput := SORT(input, out.Id_Number, rec.vehKey, -rec.iterKey, -rec.seqKey, rec.corp_key, rec.id, rec.lastReportDate);

	LuxuryAssetTax.Layouts.outputRec rollupCorporations(LuxuryAssetTax.Layouts.outputRec L, LuxuryAssetTax.Layouts.outputRec R) := TRANSFORM
	  SELF.out.Incorp_Reg_Year_Match := IF(L.out.Incorp_Reg_Year_Match = R.out.Incorp_Reg_Year_Match, L.out.Incorp_Reg_Year_Match, 'Y');
		SELF.out.Bought_Before_LLC_Incorp := IF(L.out.Bought_Before_LLC_Incorp = R.out.Bought_Before_LLC_Incorp, L.out.Bought_Before_LLC_Incorp, 'Y');
    SELF.out.Business_Owned := IF(L.out.Business_Owned = R.out.Business_Owned, L.out.Business_Owned, 'Y');
		SELF.out.Contact_Owned := IF(L.out.Contact_Owned = R.out.Contact_Owned, L.out.Contact_Owned, 'Y');
		SELF.out.contact_name := IF(L.out.contact_name <> '', L.out.contact_name, R.out.contact_name);
		SELF.out.contact_addr := IF(L.out.contact_addr <> '', L.out.contact_addr, R.out.contact_addr);

		SELF := L;
	END;

  out := ROLLUP(sortedInput, rollupCorporations(LEFT, RIGHT), out.Id_Number, rec.vehKey, rec.iterKey, rec.seqKey, rec.corp_key);

  return out;

END;