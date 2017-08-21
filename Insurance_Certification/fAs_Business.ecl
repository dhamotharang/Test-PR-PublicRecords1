IMPORT Business_Header, ut, MDR;
export fAs_business_header :=
module
   export fHeader(dataset(layouts_certification.Keybuild) pDataset) := function
      
			//-- Add unique id
      Layouts_certification.UniqueId tAddUniqueId(Layouts_certification.Keybuild l, unsigned8 cnt) := transform
         self.BH_unique_id    := cnt ;
         self                 := l   ;
      end;   
      dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));
			
      // -- Map to New Business Header format
      bh_layout := business_header.Layout_Business_Header_New;
      bh_layout tAsBusinessHeader(Layouts_certification.UniqueId L) := transform
         
         SELF.group1_id                := L.BH_unique_id;
         SELF.vl_id 					         := trim((string)L.LNInsCertRecordID);
				 SELF.vendor_id                := trim((string)L.LNInsCertRecordID);
         SELF.phone                    := (UNSIGNED8) L.Norm_Phone;
         SELF.phone_score              := 0;
         SELF.source                   := mdr.sourceTools.src_Insurance_Certification; //'IS';
         SELF.source_group             := (string)L.LNInsCertRecordID;
         SELF.company_name             := L.Norm_BusinessName;
         SELF.dt_first_seen            := L.Date_FirstSeen;
         SELF.dt_last_seen             := L.Date_LastSeen;
         SELF.dt_vendor_first_reported := (UNSIGNED4) L.DateAdded;
         SELF.dt_vendor_last_reported  := (UNSIGNED4) L.DateUpdated;
         SELF.fein                     := 0;
         SELF.current                  := TRUE;
         SELF.prim_range               := L.m_prim_range;
         SELF.predir                   := L.m_predir;
         SELF.prim_name                := L.m_prim_name;
         SELF.addr_suffix              := L.m_addr_suffix;
         SELF.postdir                  := L.m_postdir;
         SELF.unit_desig               := L.m_unit_desig;
         SELF.sec_range                := L.m_sec_range;
         SELF.city                     := L.m_p_city_name;
         SELF.state                    := L.m_st;
         SELF.zip                      := (UNSIGNED3)L.m_zip;
         SELF.zip4                     := (UNSIGNED2)L.m_zip4;
         SELF.county                   := L.m_fips_county;
         SELF.msa                      := L.m_msa;
         SELF.geo_lat                  := L.m_geo_lat;
         SELF.geo_long                 := L.m_geo_long;
         self.dppa                     := false;
      end;
     		
			dAsBusinessHeader := project( dAddUniqueId, tAsBusinessHeader(left) );
      return dAsBusinessHeader;
   end;
   
   export fContact(dataset(layouts_certification.keybuild) pDataset) := function
			
			// -- Map to New Business Contact Layout
      layout_BH_contact    := Business_Header.Layout_Business_Contact_Full_New;
      layout_BH_contact tAsBusinessContact(layouts_certification.KeyBuild l) := transform
         self.source               := mdr.sourceTools.src_Insurance_Certification; //'IS';
         self.dppa                 := false;
         self.dt_first_seen        := l.Date_FirstSeen;
         self.dt_last_seen         := l.Date_LastSeen;
         self.prim_range           := L.m_prim_range;
         self.predir               := L.m_predir;
         self.prim_name            := L.m_prim_name;
         self.addr_suffix          := L.m_addr_suffix;
         self.postdir              := L.m_postdir;
         self.unit_desig           := L.m_unit_desig;
         self.sec_range            := L.m_sec_range;
         self.city                 := L.m_p_city_name;
         self.state                := L.m_st;
         self.zip                  := (UNSIGNED3)L.m_zip;
         self.zip4                 := (UNSIGNED2)L.m_zip4;
         self.county               := L.m_fips_county;
         self.msa                  := L.m_msa;
         self.geo_lat              := L.m_geo_lat;
         self.geo_long             := L.m_geo_long;
         self.record_type          := 'C';
         self.phone                := (UNSIGNED8) l.Norm_Phone;
         self.email_address        := '';
         self.ssn                  := 0;
         self.title                := '';
         self.fname                := L.Norm_FirstName; 
         self.mname                := L.Norm_Middle;
         self.lname                := L.Norm_Last;
         self.name_suffix          := L.Norm_Suffix;
         self.name_score           := '';
         self.vendor_id            := trim(L.m_st) + '-' + 
																			hash(trim(L.Norm_BusinessName) + trim(L.m_prim_name));
         self.company_title        := '';
         self.company_department   := '';
         self.company_source_group := '';
         self.company_name         := l.Norm_BusinessName;
         self.company_prim_range   := l.m_prim_range;
         self.company_predir       := l.m_predir;
         self.company_prim_name    := l.m_prim_name;
         self.company_addr_suffix  := l.m_addr_suffix;
         self.company_postdir      := l.m_postdir;
         self.company_unit_desig   := l.m_unit_desig;
         self.company_sec_range    := l.m_sec_range;
         self.company_city         := l.Norm_City;
         self.company_state        := l.Norm_State;
         self.company_zip          := (unsigned3)l.m_zip;
         self.company_zip4         := (unsigned2)l.m_zip4;
         self.company_phone        := (UNSIGNED8)l.Norm_Phone;
         self.company_fein         := 0;
         self.bdid                 := l.bdid;
      end;
			
      dAsBusinessHeader := project( pDataset, tAsBusinessContact(left) );
      return   dAsBusinessHeader((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
   end;
end;
