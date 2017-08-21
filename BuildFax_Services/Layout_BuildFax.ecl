import BuildFax;

export Layout_BuildFax := MODULE

export input_rec := RECORD
  string20  acctno; //needed for batchR3
  string20  external_seq;	
	string10	house;
	string40	street;
	string8		apt;
	string25	city;
	string2		st;
	string5		zip;
	integer2  roofyear  := 0;
	integer2  yearbuilt := 0;
end;

export input_rec_online := RECORD
  string20  internal_seq;
  string10	house;
	string40	street;
	string8		apt;
	string25	city;
	string2		st;
	string5		zip;
	integer2  yearbuilt;
end;

export seq_input_rec := RECORD
  string20   internal_seq;	
	input_rec;
end;

export addr_rec := RECORD
  string10		PRIM_RANGE;
	string2			PREDIR;
	string28		PRIM_NAME;
	string4			ADDR_SUFFIX;
	string2			POSTDIR;
	string10		UNIT_DESIG;
	string8			SEC_RANGE;
	string25		CITY;
	string2			ST;
	string5			ZIP;
	string4			ZIP4;
end;

export cleanaddr_rec := RECORD
  seq_input_rec   input;
  addr_rec    address;
	string4     errorcode;
end;

export property_key_rec := RECORD
  string20    sequence;  
	string10		PRIM_RANGE;
	string28		PRIM_NAME;
	string25		CITY;
	string2			ST;
	string5			ZIP;
end;

export streetlookup_key_rec := RECORD
  string20    sequence;  
	STRING100		STREET;
	STRING255		CITY;
	STRING2			STATE;
	STRING6			ZIP;
end;

export buildfax_key_rec := RECORD
  string20    sequence;  
	string255		id;
end;

export jurisdiction_key_rec := RECORD
  string20    sequence;  
	string255		jurisdiction;
end;

export layout_calcpermit := RECORD
  string20  sequence;
	string255 id;
	string4   yearbuilt;
	string8   coverage_start_date;
	addr_rec  address;
	DATASET(BuildFax.Layout.Permit_slim) Permits {MAXCOUNT(99999)};
end;

export calculated_rec := RECORD
	string8     update_date;
	string4     not_update_since;
	string5     age;
end;

export layout_calcages := RECORD
  string20        sequence;
	string255       id;
  calculated_rec  new_constr;
	calculated_rec  rem;
	calculated_rec  bldg;
	calculated_rec  elect;
	calculated_rec  mech;
	calculated_rec  plumb;
	calculated_rec  other;
	calculated_rec  roof;
	calculated_rec  pool;
	calculated_rec  demol;
	calculated_rec  repair;
	calculated_rec  wind_prevent;
	calculated_rec  seismic;
	calculated_rec  solar;
	calculated_rec  sprinkler;
	calculated_rec  firealrm;
	calculated_rec  security;
	calculated_rec  change_use;
	calculated_rec  water;
	calculated_rec  wind;
	calculated_rec  fire;
	calculated_rec  pest;
	calculated_rec  natdisast;
	calculated_rec  mobilehm;
	calculated_rec  tank;
	calculated_rec  new_comm;
	calculated_rec  new_ind;
	calculated_rec  new_rtl;
	calculated_rec  new_wrhse;
	calculated_rec  new_office;
	calculated_rec  new_multi;	
end;

export common_rec := RECORD
  string1     injurisdiction;
	unsigned1   rectype;
	integer     record_sequence;
	IFBLOCK(self.rectype = constants.RecordTypes.Properties)
	  BuildFax.Layout.PROPERTY_SLIM Property {xpath('')};
	end;
	IFBLOCK(self.rectype = constants.RecordTypes.Contractors)
	  BuildFax.Layout.Contractor_SLIM Contractor {xpath('')};
	end;
	IFBLOCK(self.rectype = constants.RecordTypes.Corrections)
	  BuildFax.Layout.Correction_SLIM Correction {xpath('')};
	end;
	IFBLOCK(self.rectype = constants.RecordTypes.Inspections)
	  BuildFax.Layout.Inspection_SLIM Inspection {xpath('')};
	end;
	IFBLOCK(self.rectype = constants.RecordTypes.Permits)
	  BuildFax.Layout.Permit_SLIM Permit {xpath('')};
	end;
	IFBLOCK(self.rectype = constants.RecordTypes.PermitContractors)
	  BuildFax.Layout.PermitContractor_SLIM PermitContractor {xpath('')};
	end;
	IFBLOCK(self.rectype = constants.RecordTypes.Calculations)
	  layout_calcages Calculation {xpath('')};
	end;
	IFBLOCK(self.rectype = constants.RecordTypes.Jurisdictions)
	  BuildFax.Layout.Jurisdiction Jurisdiction {xpath(''),MAXSIZE(9999)};
	end;
