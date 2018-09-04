
//MATCHSET should be set of char1's indicating matchfields
/*	'A' = Address
	'F' = FEIN
	'P'	= phone
		* company name will always be part of the match if any of
		  the above flags are set.
	'N' = Allow match on company name only.
*/

import business_header, BIPV2;

EXPORT MAC_Match_Flex
(
	 infile
	,matchset
	,company_name_field
	,prange_field
	,pname_field
	,zip_field
	,srange_field
	,state_field
	,phone_field
	,fein_field
	,BDID_field
	,outrec
	,bool_outrec_has_score
	,BDID_Score_field				//these should default to zero in definition
	,outfile
	,keep_count							= '1'
	,score_threshold				= '75'
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,pURL										=	''
	,pEmail									=	''
	,pCity									= ''	
	,pContact_fname					= ''
	,pContact_mname					= ''
	,pContact_lname					= ''
  ,contact_ssn					  = ''
  ,source					        = ''
  ,source_record_id				= ''
  ,src_matching_is_priority	= FALSE
) :=
MACRO

import BIPV2,did_add;

#uniquename(outfilebdid)	
#if(BIPV2.IDconstants.xlink_version_BDID in pSetLinkingVersions)

	#uniquename(pBHFile						)
	#uniquename(pBHBFile					)
	#uniquename(pCnameAddressBase	)
	#uniquename(pCnameFeinBase		)
	#uniquename(pCnamePhoneBase		)
	#uniquename(pCnameBase				)
	// All files used by this macro + the files used by the macros that it calls
	%pBHFile%								:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_headers.logical			;
	%pBHBFile%							:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_Header_Best.logical	;
	%pCnameAddressBase%			:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameAddress.logical		;
	%pCnameFeinBase%				:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameFein.logical			;
	%pCnamePhoneBase%				:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNamePhone.logical			;
	%pCnameBase%						:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.CompanyName.logical					;

	#uniquename(id_layout)
	#uniquename(bdid_score)
	#uniquename(name_similar_score)
	%id_layout% := RECORD
		UNSIGNED6 temp_id := 0;
		UNSIGNED2 %bdid_score% := 0;
		UNSIGNED2 %name_similar_score% := 0;
		outrec;
	END;

	#uniquename(make_id_layout)
	%id_layout% %make_id_layout%(infile l) := TRANSFORM
		SELF := l;
	END;

	#uniquename(infile_id_layout)
	%infile_id_layout% := PROJECT(infile, %make_id_layout%(LEFT));

	#uniquename(infile_seq)
	ut.MAC_Sequence_Records(%infile_id_layout%, temp_id, %infile_seq%)
	
	//for thor route - decide whether a record is matchable
	//SRC MATCH FILTER ISSUE:
	//	when using bip mode, we are now passing already BDID'D (think src matching) records thru this macro (to pick up BIP IDS), so we have to route them around the BDID process
	#uniquename(matchable)
	%matchable% := %infile_seq%.company_name_field <> '' AND
		StringLib.StringFilter(%infile_seq%.company_name_field, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890') <> ''
		#if(BIPV2.IDconstants.xlink_version_BIP in pSetLinkingVersions or BIPV2.IDconstants.xlink_version_BIP_dev in pSetLinkingVersions)
			and (unsigned6)%infile_seq%.BDID_field = 0
		#end;
		;

	#uniquename(infile_matchable)
	%infile_matchable% := %infile_seq%(%matchable%);

	#uniquename(infile_nonmatchable)
	%infile_nonmatchable% := %infile_seq%(~(%matchable%));

	#uniquename(infile_dist)
	%infile_dist% := DISTRIBUTE(%infile_matchable%, HASH(
	#if('A' in matchset)
		(QSTRING28) pname_field, (UNSIGNED3) zip_field, (STRING2) state_field,
	#end
	#if('P' in matchset)
		(UNSIGNED6) phone_field,
	#end
	#if('F' in matchset)
		(UNSIGNED4) fein_field,
	#end
		company_name_field));

	#uniquename(infile_sort)
	%infile_sort% := SORT(%infile_dist%,
	#if('A' in matchset)
		zip_field, pname_field, prange_field,
		srange_field, state_field,
	#end
	#if('P' in matchset)
		phone_field,
	#end
	#if('F' in matchset)
		fein_field,
	#end
		company_name_field, LOCAL);

	#uniquename(infile_group)
	%infile_group% := GROUP(%infile_sort%,
	#if('A' in matchset)
		zip_field, pname_field, prange_field,
		srange_field, state_field,
	#end
	#if('P' in matchset)
		phone_field,
	#end
	#if('F' in matchset)
		fein_field,
	#end
		company_name_field, LOCAL);

	#uniquename(assign_group_id)
	%id_layout% %assign_group_id%(%id_layout% l, %id_layout% r) := TRANSFORM
		SELF.temp_id := IF (l.temp_id = 0, r.temp_id, l.temp_id);
		SELF := r;
	END;

	// This is what the BDIDs will be assigned back on.
	// Note that it's still grouped.
	#uniquename(infile_groupid_assigned)
	%infile_groupid_assigned% := ITERATE(
		%infile_group%, %assign_group_id%(LEFT, RIGHT));

	#uniquename(infile_id_distinct)
	%infile_id_distinct% := DEDUP(%infile_groupid_assigned%, temp_id);

	// Slim down the id'd, grouped infile records.
	// Keep all fields from the infile, regardless of
	// the match types requested so we can filter later.
	#uniquename(infile_slim_layout)
	%infile_slim_layout% := RECORD
		%infile_id_distinct%.temp_id;
		%infile_id_distinct%.BDID_field;
		%infile_id_distinct%.%bdid_score%;
		%infile_id_distinct%.%name_similar_score%;
		%infile_id_distinct%.company_name_field; 
	#if('F' in matchset)
		%infile_id_distinct%.fein_field; 
	#end
	#if('A' in matchset)
		%infile_id_distinct%.prange_field;
		%infile_id_distinct%.pname_field;
		%infile_id_distinct%.srange_field;
		%infile_id_distinct%.state_field;
		%infile_id_distinct%.zip_field;
	#end
	#if('P' in matchset)
		%infile_id_distinct%.phone_field;
	#end
	END;

	#uniquename(infile_slim)
	%infile_slim% := TABLE(%infile_id_distinct%, %infile_slim_layout%);

	#uniquename(match_address)
	#uniquename(match_address_partial)
	#uniquename(match_companyname_addr)
	#uniquename(match_phone)
	#uniquename(match_fein)
	#uniquename(match_name_only)
	#uniquename(match_full)

	#if('A' in matchset)
	#uniquename(pre_match_address)
	Business_Header_SS.MAC_Match_CompanyName_Address(
								 %infile_slim%
								,%pre_match_address%
								,matchset
								,BDID_field
								,%bdid_score%
								,%name_similar_score%
								,company_name_field
								,prange_field
								,pname_field
								,srange_field
								,state_field
								,zip_field
								,phone_field
								,fein_field
								,keep_count
								,pFileVersion					
								,pUseOtherEnvironment
	//							,%pCnameAddressBase%
	//							,%pCnameFeinBase%		
	//							,%pCnamePhoneBase%		
								)
								
	%match_companyname_addr% := %pre_match_address%(bdid_field <> 0 AND %bdid_score% >= score_threshold);

	#uniquename(match_address_init)
	%match_address_init% := project(%pre_match_address%(bdid_field = 0 OR %bdid_score% < score_threshold),
																	transform(%infile_slim_layout%, self.BDID_Field := 0, self.%bdid_score% := 0,
													self.%name_similar_score% := 0, self := left));

	#uniquename(match_address_select)
	typeof(%match_address_init%) %match_address_select%(%match_companyname_addr% l, %match_address_init% r) := transform
	self := r;
	end;

	// Only include temp_ids not already matched within threshold
	%match_address% := join(%match_companyname_addr%,
													%match_address_init%,
							left.temp_id = right.temp_id,
							%match_address_select%(left, right),
							right only,
							local);
													
	#else
	// Null companyname_addr set
	%match_companyname_addr% := %infile_slim%;
	%match_address%:= %infile_slim%;
	#end

	#if('A' in matchset)
	#uniquename(pre_match_address_partial)
	Business_Header_SS.MAC_Match_CompanyName_Address_Partial(
								 %match_address%
								,%pre_match_address_partial%
								,BDID_field
								,%bdid_score%
								,%name_similar_score%
								,company_name_field
								,prange_field
								,pname_field
								,srange_field
								,state_field
								,zip_field
								,keep_count
								,pFileVersion					
								,pUseOtherEnvironment
	//							,%pCnameAddressBase%
								)
								
	Business_Header_SS.MAC_Dedup_BDID_TEMPID(
				%pre_match_address_partial%, %match_address_partial%, 
				BDID_Field, %bdid_score%, %name_similar_score%)
	#else
	%match_address_partial% := %match_address%;
	#end


	#if('F' in matchset)
	#uniquename(pre_match_fein)
	Business_Header_SS.MAC_Match_CompanyName_FEIN(
								 %match_address_partial%
								,%pre_match_fein%
								,BDID_field
								,%bdid_score%
								,%name_similar_score%
								,company_name_field
								,fein_field
								,pFileVersion					
								,pUseOtherEnvironment
	//							,%pCnameFeinBase%
								)

	Business_Header_SS.MAC_Dedup_BDID_TEMPID(
				%pre_match_fein%, %match_fein%, 
				BDID_Field, %bdid_score%, %name_similar_score%)

	#else
	%match_fein% := %match_address%;
	#end

	#if('P' in matchset)
	#uniquename(pre_match_phone)
	Business_Header_SS.MAC_Match_CompanyName_Phone(
								 %match_fein%
								,%pre_match_phone%
								,BDID_field
								,%bdid_score%
								,%name_similar_score%
								,company_name_field
								,phone_field
								,pFileVersion					
								,pUseOtherEnvironment
	//							,%pCnamePhoneBase%
								)

	Business_Header_SS.MAC_Dedup_BDID_TEMPID(
				%pre_match_phone%, %match_phone%, 
				BDID_Field, %bdid_score%, %name_similar_score%)

	#else
	%match_phone% := %match_fein%;
	#end

	#if('N' in matchset)
	Business_Header_SS.MAC_Match_CompanyName(
								 %match_phone%
								,%match_name_only%
								,BDID_field
								,%bdid_score%
								,%name_similar_score%
								,company_name_field
								,pFileVersion					
								,pUseOtherEnvironment
	//							,%pCnameBase%
								)

	%match_full% := %match_name_only%;
	#else
	%match_full% := %match_phone%;
	#end

	#uniquename(match_all_dist)
	%match_all_dist% := DISTRIBUTE(%match_full%, HASH(temp_id));

	#uniquename(match_all_tempid_bdid)
	Business_Header_SS.MAC_Dedup_BDID_TEMPID(
				%match_all_dist%, %match_all_tempid_bdid%, 
				BDID_Field, %bdid_score%, %name_similar_score%)

	#uniquename(bhb)
	%bhb% := %pBHBFile%;
								
	#uniquename(match_full_best_layout)
	#uniquename(best_prim_range)
	#uniquename(best_prim_name)
	#uniquename(best_zip)
	#uniquename(best_city)
	#uniquename(best_state)
	%match_full_best_layout% := record
	%match_all_tempid_bdid%;
	qstring10 %best_prim_range%;
	qstring28 %best_prim_name%;
	unsigned3 %best_zip%;
	qstring25 %best_city% := '';
	string2   %best_state% := '';
	end;

	#uniquename(AppendBestAddr)
	%match_full_best_layout% %AppendBestAddr%(%bhb% l, %match_all_tempid_bdid% r) := transform
	self.%best_prim_range% := l.prim_range;
	self.%best_prim_name% := l.prim_name;
	self.%best_zip% := l.zip;
	self.%best_city% := l.city;
	self.%best_state% := l.state;
	self := r;
	end;

	#uniquename(match_full_best)
	%match_full_best% := join(%bhb%,
														%match_all_tempid_bdid%,
						 left.bdid = (unsigned6)right.BDID_field,
						 %AppendBestAddr%(left, right),
						 right outer,
						 hash);

	#uniquename(match_full_best_dist)
	%match_full_best_dist% := DISTRIBUTE(%match_full_best%, HASH(temp_id));

	// Make sure that the same BDID doesn't appear multiple times
	// for any temp id.  The company name match is not local, so 
	// we need the above distribute before doing this for the
	// last time.

	#uniquename(match_all_sort)
	// Note the BDID picked when the bdid_score and name_similar_score are equal can
	// be improved by picking a BDID with a non-blank, non-PO BOX address
	%match_all_sort% := SORT(%match_full_best_dist%, 
		temp_id, -%bdid_score%, -%name_similar_score%,
						 map(%best_zip% <> 0 and %best_prim_name% <> '' and %best_prim_range% <> '' => 0,  // prefer full address (can't be a PO Box)
							%best_zip% <> 0 and %best_prim_name% <> '' and %best_prim_name%[1..6] <> 'PO BOX' => 1, // allows RR but not PO BOX
					 %best_prim_name% <> '' and %best_prim_range% <> '' and %best_city% <> '' and %best_state% <> '' => 2,  // full address with city, state
					 %best_prim_name% <> '' and %best_prim_name%[1..6] <> 'PO BOX' and %best_city% <> '' and %best_state% <> '' => 3, // allows RR but not PO BOX
										%best_zip% <> 0 and %best_prim_name% <> '' => 4, // Allow PO BOX at this point
					 %best_zip% <> 0 => 5, // Anything with a zip
					 %best_city% <> '' and %best_state% <> '' => 6, // Anything with a city and state
					 7),
					BDID_field, LOCAL);
					
	#uniquename(match_all_dedup)
	%match_all_dedup% := DEDUP(%match_all_sort%, temp_id, KEEP(keep_count), LOCAL);

	#uniquename(match_all_dedup_slim)
	%match_all_dedup_slim% := project(%match_all_dedup%,
																		transform(%infile_slim_layout%, self := left));

	#uniquename(match_all_combined)
	%match_all_combined% := %match_all_dedup_slim% + %match_companyname_addr%;

	// Put the BDIDs and scores on the original dataset
	#uniquename(assign_bdid)
	%id_layout% %assign_bdid%(%id_layout% l, %infile_slim_layout% r) := TRANSFORM
		SELF.BDID_field := if((r.%bdid_score% > 0 or keep_count >= 50) and r.%bdid_score% >= score_threshold, r.BDID_field, 0);
		SELF.%bdid_score% := if(r.%bdid_score% >= score_threshold, r.%bdid_score%, 0);
		SELF := l;
	END;

	#uniquename(bdids_assigned)
	%bdids_assigned% := JOIN(
		DISTRIBUTE(GROUP(%infile_groupid_assigned%), HASH(temp_id)),
		%match_all_combined%, 
		LEFT.temp_id = RIGHT.temp_id,
		%assign_bdid%(LEFT, RIGHT), LOCAL);

	// Format the output as requested
	#uniquename(format_result)
	outrec %format_result%(%id_layout% l) := TRANSFORM
	#if(bool_outrec_has_score)
		SELF.BDID_score_field := l.%bdid_score%;
	#end
		SELF := l;
	END;


	#uniquename(outthor)
	%outthor% := PROJECT(%bdids_assigned% + %infile_nonmatchable%, 
				%format_result%(LEFT));
				
	//*********************
	//****** 		ROXIE route
	//*********************

	#uniquename(roxprep)
	business_header_ss.Layout_BDID_InBatch %roxprep%(%infile_seq% l) := transform
		#if('F' in matchset)
			self.fein := (qSTRING9)l.fein_field;
		#else
			self.fein := '';
		#end
		#if('A' in matchset)
			self.prim_range := (qSTRING10)l.prange_field;
			self.prim_name := (qSTRING28)l.pname_field;
			self.sec_range := (qSTRING8)l.srange_field; 
			self.z5 := (qSTRING5)l.zip_field;
			self.st := (qSTRING2)l.state_field;
		#else
			self.prim_range := '';
			self.prim_name := '';
			self.sec_range := '';
			self.z5 := '';
			self.st := '';
		#end
		#if('P' in matchset)
			self.phone10 := (qstring10)l.phone_field;
		#else
			self.phone10 := '';
		#end
		self.seq := l.temp_id;
		self.company_name := (qstring120)l.company_name_field;
	end;

	//see SRC MATCH FILTER ISSUE comment above
	//here we address the roxie records on their way to roxie
	#uniquename(roxin)
	%roxin% := distribute(project(%infile_seq%
	#if(BIPV2.IDconstants.xlink_version_BIP in pSetLinkingVersions or BIPV2.IDconstants.xlink_version_BIP_dev in pSetLinkingVersions)
				(bdid_field = 0)
	#end
	, %roxprep%(left)),hash(random()));

	#uniquename(roxout)
	business_header.mac_BDID_Roxie(%roxin%, %roxout%)

	//** Reappend the full rec
	#uniquename(postrox)
	typeof(%infile_seq%) %postrox%(%infile_seq% l, %roxout% r) := transform
		self.bdid_field := r.bdid;
		self.%bdid_score% := r.score;
		self := l;
	end;


	#uniquename(roxplus)
	%roxplus% := join(%infile_seq%, %roxout%,
					left.temp_id = right.seq,
					%postrox%(left, right), 
					hash,local)
					;
// output(%infile_seq%, named('infile_seq'));
// output(%roxplus%, named('roxplus'));
	#uniquename(strip_id_roxie)
	outrec %strip_id_roxie%(%roxplus% L) := transform
		self.bdid_field := if(L.%bdid_score% >= score_threshold, L.bdid_field, 0);
		#if(bool_outrec_has_score)
			SELF.BDID_score_field := if(L.%bdid_score% >= score_threshold, l.%bdid_score%, 0);
		#end
		self := L;
	end;

	//see SRC MATCH FILTER ISSUE comment above
	//here we address the roxie records on their way back from roxie
	#uniquename(outrox)
	%outrox% := project(%roxplus%,%strip_id_roxie%(LEFT))
	#if(BIPV2.IDconstants.xlink_version_BIP in pSetLinkingVersions or BIPV2.IDconstants.xlink_version_BIP_dev in pSetLinkingVersions)
		+ project(%infile_seq%(bdid_field > 0), outrec);
	#end
	;
	// output(%outrox%, named('outrox'));

	//****** Pick which route to go
	#uniquename(force)
	string4 %force% := '' : stored('did_add_force');

	#uniquename(preclean)

	/*
	outfile := if((%force% = 'thor' or (count(infile) > 5000000 and %force% <> 'roxi')) and thorlib.nodes() >= 400,
								%outthor%,
								%outrox%);*/
	%outfilebdid% := IF(%force% = 'thor' OR thorlib.nodes() >= 400,
								%outthor%,
								%outrox%);

	// output(%force% = 'thor' OR thorlib.nodes() >= 400, named('isThor'));

#else
	%outfilebdid% := infile;
#end


#if(BIPV2.IDconstants.xlink_version_BIP in pSetLinkingVersions or BIPV2.IDconstants.xlink_version_BIP_dev in pSetLinkingVersions)


/*
//This is the version that should be checked in for the general dataland population for now.	
	outfile := //just a placeholder
	project(
		%outfilebdid%,
		transform(
			outrec,
			BIPV2.IDmacros.mac_SetIDsZero()
			self := left
		)
	);
*/

//This is for BIP2.0 xlink dev for now	
Business_Header_SS.MAC_Match_Flex_V2
(
	 %outfilebdid%
	,matchset
	,company_name_field
	,prange_field
	,pname_field
	,zip_field
	,srange_field
	,state_field
	,phone_field
	,fein_field
	,BDID_field
	,outrec
	,bool_outrec_has_score
	,BDID_Score_field
	,outfile
	,keep_count
	,score_threshold
	,pFileVersion	
	,pUseOtherEnvironment
	,pSetLinkingVersions  //allow this parameter to specify prod or dev bip version
	,pURL
	,pEmail
	,pCity
	,pContact_fname
	,pContact_mname				
	,pContact_lname					
  ,contact_ssn
  ,source
  ,source_record_id
  ,src_matching_is_priority
)	
	
#else
	outfile := %outfilebdid%;
#end



ENDMACRO;

/*
//  SAMPLE CALL
import dnb_dmi, Business_Header, Business_Header_SS, MDR, ut;
// Inputfile := choosen(dnb_dmi.Files(,).base.companies.qa(clean_Address.zip = '33487'),20) : persist('~thor_data400::cemtemp::dmi::33487');//just 20 records or less is fine.  Inline dataset would be great, but a project of a choosen of something available on thor would be fine too
Inputfile := dataset('~thor_data400::cemtemp::dmi::33487', zz_cemtemp.layout_dmi_sample, thor);//just 20 records or less is fine.  Inline dataset would be great, but a project of a choosen of something available on thor would be fine too
BDID_Matchset := ['A','P'];
output(Inputfile, named('Inputfile'));



NEW_outrec 							:= {dnb_dmi.Layouts.Temporary.BdidSlim, BIPV2.IDlayouts.l_xlink_ids};
NEW_SetLinkingVersions 	:= BIPV2.IDconstants.xlink_versions_BDID_BIP;
NEW_SRC_RID_field				:= BIPV2.IDconstants.SRC_RID_field_default;
NEW_Inputfile := 
project(
	Inputfile, 
	transform(
		{Inputfile, BIPV2.IDlayouts.l_xlink_ids}
		,self := left
		,self := []
	)
);



NEW_outrec tSlimForBdiding2(NEW_Inputfile l) :=
transform

	self.unique_id		:= l.rid																;
	self.company_name	:= if(l.rawfields.trade_style = '' or (l.rawfields.trade_style <> '' and l.rawfields.parent_duns_number = '' and l.rawfields.ultimate_duns_number = ''),
														Stringlib.StringToUpperCase(l.rawfields.business_name),
														Stringlib.StringToUpperCase(l.rawfields.trade_style));
	self.prim_range		:= l.Clean_address.prim_range		;
	self.prim_name		:= l.Clean_address.prim_name		;
	self.zip5					:= l.Clean_address.zip					;
	self.sec_range		:= l.Clean_address.sec_range		;
	self.state				:= l.Clean_address.st						;
	self.phone				:= l.rawfields.telephone_number									;
	self.bdid					:= 0																		;
	self.bdid_score		:= 0																		;
	self.source_group := IF(l.active_duns_number = 'Y', l.rawfields.duns_number, 'D' + l.rawfields.duns_number + '-' + stringlib.stringtouppercase(l.rawfields.business_name));
	self.fein					:= '';
	BIPV2.IDmacros.mac_SetIDsZero()
end;   

dSlimForBdiding2 :=  project(NEW_Inputfile,tSlimForBdiding2(left));
output(dSlimForBdiding2, named('dSlimForBdiding2'));

Business_Header_SS.MAC_Add_BDID_Flex(
	 dSlimForBdiding2											// Input Dataset						
	,BDID_Matchset                        // BDID Matchset what fields to match on           
	,company_name	                        // company_name	              
	,prim_range		                        // prim_range		              
	,prim_name		                        // prim_name		              
	,zip5					                        // zip5					              
	,sec_range		                        // sec_range		              
	,state				                        // state				              
	,phone				                        // phone				              
	,fein_not_used                        // fein              
	,bdid													        // bdid												
	,NEW_outrec  													// Output Layout 
	,true                                 // output layout has bdid score field?                       
	,bdid_score                           // bdid_score                 
	,dBdidFlexOut2                         // Output Dataset      
	,1																		//threshold
	,																		
	,
	// ,BIPV2.IDconstants.xlink_versions_BDID_BIP
	// ,[BIPV2.IDconstants.xlink_version_BDID]
	,[BIPV2.IDconstants.xlink_version_BIP]
);   

output(dBdidFlexOut2, named('dBdidFlexOut2'));

*/