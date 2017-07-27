import ut, alerts;

export alert_calcs(boolean curVersion = true) := MODULE

	// shorter names
	shared layout_hashval := alerts.layouts.layout_hashval;
	shared layout_report_hash := alerts.layouts.layout_report_hash;
	
	shared layout_report_hashes := alerts.layouts.layout_locreport_hashes;
	
	// version numbers
	shared unsigned1 propHashVersion := 1;
	shared unsigned1 assocHashVersion := 1;
	
	// commoned up code for Functions below
	shared processReportAlerts(ds, trans, ver) := MACRO
		hashvals := PROJECT(ds, trans(LEFT));
		RETURN DATASET([{ver, SUM(hashvals,hashval)}], layout_report_hash);
	ENDMACRO;

  // hash calculation logic for each particular data type

	//
	// Property Info hashes
	//		
	layout_hashval calcPropHashVals(layout_report.propertyInfo l) := TRANSFORM
		SELF.hashval := HASH64(l.Legal_Description, l.land_usage, l.sale_date, l.Sale_Price, l.Lender_Name,
													 l.Loan_Type,l.Loan_Amount,l.Loan_Term, l.Tax_Year, l.Land_Value, l.Improvement_Value,
													 l.Total_Value);
	END; // no fields of qstring type

  DATASET(layout_report_hash) calcPropHashes(DATASET(layout_report.propertyInfo) recs) := FUNCTION
		processReportAlerts(recs,calcPropHashVals,propHashVersion)
	END;

	//
	// Assoc Info hashes
	//
	
	layout_hashval calcCompanyHashVals(layout_report.CompanyName l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.company_name);
	END;

	layout_hashval calcBusAssocRecHashVals(layout_report.BusAssoc l) := TRANSFORM
		SELF.hashval := SUM(PROJECT(l.company_name, calcCompanyHashVals(LEFT)),hashval);
	END;

	
	layout_hashval calcAssocRecHashVals(layout_report.Assoc l,INTEGER C) := TRANSFORM
		SELF.hashval := HASH64(C,(>data<)l.fname,(>data<)l.mname,(>data<)l.lname);
	END;
	
	layout_hashval calcAssocHashVals(layout_report.AssocRecord l) := TRANSFORM
		SELF.hashval := SUM(PROJECT(l.curOwnRes.a, calcAssocRecHashVals(LEFT,1)),hashval) +
										SUM(PROJECT(l.curOwn.a, calcAssocRecHashVals(LEFT,2)),hashval) +
										SUM(PROJECT(l.curRes.a, calcAssocRecHashVals(LEFT,3)),hashval) +
										SUM(PROJECT(l.prevOwn.a, calcAssocRecHashVals(LEFT,4)),hashval) +
										SUM(PROJECT(l.prevRes.a, calcAssocRecHashVals(LEFT,5)),hashval) +
										SUM(PROJECT(l.other.ba, calcBusAssocRecHashVals(LEFT)),hashval);
	END;

  DATASET(layout_report_hash) calcAssocHashes(DATASET(layout_report.AssocRecord) recs) := FUNCTION
		processReportAlerts(recs,calcAssocHashVals,assocHashVersion)
	END;
	
  export layout_report_hashes calcHashes(layout_report.KeyRec l) := TRANSFORM
	  SELF.prop_hashes := calcPropHashes(l.propInfo);
	  SELF.assoc_hashes := calcAssocHashes(DATASET(l.associates));
		SELF := [];
  END;

END;