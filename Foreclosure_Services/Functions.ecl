import ut, Census_Data, Foreclosure_services, iesp, suppress, AutoStandardI, MDR, doxie;

export Functions := module

//same as raw.params
EXPORT params := INTERFACE
  EXPORT string5 industry_class := '';
  EXPORT string32 application_type := Suppress.Constants.ApplicationTypes.DEFAULT;
  EXPORT string ssn_mask := suppress.constants.ssn_mask_type.ALL;
END;

EXPORT SetAddressFields(string primname, string primrange, string predir, string postdir,
	                        string addrsuff, string unitdesig, string secrange, string pcityname,
													string vcityname, string paramcity, string st, string zip, string zip4,
													string countyname, string postalcode) :=		
	iesp.ECL2ESP.setAddress(primname, primrange, predir, postdir, addrsuff,unitdesig,secrange,
													if(pcityname<>'',pcityname,vcityname), st, zip, zip4, countyname, postalcode);

//**************************************************************//
// Add Plaintiffs and Defendant dataset and county name Function//
// This functon is created to be an entry point for normalizing //
// search and report plaintiffs and defendants.			    				//
//																															//
// Added pull_did and SSN mask to the defendants normalizing 		//
// because this is the only place where we have dids and SSN		//
//**************************************************************//

shared Layouts.rawrec_plaintiffs_defendants fnAddPlaintiffAndDefendantDS
						(dataset(Foreclosure_services.Layouts.rawrec) in_recs, params in_mod) := function


out_f_seq_rec := record
     unsigned4 rec_seq := 0;
	in_recs;	
end; 
out_f:=in_recs;
out_f_seq_init := table(out_f, out_f_seq_rec);
 
ut.MAC_Sequence_Records(out_f_seq_init, rec_seq, out_f_seq); 

out_slim_seq_rec := record
	unsigned4 rec_seq;
	Foreclosure_Services.Layouts.rawrec_plaintiffs_defendants;
end; 
 
out_slim_seq_rec slim_it(out_f_seq l) := transform 							    
	self.plaintiffs := [];
	self.defendants := [];
	self := l;
end;
 
out_slim_seq := project(out_f_seq, slim_it(left)); 
out_slim_seq_w_tzone:=out_slim_seq;

out_plaintiffs_seq := record
	unsigned4 rec_seq;
	iesp.share.t_StringArrayItem;
end; 
tmp_rec_plaintiffs:=record
out_plaintiffs_seq;
unsigned rec_order;
end;
tmp_rec_plaintiffs norm_plaintiffs(out_f_seq l,integer c) := transform
     self.rec_order := c;
	self.rec_seq := l.rec_seq;
	self.value := choose(c,l.plaintiff_1,l.plaintiff_2);
end;

out_plaintiffs := normalize(out_f_seq, 2, norm_plaintiffs(left, counter));
out_plaintiffs_flt := out_plaintiffs(value<>'');
out_plaintiffs_srt := dedup(sort(out_plaintiffs_flt,rec_seq,value),rec_seq,value);
out_plaintiffs_dep:=project(sort(out_plaintiffs_srt,rec_order),out_plaintiffs_seq);

out_name_seq_rec := record
	unsigned4 rec_seq;
	iesp.foreclosure.t_ForeclosureReportDefendant;
end; 
tmp_rec_Defendants:=record
out_name_seq_rec;
unsigned rec_order;
end;
tmp_rec_Defendants norm_names(out_f_seq l,integer c) := transform
	self.rec_order := c;
	self.rec_seq := l.rec_seq;
	self.name.first := choose(c,l.name1_first,l.name2_first,l.name3_first,l.name4_first);
	self.name.middle := choose(c,l.name1_middle,l.name2_middle,l.name3_middle,l.name4_middle);
	self.name.last := choose(c,l.name1_last,l.name2_last,l.name3_last,l.name4_last);
	self.name.suffix := choose(c,l.name1_suffix,l.name2_suffix,l.name3_suffix,l.name4_suffix);
	self.name.prefix := choose(c,l.name1_prefix,l.name2_prefix,l.name3_prefix,l.name4_prefix);
	self.name.full:='';
	self.companyname := choose(c,l.name1_company,l.name2_company,l.name3_company,l.name4_company);
	self.ssn := choose(c,l.name1_ssn,l.name2_ssn,l.name3_ssn,l.name4_ssn);
	self.UniqueId := choose(c,l.name1_did,l.name2_did,l.name3_did,l.name4_did);
