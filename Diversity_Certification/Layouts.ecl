import address,AID,BIPV2;

export Layouts := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string	DartID;
			string	DateAdded;
			string	DateUpdated;
			string	Website;
			string	State;
			string	ProfileLastUpdated;
			string	County;
			string	ServiceArea;
			string	Region1;
			string	Region2;
			string	Region3;
			string	Region4;
			string	Region5;
			string	FName;
			string	LName;
			string	MName;
			string	Suffix;
			string	Title;
			string	Ethnicity;
			string	Gender;
			string	Address1;
			string	Address2;
			string	AddressCity;
			string	AddressState;
			string	AddressZipcode;
			string	AddressZip4;
			string	Building;
			string	Contact;
			string	Phone1;
			string	Phone2;
			string	Phone3;
			string	Cell;
			string	Fax;
			string	Email1;
			string	Email2;
			string	Email3;
			string	Webpage1;
			string	Webpage2;
			string	Webpage3;
			string	BusinessName;
			string	DBA;
			string	BusinessID;
			string	BusinessType1;
			string	BusinessLocation1;
			string	BusinessType2;
			string	BusinessLocation2;
			string	BusinessType3;
			string	BusinessLocation3;
			string	BusinessType4;
			string	BusinessLocation4;
			string	BusinessType5;
			string	BusinessLocation5;
			string	Industry;
			string	Trade;
			string	ResourceDescription;
			string	NatureofBusiness;
			string	BusinessDescription;
			string	BusinessStructure;
			string	TotalEmployees;
			string	AvgContractSize;
			string	FirmID;
			string	FirmLocationAddress;
			string	FirmLocationAddressCity;
			string	FirmLocationAddressZip4;
			string	FirmLocationAddressZipCode;
			string	FirmLocationCounty;
			string	FirmLocationState;
			string	CertFed;
			string	CertState;
			string	ContractsFederal;
			string	ContractsVA;
			string	ContractsCommercial;
			string	ContractorGovernmentPrime;
			string	ContractorGovernmentSub;
			string	ContractorNonGovernment;
			string	RegisteredGovernmentBus;
			string	RegisteredNonGovernmentBus;
			string	ClearanceLevelPersonnel;
			string	ClearanceLevelFacility;
			string	CertificateDateFrom1;
			string	CertificateDateTo1;
			string	CertificateStatus1;
			string	CertificationNumber1;
			string	CertificationType1;
			string	CertificateDateFrom2;
			string	CertificateDateTo2;
			string	CertificateStatus2;
			string	CertificationNumber2;
			string	CertificationType2;
			string	CertificateDateFrom3;
			string	CertificateDateTo3;
			string	CertificateStatus3;
			string	CertificationNumber3;
			string	CertificationType3;
			string	CertificateDateFrom4;
			string	CertificateDateTo4;
			string	CertificateStatus4;
			string	CertificationNumber4;
			string	CertificationType4;
			string	CertificateDateFrom5;
			string	CertificateDateTo5;
			string	CertificateStatus5;
			string	CertificationNumber5;
			string	CertificationType5;
			string	CertificateDateFrom6;
			string	CertificateDateTo6;
			string	CertificateStatus6;
			string	CertificationNumber6;
			string	CertificationType6;
			string	StarRating;
			string	Assets;
			string	BidDescription;
			string	CompetitiveAdvantage;
			string	CageCode;
			string	CapabilitiesNarrative;
			string	Category;
			string	ChtrClass;
			string	ProductDescription1;
			string	ProductDescription2;
			string	ProductDescription3;
			string	ProductDescription4;
			string	ProductDescription5;
			string	ClassDescription1;
			string	SubClassDescription1;
			string	ClassDescription2;
			string	SubClassDescription2;
			string	ClassDescription3;
			string	SubClassDescription3;
			string	ClassDescription4;
			string	SubClassDescription4;
			string	ClassDescription5;
			string	SubClassDescription5;
			string	Classifications;
			string	Commodity1;
			string	Commodity2;
			string	Commodity3;
			string	Commodity4;
			string	Commodity5;
			string	Commodity6;
			string	Commodity7;
			string	Commodity8;
			string	CompleteDate;
			string	CrossReference;
			string	DateEstablished;
			string	BusinessAge;
			string	Deposits;
			string	DUNSNumber;
			string	EntType;
			string	ExpirationDate;
			string	ExtendedDate;
			string	IssuingAuthority;
			string	Keywords;
			string	LicenseNumber;
			string	LicenseType;
			string	MinCD;
			string	MinorityAffiliation;
			string	MinorityOwnershipDate;
			string	SICCode1;
			string	SICCode2;
			string	SICCode3;
			string	SICCode4;
			string	SICCode5;
			string	SICCode6;
			string	SICCode7;
			string	SICCode8;
			string	NAICSCode1;
			string	NAICSCode2;
			string	NAICSCode3;
			string	NAICSCode4;
			string	NAICSCode5;
			string	NAICSCode6;
			string	NAICSCode7;
			string	NAICSCode8;
			string	Prequalify;
			string	ProcurementCategory1;
			string	SubprocurementCategory1;
			string	ProcurementCategory2;
			string	SubprocurementCategory2;
			string	ProcurementCategory3;
			string	SubprocurementCategory3;
			string	ProcurementCategory4;
			string	SubprocurementCategory4;
			string	ProcurementCategory5;
			string	SubprocurementCategory5;
			string	Renewal;
			string	RenewalDate;
			string	UnitedCertProgramPartner;
			string	VendorKey;
			string	Vendornumber;
			string	WorkCode1;
			string	WorkCode2;
			string	WorkCode3;
			string	WorkCode4;
			string	WorkCode5;
			string	WorkCode6;
			string	WorkCode7;
			string	WorkCode8;
			string	Exporter;
			string	ExportBusinessActivities;
			string	ExportTo;
			string	ExportBusinessRelationships;
			string	ExportObjectives;
			string	Reference1;
			string	Reference2;
			string	Reference3;
	end;

	export Temp	:=	record,maxlength(max_size)
			string8 dt_first_seen ;
			string8 dt_last_seen;                 
			string8 dt_vendor_first_reported;
			string8 dt_vendor_last_reported ; 
			Input;
			unsigned6					unique_id;
			string100					Append_Prep_MailAddress1;
			string50					Append_Prep_MailAddressLast;
			AID.Common.xAID		Append_MailRawAID;
			string100					Append_Prep_PhyAddress1;
			string50					Append_Prep_PhyAddressLast;
			AID.Common.xAID		Append_PhyRawAID;
			string phone;
			string email;
			string8 Expiration_date;
			string120	SICCode1_desc;
   		string120	SICCode2_desc;
   		string120	SICCode3_desc;
   		string120	SICCode4_desc;
   		string120	SICCode5_desc;
   		string120	SICCode6_desc;
   		string120	SICCode7_desc;
   		string120	SICCode8_desc;
   		string120	NAICSCode1_desc;
   		string120	NAICSCode2_desc;
   		string120	NAICSCode3_desc;
   		string120	NAICSCode4_desc;
   		string120	NAICSCode5_desc;
   		string120	NAICSCode6_desc;
   		string120	NAICSCode7_desc;
   		string120	NAICSCode8_desc;
	end;

	export Base := record,maxlength(max_size)
			BIPV2.IDlayouts.l_xlink_ids;
			unsigned6 bdid 	:= 0;
			unsigned6 did 	:= 0;
			temp;
	end;
	
	export	KeyBuild := record,maxlength(max_size)
			base;
			string10	m_prim_range; 
			string2		m_predir;	
			string28	m_prim_name;	
			string4		m_addr_suffix; 
			string2		m_postdir;	
			string10	m_unit_desig;	
			string8		m_sec_range;	
			string25	m_p_city_name;	
			string25	m_v_city_name; 
			string2		m_st;	
			string5		m_zip;	
			string4		m_zip4;	
			string4		m_cart;	
			string1		m_cr_sort_sz;	
			string4		m_lot;	
			string1		m_lot_order;	
			string2		m_dbpc;	
			string1		m_chk_digit;	
			string2		m_rec_type;	
			string2		m_fips_state;	
			string3		m_fips_county;	
			string10	m_geo_lat;	
			string11	m_geo_long;	
			string4		m_msa;	
			string7		m_geo_blk;	
			string1		m_geo_match;	
			string4		m_err_stat;	
			string10	p_prim_range; 
			string2		p_predir;	
			string28	p_prim_name;	
			string4		p_addr_suffix; 
			string2		p_postdir;	
			string10	p_unit_desig;	
			string8		p_sec_range;	
			string25	p_p_city_name;	
			string25	p_v_city_name; 
			string2		p_st;	
			string5		p_zip;	
			string4		p_zip4;	
			string4		p_cart;	
			string1		p_cr_sort_sz;	
			string4		p_lot;	
			string1		p_lot_order;	
			string2		p_dbpc;	
			string1		p_chk_digit;	
			string2		p_rec_type;	
			string2		p_fips_state;	
			string3		p_fips_county;	
			string10	p_geo_lat;	
			string11	p_geo_long;	
			string4		p_msa;	
			string7		p_geo_blk;	
			string1		p_geo_match;	
			string4		p_err_stat;
	end;
	
  export Auto_KeyBuild	:=	record,maxlength(max_size)
			input;
			unsigned6 bdid;
			unsigned6 did;
			unsigned6	unique_id;			
			string10	prim_range; 
			string2		predir;	
			string28	prim_name;	
			string4		addr_suffix; 
			string2		postdir;	
			string10	unit_desig;	
			string8		sec_range;	
			string25	p_city_name;	
			string25	v_city_name; 
			string2		st;	
			string5		zip;	
			string4		zip4;	
			string4		cart;	
			string1		cr_sort_sz;	
			string4		lot;	
			string1		lot_order;	
			string2		dbpc;	
			string1		chk_digit;	
			string2		rec_type;	
			string2		fips_state;	
			string3		fips_county;	
			string10	geo_lat;	
			string11	geo_long;	
			string4		msa;	
			string7		geo_blk;	
			string1		geo_match;	
			string4		err_stat;	
	end;
	

	export DidSlim := record
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		suffix					;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range				;
			string5			zip							;
			string2			st							;
			string10		phone						;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
		end;

		export BdidSlim := 	record
			BIPV2.IDlayouts.l_xlink_ids		;
			unsigned8		unique_id					;
			string100 	BusinessName			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip							  ;
			string8			sec_range					;
			string2			st							  ;
			unsigned6		bdid					:= 0;
			unsigned1   bdid_score 		:= 0;
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			string25		p_city_name				;
			string 			phone							;
			string 			email							;
		end;
			
end;