Import ut, std, tools, inquiry_acclogs, Address, did_Add, didville, mdr;

export Build_Base_Glb5 (
                         string pversion
                         ,dataset(Layouts.Base.Glb5) inBaseGlb5 = Files().Base.Glb5.QA
                         ,dataset(Layouts.Input.Glb5) inGlb5Update = Files().Input.Glb5.Sprayed //not used
                         ,boolean UpdateGlb5 = FraudDefenseNetwork._Flags.Update.Glb5
                       ) := module

// UpdateGlb5 = false for full load. UpdateGlb5 = true should be update append

   parsed := inquiry_acclogs.fnMapCommon_Accurint('FDN').clean;
   FilteredData := Parsed (~inquiry_acclogs.FnTranslations.is_Disable_Observation(allowflags) and GLB_purpose = '5');
   inGlb5Update0 := Inquiry_AccLogs.fn_clean_and_parse(FilteredData) : persist(Persistnames.glb5);

   unsigned Glb5MaxRecordID := if(UpdateGlb5, max(inBaseGlb5, source_rec_id), 0) : global; // For full initial load as its not update

   Functions.CleanFields(inGlb5Update0, inGlb5UpdateUpper);

   Layouts.Base.Glb5 tPrep(inGlb5UpdateUpper pInput, integer cnt) :=
             transform
                  self.process_date := (unsigned) pversion,
                  self.Unique_Id := 0;
                  self.global_sid := 0;
                  self.record_sid := 0;
                  self.Source := 'GLB5';
                  self.dt_first_seen := (unsigned)pInput.datetime [1..8];
                  self.dt_last_seen := (unsigned)pInput.datetime [1..8];
                  self.dt_vendor_last_reported := (unsigned) pversion;
                  self.dt_vendor_first_reported := (unsigned) pversion;
                  self.source_rec_id := Glb5MaxRecordID + cnt;
                  
               // add  address and name prep
                  self.current := 'C';
                  self.cleaned_name.title := pInput.title;
                  self.cleaned_name.fname := pInput.fname;
                  self.cleaned_name.mname := pInput.mname;
                  self.cleaned_name.lname := pInput.lname;
                  self.cleaned_name.name_suffix := pInput.name_suffix;
                  self.cleaned_name.name_score := pInput.name_score;
                  self.address_1 := Address.Addr1FromComponents(pInput.orig_addr1, pInput.orig_lastline1, '', '', '', '', '');
                  self.address_2 := Address.Addr2FromComponents(pInput.orig_city1, pInput.orig_state1, pInput.orig_zip1[1..5]);
                  self.work_phone := pInput.work_phone;
                  self.phone_number := if(pInput.personal_phone <>'', pInput.personal_phone, pInput.company_phone);
                  self := pInput;
                  self := [];
             end;

   Glb5Proj := project(dedup(inGlb5UpdateUpper(linkid<>''), all), tPrep(left, counter));

   Standardize_Address(Glb5Proj, GLB5AddrCleaned);

   Standardize_Phone(GLB5AddrCleaned, work_phone, GLB5WrkPhCleaned, clean_phones.Work_phone,, true);
   Standardize_Phone(GLB5WrkPhCleaned, phone_number, GLB5PhoneCleaned, clean_phones.phone_number,, true);

   Mac_LexidAppend(GLB5PhoneCleaned, GLB5WithIDL);
	 
  // Rollup Update and previous base
   Pcombined := if(UpdateGlb5, inBaseGlb5 + GLB5WithIDL, GLB5WithIDL);
   pDataset_Dist := distribute(Pcombined, hash32(transaction_id));
   pDataset_sort := sort(pDataset_Dist, -transaction_id, -dt_last_seen, -process_date, record, local);

   Layouts.Base.Glb5 RollupUpdate(Layouts.Base.Glb5 l, Layouts.Base.Glb5 r) :=
             transform
                  self.dt_first_seen := ut.EarliestDate(l.dt_first_seen, r.dt_first_seen);
                  self.dt_last_seen := max(l.dt_last_seen, r.dt_last_seen);
                  SELF.dt_vendor_last_reported := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
                  SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
                  SELF.source_rec_id := if(r.source_rec_id < l.source_rec_id, r.source_rec_id, l.source_rec_id); // leave always previous rid
                  self.current := if(l.current = 'C' or r.current = 'C', 'C', 'H');
                  self := l;
             end;

   pDataset_rollup := rollup(
                              pDataset_sort
                              ,RollupUpdate(left, right)
                              ,Record
                              ,except process_date, dt_first_seen, dt_last_seen, dt_vendor_last_reported, dt_vendor_first_reported, source_rec_id, current, local
                            );
   