end;

out_names := normalize(out_f_seq, 4, norm_names(left, counter));

out_names_fltd := out_names(name.first<>'' or name.last<>'' or ssn<>'' or companyname<>'');
out_names_srt := dedup(sort(out_names_fltd,rec_seq,companyname, name.first, name.last),rec_seq,companyname, name.first, name.last);
out_names_dep_tmp:=project(sort(out_names_srt,rec_order),out_name_seq_rec);

// suppression and masking: [defendants] only; [plaintiffs] is a free-flow text.
Suppress.MAC_Suppress(out_names_dep_tmp,suppress_did,in_mod.application_type,Suppress.Constants.LinkTypes.DID,uniqueid);
Suppress.MAC_Suppress(suppress_did,suppress_ssn,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,ssn);
suppress.MAC_Mask(suppress_ssn, out_names_dep, ssn, blank, true, false,,,,in_mod.ssn_mask);
	
out_slim_seq_rec get_plaintiffs(out_slim_seq_w_tzone l, out_plaintiffs_dep r) := transform
	self.plaintiffs := l.plaintiffs + dataset([{r.value}],
	                                            iesp.share.t_StringArrayItem);
	self := l;
	
end;

out_with_palintiffs := denormalize(out_slim_seq_w_tzone, out_plaintiffs_dep,
                                   left.rec_seq = right.rec_seq,
							get_plaintiffs(left, right));


out_slim_seq_rec get_defendants(out_with_palintiffs l, out_names_dep r) := transform
	self.defendants := l.defendants + dataset([{r.name.full,
									    r.name.first,
									    r.name.middle,
									    r.name.last,
									    r.name.suffix,
									    r.name.prefix,
									    r.ssn,
									    r.companyname,
									    r.uniqueid}],
	                    iesp.foreclosure.t_ForeclosureReportDefendant);
	self := l;								    
end;

out_raw := denormalize(out_with_palintiffs, out_names_dep,
                       left.rec_seq = right.rec_seq,
  				   get_defendants(left, right));

Foreclosure_Services.Layouts.rawrec_plaintiffs_defendants add_county (out_raw le,Census_Data.Key_Fips2County rt):=transform
self.situs1_county_name:=rt.county_name;
self:=le;
end;


out_raw_county_tmp := JOIN (out_raw, Census_Data.Key_Fips2County,
                            KEYED (left.situs1_st = right.state_code) and
                            KEYED (left.situs1_fipscounty = right.county_fips),
                            add_county(LEFT, RIGHT),
                            LIMIT (0), KEEP (1), LEFT OUTER);						 

Foreclosure_Services.Layouts.rawrec_plaintiffs_defendants add_county_2 (out_raw_county_tmp le,Census_Data.Key_Fips2County rt):=transform
self.situs2_county_name:=rt.county_name;
self:=le;
end;


out_raw_county := JOIN (out_raw_county_tmp, Census_Data.Key_Fips2County,
                        KEYED (left.situs2_st = right.state_code) and
                        KEYED (left.situs2_fipscounty = right.county_fips),
                        add_county_2 (LEFT, RIGHT),
                        LIMIT (0), KEEP (1), LEFT OUTER);						 

return out_raw_county;
end;

//*****************************
// Function to check for Data restriction for FARES and BK
//*****************************

