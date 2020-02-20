IMPORT BatchShare, relationship, topbusiness_services, bipv2,iesp, risk_indicators;
EXPORT Layouts := MODULE

export Local_tRelationshipIdentifierSearch := record
	dataset(iesp.relationshipidentifiersearch.t_RelationshipIdentifierSearchBy) SearchBy 
	   {MAXCOUNT(iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS)};
end;

 EXPORT OptionsLayout := RECORD			
		BOOLEAN lnbranded;		
		BOOLEAN IncludeNeighbors;		
		STRING8 AsOfDate;
		//boolean PDF;
 END;

 EXPORT NeighborRel := RECORD
   UNSIGNED6 PrimaryDID;
	 UNSIGNED6 SecondaryDid;
	 BOOLEAN   IsNeighborOf;
 END;			
 export Phone_layout := RECORD
	 string10 phone;
	 string5  zip;
	 string20 lname;
	 string30 prim_name; 
	 string30 prim_range; 
	 string2 st; 
	 string10 sec_range;
	 string10 predir; 
	 string10 postdir; 
	 DATASET(Risk_Indicators.Layout_Desc) hri_phone 
	     {MAXCOUNT(RelationshipIdentifier_Services.Constants.HRIMAX)};
 END;		
 
 export SecondaryEntityWithNeighbor := RECORD
	 iesp.relationshipidentifierreport.t_relationshipIdentifierReportSecondaryEntity;
	 boolean isNeighbor; 
	 iesp.share.t_Date neighbor_dt_first_seen;
	 iesp.share.t_Date neighbor_dt_last_seen; 
 END;
 
 EXPORT SecondaryEntity_withDID := RECORD
   UNSIGNED6 DID;
	 SecondaryEntityWithNeighbor;	 
 END;

 EXPORT ReportRecordWithSeqNum := RECORD
   UNSIGNED2 seqNum;	 	 
	 iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportPrimaryEntity PrimaryEntity;	 
	 dataset(SecondaryEntityWithNeighbor) secondaryEntities 
	         { MAXCOUNT(iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS -1)};
 END;
 
  EXPORT ReportRecordWithSeqNumIESP := RECORD
   UNSIGNED2 seqNum; 
	 iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportPrimaryEntity PrimaryEntity;
	 dataset(iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportSecondaryEntity)  SecondaryEntities
	               {MAXCOUNT(iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS -1)};	 
								 // this is -1 from constant because if we have entity 1,2,3 e.g. 3 total
								 // can entity 1 being a primary entity can't have a relationship with 
								 // secondary entity  1 as thats the same as itself so thus a -1 here.
								 // since 1 would only have relationships with 1-2 and 1-3 thus (2 total or 3-1)
 END;
  
 EXPORT RelationshipFunctionRec := RECORD
	 string20 orig_acctno;
	 string20 acctno;
	 UNSIGNED2 seqNum;
   STRING30 fname1;
   STRING30 mname1; 
   STRING30 lname1; 
   STRING30 fname2; 
   STRING30 mname2;
   STRING30 lname2;
   STRING30 title_str;
	 Relationship.layout_GetRelationship.InterfaceOutput_new;   	 
 END;
 FETCH_LEVEL := BIPV2.IDconstants.Fetch_Level_SELEID;
 FETCH_LIMIT := TopBusiness_Services.Constants.ContactsKfetchMaxLimit;
 EXPORT contactBIPLinkidsRec := RECORD
   RECORDOF(topbusiness_services.key_fetches(dataset([],bipv2.idlayouts.l_xlink_ids),
	                                           FETCH_LEVEL,FETCH_LIMIT).ds_contact_linkidskey_recs);
 END;

 EXPORT bat_RelationshipIdentifierReportRelationshipTypeIESPDATE := record
	string50 RelationshipType; 	
	iesp.share.t_date relationshipFirstSeenDate;	
	iesp.share.t_date relationshipLastseenDate;
 end;
 export bat_relationshipIdentifierReportRelationshipType := Record
	String50 RelationshipType; 
	unsigned4 rel_dt_first_seen; 
	unsigned4 rel_dt_last_seen;
END;
export bat_relationshipIdentiferReportRelTypeWithStrength := record
   bat_relationshipIdentifierReportRelationshipType;
	 string20 strength; // this comes from 'confidence' field in relationship key