// GLB5 Append Market information 
  inBaseGLB5_dist       := distribute(pDataset_rollup, hash32(orig_company_id));
  MBSmarketAppend_dist  := distribute(Files().Input.MBSmarketAppend.Sprayed, hash32(company_id));

	Glb5MarketAppend      := join(inBaseGLB5_dist, MBSmarketAppend_dist, left.orig_company_id = right.company_id,
                                              transform(FraudDefenseNetwork.Layouts.base.Glb5,
																							               self.sybase_company_id        := stringlib.stringtouppercase(right.company_id); 
																							               self.sybase_main_country_code := stringlib.stringtouppercase(right.main_country_code); 
																							               self.sybase_bill_country_code := stringlib.stringtouppercase(right.bill_country_code);
																							               self.sybase_app_type          := stringlib.stringtouppercase(right.app_type);
																							               self.sybase_market            := stringlib.stringtouppercase(right.market);
																							               self.sybase_sub_market        := stringlib.stringtouppercase(right.sub_market);
																							               self.sybase_vertical          := stringlib.stringtouppercase(right.vertical) ;
																							               self                          := left; 
																							               self                          := []), left outer, local);


// Source exlusions 

  FilterSet    := ['GOV', 'GOVERNMENT & ACADEMIC', 'GOVERNMENT', 'HEA', 'HEALTHCARE INITIATIVE', 'GOVERNMENT HEALTHCARE', 'INTERNAL', 'HC -   PROVIDER',  'TAX & REVENUE.FEDERAL','HEALTHCARE' , 'PROVIDER', 'PHARMACY' ,'PAYER'];
  SrcExclusion := set(Files().Input.MBSSourceGcExclusion.Sprayed (gc_id <>0  and status = 1), (string)gc_id); 
	SrcExclusionC := set(Files().Input.MBSSourceGcExclusion.Sprayed (gc_id <>0 and status = 1), (string)company_id); 
  Jfiltered    := Glb5MarketAppend(global_company_id   not in SrcExclusion ); 
	Jfiltered1   := Jfiltered(company_id    not in SrcExclusionC );
  JcountryCode := Jfiltered1(sybase_MAIN_COUNTRY_CODE = 'USA'); 
  Japptype     := JcountryCode(sybase_app_type          not in FilterSet ); 
  Jvertical    := Japptype (sybase_vertical             not in FilterSet ); 
  Jsub_market  := Jvertical(sybase_sub_market           not in FilterSet ); 
  Jmarket      := Jsub_market(sybase_market             not in FilterSet ):persist('temp::glb5_1'); 
   
   dInSegment   := project (Jmarket , transform( FraudDefenseNetwork.Layouts.base.Glb5, 

       self.Industry_segment := map( 
                              left.sybase_app_type in ['INS','AUTO','AIG','LIFE']    => 'INSURANCE' , 
			                        left.sybase_app_type in ['LE','LEG','USLM']      => 'LEGAL' , 
			                        left.sybase_app_type in ['TCOL', 'FCOL', 'COL','COLLECTIONS'] => 'COLLECTIONS' ,
															left.sybase_app_type ='IRB' => 'IRB',
			                        left.sybase_app_type = 'XBPS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'LEGAL',
															left.sybase_app_type = ''  and left.sybase_vertical not in [ 'CORE','','AUTO','USLM'] => left.sybase_vertical ,
			                        left.sybase_app_type = ''  and left.sybase_vertical in [ 'CORE',''] 
															and left.sybase_sub_market = 'PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS' , 'OTHERS'); 
				
				self.sybase_app_type  := map ( 	left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'LIFE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'AUTO',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'USLM',
															left.sybase_app_type = ''  and left.sybase_vertical ='COLLECTIONS' => 'COLLECTIONS',
															left.sybase_app_type = ''  and left.sybase_vertical ='EMERGING' => 'EMERGING',
															left.sybase_app_type = ''  and left.sybase_vertical ='FINANCIAL SERVICES' => 'FINANCIAL SERVICES',
															left.sybase_app_type = ''  and self.Industry_segment ='OTHERS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_sub_market ='PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS',
															left.sybase_app_type);
				
				self := left ));
				
				Jdedup := dedup(dInSegment,(unsigned)linkid, trim(company_id,left,right), trim(global_company_id,left,right) , trim(datetime[1..8],left,right),all ); 
   
   dBase_RecordID := Project(Jdedup, transform(recordof(Jdedup),
                                                        RecordID := Constants().GLB5RecIDSeries + left.source_rec_id;
                                                        self.record_sid := RecordID;
                                                        self := left;
                                                       ));   
	 
   dBase_GlobalSID := mdr.macGetGlobalSID(dBase_RecordID, 'FDN', 'source', 'global_sid');

   tools.mac_WriteFile(Filenames(pversion).Base.Glb5.New, dBase_GlobalSID, Build_Base_File);
  
// Return
   export full_build := sequential(
                                    Build_Base_File, Promote(pversion).buildfiles.New2Built
                                  );

   export All := if(
                     tools.fun_IsValidVersion(pversion), full_build, output('No Valid version parameter passed, skipping Build_Base_Glb5 atribute')
                   );

end;