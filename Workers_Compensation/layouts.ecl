IMPORT Workers_Compensation,address,AID,bipv2;

EXPORT Layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;

	EXPORT Input := RECORD,MAXLENGTH(40000)
			STRING  Master_UID;
			STRING	unique_id;
			STRING	RMID;
			STRING	Description;
			STRING  ADDRESS;
			STRING  CITY;
			STRING	State;
			STRING	ZIP;
			STRING	ZipPlus4;
			STRING  classCode; /* these are state class codes and no lookup table is available */
			STRING  Effective_Month_Day;
			STRING  EffectiveMonth;
			STRING	NAICCarrierName;
			STRING	NAICCarrierNumber;
			STRING	NAICGroupName;
			STRING	NAICGroupNumber;
			STRING	FEIN;
			STRING	PolicySelf;
			STRING  Record_Type;
			STRING  Insured_Status; /* New field added 3/26/12 */
	END;

  EXPORT Temp	:=	RECORD
			STRING15  Master_UID;
			STRING15	unique_id;
			STRING15	RMID;
			STRING100	Description;
			STRING100 ADDRESS;
			STRING50  CITY;
			STRING2	  State;
			STRING5	  ZIP;
			STRING4	  ZipPlus4;
			STRING15  classCode; /* these are state class codes and no lookup table is available */
			STRING5	  Effective_Month_Day;
			STRING2	  EffectiveMonth;
			STRING8	  Effective_Date;
			STRING100	NAICCarrierName;
			STRING15	NAICCarrierNumber;
			STRING100	NAICGroupName;
			STRING15	NAICGroupNumber;
			STRING30	FEIN;
			STRING30	PolicySelf;
			STRING5	  Record_Type;
			STRING2   Insured_Status; /* New field added 3/26/12 "E" for Exempt & "B" for Bare*/
			STRING100	Append_MailAddress1;
			STRING50	Append_MailAddressLast;
			AID.Common.xAID		Append_MailRawAID;
			AID.Common.xAID   Append_MailACEAID;                                 
	END;

	EXPORT Base := RECORD,MAXLENGTH(40000)
			UNSIGNED8 Date_FirstSeen;
			UNSIGNED8 Date_LastSeen;
			UNSIGNED6 bdid 	:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
			unsigned8 source_rec_id := 0;  
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
	
	export BdidSlim := record
			unsigned8		bh_unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string8			sec_range			 		;
			string5			zip5							;
			string2			state		 					;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string25    city         := '';
			bipv2.IDlayouts.l_xlink_ids   ;
			unsigned8 	source_rec_id := 0;
			string2     source            ;
			STRING30	  FEIN              ;
	  end;
		
	EXPORT UniqueId := RECORD,MAXLENGTH(max_size)
			UNSIGNED8	BH_Unique_id;
			KeyBuild;
	END;
	
END;
