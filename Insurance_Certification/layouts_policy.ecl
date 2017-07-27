IMPORT Insurance_Certification,address,AID,bipv2;

EXPORT layouts_policy := MODULE

	SHARED max_size := _Dataset().max_record_size;

	EXPORT Input := RECORD,MAXLENGTH(40000)
			STRING LNPolicyID;
			UNSIGNED8 LNInsCertRecordID;
			STRING DartID;
			STRING InsuranceProvider;
			STRING PolicyNumber;
			STRING CoverageStartDate;
			STRING CoverageExpirationDate;
			STRING CoverageWrapUP;
			STRING PolicyStatus;
			STRING InsuranceProviderAddressLine;
			STRING InsuranceProviderAddressLine2;
			STRING InsuranceProviderCity;
			STRING InsuranceProviderState;
			STRING InsuranceProviderZip;
			STRING InsuranceProviderZip4;
			STRING InsuranceProviderPhone;
			STRING InsuranceProviderFax;
			STRING CoverageReinstateDate;
			STRING CoverageCancellationDate;
			STRING CoverageWrapUpDate;
			STRING BusinessNameDuringCoverage;
			STRING AddressLineDuringCoverage;
			STRING AddressLine2DuringCoverage;
			STRING CityDuringCoverage;
			STRING StateDuringCoverage;
			STRING ZipDuringCoverage;
			STRING Zip4DuringCoverage;
			STRING NumberofEmployeesDuringCoverage;
			STRING InsuranceProviderContactDept;
			STRING InsuranceType;
			STRING CoveragePostedDate;
			STRING CoverageAmountFrom;
			STRING CoverageAmountTo;
	END;

  EXPORT Temp	:=	RECORD /* Add the max lengths for each field later */
			UNSIGNED8 LNInsCertRecordID;
			STRING DartID;
			STRING InsuranceProvider;
			STRING PolicyNumber;
			STRING CoverageStartDate;
			STRING CoverageExpirationDate;
			STRING CoverageWrapUP;
			STRING PolicyStatus;
			STRING InsuranceProviderAddressLine;
			STRING InsuranceProviderAddressLine2;
			STRING InsuranceProviderCity;
			STRING InsuranceProviderState;
			STRING InsuranceProviderZip;
			STRING InsuranceProviderZip4;
			STRING InsuranceProviderPhone;
			STRING InsuranceProviderFax;
			STRING CoverageReinstateDate;
			STRING CoverageCancellationDate;
			STRING CoverageWrapUpDate;
			STRING BusinessNameDuringCoverage;
			STRING AddressLineDuringCoverage;
			STRING AddressLine2DuringCoverage;
			STRING CityDuringCoverage;
			STRING StateDuringCoverage;
			STRING ZipDuringCoverage;
			STRING Zip4DuringCoverage;
			STRING NumberofEmployeesDuringCoverage;
			STRING InsuranceProviderContactDept;
			STRING InsuranceType;
			STRING CoveragePostedDate;
			STRING CoverageAmountFrom;
			STRING CoverageAmountTo;
			UNSIGNED6		unique_id;
			STRING100		Append_MailAddress1;
			STRING50		Append_MailAddressLast;
			AID.Common.xAID		Append_MailRawAID;		
			AID.Common.xAID   Append_MailACEAID;   
	END;

	EXPORT Base := RECORD,MAXLENGTH(40000)
			UNSIGNED8 Date_FirstSeen;
			UNSIGNED8 Date_LastSeen;
			UNSIGNED6 bdid 	:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
			Temp;
	END;
  	
	EXPORT	KeyBuild := RECORD
			Base;
			STRING10	m_prim_range; 
			STRING2		m_predir;	
			STRING28	m_prim_name;	
			STRING4		m_addr_suffix; 
			STRING2		m_postdir;	
			STRING10	m_unit_desig;	
			STRING8		m_sec_range;	
			STRING25	m_p_city_name;	
			STRING25	m_v_city_name; 
			STRING2		m_st;	
			STRING5		m_zip;	
			STRING4		m_zip4;	
			STRING4		m_cart;	
			STRING1		m_cr_sort_sz;	
			STRING4		m_lot;	
			STRING1		m_lot_order;	
			STRING2		m_dbpc;	
			STRING1		m_chk_digit;	
			STRING2		m_rec_type;	
			STRING2		m_fips_state;	
			STRING3		m_fips_county;	
			STRING10	m_geo_lat;	
			STRING11	m_geo_long;	
			STRING4		m_msa;	
			STRING7		m_geo_blk;	
			STRING1		m_geo_match;	
			STRING4		m_err_stat;		
	END;
	
	EXPORT UniqueId := RECORD,MAXLENGTH(max_size)
			UNSIGNED8	BH_Unique_id;
			KeyBuild;
	END;
	
END;
