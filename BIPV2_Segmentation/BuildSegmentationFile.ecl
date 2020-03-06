import BIPV2;
import BIPV2_Best;
import BIPV2_Files;
import BIPV2_Build;
import BIPV2_Contacts;
import MDR;
import BIPV2_PostProcess;
import InsuranceHeader_PostProcess;
import tools;


export BuildSegmentationFile(
                               string   pVersion                 = BIPV2.KeySuffix
				        ) := function

     outputFileName := BIPV2_Segmentation.Files(trim(pVersion)).FILE_LOGICAL;
		
     //Current Build Version of Contacts Key
	contactKeyDs   := distribute(pull(BIPV2_Build.key_contact_linkids.keybuilt), hash32(seleid));

     //Current Best File
     bestRecs       := BIPV2_Best.Files().base.built;	

     //Current Build CommonBase Header
	headerRecs     := BIPV2.CommonBase.DS_Clean;  //this is the "built" version of the base file cleaned, no need to further clean it.  should be faster

	
     //Current Consumer Header Segmentation	
     seg_key := InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;

     header_clean := distribute(headerRecs, hash32(seleid));

     nonResidentAddress := dedup(table(header_clean(address_type_derived!='R'), {prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name, st, zip, zip4}), all, hash);
							  
     Layouts.TallyLayout tallyTransform(Layouts.SlimLayout l, dataset(Layouts.SlimLayout) allrows) := transform
          self.dt_first_seen := min(allRows(dt_first_seen<>0), dt_first_seen);
          self.dt_last_seen  := max(allRows, dt_last_seen);
          self.proxid_cnt    := count(table(allrows(proxid<>0), {proxid}, proxid)) ;
          self.addr_state_cnt:= count(table(allrows(trim(st)<>''), {st}, st)) ;
          self.record_cnt    := count(allrows) ;
          self.has_SOS       := exists(allrows(MDR.sourcetools.SourceIsCorpV2(source)));     
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
                               self:=[]), left outer, keep(1), hash);

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
                                     self:=left), left outer, keep(1), hash);           
                                     
     contactInfo        := ExtractContacts(contactKeyDs, seg_key);
     sourceGroupInfo    := ExtractSourceGroups(header_clean);
     allAddressTypeInfo := ExtractAllAddressType(header_clean);
     parentSeleIDInfo   := ExtractParentSeleidInfo(header_clean);
	orgStructureInfo   := ExtractCompanyOrgStructure(header_clean);
	
     withContacts := join(withBest, contactInfo, 
	                     left.seleid = right.seleid, 
                          transform(Layouts.SegmentationLayout,
                                    self.best_contact_did       := right.best_contact_did;
                                    self.best_contact_job_title := right.best_contact_job_title;
                                    self.best_contact_seg_ind   := right.best_contact_seg_ind;
                                    self                        := left), keep(1), left outer, hash);

	  
     withSourceGroupInfo := join(withContacts, sourceGroupInfo,
	                            left.seleid = right.seleid,
						   transform(Layouts.SegmentationLayout,
						             self.sourceGroups := map(right.hasPublicRecords and right.hasDirectory and right.hasBureau => 'PBD',
								                            right.hasPublicRecords and right.hasBureau                        => 'PB',
								                            right.hasPublicRecords and right.hasDirectory                     => 'PD',
								                            right.hasBureau        and right.hasDirectory                     => 'BD',
								                            right.hasPublicRecords                                            => 'P',
								                            right.hasDirectory                                                => 'D',
								                            right.hasBureau                                                   => 'B',
								                            right.hasTelephone                                                => 'T',
													   'U'
								                           ),
								   self := left), left outer, hash);

     withAllAddressTypeInfo := join(withSourceGroupInfo, allAddressTypeInfo,
	                               left.seleid = right.seleid,
						      transform(Layouts.SegmentationLayout,
						                self.all_address_type := right.all_address_type,
								      self := left), left outer, hash);
								   
     withParentSeleidInfo  := join(withAllAddressTypeInfo, parentSeleIDInfo,
	                              left.seleid = right.seleid,
						     transform(Layouts.SegmentationLayout,
						               self.parent_seleid := right.seleid,
								     self := left), left outer, hash);

     withOrgStructInfo     := join(withParentSeleidInfo, orgStructureInfo,
	                              left.seleid = right.seleid,
						     transform(Layouts.SegmentationLayout,
						               self.org_structure     := right.org_structure,
						               self.org_sub_structure := right.org_sub_structure,
								     self := left), left outer, hash);
		
     withBestAddrInfo      := join(withOrgStructInfo, nonResidentAddress,
	                                  left.company_prim_range  = right.prim_range
	                              and left.company_predir      = right.predir
	                              and left.company_prim_name   = right.prim_name
	                              and left.company_addr_suffix = right.addr_suffix
	                              and left.company_postdir     = right.postdir
	                              and left.company_unit_desig  = right.unit_desig
	                              and left.company_sec_range   = right.sec_range
	                              and left.company_p_city_name = right.p_city_name
	                              and left.company_st          = right.st
	                              and left.company_zip5        = right.zip
	                              and left.company_zip4        = right.zip4,
						     transform(Layouts.SegmentationLayout,
						               self.best_address_type := if(right.st!='','B','R'),
								     self := left), left outer, hash);
								   
     go := sequential(
	     output(withBestAddrInfo,,outputFileName,overwrite,compressed) 
	    ,evaluate(BIPV2_Segmentation.Files(trim(pVersion),false).updateSuperFiles(outputFileName))
	);
	
     return go;
end;