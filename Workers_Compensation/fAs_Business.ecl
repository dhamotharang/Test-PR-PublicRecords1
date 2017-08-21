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
         SELF.vl_id 					         := trim(L.Master_UID);
				 SELF.vendor_id                := trim(L.Master_UID);
         SELF.phone                    := 0;
         SELF.phone_score              := 0;
         SELF.source                   := mdr.sourceTools.src_Workers_Compensation;  
         SELF.source_group             := SELF.vendor_id;
         SELF.company_name             := L.Description;
         SELF.dt_first_seen            := L.Date_FirstSeen;
         SELF.dt_last_seen             := L.Date_LastSeen;
         SELF.dt_vendor_first_reported := (UNSIGNED4) L.Date_FirstSeen;
         SELF.dt_vendor_last_reported  := (UNSIGNED4) L.Date_LastSeen;
         SELF.fein                     := (UNSIGNED) l.FEIN;
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
   
end;
