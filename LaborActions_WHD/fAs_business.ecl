IMPORT Business_Header, ut, MDR;
export fAs_business :=
module
   export fHeader(dataset(layouts.Keybuild) pDataset) := function
      
			//-- Add unique id
      Layouts.UniqueId tAddUniqueId(Layouts.Keybuild l, unsigned8 cnt) := transform
         self.BH_unique_id    := cnt ;
         self                 := l   ;
      end;   
      dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));
			
      // -- Map to New Business Header format
      bh_layout := business_header.Layout_Business_Header_New;
      bh_layout tAsBusinessHeader(Layouts.UniqueId L) := transform
         
         SELF.group1_id                := L.BH_unique_id;
         SELF.vl_id 					         := trim(L.m_st) + '-' + 
																					hash(trim(L.EmployerName) + trim(L.m_prim_name));
				 SELF.vendor_id                := trim(L.m_st) + '-' + 
																					hash(trim(L.EmployerName) + trim(L.m_prim_name));
         SELF.phone                    := 0;
         SELF.phone_score              := 0;
         SELF.source                   := mdr.sourceTools.src_LaborActions_WHD; //'WX';
         SELF.source_group             := L.CaseID;
         SELF.company_name             := L.EmployerName;
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
   
   export fContact(dataset(layouts.keybuild) pDataset) := function
			
			// -- Map to New Business Contact Layout
      layout_BH_contact    := Business_Header.Layout_Business_Contact_Full_New;
      layout_BH_contact tAsBusinessContact(layouts.KeyBuild l) := transform
         self.source               := mdr.sourceTools.src_LaborActions_WHD; //'WX';
         self.dppa                 := false;
         self.dt_first_seen        := l.Date_FirstSeen;
         self.dt_last_seen         := l.Date_LastSeen;
         self.prim_range           := '';
         self.predir               := '';
         self.prim_name            := '';
         self.addr_suffix          := '';
         self.postdir              := '';
         self.unit_desig           := '';
         self.sec_range            := '';
         self.city                 := '';
         self.state                := '';
         self.zip                  := 0;
         self.zip4                 := 0;
         self.county               := '';
         self.msa                  := '';
         self.geo_lat              := '';
         self.geo_long             := '';
         self.record_type          := 'C';
         self.phone                := 0;
         self.email_address        := '';
         self.ssn                  := 0;
         self.title                := '';
         self.fname                := '';
         self.mname                := '';
         self.lname                := '';
         self.name_suffix          := '';
         self.name_score           := '';
         self.vendor_id            := trim(L.m_st) + '-' + 
																			hash(trim(L.EmployerName) + trim(L.m_prim_name));
         self.company_title        := '';
         self.company_department   := '';
         self.company_source_group := '';
         self.company_name         := l.EmployerName;
         self.company_prim_range   := l.m_prim_range;
         self.company_predir       := l.m_predir;
         self.company_prim_name    := l.m_prim_name;
         self.company_addr_suffix  := l.m_addr_suffix;
         self.company_postdir      := l.m_postdir;
         self.company_unit_desig   := l.m_unit_desig;
         self.company_sec_range    := l.m_sec_range;
         self.company_city         := l.city;
         self.company_state        := l.employerstate;
         self.company_zip          := (unsigned3)l.m_zip;
         self.company_zip4         := (unsigned2)l.m_zip4;
         self.company_phone        := 0;
         self.company_fein         := 0;
         self.bdid                 := l.bdid;
      end;
			
      dAsBusinessHeader := project( pDataset, tAsBusinessContact(left) );
      return   dAsBusinessHeader((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
   end;
end;