export getCodes(boolean includeBlackKnight=false) := function

 ds := {STRING2 code};

	boolean isFRRestricted := doxie.DataRestriction.Fares;
	boolean isBKRestricted := doxie.DataRestriction.BlackKnight or (not includeBlackKnight);

 codeDS := if(isFRRestricted, if(isBKRestricted, DATASET([{''}], ds), DATASET([{MDR.sourceTools.src_BKFS_Reo},{MDR.sourceTools.src_BKFS_Nod}], ds)), 
		                        if(isBKRestricted, DATASET([{MDR.sourceTools.src_Foreclosures}], ds), 
         														         DATASET([{MDR.sourceTools.src_BKFS_Reo},{MDR.sourceTools.src_BKFS_Nod},{MDR.sourceTools.src_Foreclosures}], ds)));
 srcCodeSet := SET(codeDS, code);
				 
	return srcCodeSet;
end;


//**************************************************************//
// Search Function																							//
//**************************************************************//
	export fnForeclosureSearchval(dataset(Foreclosure_services.Layouts.rawrec) in_recs_tmp, params in_mod) := function

		iesp.foreclosure.t_ForeclosureSearchRecord xform(Foreclosure_Services.Layouts.rawrec_plaintiffs_defendants l) := TRANSFORM
			self.ForeclosureId:= l.foreclosure_id;
			//Setting VendorSource to 'A' if source of records is FARES and 'B' for BlackKnight, per requirement, to distinguish between Fares and Blackknight data 
			self.VendorSource:=if(l.source=MDR.sourceTools.src_Foreclosures, Foreclosure_services.Constants('').src_Fares, 
																																																Foreclosure_services.Constants('').src_BlackKnight);
			self.LenderType := l.lender_type;
			self.LenderTypeDescription := l.lender_type_desc;
			self.LoanAmount := l.loan_amount;
			self.LoanType := l.loan_type;
			self.LoanTypeDescription := l.loan_type_desc;
			self.RecordingDate :=iesp.ECL2ESP.toDatestring8(l.recording_date);
			self.SiteAddress :=setAddressFields(l.situs1_prim_name, l.situs1_prim_range, l.situs1_predir, l.situs1_postdir, l.situs1_addr_suffix,
			                              l.situs1_unit_desig,l.situs1_sec_range, l.situs1_p_city_name,l.situs1_v_city_name, '',
																		l.situs1_st, l.situs1_zip, l.situs1_zip4,l.situs1_county_name, ''),
			self.Site2Address :=setAddressFields(l.situs2_prim_name, l.situs2_prim_range, l.situs2_predir, l.situs2_postdir, l.situs2_addr_suffix,
			                              l.situs2_unit_desig,l.situs2_sec_range, l.situs2_p_city_name,l.situs2_v_city_name, '',
																		l.situs2_st, l.situs2_zip, l.situs2_zip4,l.situs2_county_name, ''),
			self.DeedType :=l.deed_desc;
			self.DocumentType :=l.document_desc;
			self.Plaintiffs :=choosen(l.plaintiffs,iesp.Constants.MAX_COUNT_PLAINTIFF);
			self.Defendants :=choosen(project(l.defendants,iesp.foreclosure.t_ForeclosureSearchDefendant),iesp.Constants.MAX_COUNT_DEFENDANT);
			self._penalty  := l.penalt;
			self.AlsoFound := l.isDeepDive;			
			self := [];
			END;
			
			in_recs:=fnAddPlaintiffAndDefendantDS(in_recs_tmp,in_mod);
			 temp_filter_search := project(in_recs,xform(LEFT));
 			 filter := dedup(sort(temp_filter_search,record), record);
	    return(filter);         
	end;
	
	
//**************************************************************//
// Report Function  																						//
//**************************************************************//

