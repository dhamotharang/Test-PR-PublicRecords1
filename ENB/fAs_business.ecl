IMPORT Business_Header, ut;
export fAs_business :=
module
   export fHeader(dataset(layouts.base) pDataset) :=
   function
      //Add unique id
      Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Base l, unsigned8 cnt) :=
      transform
         self.unique_id    := cnt   ;
         self                    := l     ;
      end;   
      
      dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));
      //////////////////////////////////////////////////////////////////////////////////////////////
      // -- Map to BH format
      //////////////////////////////////////////////////////////////////////////////////////////////
      bh_layout := business_header.Layout_Business_Header;
      bh_layout tAsBusinessHeader(Layouts.Temporary.UniqueId L) := 
      transform
         
         SELF.group1_id                         := L.unique_id;
         SELF.vendor_id                         := trim(L.Clean_company_address.st) + '-' + hash(trim(L.Rawfields.COMPANY_NAME) + trim(L.Clean_company_address.prim_name));
         SELF.phone                             := (unsigned6)l.clean_phones.Company_Phone_Number;
         SELF.phone_score                    := IF((unsigned6)l.clean_phones.Company_Phone_Number = 0, 0, 1);
         SELF.source                            := 'SP';
         SELF.source_group                   := self.vendor_id;
         SELF.company_name                   := L.Rawfields.COMPANY_NAME;
         SELF.dt_first_seen                  := l.dt_first_seen;
         SELF.dt_last_seen                   := l.dt_last_seen;
         SELF.dt_vendor_first_reported := L.dt_vendor_first_reported;
         SELF.dt_vendor_last_reported  := L.dt_vendor_last_reported;
         SELF.fein                              := 0;
         SELF.current                           := TRUE;
         SELF.prim_range                     := L.Clean_company_address.prim_range;
         SELF.predir                            := L.Clean_company_address.predir;
         SELF.prim_name                         := L.Clean_company_address.prim_name;
         SELF.addr_suffix                    := L.Clean_company_address.addr_suffix;
         SELF.postdir                           := L.Clean_company_address.postdir;
         SELF.unit_desig                     := L.Clean_company_address.unit_desig;
         SELF.sec_range                         := L.Clean_company_address.sec_range;
         SELF.city                              := L.Clean_company_address.p_city_name;
         SELF.state                             := L.Clean_company_address.st;
         SELF.zip                                  := (UNSIGNED3)L.Clean_company_address.zip;
         SELF.zip4                              := (UNSIGNED2)L.Clean_company_address.zip4;
         SELF.county                            := L.Clean_company_address.fips_county;
         SELF.msa                                  := L.Clean_company_address.msa;
         SELF.geo_lat                           := L.Clean_company_address.geo_lat;
         SELF.geo_long                       := L.Clean_company_address.geo_long;
         self.dppa                                 := false;
         
      end;
      dAsBusinessHeader := project(
                                           dAddUniqueId
                                          ,tAsBusinessHeader(left)
                                          );
      return dAsBusinessHeader;
   end;
   
   export fContact(dataset(layouts.base) pDataset) :=
   function
      layout_BH_contact    := Business_Header.Layout_Business_Contact_Full;
      //////////////////////////////////////////////////////////////////////////////////////////////
      // -- Map to Business Contact Layout
      //////////////////////////////////////////////////////////////////////////////////////////////
      layout_BH_contact tAsBusinessContact(layouts.base l) :=
      transform
                  
         self.source                      := 'SP';
         self.dppa                           := false;
         self.dt_first_seen            := l.dt_first_seen;
         self.dt_last_seen             := l.dt_last_seen;
         self.prim_range                  := l.Clean_company_address.prim_range;
         self.predir                      := l.Clean_company_address.predir;
         self.prim_name                := l.Clean_company_address.prim_name;
         self.addr_suffix              := l.Clean_company_address.addr_suffix;
         self.postdir                     := l.Clean_company_address.postdir;
         self.unit_desig                  := l.Clean_company_address.unit_desig;
         self.sec_range                := l.Clean_company_address.sec_range;
         self.city                           := l.Clean_company_address.p_city_name;
         self.state                       := l.Clean_company_address.st;
         self.zip                         := (unsigned)l.Clean_company_address.zip;
         self.zip4                           := (unsigned)l.Clean_company_address.zip4;
         self.county                      := l.Clean_company_address.fips_county;
         self.msa                         := l.Clean_company_address.msa;
         self.geo_lat                     := l.Clean_company_address.geo_lat;
         self.geo_long                    := l.Clean_company_address.geo_long;
         self.record_type              := 'C';
         self.phone                       := (unsigned6)l.clean_phones.Company_Phone_Number;
         self.email_address            := '';
         self.ssn                         := 0;
         self.title                       := l.clean_contact_name.title;
         self.fname                       := l.clean_contact_name.fname;
         self.mname                       := l.clean_contact_name.mname;
         self.lname                       := l.clean_contact_name.lname;
         self.name_suffix              := l.clean_contact_name.name_suffix;
         self.name_score                  := Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
         self.vendor_id                := trim(L.Clean_company_address.st) + '-' + hash(trim(L.Rawfields.COMPANY_NAME) + trim(L.Clean_company_address.prim_name) + trim(l.clean_contact_name.lname) + trim(l.clean_contact_name.fname));
         self.company_title            := l.rawfields.Job_Title;
         self.company_department    := '';
         self.company_source_group  := '';
         self.company_name             := l.rawfields.COMPANY_NAME;
         self.company_prim_range    := self.prim_range;
         self.company_predir           := self.predir;
         self.company_prim_name     := self.prim_name;
         self.company_addr_suffix   := self.addr_suffix;
         self.company_postdir       := self.postdir;
         self.company_unit_desig    := self.unit_desig;
         self.company_sec_range     := self.sec_range;
         self.company_city             := self.city;
         self.company_state            := self.state;
         self.company_zip              := self.zip;
         self.company_zip4             := self.zip4;
         self.company_phone            := (unsigned8)self.phone;
         self.company_fein             := 0;
         self.bdid                           := 0;
      end;
      dAsBusinessHeader := project(
                                           pDataset
                                          ,tAsBusinessContact(left)
                                          );
      return   dAsBusinessHeader((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
   end;
end;
