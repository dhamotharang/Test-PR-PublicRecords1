IMPORT Business_Header, MDR, ut;

EXPORT fAs_business := MODULE

   EXPORT fHeader(DATASET(Layouts.Keybuild) pDataset) := FUNCTION

		 //-- Add unique id
     Layouts.UniqueId tAddUniqueId(Layouts.Keybuild L, UNSIGNED8 cnt) := TRANSFORM
       SELF.BH_unique_id := cnt;
       SELF := L;
     END;
     dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT, COUNTER));

     // -- Map to New Business Header format
     bh_layout := business_header.Layout_Business_Header_New;

     bh_layout tAsBusinessHeader(Layouts.UniqueId L) := TRANSFORM
       SELF.group1_id                := L.BH_unique_id;
       SELF.vl_id 					         := TRIM(L.Phys_state) + '-' +
																				HASH(TRIM(L.legal_business_name) + TRIM(L.Phys_prim_name));
			 SELF.vendor_id                := TRIM(L.Phys_state) + '-' +
																				HASH(TRIM(L.legal_business_name) + TRIM(L.Phys_prim_name));
       SELF.phone                    := (UNSIGNED)L.phys_loc_phone;
       SELF.phone_score              := 0;
       SELF.source                   := MDR.sourceTools.src_NCPDP;
       SELF.source_group             := L.NCPDP_provider_id;
       SELF.company_name             := L.legal_business_name;
       SELF.dt_first_seen            := L.Dt_First_Seen;
       SELF.dt_last_seen             := L.Dt_Last_Seen;
       SELF.dt_vendor_first_reported := 0;
       SELF.dt_vendor_last_reported  := 0;
       SELF.fein                     := (UNSIGNED)L.federal_tax_id;
       SELF.current                  := TRUE;
       SELF.prim_range               := L.Phys_prim_range;
       SELF.predir                   := L.Phys_predir;
       SELF.prim_name                := L.Phys_prim_name;
       SELF.addr_suffix              := L.Phys_addr_suffix;
       SELF.postdir                  := L.Phys_postdir;
       SELF.unit_desig               := L.Phys_unit_desig;
       SELF.sec_range                := L.Phys_sec_range;
       SELF.city                     := L.Phys_p_city_name;
       SELF.state                    := L.Phys_state;
       SELF.zip                      := (UNSIGNED3)L.Phys_zip5;
       SELF.zip4                     := (UNSIGNED2)L.Phys_zip4;
       SELF.county                   := L.Phys_county;
       SELF.msa                      := L.Phys_msa;
       SELF.geo_lat                  := L.Phys_geo_lat;
       SELF.geo_long                 := L.Phys_geo_long;
       SELF.dppa                     := FALSE;
     END;

     RETURN PROJECT(dAddUniqueId, tAsBusinessHeader(LEFT));

   END;
   
   EXPORT fContact(DATASET(Layouts.Keybuild) pDataset) := FUNCTION
			
			// -- Map to New Business Contact Layout
      layout_BH_contact := Business_Header.Layout_Business_Contact_Full_New;
			
      layout_BH_contact tAsBusinessContact(Layouts.Keybuild L) := TRANSFORM
         SELF.source               := MDR.sourceTools.src_NCPDP;
         SELF.dppa                 := FALSE;
         SELF.dt_first_seen        := L.Dt_First_Seen;
         SELF.dt_last_seen         := L.Dt_Last_Seen;
         SELF.prim_range           := '';
         SELF.predir               := '';
         SELF.prim_name            := '';
         SELF.addr_suffix          := '';
         SELF.postdir              := '';
         SELF.unit_desig           := '';
         SELF.sec_range            := '';
         SELF.city                 := '';
         SELF.state                := '';
         SELF.zip                  := 0;
         SELF.zip4                 := 0;
         SELF.county               := '';
         SELF.msa                  := '';
         SELF.geo_lat              := '';
         SELF.geo_long             := '';
         SELF.record_type          := 'C';
         SELF.phone                := 0;
         SELF.email_address        := '';
         SELF.ssn                  := 0;
         SELF.title                := '';
         SELF.fname                := L.fname;
         SELF.mname                := L.mname;
         SELF.lname                := L.lname;
         SELF.name_suffix          := L.suffix;
         SELF.name_score           := '';
         SELF.vendor_id            := TRIM(L.Phys_state) + '-' +
																			HASH(TRIM(L.legal_business_name) + TRIM(L.Phys_prim_name));
         SELF.company_title        := '';
         SELF.company_department   := '';
         SELF.company_source_group := '';
         SELF.company_name         := L.legal_business_name;
         SELF.company_prim_range   := L.Phys_prim_range;
         SELF.company_predir       := L.Phys_predir;
         SELF.company_prim_name    := L.Phys_prim_name;
         SELF.company_addr_suffix  := L.Phys_addr_suffix;
         SELF.company_postdir      := L.Phys_postdir;
         SELF.company_unit_desig   := L.Phys_unit_desig;
         SELF.company_sec_range    := L.Phys_sec_range;
         SELF.company_city         := L.Phys_p_city_name;
         SELF.company_state        := L.Phys_state;
         SELF.company_zip          := (UNSIGNED3)L.Phys_zip5;
         SELF.company_zip4         := (UNSIGNED2)L.Phys_zip4;
         SELF.company_phone        := (UNSIGNED)L.phys_loc_phone;
         SELF.company_fein         := (UNSIGNED)L.federal_tax_id;
         SELF.bdid                 := L.bdid;
      END;
			
      dAsBusinessHeader := PROJECT(pDataset, tAsBusinessContact(LEFT));
      RETURN dAsBusinessHeader((INTEGER)name_score < 3,
			                         Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
			
   END;

END;