END;

	EXPORT BATCH := MODULE
	  EXPORT OrigINPUT := 
				RECORD

			STRING30  acctno;
			STRING50  Role_1;                           
      STRING1   IndividualOrBusiness_1; 
      UNSIGNED6 did_1;
      STRING8   DOB_1;
      string20  name_first_1;
      string20  name_middle_1;
      string20  name_last_1;
      string5   name_suffix_1;
      string9   ssn_1;
      string10  homephone_1;
      STRING120 comp_name_1;
      STRING9   tin_1;                                
      UNSIGNED6 InSELEID_1;
      STRING10  prim_range_1;
      STRING2   predir_1;
      STRING28  prim_name_1;
      STRING4   addr_suffix_1;
      STRING2   postdir_1;
      STRING10  unit_desig_1;
      STRING8   sec_range_1;
      STRING25  city_name_1;
      STRING2   st_1;
      STRING5   z5_1;
      STRING4   zip4_1;                             
      STRING10  workphone_1;
      STRING50  Role_2;
      STRING1   IndividualOrBusiness_2;           
      UNSIGNED6 did_2;
      STRING8   DOB_2;
      string20  name_first_2;
      string20  name_middle_2;
      string20  name_last_2;
      string5   name_suffix_2;
      string9   ssn_2;
      string10  homephone_2;
			STRING120 comp_name_2;
      STRING9   tin_2;                                
      UNSIGNED6 InSELEID_2;
      STRING10  prim_range_2;
      STRING2   predir_2;
      STRING28  prim_name_2;
      STRING4   addr_suffix_2;
      STRING2   postdir_2;
      STRING10  unit_desig_2;
      STRING8   sec_range_2;
      STRING25  city_name_2;
      STRING2   st_2;
      STRING5   z5_2;
      STRING4   zip4_2;                             
      STRING10  workphone_2;

   END;		
	 
	 EXPORT tmp_BatchLayout := RECORD
	    OrigInput;
	    BOOLEAN isValidInput := FALSE;
	 END;
			
		EXPORT Input := 
	  
		RECORD
			STRING30  acctno;
			STRING50  Role;		
			STRING1   IndividualOrBusiness;
			// person Info
			UNSIGNED6 did;
			STRING8   DOB;
			string20  name_first;
			string20  name_middle;
			string20  name_last;
			string5   name_suffix;
			string9   ssn;
			string10  homephone;
			// business info
			STRING120 comp_name;
			STRING9   tin;		
			UNSIGNED6 InSELEID;
			// address
			STRING10  prim_range;
			STRING2   predir;
			STRING28  prim_name;
			STRING4   addr_suffix;
			STRING2   postdir;
			STRING10  unit_desig;
			STRING8   sec_range;
			STRING25  p_city_name;
			STRING2   st;
			STRING5   z5;
			STRING4   zip4;		
			STRING10  workphone;
		END;
	
		EXPORT Input_Processed :=
		RECORD(input)
			STRING20 orig_acctno := '';
			Batchshare.Layouts.ShareErrors;
		END;
	
		EXPORT intermediateLayout :=	  
		RECORD	
			//bipv2.IDlayouts.l_key_ids_bare; // this is ult/org/seleid etc...all 7 of them.
		  UNSIGNED6 did;		
			UNSIGNED6 ultid;
			UNSIGNED6 orgid;
			UNSIGNED6 seleid;
			UNSIGNED6 proxid;
			UNSIGNED6 powid;
			UNSIGNED6 empid;
			UNSIGNED6 dotid;
			Input_processed;
			unsigned4 seqNum;
			unsigned4 rid;
			INTEGER RoleNum;
			unsigned4 asOfDate;		
		END;
		EXPORT intermediateLayoutExt :=
		RECORD
			STRING30 fname; 
			STRING30 mname; 
			STRING30 lname;		
			interMediateLayout;
		END;
	
		EXPORT BatchRelationshipFunctionRec := RECORD
			string20 orig_acctno;
			string20 acctno;
			UNSIGNED2 seqNum;
			STRING30 fname1;
			STRING30 mname1; 
			STRING30 lname1; 
			STRING30 fname2; 
			STRING30 mname2;
			STRING30 lname2;
			STRING30 title_str;
			Relationship.layout_GetRelationship.InterfaceOutput_new;			
		END;
		EXPORT BatchSELEIDRelationshipFunctionRec := RECORD
	   // these are only fields needed here from this payload:
		 // // RECORDOF(BIPV2.Key_BH_Relationship_SELEID.kFetch(
		            // dataset([],BIPV2.Key_BH_Relationship_SELEID.l_kFetch_in)));
			STRING20 orig_acctno;
			string20 acctno;
			unsigned2 seqNum;
			unsigned6 Primaryseleid; 
			unsigned6 Secseleid;             
			unsigned4 dt_first_seen_track; 
			unsigned4 dt_last_seen_track;		 
		END;								

		export bat_relationshipIdentifierReportSecondaryEntity := record
			unsigned6 UniqueID;
			boolean   isNeighbor; 
			unsigned4 neighbor_dt_first_seen; 
			unsigned4 neighbor_dt_last_seen;
			String50  Role; 
			unsigned6 RoleNum;
			string120 CompanyName;
			string9   Tin; 
			iesp.share.t_BusinessIdentity BusinessIds; 
			iesp.share.t_Identity Identity; 
			iesp.share.t_address SecAddress;
			string10  SecPhone;	
			string8   SecDob;
	
			dataset (bat_RelationshipIdentifierReportRelationshipTypeIESPDATE)	         	
				relationshipTypes	
				{MAXCOUNT(RelationshipIdentifier_Services.Constants.MAX_COUNT_RELATIONSHIP_TYPES)};				
	                                    // should be a defined set of messages 'Possible Brother',
	                                                     // 'co-named on a property transfer', 'Possible Neighbor'
																	 										 // 'no relationship found', 'Transaction'	
																											 // maxcount of 25 currently.	
			unsigned2 NumberOfSources; 
			string20 RelationshipStrength;  // some kind of scoring field here.	
		end;

		export bat_relationshipIdentifierReportPrimaryEntity := record
			string20 orig_acctno;
			string20 acctno;
			unsigned6 UniqueID;
			string50 Role;
			unsigned6 RoleNum;	
			string120 CompanyName;
			string9 Tin;
			iesp.share.t_BusinessIdentity BusinessIds; 
			iesp.share.t_address Address; 
			iesp.share.t_Identity Identity;// includes t_name structure and ssn stuff.	
			iesp.share.t_PhoneInfoEx PhoneInfoEx;  // needs to be best non gateway phone and HRI info.
		end;	
	
		export BatchRelationshipIdentifierReportRecord := record	
			string20 orig_acctno;
			string20 acctno;
			UNSIGNED2 seqNum;	
			bat_relationshipIdentifierReportPrimaryEntity PrimaryEntity;
			dataset(bat_relationshipIdentifierReportSecondaryEntity) secondaryEntitys 
				{maxcount( RelationshipIdentifier_Services.Constants.MAX_COUNT_SECONDARY_ENTITIES)}; 		
		end;
	
	END; // BATCH MODULE
END;	// outermost module