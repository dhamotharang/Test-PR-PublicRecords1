
import BIPV2, doxie, doxie_crs;

export Layout_report := MODULE

	export Location_info := RECORD
		Layout_Location_slim;  // used to echo back the (cleaned) input parameters
		string10  lat := '';
		string11  lon := '';
		string18  county := '';
		string4   msa := '';
		string60 msaDesc := '';
	END;
	
	export ApnRec := RECORD
		string45 apn;
	END;
	
	export propertyInfo := RECORD
		doxie_crs.layout_property_ln.Legal_Description;
		doxie_crs.layout_property_ln.land_usage;
		doxie_crs.layout_property_ln.sale_date;
		doxie_crs.layout_property_ln.Sale_Price;
	//  string8   priorSalesDate;   // deeds or assets?: prior_sales_date   
	//  string11  priorSalesPrice;	// deeds or assets?: prior_sales_price
	// Deed type  -- deeds: mortgage_deed_type???   ex: MG
		
		doxie_crs.layout_property_ln.Lender_Name; 
		doxie_crs.layout_property_ln.Loan_Type;
		doxie_crs.layout_property_ln.Loan_Amount; 
		string8 Loan_Term;
		// Rate  -- doesn't appear to be available

		// (from most recent tax_year)
		doxie_crs.layout_property_ln.Tax_Year; 
		doxie_crs.layout_property_ln.Land_Value; 
		doxie_crs.layout_property_ln.Improvement_Value; 
		doxie_crs.layout_property_ln.Total_Value;
		BOOLEAN isFares;
		string1 vendor_source_flag;
	END;

	export Assoc := RECORD
		doxie.layout_best.did;
		doxie.layout_best.fname;
		doxie.layout_best.mname;
		doxie.layout_best.lname;
		doxie.layout_best.name_suffix;
	END;

	export AssocRec := RECORD
		unsigned6 totCnt;   // actual count before limiting
		DATASET(Assoc) a {maxcount(consts.max_assocs)};
	END;

	export CompanyName := RECORD
		qstring120 company_name;
	END;
	
	export BusAssoc := RECORD
		unsigned6 group_id;
		BIPV2.IDlayouts.l_header_ids businessIDs;
		DATASET(CompanyName) company_name {maxcount(consts.max_assocs)};
	END;
	
	export BusAssocRec := RECORD
		unsigned6 totCnt; // actual count before limiting
		DATASET(BusAssoc) ba  {maxcount(consts.max_assocs)};
	END;
	
	export AssocRecord := RECORD
		AssocRec curOwnRes;
		AssocRec curOwn;
		AssocRec curRes;
		AssocRec prevOwn;
		AssocRec prevRes;
		BusAssocRec other;
	END;

  // the maxlength should be replaced with maxcounts on the child datasets
	export KeyRec := RECORD, MAXLENGTH(100000)
		DATASET(Location_info) locInfo;
		DATASET(Layout_location_slim) addrs;
		DATASET(ApnRec) apns;
		DATASET(propertyInfo) propInfo;
		DATASET(doxie.layout_nbr_records) neighbors;
		AssocRecord associates;
		unsigned1 do_royal;
	END;

END;