IMPORT  Address, AID, NID, ut, OneKey;


EXPORT Standardize_NameAddr := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeName(DATASET(OneKey.Layouts.base) pPreProcessInput) :=	FUNCTION

    NID.Mac_CleanParsedNames(pPreProcessInput, cleaned_name_output, frst_nm, mid_nm, last_nm, sfx_cd);
		
    Cleaned_Name_PreProcessInput := cleaned_name_output;

    Layouts.base tStandardizeName(Cleaned_Name_PreProcessInput l) := TRANSFORM

      //////////////////////////////////////////////////////////////////////////////////////
      // -- Map Fields
      //////////////////////////////////////////////////////////////////////////////////////
      SELF.title               := l.cln_title;
      SELF.fname               := l.cln_fname;
      SELF.mname               := l.cln_mname;
      SELF.lname               := l.cln_lname;
      SELF.name_suffix         := l.name_suffix;
      SELF.name_score          := '';

      SELF                     := l;
			
    END;
		
		dStandardizedName := PROJECT(cleaned_name_PreProcessInput, tStandardizeName(LEFT));
		
		RETURN dStandardizedName;

	END;
	

  //////////////////////////////////////////////////////////////////////////////////////
  // -- function: fStandardizeAddresses
  // -- Standardizes addresses
  // -- Apply AID process on the entire base recs for getting fresh address.
  //////////////////////////////////////////////////////////////////////////////////////
  EXPORT fStandardizeAddresses(DATASET(OneKey.Layouts.Base) pStandardizeNameInput) := FUNCTION
	
    HasAddress           := TRIM(pStandardizeNameInput.prep_addr_line_last, LEFT, RIGHT) != '';
										
    dWith_address        := pStandardizeNameInput(HasAddress);
    dWithout_address     := pStandardizeNameInput(not(HasAddress));

    UNSIGNED4 lFlags     := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

    AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
		
    dBase := PROJECT(dwithAID
                    ,TRANSFORM(OneKey.Layouts.base,
                               SELF.ace_aid       := LEFT.aidwork_acecache.aid;
                               SELF.raw_aid       := LEFT.aidwork_rawaid;
                               SELF.prim_range    := LEFT.aidwork_acecache.prim_range;
                               SELF.predir        := LEFT.aidwork_acecache.predir;
                               SELF.prim_name     := LEFT.aidwork_acecache.prim_name;
                               SELF.addr_suffix   := LEFT.aidwork_acecache.addr_suffix;
                               SELF.postdir       := LEFT.aidwork_acecache.postdir;
                               SELF.unit_desig    := LEFT.aidwork_acecache.unit_desig;
                               SELF.sec_range     := LEFT.aidwork_acecache.sec_range;
                               SELF.p_city_name   := LEFT.aidwork_acecache.p_city_name;
                               SELF.v_city_name   := LEFT.aidwork_acecache.v_city_name;
                               SELF.st            := LEFT.aidwork_acecache.st;
                               SELF.zip           := LEFT.aidwork_acecache.zip5;
                               SELF.zip4          := LEFT.aidwork_acecache.zip4;
                               SELF.cart          := LEFT.aidwork_acecache.cart;
                               SELF.cr_sort_sz    := LEFT.aidwork_acecache.cr_sort_sz;
                               SELF.lot           := LEFT.aidwork_acecache.lot;
                               SELF.lot_order     := LEFT.aidwork_acecache.lot_order;
                               SELF.dbpc          := LEFT.aidwork_acecache.dbpc;
                               SELF.chk_digit     := LEFT.aidwork_acecache.chk_digit;
                               SELF.rec_type      := LEFT.aidwork_acecache.rec_type;
                               SELF.fips_state    := LEFT.aidwork_acecache.county[1..2];
                               SELF.fips_county   := LEFT.aidwork_acecache.county[3..];
                               SELF.geo_lat       := LEFT.aidwork_acecache.geo_lat;
                               SELF.geo_long      := LEFT.aidwork_acecache.geo_long;
                               SELF.msa           := LEFT.aidwork_acecache.msa;
                               SELF.geo_blk       := LEFT.aidwork_acecache.geo_blk;
                               SELF.geo_match     := LEFT.aidwork_acecache.geo_match;
                               SELF.err_stat      := LEFT.aidwork_acecache.err_stat;
                               SELF               := LEFT;)
                    ) + PROJECT(dWithout_address, TRANSFORM(OneKey.Layouts.base, SELF := LEFT));

		RETURN dBase;
		
	END;
	

  //////////////////////////////////////////////////////////////////////////////////////
  // -- function: fAll
  //////////////////////////////////////////////////////////////////////////////////////
  EXPORT fAll(DATASET(OneKey.Layouts.Base) pBaseFile
             ,STRING pversion
             ,STRING pPersistname = OneKey.Filenames().PersistStandardizeNameAddr) := FUNCTION
	
    dStandardizeName  := fStandardizeName(pBaseFile);				
    dStandardizeAddr  := fStandardizeAddresses(dStandardizeName) : PERSIST(pPersistname);		
		
    RETURN dStandardizeAddr;
	
  END;

END;