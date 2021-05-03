IMPORT Address, BIPV2, MDR;

EXPORT Layouts := MODULE

	////////////////////////////////////////////////////////////////////////
	// -- Input Layout(s)
	////////////////////////////////////////////////////////////////////////

  // InputA is similar to the old Verified file from SKA.  The file contains medical field personnel along with 
  // location information where they operate/work.
  EXPORT InputA := MODULE
  
    EXPORT Sprayed := RECORD //layout size (1547)
      STRING15  HCP_HCE_ID;                  //ID for a person.
      STRING32  OK_INDV_ID;
      STRING15  SKA_UID;                     //Old SKA ID for a person that will eventually be deprecated
      STRING40  FRST_NM;
      STRING40  MID_NM;
      STRING40  LAST_NM;
      STRING10  SFX_CD;
      STRING10  GENDER_CD;
      STRING10  PRIM_PRFSN_CD;
      STRING50  PRIM_PRFSN_DESC;
      STRING10  PRIM_SPCL_CD;
      STRING75  PRIM_SPCL_DESC;
      STRING10  SEC_SPCL_CD;
      STRING75  SEC_SPCL_DESC;
      STRING10  TERT_SPCL_CD;
      STRING75  TERT_SPCL_DESC;
      STRING10  SUB_SPCL_CD;
      STRING50  SUB_SPCL_DESC;
      STRING10  TITL_TYP_ID;
      STRING50  TITL_TYP_DESC;
      STRING15  HCO_HCE_ID;                  //ID for a location
      STRING35  OK_WKP_ID;
      STRING15  SKA_ID;                      //Old SKA ID for a location that will eventually be deprecated
      STRING150 BUS_NM;
      STRING150 DBA_NM;
      STRING10  ADDR_ID;
      STRING10  STR_FRONT_ID;
      STRING80  ADDR_LN_1_TXT;
      STRING80  ADDR_LN_2_TXT;
      STRING50  CITY_NM;
      STRING2   ST_CD;
      STRING5   ZIP5_CD;
      STRING4   ZIP4_CD;
      STRING10  FIPS_CNTY_CD;
      STRING50  FIPS_CNTY_DESC;
      STRING15  TELEPHN_NBR;
      STRING15  COT_ID;
      STRING15  COT_CLAS_ID;
      STRING50  COT_CLAS_DESC;
      STRING15  COT_FCLT_TYP_ID;
      STRING50  COT_FCLT_TYP_DESC;
      STRING15  COT_SPCL_ID;
      STRING50  COT_SPCL_DESC;
      STRING1   EMAIL_IND_FLAG;
      STRING50  HCP_AFFIL_XID;               //ID that comprises the HCP_HCE_ID, HCO_HCE_ID, and TITL_TYP_ID
      STRING1   DELTA_CD;                    //Values include "U" - Update, "I" - Insert(new record),
                                             //"D" - Delete (no longer valid personal record, ex. change to role/location),
                                             //"" - empty code means there was no change to the record
    END;

    EXPORT Verified_In :=  RECORD
      Sprayed;
      STRING100 prep_addr_line1 := '';
      STRING50  prep_addr_line_last := '';
    END; 
 
  END;  //End InputA module

  // InputB is similar to the old Nixie file from SKA.  This file accompanies the verified file by providing
  // individuals who are no longer actively operating in the medical field along with reason and deactivation date.
  EXPORT InputB := MODULE
  
    EXPORT Sprayed := RECORD //layout size (671)
      STRING15  HCP_HCE_ID;                  //ID for a person that matched a person that was in InputA
      STRING32  OK_INDV_ID;
      STRING15  SKA_UID;
      STRING7   IMS_ID;
      STRING40  FRST_NM;
      STRING40  MID_NM;
      STRING40  LAST_NM;
      STRING10  SFX_CD;
      STRING10  GENDER_CD;
      STRING10  PRIM_PRFSN_CD;
      STRING50  PRIM_PRFSN_DESC;
      STRING10  PRIM_SPCL_CD;
      STRING75  PRIM_SPCL_DESC;
      STRING10  HCE_PRFSNL_STAT_CD;
      STRING50  HCE_PRFSNL_STAT_DESC;
      STRING150 EXCLD_RSN_DESC;              //Reason for deactivation
      STRING25  NPI;
      STRING10  DEACTV_DT;                   //Date person was deactivated
      STRING15  XREF_HCE_ID;
      STRING50  CITY_NM;
      STRING2   ST_CD;
      STRING5   ZIP5_CD;
    END;

    EXPORT Nixie_In := RECORD
      Sprayed;
      STRING100 prep_addr_line1 := '';
      STRING50  prep_addr_line_last := '';
    END;

  END;  //End InputB module


	////////////////////////////////////////////////////////////////////////
	// -- Base Layout(s)
	////////////////////////////////////////////////////////////////////////
	EXPORT Base := RECORD
  
    STRING2     source := MDR.sourceTools.src_One_Key;
    UNSIGNED6   bdid;
    UNSIGNED1   bdid_score := 0;		
    UNSIGNED8   source_rec_id := 0;
    UNSIGNED4   dt_vendor_first_reported := 0;
    UNSIGNED4   dt_vendor_last_reported  := 0;
    STRING1     record_type := 'C';
    InputA.Sprayed;
    //InputB.Sprayed - InputA.Sprayed
    InputB.Sprayed.IMS_ID;
    InputB.Sprayed.HCE_PRFSNL_STAT_CD;
    InputB.Sprayed.HCE_PRFSNL_STAT_DESC;
    InputB.Sprayed.EXCLD_RSN_DESC;
    InputB.Sprayed.NPI;
    InputB.Sprayed.DEACTV_DT;
    STRING10    CLEANED_DEACTV_DT;
    InputB.Sprayed.XREF_HCE_ID;
    STRING10    Clean_Phone := '';
    Address.Layout_Clean_Name;
    STRING100   prep_addr_line1 := '';
    STRING50    prep_addr_line_last := '';
    Address.Layout_Clean182_fips;
    UNSIGNED8   raw_aid := 0;
    UNSIGNED8   ace_aid := 0;      
    BIPV2.IDlayouts.l_xlink_ids;
        
  END;  //End Base Record

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	EXPORT Temporary := MODULE

    EXPORT NamesRec := RECORD
      STRING122 name;
      Base;
    END;
 
    EXPORT UniqueId := RECORD
      UNSIGNED8 unique_id;
      Base;
    END;
 
    EXPORT BdidSlim := RECORD
      UNSIGNED8   unique_id;
      STRING150   bus_nm;
      STRING10    prim_range;
      STRING28    prim_name;
      STRING5     zip5;
      STRING8     sec_range;
      STRING25    p_City_name;   		// City
      STRING2     st;
      STRING10    Clean_Phone;
      STRING20    fname;
      STRING20    mname;
      STRING20    lname;
      UNSIGNED6   bdid := 0;
      UNSIGNED1   bdid_score := 0;
      BIPV2.IDlayouts.l_xlink_ids;
    END;
	
  END; //End Temporary module
  
END;  //End layouts module