export fnforeclosureReportval(dataset(foreclosure_services.Layouts.rawrec) in_recs_tmp, params in_mod) := function
										 
  iesp.foreclosure.t_ForeclosureReportRecord xform(Foreclosure_Services.Layouts.rawrec_plaintiffs_defendants l) := TRANSFORM																								 
	
	self.ForeclosureId:= l.foreclosure_id;
	self.VendorSource:= if(l.source=MDR.sourceTools.src_Foreclosures, Foreclosure_services.Constants('').src_Fares, Foreclosure_services.Constants('').src_BlackKnight);
 self.LenderType := l.lender_type;
	self.LenderTypeDescription := l.lender_type_desc;
	self.LoanAmount := l.loan_amount;
	self.LoanType := l.loan_type;
	self.LoanTypeDescription := l.loan_type_desc;	
	self.CaseNumber :=l.court_case_nbr;
	self.DeedType :=l.deed_desc;
	self.SiteAddress :=setAddressFields(l.situs1_prim_name, l.situs1_prim_range, l.situs1_predir, l.situs1_postdir, l.situs1_addr_suffix,
			                              l.situs1_unit_desig,l.situs1_sec_range, l.situs1_p_city_name,l.situs1_v_city_name, '',
																		l.situs1_st, l.situs1_zip, l.situs1_zip4,l.situs1_county_name, '');
	self.Site2Address :=setAddressFields(l.situs2_prim_name, l.situs2_prim_range, l.situs2_predir, l.situs2_postdir, l.situs2_addr_suffix,
																	  l.situs2_unit_desig,l.situs2_sec_range, l.situs2_p_city_name,l.situs2_v_city_name, '',
																		l.situs2_st, l.situs2_zip, l.situs2_zip4,l.situs2_county_name, '');
	self.FilingDate :=iesp.ECL2ESP.todatestring8(l.filing_date);
	self.RecordingDate :=iesp.ECL2ESP.toDatestring8(l.recording_date);
	self.DocumentType :=l.document_desc;
	self.DocumentYear :=(unsigned) l.document_year;
	self.DocumentNumber :=l.document_nbr;
	self.DocumentBook :=l.document_book;
	self.DocumentPages :=l.document_pages;
	self.DateOfLoanDefault :=iesp.ECL2ESP.toDatestring8(l.date_of_default[1..8]);
	self.AmountOfLoanDefault :=l.amount_of_default;
	self.AuctionDate :=iesp.ECL2ESP.toDatestring8(l.auction_date[1..8]);
	self.AuctionTime :=l.auction_time;
	self.AuctionLocation := iesp.ECL2ESP.setAddress ('', '', '', '', '', '', '',
                                                   L.city_of_auction_call, L.state_of_auction_call, '', '', '', '',
                                                   L.street_address_of_auction_call);
	self.OpeningBid :=l.opening_bid;
	self.FinalJudgmentAmount :=l.final_judgment_amount;
	self.Lender.name :=iesp.ecl2esp.SetNameFields(l.lender_beneficiary_first_name, '', l.lender_beneficiary_last_name, '', '','');
	self.Lender.CompanyName :=l.lender_beneficiary_company_name;
	self.Trustee :=l.trustee_name;
	self.TitleCompany :=l.title_company_name;
	self.Attorney :=l.attorney_name;
	self.AttorneyPhoneNumber :=l.attorney_phone_nbr;
	self.AttorneyTimeZone :='';
	self.SubdivisionName :=l.tract_subdivision_name;
	self.LandUsage :=l.property_desc;
	self.ParcelNumber :=l.parcel_number_parcel_id;
	self.YearBuilt :=(unsigned) l.year_built;
	self.CurrentLandValue :=l.current_land_value;
	self.CurrentImprovementValue :=l.current_improvement_value;
	self.LandSize :=l.lot_size;
	self.LivingSize :=l.living_area_square_feet;
	self.LegalDescription :=l.expanded_legal;
	self.Plaintiffs :=choosen(l.plaintiffs,iesp.Constants.MAX_COUNT_PLAINTIFF);
	self.Defendants :=choosen(l.defendants,iesp.Constants.MAX_COUNT_DEFENDANT);
	self := [];
END;
			
	in_recs:=fnAddPlaintiffAndDefendantDS(in_recs_tmp,in_mod);
	temp_filter_report:=project(in_recs,xform(LEFT));
	filter_report := dedup(sort(temp_filter_report,record), record);
	ut.getTimeZone(filter_report,AttorneyPhoneNumber,AttorneyTimeZone,filter_report_w_tzone)

	return(filter_report_w_tzone);         
	end;	

end;
