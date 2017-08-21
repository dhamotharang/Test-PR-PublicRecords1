export layouts_base := MODULE
		export MariFlat_final :=
		RECORD
			Prof_License_Mari.layouts_reference.MARIFLAT_slim;
			unsigned6	DID,
			unsigned6	DID_SCORE,
			unsigned6	BDID,
			unsigned6	BDID_SCORE,
			unsigned6	RAWAID,
			string5		TITLE,
			string20	FNAME,
			string20	MNAME,
			string20	LNAME,
			string5		NAME_SUFFIX,
			string9   CLN_SSN_TAXID,
			string10  TMP_ZIP,
			string10	cln_PRIM_RANGE,
			string2   cln_PREDIR,
			string28	cln_PRIM_NAME,
			string4   cln_ADDR_SUFFIX,
			string2   cln_POSTDIR,
			string10  cln_UNIT_DESIG,
			string8		cln_SEC_RANGE,
			string30  cln_P_CITY_NAME,   	// increase length to accommodate Canadian City
			string25  cln_V_CITY_NAME,
			string2		cln_STATE,
			string6		cln_ZIP,						// increase length to accommodate Canadian Zip
			string4   cln_ZIP4,
			string4   cln_CART,
			string1   cln_CR_SORT_SZ,
			string4   cln_LOT,
			string1   cln_LOT_ORDER,
			string2   cln_DBPC,
			string1   cln_CHK_DIGIT,
	    string2   cln_REC_TYPE,
	    string5   cln_COUNTY,
	    string10  cln_GEO_LAT,
			string11  cln_GEO_LONG,
      string4   cln_MSA,
			string7   cln_GEO_BLK,
			string1   cln_GEO_MATCH,
			string5   cln_ERR_STAT,  			// increase length to accommodate Canadian err_stat
	END;					


 	  export MariLICENSOR
	     :=
			RECORD,MAXLENGTH(1000)
			  INTEGER		LICENSOR_KEY,		// Primary Key
				STRING5		AGENCY,					// Source Upd Code
				STRING2		STATE_CD,				// Standardize State Code
				STRING1		TYPE_CD,				// Valid Entry: S=State, N=National
				STRING8		UPDATE_DTE,			// format YYYYMMDD
				STRING80  LABEL,						// Standardized Source Description
			END;
		
	  // export MariLICENSE
		 // :=
			// RECORD,MAXLENGTH(1000)
				// INTEGER		LICENSE_KEY,			// Primary Key
				// INTEGER		LICENSOR_KEY,			// Foreign Key to Licensor record
				// STRING8		FIRST_SEEN_DTE,		// format YYYYMMDD
				// STRING8		LAST_SEEN_DTE,		// format YYYYMMDD
				// STRING40	PROFESSION,				// Standardized Profession Description
				// STRING30	LICENSE_NBR,
				// STRING30	OFF_LICENSE_NBR,
				// STRING50	LICENSE_TYPE,			// Standardized License Type Description
				// STRING120	LICENSE_STATUS,		// Standardized License Status Description
				// STRING8		ORIG_ISS_DTE,			// format YYYYMMDD
				// STRING8		CURR_ISS_DTE,			// format YYYYMMDD
				// STRING8		EXPIRE_DTE,				// format YYYYMMDD
				// STRING120	NOTES							// Miscenalleous information
			// END;
			
	 // export MariENTITY
	    // :=
		   // RECORD,MAXLENGTH(2000)
				// INTEGER		PRIME_KEY,				// Primary Key
				// INTEGER		LICENSE_KEY,			// Foreign key to License Record
				// INTEGER		ENTITY_FOREIGN,		// Entity Key of Main Office
				// INTEGER		RELATION_KEY,			// Valid Entry: Either 0=Main, 1=Branch
				// UNSIGNED6	DID,
				// UNSIGNED6	DID_SCORE,
				// UNSIGNED6	BDID,
				// UNSIGNED6	BDID_SCORE,
				// UNSIGNED6	RAWAID,
				// STRING8		DATA_DTE,					// format YYYYMMDD
				// STRING80	NAME_COMPANY,
				// STRING30	NAME_LAST,
				// STRING30	NAME_FIRST,
				// STRING30	NAME_MID,
				// STRING10	NAME_SUFX,
				// STRING15	NAME_NICK,
				// STRING8		BIRTH_DTE,				// format YYYYMMDD
				// STRING10	GENDER,						// Valid Entry: MALE, FEMALE
				// STRING1		ADDR_TYPE,				// Valid Entry: B=Business, M=Mailing
				// STRING50	ADDR_ADDR1,
				// STRING50	ADDR_ADDR2,
				// STRING25	ADDR_CITY,
				// STRING2		ADDR_STATE,
				// STRING10	ADDR_ZIP,
				// STRING25	ADDR_CNTRY,
				// STRING10	PHN_PHONE,
				// STRING10	PHN_PHONE_FAX,
				// STRING80	EMAIL,
				// STRING80	WEBSITE,
				// STRING120	NOTES,
				// INTEGER		MLTREC_KEY,
				// INTEGER	  CMC_SLPK,
				// INTEGER   PCMC_SLPK
			// END;
			
	 // export MariDBA
		// :=
			// RECORD,MAXLENGTH(1000)
				// INTEGER		DBA_KEY,				// Primary Key
				// INTEGER		PRIME_KEY,			// Foreign Key to Entity record
				// UNSIGNED6	DID,
				// UNSIGNED6	DID_SCORE,
				// STRING1		NAME_TYPE,
				// STRING80	NAME_FULL,
				// STRING30	NAME_LAST,
				// STRING30	NAME_FIRST,
				// STRING30	NAME_MID,
				// STRING10	NAME_SUFX,
				// STRING15	NAME_NICK,
				// STRING40	NAME_TTL,
				// STRING10	PHN_CONTACT,
				// STRING10	PHN_CONTACT_FAX,
				// STRING15	LICENSE_NBR,
				// STRING80	EMAIL
			// END;
	
	// export MariENTITY_final
	   // :=
		  // RECORD,MAXLENGTH(3000)
				// MariENTITY;

				// Clean Name Fields
				// STRING5		TITLE,
				// STRING20  FNAME,
				// STRING20  MNAME,
				// STRING20  LNAME,
				// STRING5   NAME_SUFFIX,
				
				
				// Clean Address Fields
				// STRING10    PRIM_RANGE,
				// STRING2     PREDIR,
				// STRING28    PRIM_NAME,
				// STRING4     SUFFIX,
				// STRING2     POSTDIR,
				// STRING10    UNIT_DESIG,
				// STRING8     SEC_RANGE,
				// STRING25    P_CITY_NAME,
				// STRING25    V_CITY_NAME,
				// STRING2     STATE,
				// STRING5     ZIP5,
				// STRING4     ZIP4,
				// STRING4     CART,
				// STRING1     CR_SORT_SZ,
				// STRING4     LOT,
				// STRING1     LOT_ORDER,
				// STRING2     DBPC,
				// STRING1     CHK_DIGIT,
				// STRING2     RECORD_TYPE,
				// STRING3     COUNTY,
				// STRING10    GEO_LAT,
				// STRING11    GEO_LONG,
				// STRING4     MSA,
				// STRING7     GEO_BLK,
				// STRING1     GEO_MATCH,
				// STRING4   	ERR_STAT
		// END;
		
		// export MariDBA_final
		// :=
			// RECORD,MAXLENGTH(1000)
				// INTEGER		DBA_KEY,	
				// INTEGER		PRIME_KEY,	
				// UNSIGNED6	DID,
				// UNSIGNED6	DID_SCORE,
				
				// Clean Name Fields
				// STRING5		TITLE,
				// STRING20  FNAME,
				// STRING20  MNAME,
				// STRING20  LNAME,
				// STRING5   NAME_SUFFIX,
				// STRING1		NAME_TYPE,
								
				// STRING1   NAME_FORMAT,
				// STRING80	NAME_FULL,
				// STRING10	PHN_CONTACT,
				// STRING10	PHN_CONTACT_FAX,
				// STRING80	EMAIL
			
		// END;
	
	END;