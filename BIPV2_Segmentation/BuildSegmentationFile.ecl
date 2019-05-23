import BIPV2;
import BIPV2_Best;
import BIPV2_Files;
import BIPV2_Build;
import MDR;
import BIPV2_PostProcess;
import InsuranceHeader_PostProcess;
import tools;


export BuildSegmentationFile(
                               string   pVersion                 = BIPV2.KeySuffix_mod2.MostRecentWithIngestVersionDate
				        ) := function

     outputFileName := BIPV2_Segmentation.Files(trim(pVersion),false).FILE_LOGICAL;
		
     //Current Build Version of Contacts Key
	contactKeyDs   := distribute(pull(BIPV2_Build.key_contact_linkids.keybuilt), hash32(seleid));

     //Current Best File
     bestRecs       := BIPV2_Best.Files().base.built;	

     //Current Build CommonBase Header
	headerRecs     := BIPV2.CommonBase.DS_Built;

	
     //Current Consumer Header Segmentation	
     seg_key := InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;

     header_clean := distribute(BIPV2.CommonBase.clean(headerRecs), hash32(seleid));

     Layouts.TallyLayout tallyTransform(Layouts.SlimLayout l, dataset(Layouts.SlimLayout) allrows) := transform
          self.dt_first_seen := min(allRows(dt_first_seen<>0), dt_first_seen);
          self.dt_last_seen  := max(allRows, dt_last_seen);
          self.proxid_cnt    := count(table(allrows(proxid<>0), {proxid}, proxid)) ;
          self.addr_state_cnt:= count(table(allrows(trim(st)<>''), {st}, st)) ;
          self.record_cnt    := count(allrows) ;
          self.has_SOS       := exists(allrows(MDR.sourcetools.SourceIsCorpV2(source)));     
          self.org_structure := project(table(allrows(company_org_structure_derived<>''), {company_org_structure_derived, cnt := count(group)}, company_org_structure_derived), Layouts.OrgStructureLayout);
          self:=l;
     end;

     header_slim  := project(header_clean, transform(Layouts.SlimLayout, self:=left; self:=[]));                    
     header_info  := ungroup(rollup(group(sort(header_slim, seleid, local), seleid), group, tallyTransform(left, rows(left))));

     seg := BIPV2_PostProcess.segmentation_category.perSeleid(header_clean, BIPV2.KeySuffix_mod2.MostRecentWithIngestVersionDate);
     
     withSeg := join(header_info, distribute(seg, hash32(seleid)), 
                     left.seleid = right.seleid, 
                     transform(Layouts.SegmentationLayout,
                               self.category := right.category;
                               self.subcategory := right.subCategory;
                               self:=left;
                               self:=[]), left outer, keep(1), local);

     withBest := join(withSeg, bestRecs(proxid=0), 
                      left.seleid = right.seleid, 
                      transform(Layouts.SegmentationLayout,
                                     self.company_name               := right.company_name[1].company_name;
                                     addr                            := right.company_address[1];
                                     self.company_prim_range         := addr.company_prim_range;
                                     self.company_predir             := addr.company_predir;
                                     self.company_prim_name          := addr.company_prim_name;
                                     self.company_addr_suffix        := addr.company_addr_suffix;
                                     self.company_postdir            := addr.company_postdir;
                                     self.company_unit_desig         := addr.company_unit_desig;
                                     self.company_sec_range          := addr.company_sec_range;
                                     self.company_p_city_name        := addr.company_p_city_name;
                                     self.address_v_city_name        := addr.address_v_city_name;
                                     self.company_st                 := addr.company_st;
                                     self.company_zip5               := addr.company_zip5;
                                     self.company_zip4               := addr.company_zip4;
                                     self.state_fips                 := addr.state_fips;
                                     self.county_fips                := addr.county_fips;
                                     self.county_name                := addr.county_name;
                                     self.company_phone              := right.company_phone[1].company_phone;
                                     self.company_fein               := right.company_fein[1].company_fein;
                                     self.duns_number                := right.duns_number[1].duns_number;
                                     self.company_incorporation_date := right.company_incorporation_date[1].company_incorporation_date;
                                     self.company_sic_code1          := right.sic_code[1].company_sic_code1;
                                     self.company_naics_code1        := right.naics_code[1].company_naics_code1;               
                                     self:=left), left outer, keep(1), local);           
                                     
     contactInfo := ExtractContacts.extractContactInfo(contactKeyDs, seg_key);

     withContacts := join(withBest, contactInfo, 
	                     left.seleid = right.seleid, 
                          transform(Layouts.SegmentationLayout,
                                    self.contacts := right.contacts;
                                    self:=left), keep(1), left outer, local);
                                                                                                                                                                               
     go := sequential(
	     output(withContacts,,outputFileName,overwrite,compressed) 
	    ,evaluate(BIPV2_Segmentation.Files(trim(pVersion),false).updateSuperFiles(outputFileName))
	);
	
     return go;
end;