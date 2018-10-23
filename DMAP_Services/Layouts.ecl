IMPORT iesp, LN_PropertyV2_Services;

EXPORT Layouts := MODULE

	EXPORT voo_layout:= RECORD
		INTEGER2 InferredOwnershipTypeIndex;
		INTEGER2 VerificationOfOccupancyScore;
		STRING1 OwnOrRent;
		STRING8 AsOfDate; 
	END;
	
	EXPORT phone_layout:= RECORD
		STRING10 Phone;
	END;
	
	EXPORT addr_layout:= RECORD
		STRING10  PrimRange;
		STRING2   Predir;
		STRING28  PrimName;
		STRING4   AddrSuffix;
		STRING2   Postdir;
		STRING10  UnitDesig;
		STRING8   SecRange;
		STRING25  CityName;
		STRING2   St;
		STRING5   Zip;
		BOOLEAN		is_input_property;
		UNSIGNED2 AddrSeq;
	END;
	
	EXPORT address_info:= RECORD
		addr_layout Address;
		UNSIGNED4 DateLastSeen;
		UNSIGNED4 DateFirstSeen;
		BOOLEAN is_best_address;
		UNSIGNED DaysSinceLastSeen;
	END;
	
	EXPORT borrower_layout:= RECORD
		UNSIGNED6 Did;
		STRING11   SSN;
		UNSIGNED4 DOB;
		iesp.share.t_Name Name;
		address_info;
	END;
	
	EXPORT fids_layout:= RECORD
		LN_PropertyV2_Services.keys.assessor().ln_fares_id;
		UNSIGNED2 AddrSeq;
		BOOLEAN		is_input_property;
	END;		
	
	EXPORT deed_layout:= RECORD (fids_layout)
		STRING24 BorrowerVestingDesc;
		STRING24 BuyerVestingDesc;
		STRING4 YearLotAcquired;
		STRING11 OriginalCost;
		STRING8 RecordingDate;
		STRING76 PropertyType;
	END;
	
	EXPORT assessment_layout:= RECORD
		STRING5 NoOfUnits;
		STRING76 SubjectPropertyType;
		STRING250 LegalDescription;
		STRING4 YearBuilt;
		STRING13 RealEstateTaxesCurrentProperty;
		STRING4 AssessedValueYear;
		STRING4 Taxyear;
	END;
	
	EXPORT property_layout:= RECORD
		addr_layout Address;
		assessment_layout;
		deed_layout;
	END;
	
	EXPORT dmap_Layout:= RECORD
		borrower_layout;
		property_layout Property;
		voo_layout;
		DATASET(addr_layout) RealEstateOwnedProperty;
		STRING LoanPurpose;
	END;
	
	EXPORT input_Layout:= RECORD
		UNSIGNED6 Did;
		addr_layout PropertyAddr;
		STRING30 LoanPurpose;
	END;
END;
