import Business_Header, AID_Build, ut, mdr;

EXPORT BL_Init(

	 dataset(Business_Header.Layout_Business_Linking.Linking_Interface)	pAll_Business_Linking_Sources	= BIPV2.Business_Sources
	//,string																pPersistname									= persistnames().BLInit
	,string																pPersistname									= '~thor_data400::persist::BIPV2::BL_Init'
	,boolean															pShouldRecalculatePersist			= true													

) :=
function

	Layout_BL_Full := BIPV2.Layout_Business_Linking_Full;
	Layout_BL			 := Business_Header.Layout_Business_Linking.Linking_Interface;
	
	//*** convert RawAID to AceAID where we can
	k_aid := AID_Build.Key_AID_Base;

	l_aid := {k_aid.RawAID; k_aid.AceAID;};
		
	//*** function to append the aceaid for a given rawaid
	dataset(Layout_BL_Full) SetAceAID(dataset(Layout_BL) ds_in) := function
			//*** ACE_AID Key file.
			dist_aid 		:= distribute(project(pull(k_aid)(RawAID<>0,AceAID<>0),l_aid), hash32(RawAID));
			ds_in_full	:= project(ds_in, transform(Layout_BL_Full, self := left, self := []));
			dist_ds_in	:= distribute(ds_in_full(company_rawaid <> 0), hash32(company_rawaid));
						
			ds_ace			:= join(dist_ds_in, dist_aid,
													left.company_rawaid = right.RawAID,
													transform(Layout_BL_Full, self.company_Aceaid := right.AceAID, self := left, self := []),
													left outer, keep(1), local );
			
			return ds_ace + ds_in_full(company_rawaid = 0);
	end;
	
	dAll_Sources_AceAId := SetAceAID(pAll_Business_Linking_Sources);
	
	//*** Modified code for Bug: 153999  - DATA: URL showing partial information 
	bad_urls := ['HTTP:','HTTP://','HTTPS://','HTTPS:','HTTP://WWW','HTTP://WWW.','HTTPS://WWW','HTTPS://WWW.','WWW','WWW.'];

	//*** populate all derived fields using the BL_Tables.	
	Layout_BL_Full SetDescFields(dAll_Sources_AceAId l) := transform 																					
			boolean bad_phone 									:= if(trim(l.company_phone) in ut.set_BadPhones, true, false);
			unsigned4 dt_first_seen_tmp					:= (unsigned4)business_header.validatedate((string8)l.dt_first_seen						,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1));
			unsigned4 dt_last_seen_tmp					:= (unsigned4)business_header.validatedate((string8)l.dt_last_seen						,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1));
			unsigned4 dt_ven_first_reported_tmp	:= (unsigned4)business_header.validatedate((string8)l.dt_vendor_first_reported,if(length(trim((string8)l.dt_vendor_first_reported	)) = 8,0,1));
			unsigned4 dt_ven_last_reported_tmp	:= (unsigned4)business_header.validatedate((string8)l.dt_vendor_last_reported	,if(length(trim((string8)l.dt_vendor_last_reported	)) = 8,0,1));
			
			self.Company_name_type_derived			:= BIPV2.BL_Tables.CompanyNameTypeDesc(l.Company_name_type_raw);
			self.Company_address_type_derived		:= BIPV2.BL_Tables.AddrType(l.Company_address_type_raw);
			self.Company_org_structure_derived	:= BIPV2.BL_Tables.CompanyOrgStructure(l.Company_org_structure_raw);
			self.Company_name_status_derived		:= BIPV2.BL_Tables.CompanyNameStatusDesc(l.Company_name_status_raw);
			self.Company_status_derived					:= BIPV2.BL_Tables.CompanyStatusDesc(l.Company_status_raw);
			self.Contact_type_derived						:= BIPV2.BL_Tables.ContactTypeDesc(l.Contact_type_raw);
			self.Contact_job_title_derived			:= BIPV2.BL_Tables.ContactTitle(l.Contact_job_title_raw);
			self.Contact_status_derived					:= BIPV2.BL_Tables.ContactStatus(l.Contact_status_raw);
			//*** Blank out wrong length FEIN's (Valid length of FEINs is 9), as per bug# 151785
			self.company_fein										:= if (length(stringlib.stringcleanspaces(l.company_fein)) = 9, stringlib.stringcleanspaces(l.company_fein), '');   //*** Bug: 151785 - TIN format not correct for specific example
			self.company_sic_code1							:= if ((mdr.sourceTools.SourceIsDunn_Bradstreet(l.source) or mdr.sourceTools.SourceIsInfutor_NARB(l.source) or 
																	mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(l.source)) and length(trim(l.company_sic_code1)) in [4,8], trim(l.company_sic_code1),
																									if(length(trim(l.company_sic_code1)) = 4, trim(l.company_sic_code1), ''));
			self.company_sic_code2							:= if ((mdr.sourceTools.SourceIsDunn_Bradstreet(l.source) or mdr.sourceTools.SourceIsInfutor_NARB(l.source) or 
																									mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(l.source)) and length(trim(l.company_sic_code2)) in [4,8], trim(l.company_sic_code2),
																									if(length(trim(l.company_sic_code2)) = 4, trim(l.company_sic_code2), ''));
			self.company_sic_code3							:= if ((mdr.sourceTools.SourceIsDunn_Bradstreet(l.source) or mdr.sourceTools.SourceIsInfutor_NARB(l.source) or
																									mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(l.source)) and length(trim(l.company_sic_code3)) in [4,8], trim(l.company_sic_code3),
																									if(length(trim(l.company_sic_code3)) = 4, trim(l.company_sic_code3), ''));
			self.company_sic_code4							:= if ((mdr.sourceTools.SourceIsDunn_Bradstreet(l.source) or mdr.sourceTools.SourceIsInfutor_NARB(l.source) or
																									mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(l.source)) and length(trim(l.company_sic_code4)) in [4,8], trim(l.company_sic_code4),
																									if(length(trim(l.company_sic_code4)) = 4, trim(l.company_sic_code4), ''));
			self.company_sic_code5							:= if ((mdr.sourceTools.SourceIsDunn_Bradstreet(l.source) or mdr.sourceTools.SourceIsInfutor_NARB(l.source) or
																									mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(l.source)) and length(trim(l.company_sic_code5)) in [4,8], trim(l.company_sic_code5),
																									if(length(trim(l.company_sic_code5)) = 4, trim(l.company_sic_code5), ''));
			self.company_naics_code1						:= if (length(trim(l.company_naics_code1)) = 6, trim(l.company_naics_code1), '');
			self.company_naics_code2						:= if (length(trim(l.company_naics_code2)) = 6, trim(l.company_naics_code2), '');
			self.company_naics_code3						:= if (length(trim(l.company_naics_code3)) = 6, trim(l.company_naics_code3), '');
			self.company_naics_code4						:= if (length(trim(l.company_naics_code4)) = 6, trim(l.company_naics_code4), '');
			self.company_naics_code5						:= if (length(trim(l.company_naics_code5)) = 6, trim(l.company_naics_code5), '');
		  self.company_url										:= if (ut.CleanSpacesAndUpper(l.company_url) in bad_Urls, '', stringlib.stringcleanspaces(l.company_url));  //*** Bug: 153999  - DATA: URL showing partial information
			self.company_phone									:= if (bad_phone, '', trim(l.company_phone));
			self.phone_type											:= if (bad_phone, '', trim(l.phone_type));
			self.phone_score										:= if (bad_phone, 0, l.phone_score);
			self.contact_phone									:= if (trim(l.contact_phone) in ut.set_BadPhones, '', trim(l.contact_phone));
			// -- Bug:146861 - Blank the David/Shala or Shahla or SHALAH Peyman contact names.
			// -- Bug: 157298  - Remove Contact Angela Farole from BDID 53982819 Avante Abstract Inc.
			self.contact_name.lname 						:= if(trim(l.contact_name.lname) = 'PEYMAN' and trim(l.contact_name.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'],'',
																								if(trim(l.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and 
																									 trim(l.contact_name.lname) = 'FAROLE' and trim(l.contact_name.fname) = 'ANGELA','', l.contact_name.lname));
			self.contact_name.fname 						:= if(trim(l.contact_name.lname) = 'PEYMAN' and trim(l.contact_name.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'],'',
																								if(trim(l.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and
																									 trim(l.contact_name.lname) = 'FAROLE' and trim(l.contact_name.fname) = 'ANGELA','',l.contact_name.fname));
			self.contact_name.mname 						:= if(trim(l.contact_name.lname) = 'PEYMAN' and trim(l.contact_name.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'],'',
																								if(trim(l.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and 
																									 trim(l.contact_name.lname) = 'FAROLE' and trim(l.contact_name.fname) = 'ANGELA','',l.contact_name.mname));
			self.contact_name.title 						:= if(trim(l.contact_name.lname) = 'PEYMAN' and trim(l.contact_name.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'],'',
																								if(trim(l.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and 
																									 trim(l.contact_name.lname) = 'FAROLE' and trim(l.contact_name.fname) = 'ANGELA','',l.contact_name.title));
			self.contact_name.name_suffix 			:= if(trim(l.contact_name.lname) = 'PEYMAN' and trim(l.contact_name.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'],'',
																								if(trim(l.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and 
																									 trim(l.contact_name.lname) = 'FAROLE' and trim(l.contact_name.fname) = 'ANGELA','',l.contact_name.name_suffix));
			self.contact_name.name_score				:= if(trim(l.contact_name.lname) = 'PEYMAN' and trim(l.contact_name.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'],'',
																								if(trim(l.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and 
																									 trim(l.contact_name.lname) = 'FAROLE' and trim(l.contact_name.fname) = 'ANGELA','',l.contact_name.name_score));
			//** Fixing the bad first_seen or first_reported dates if they are greater than the last_seen or last_reported.																			
			self.dt_first_seen									:= if (dt_first_seen_tmp > dt_last_seen_tmp and dt_last_seen_tmp <> 0, dt_last_seen_tmp, dt_first_seen_tmp);
			self.dt_last_seen										:= dt_last_seen_tmp;
			self.dt_vendor_first_reported				:= if (dt_ven_first_reported_tmp > dt_ven_last_reported_tmp and dt_ven_last_reported_tmp <> 0, dt_ven_last_reported_tmp, dt_ven_first_reported_tmp);
			self.dt_vendor_last_reported				:= dt_ven_last_reported_tmp;
			self 																:= l;
	end;
	
	dAll_Sources := project(dAll_Sources_AceAId, SetDescFields(left));
	
	dBizHdr_Source_Ingest := distribute(Bipv2.Filters.Input.Business_headers(dAll_Sources)): PERSIST(pPersistname);
	

/*
	returndataset := if(pShouldRecalculatePersist = true, dAll_Sources_out
																											, persists().BHInit
										);
*/	
	return dBizHdr_Source_Ingest;

end;