end;

export output_rec := RECORD
  cleanaddr_rec;
	common_rec;
end;

export output_rec_flat_final := RECORD
	string20    acctno; //needed for batchR3
  string20    external_seq;	
	string10	  house;
	string40	  street;
	string8		  apt;
	string25	  city;
	string2		  st;
	string5		  zip;
	string4     roofyear;
	string4     yearbuilt;
  string10		PRIM_RANGE;
	string2			PREDIR;
	string28		PRIM_NAME;
	string4			ADDR_SUFFIX;
	string2			POSTDIR;
	string10		UNIT_DESIG;
	string8			SEC_RANGE;
	string25		addr_CITY;
	string2			addr_ST;
	string5			addr_ZIP;
	string4			ZIP4;
	string4     errorcode;
  string1     injurisdiction;
	unsigned1   rectype;
	string20    record_sequence;
	
	IFBLOCK(self.rectype = constants.RecordTypes.Properties)
	  STRING255  	prop_ID;
	  UNSIGNED4		prop_RecNum;
	  STRING4			ERROR_CODE;
	  STRING100		prop_RADDRESS1;
	  STRING80		prop_RADDRESS2;
	  STRING50		prop_RCITY;
	  STRING10		prop_RSTATE;
	  STRING10		prop_RZIP;
	  STRING100		OADDRESS1;
	  STRING80		OADDRESS2;
	  STRING50		OCITY;
	  STRING10		OSTATE;
	  STRING10		OZIP;
	  STRING100		CADDRESS1;
	  STRING80		CADDRESS2;
	  STRING50		CCITY;
	  STRING10		CSTATE;
	  STRING10		CZIP;
	  STRING10		CZIP5;
	  STRING10		prop_PRIM_RANGE;
	  STRING2			prop_PREDIR;
	  STRING28		prop_PRIM_NAME;
	  STRING4			prop_ADDR_SUFFIX;
	  STRING2			prop_POSTDIR;
	  STRING10		prop_UNIT_DESIG;
	  STRING8			prop_SEC_RANGE;
	  STRING25		prop_CITY;
	  STRING2			prop_ST;
	  STRING5			prop_ZIP;
	  STRING4			prop_ZIP4;
	  UNSIGNED4		prop_CAPassNumber;
	  UNSIGNED4		CAPassHits;
	  STRING50		PIN;
	  STRING50		CensusTract;
	  STRING50		FloodZone;
	  STRING50		Acreage;
	  STRING50		Section;
	  STRING50		Township;
	  STRING50		Range;
	  STRING50		Area;
	  STRING50		Parcel;
	  STRING50		Lot;
	  STRING50		Block;
	  STRING50		Grid;
	  STRING50		PropertyMap;
	  STRING50		Volume;
	  STRING50		Page;
	  STRING50		District;
	  STRING50		Subdivision;
	  STRING50		Development;
	  STRING50		Elevation;
	  DECIMAL15_10 LatitudeDecimal;
	  DECIMAL15_10 LongitudeDecimal;
	  STRING50		Zone;
	  DECIMAL6_2 	CommercialPercentage;
	  DECIMAL6_2 	ResidentialPercentage;
	  STRING100		StreetExtract;
	  STRING4			prop_YearBuilt; 
	  STRING50		MuniName; 
	  STRING20		CountyFIPS; 
	  STRING50		CountyName; 
	  STRING50		ParcelPrimary; 
	  STRING50		ParcelReference; 
	  STRING4			ParcelChangeYear; 
	end;
	
	IFBLOCK(self.rectype = constants.RecordTypes.Contractors)
	  STRING255  	contr_ID;
	  UNSIGNED4		contr_RECNUM;
	  STRING255		FULLNAME;
	  STRING100 	CompanyName;
	  STRING255 	CompanyDesc;
	  STRING20		PHONE;
	  STRING100		RADDRESS1;
	  STRING80		RADDRESS2;
	  STRING50		RCITY;
	  STRING10		RSTATE;
	  STRING10		RZIP;
	  STRING10		contr_PRIM_RANGE;
	  STRING2			contr_PREDIR;
	  STRING28		contr_PRIM_NAME;
	  STRING4			contr_ADDR_SUFFIX;
	  STRING2			contr_POSTDIR;
	  STRING10		contr_UNIT_DESIG;
	  STRING8			contr_SEC_RANGE;
	  STRING25		contr_CITY;
	  STRING2			contr_ST;
	  STRING5			contr_ZIP;
	  STRING4			contr_ZIP4;
	  STRING50		TRADE;
	end;
	
	IFBLOCK(self.rectype = constants.RecordTypes.Corrections)
	  STRING255  	corr_ID;
	  STRING255		corr_PROPERTYID;
	  UNSIGNED4		corr_RECNUM;
	  STRING255		corr_PROPERTYRECNUM;
	  STRING100		CORRECTEDADDRESS1;
	  STRING80		CORRECTEDADDRESS2;
	  STRING50		CORRECTEDCITY;
	  STRING10		CORRECTEDSTATE;
	  STRING10		CORRECTEDZIP;
	  UNSIGNED4		corr_CAPASSNUMBER;
	  STRING10		corr_PRIM_RANGE;
	  STRING2			corr_PREDIR;
	  STRING28		corr_PRIM_NAME;
	  STRING4			corr_ADDR_SUFFIX;
	  STRING2			corr_POSTDIR;
	  STRING10		corr_UNIT_DESIG;
	  STRING8			corr_SEC_RANGE;
	  STRING25		corr_CITY;
	  STRING2			corr_ST;
	  STRING5			corr_ZIP;
	  STRING4			corr_ZIP4;
	  DECIMAL15_10	LATITUDE;
	  DECIMAL15_10	LONGITUDE;
	end;
	
	IFBLOCK(self.rectype = constants.RecordTypes.Inspections)
	  STRING255  	inspect_ID;
	  STRING255		inspect_PermitID;
	  UNSIGNED4		inspect_RECNUM;
	  STRING255		inspect_PermitRecNum;
	  STRING50		InspType;
	  STRING255		Description;
	  STRING3			Final;
	  STRING10		RequestDate;
	  STRING10		RequestTime;
	  STRING10		DesiredDate;
	  STRING10		DesiredTime;
	  STRING10		ScheduledDate;
	  STRING10		ScheduledTime;
	  STRING10		InspectedDate;
	  STRING10		InspectedTime;
	  STRING3			ReInspection;
	  STRING40		Inspector;
	  STRING40		Result;
	end;
	
	IFBLOCK(self.rectype = constants.RecordTypes.Permits)
	  STRING255  	perm_ID;
	  STRING255		perm_PropertyID;
	  UNSIGNED4		perm_RECNUM;
	  UNSIGNED4		perm_PropertyRecNum;
	  STRING50		perm_Jurisdiction;
	  STRING50		PermitNum;
	  STRING50		PermitClass;
	  STRING50		MasterPermitNum;
	  STRING50		WorkClass;
	  STRING50		ProposedUse;
	  STRING50		PermitStatus;
	  STRING10		perm_PreferredDate;
	  STRING10		AppliedDate;
	  STRING10		IssuedDate;
	  STRING10		ExpiresDate;
	  STRING10		CoIssuedDate;
	  STRING10		CompletedDate;
	  STRING10		HoldDate;
	  STRING10		VoidDate;
	  STRING10		StatusDate;
	  STRING50		ValuationAmount;
	  STRING50		ValuationAmountDecimal;
	  STRING50		ProjectName;
	  STRING50		PermitType;
	  STRING50		PermitTypeDescription;
	  STRING50		PermitTypePreferred;
	  STRING100		PermitTypeCombined;
	  STRING50		ProjectID;
	  STRING20		TotalSqFt;
	  STRING20		TotalFinishedSqFt;
	  STRING20		TotalUnfinishedSqFt;
	  STRING20		TotalHeatedSqFt;
	  STRING20		TotalUnHeatedSqFt;
	  STRING20		TotalAccSqFt;
	  STRING20		TotalSprinkledSqFt;
	  UNSIGNED2		check_NewConstruction;
	  UNSIGNED2		check_AlterationRemodelAddition;
	  UNSIGNED2		check_PermitTypeBuilding;
	  UNSIGNED2		check_PermitTypeElectrical;
	  UNSIGNED2		check_PermitTypeMechanical;
	  UNSIGNED2		check_PermitTypePlumbing;
	  UNSIGNED2		check_PermitTypeOther;
	  UNSIGNED2		check_Roof;
	  UNSIGNED2		check_Pool;
	  UNSIGNED2		check_Demolition;
	  UNSIGNED2		check_RepairReplace;
	  UNSIGNED2		check_WindDamagePrevention;
	  UNSIGNED2		check_SeismicDamagePrevention;
	  UNSIGNED2		check_SolarPower;
	  UNSIGNED2		check_SprinklerSystems;
	  UNSIGNED2		check_FireAlarm;
	  UNSIGNED2		check_SecuritySystems;
	  UNSIGNED2		check_ChangeofUse;
	  UNSIGNED2		check_WaterDamage;
	  UNSIGNED2		check_WindDamage;
	  UNSIGNED2		check_FireDamage;
	  UNSIGNED2		check_PestsRodents;
	  UNSIGNED2		check_NaturalDisasterDamage;
	  UNSIGNED2		check_MobileHome;
	  UNSIGNED2		check_TankNoSeptic;
	  UNSIGNED2		check_NewCommercialConstruction;
	  UNSIGNED2		check_NewCommercialConstructionIndustrial;
	  UNSIGNED2		check_NewCommercialConstructionRetail;
	  UNSIGNED2		check_NewCommercialConstructionWarehouse;
	  UNSIGNED2		check_NewCommercialConstructionOffice;
	  UNSIGNED2		check_NewMultiFamilyConstruction;
	  UNSIGNED2		check_PermitStatusCompleted;
	  UNSIGNED2		check_PermitStatusExpiredCanceledVoid;
	  UNSIGNED2		check_WindOpeningProtection;
	  UNSIGNED2		check_WindOpeningProtection_StrictShutter;
	  UNSIGNED2		check_WindOpeningProtection_LooseShutter;
	  UNSIGNED2		check_RoofCovering_StrictReroof;
	  UNSIGNED2		check_RoofCovering_LooseReroof;
    UNSIGNED2		check_LikelyValueIncreasing;
	  UNSIGNED2		check_NotLikelyValueIncreasing;
	end;
	
	IFBLOCK(self.rectype = constants.RecordTypes.PermitContractors)
	  STRING255  	pc_ID;
	  STRING255		pc_PermitID;
	  STRING255		ContractorID;
	  UNSIGNED4		pc_RecNum;
	  UNSIGNED4		pc_PermitRecNum;
	  UNSIGNED4		ContractorRecNum;
	end;
	
	IFBLOCK(self.rectype = constants.RecordTypes.Calculations)
	  string255   calc_id;
		string8     new_constr_update_date;
	  string4     new_constr_not_update_since;
	  string5     new_constr_age;
		string8     rem_update_date;
	  string4     rem_not_update_since;
	  string5     rem_age;
		string8     bldg_update_date;
	  string4     bldg_not_update_since;
	  string5     bldg_age;
		string8     elect_update_date;
	  string4     elect_not_update_since;
	  string5     elect_age;
		string8     mech_update_date;
	  string4     mech_not_update_since;
	  string5     mech_age;
		string8     plumb_update_date;
	  string4     plumb_not_update_since;
	  string5     plumb_age;
		string8     other_update_date;
	  string4     other_not_update_since;
	  string5     other_age;
		string8     roof_update_date;
	  string4     roof_not_update_since;
	  string5     roof_age;
		string8     pool_update_date;
	  string4     pool_not_update_since;
	  string5     pool_age;
		string8     demol_update_date;
	  string4     demol_not_update_since;
	  string5     demol_age;
		string8     repair_update_date;
	  string4     repair_not_update_since;
	  string5     repair_age;
		string8     wind_prevent_update_date;
	  string4     wind_prevent_not_update_since;
	  string5     wind_prevent_age;
		string8     seismic_update_date;
	  string4     seismic_not_update_since;
	  string5     seismic_age;
		string8     solar_update_date;
	  string4     solar_not_update_since;
	  string5     solar_age;
		string8     sprinkler_update_date;
	  string4     sprinkler_not_update_since;
	  string5     sprinkler_age;
		string8     firealrm_update_date;
	  string4     firealrm_not_update_since;
	  string5     firealrm_age;
		string8     security_update_date;
	  string4     security_not_update_since;
	  string5     security_age;
		string8     change_use_update_date;
	  string4     change_use_not_update_since;
	  string5     change_use_age;
		string8     water_update_date;
	  string4     water_not_update_since;
	  string5     water_age;
		string8     wind_update_date;
	  string4     wind_not_update_since;
	  string5     wind_age;
		string8     fire_update_date;
	  string4     fire_not_update_since;
	  string5     fire_age;
		string8     pest_update_date;
	  string4     pest_not_update_since;
	  string5     pest_age;
		string8     natdisast_update_date;
	  string4     natdisast_not_update_since;
	  string5     natdisast_age;
		string8     mobilehm_update_date;
	  string4     mobilehm_not_update_since;
	  string5     mobilehm_age;
		string8     tank_update_date;
	  string4     tank_not_update_since;
	  string5     tank_age;
		string8     new_comm_update_date;
	  string4     new_comm_not_update_since;
	  string5     new_comm_age;
		string8     new_ind_update_date;
	  string4     new_ind_not_update_since;
	  string5     new_ind_age;
		string8     new_rtl_update_date;
	  string4     new_rtl_not_update_since;
	  string5     new_rtl_age;
		string8     new_wrhse_update_date;
	  string4     new_wrhse_not_update_since;
	  string5     new_wrhse_age;
		string8     new_office_update_date;
	  string4     new_office_not_update_since;
	  string5     new_office_age;
		string8     new_multi_update_date;
	  string4     new_multi_not_update_since;
	  string5     new_multi_age;
	end;
	
	IFBLOCK(self.rectype = constants.RecordTypes.Jurisdictions)
	  STRING255  	juris_Jurisdiction;
	  STRING10		GoLiveDate;
	  STRING10		juris_PreferredDate;
	  STRING10		MinDate;
	  STRING10		ExclusionMinDate;
	  STRING10		MaxDate;
	  STRING10		ExclusionMaxDate;
	  STRING16		LastUpdateTime;
	  STRING255		JurisdictionName;
	  STRING255		OfficialName;
	  STRING100		StreetAddress;
	  STRING80		juris_City;
	  STRING10		STATE;
	  STRING10		juris_ZIP;
	  STRING100		website;
	  STRING30		Fax;
	  STRING30		Office;
	  STRING30		OtherPhone;
	  STRING100		County;
  end;
end;

export output_rec_flat_seq := RECORD
  string20    internal_seq;	
	output_rec_flat_final;
end;

export Layout_Property := RECORD
  string20 sequence,
	BuildFax.Layout.PROPERTY_SLIM;
end;

export Layout_Contractor := RECORD
  string20 sequence,
	BuildFax.Layout.Contractor_SLIM;
end;

export Layout_Correction := RECORD
  string20 sequence,
	BuildFax.Layout.Correction_SLIM;
end;
 
export Layout_Inspection := RECORD
  string20 sequence,
	BuildFax.Layout.Inspection_SLIM;
end;

export Layout_Permit := RECORD
  string20 sequence,
	BuildFax.Layout.Permit_SLIM Permit;
end;

export Layout_PermitContractor := RECORD
  string20 sequence,
	BuildFax.Layout.PermitContractor_SLIM;
end;

export Layout_StreetLookup := RECORD
  string20 sequence,
	BuildFax.Layout.StreetLookup;
end;

export Layout_Jurisdiction := RECORD
  string20 sequence,
	BuildFax.Layout.Jurisdiction;
end;

END;