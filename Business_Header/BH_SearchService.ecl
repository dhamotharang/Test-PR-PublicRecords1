/*--SOAP--
<message name="BH_SearchService">
	<part name="CompanyName" type="xsd:string"/>
	<part name="ExactOnly" 	type="xsd:boolean"/>
	<part name="FirstName"	type="xsd:string"/>
	<part name="MiddleName"	type="xsd:string"/>
	<part name="LastName"	type="xsd:string"/>
	<part name="Addr" 		type="xsd:string"/>
	<part name="City" 		type="xsd:string"/>
	<part name="State" 		type="xsd:string"/>
	<part name="Zip" 		type="xsd:string"/>
	<part name="MileRadius" 	type="xsd:unsignedInt"/>
	<part name="SSN"		type="xsd:string"/>
	<part name="Phone" 		type="xsd:string"/>
	<part name="FEIN" 		type="xsd:string"/>
	<part name="BDID" 		type="xsd:string"/>
	<part name="BDIDOnly" 	type="xsd:boolean"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="BusinessSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="GLBPurpose" type="xsd:byte"/>
 </message>
*/
/*--INFO-- This service searches the business header file.*/

IMPORT WSInput, STD, doxie, AutoStandardI, Suppress;

EXPORT BH_SearchService() := MACRO
		
		//The following macro defines the field sequence on WsECL page of query.
		WSInput.MAC_BH_SearchService();
		
		rec_in := iesp.business.t_BusinessSearchRequest;
		ds_in := DATASET ([], rec_in) : STORED ('BusinessSearchRequest', FEW);
		first_row := ds_in[1] : independent;

		//set options
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);


		//set search criteria from XML blob
		search_by := global (first_row.SearchBy);		
		iesp.ECL2ESP.SetInputName (search_by.Name);
		iesp.ECL2ESP.SetInputAddress (search_by.Address);
		#stored ('CompanyName', search_by.CompanyName);		
		#stored ('Phone', search_by.PhoneNumber);		
		#stored ('FEIN', search_by.FEIN);		
		#stored ('SSN', search_by.SSN);		
		#stored ('MileRadius', search_by.Radius);

		options := global (first_row.Options);
		#stored ('IncludeAllContacts', options.IncludeAllContacts);

		boolean IncludeAllContacts := false : stored('IncludeAllContacts');

		Business_Header.doxie_MAC_Field_Declare()
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

		slimrec := record
			unsigned6	bdid;
			unsigned4	seq;
			unsigned1	score;
		END;

		// standard get_bdids
		gbdp := if (company_name_value != '' or phone_value != '' or
					fein_value != 0 or pname_value != '', Business_Header.doxie_get_bdids_plus()(score > 10), dataset([],slimrec));


		// by contact
		// bycontact := if (lname_value != '' or ssn_value != '',
										 // business_header.fetch_bc(bdid_value,(unsigned6)did_value,ssn_value,fname_value,mname_value,lname_value,prange_value,pname_value,city_value,state_value,zip_val,company_name_value,glb_ok,dppa_ok,nicknames,phonetics), 
										 // dataset([],business_header.Layout_Business_Contact_full));
		bycontact := business_header.Fetch_BC_State_LFName(state_value, fname_value, lname_value, nicknames, phonetics and lname_value<>'')(from_hdr = 'N' and (not mdr.sourcetools.SourceIsEBR(source)/* or not doxie.DataRestriction.EBR*/)) + 
								 business_header.Fetch_BC_SSN((unsigned)ssn_value)(from_hdr = 'N' and (not mdr.sourcetools.SourceIsEBR(source)/* or not doxie.DataRestriction.EBR*/));

		slimrec into_bdid(bycontact L) := TRANSFORM
			self.seq := 0;
			self.score := 100; // there is a very thorough filter 
								// on fetch_bc already.
			self.bdid := L.bdid;
		END;

		bcbd := project(bycontact,into_bdid(LEFT));

		// by supplied BDID

		bdv := Business_Header.stored_bdid_val;

		bd := dataset([{(integer)bdv,0,100}],slimrec);

		// add em together and dedup em.

		fr_noseq := dedup(sort(gbdp + bcbd + bd,bdid),bdid);

		slimrec re_seq(fr_noseq L, integer C) := TRANSFORM
			self.seq := C;
			self := L;
		END;

		filtered_res := project(fr_noseq(bdid != 0),re_seq(LEFT,COUNTER));

		res_ded := dedup(sort(filtered_res(bdid != 0),bdid,seq),bdid);

		layout_svc := RECORD
			Business_Header_SS.Layout_BDID_InBatch;
			UNSIGNED6 temp_id;
			UNSIGNED1 score := 0;
			UNSIGNED6 bdid;
		END;

		// Add the entered value back on so that we can filter on them
		layout_svc Format(res_ded l) := TRANSFORM
			self.temp_id := 1;
			self.company_name := company_name_value;
			self.prim_range := prange_value;
			self.prim_name := pname_value;
			self.predir := predir_value;
			self.postdir := postdir_value;
			self.addr_suffix := addr_suffix_value;
			self.sec_range := sec_range_value;
			self.p_city_name := city_value;//moved that logic into mac_filter
			self.st := state_value;
			self.z5 := zip_val;//moved that logic into mac_filter
			self.phone10 := phone_value;
			self.fein := if(fein_value = 0,'',intformat(fein_value,9,1));
			self := l; // BDID + seq
		END;

		infile := project(res_ded, Format(left));

		Business_Header_SS.MAC_Filter_Matches(
			infile,
			best_j_initial,
			true
		)

		Business_Header.layout_biz_search.result_with_input_and_dt_first_seen AdjPen(best_j_initial l) := TRANSFORM
			self.bdid := l.bdid;
			self.seq := l.seq;
			self.score := (l.score +
			100 - ut.CompanySimilar100(company_name_value, l.pl.company_name)
			) / 2;
			self.input_company_name_value := STD.Str.ToUpperCase(company_name_val);
			self.input_city_value := STD.Str.ToUpperCase(city_val);
			self.input_state_value := STD.Str.ToUpperCase(state_val);
			self.input_zip_value := STD.Str.ToUpperCase(zip_val);
			self.input_mile_radius_value := mile_radius_value;
			self := l.pl;
			self := [];
		END;

		best_j_without_tz_or_verified := project(best_j_initial(bdid != 0),
						AdjPen(left));

		best_j_dedup_score := rollup(sort(best_j_without_tz_or_verified,bdid,-score,record),
			TRANSFORM(recordof(best_j_without_tz_or_verified),
				self.dt_last_seen := if(right.dt_last_seen > left.dt_last_seen,right.dt_last_seen,left.dt_last_seen),
				self.dt_first_seen := if(right.dt_first_seen != 0 AND (right.dt_first_seen < left.dt_first_seen), right.dt_first_seen, left.dt_first_seen),
				self.fein := if(left.fein = 0,right.fein,left.fein),
				self.phone := if(left.phone = 0,right.phone,left.phone),
				self := left),bdid);

		best_j_with_string_phone := project(best_j_dedup_score,TRANSFORM({Business_Header.layout_biz_search.result_with_input_and_dt_first_seen - [phone];string10 phone;},
			self.phone := if(left.phone = 0, '', intformat(left.phone,10,1)),
			self := left));

		ut.getTimeZone(best_j_with_string_phone,phone,timezone,best_j_without_verified);

		append_gong_in := project(best_j_without_verified(phone != ''),TRANSFORM(doxie.Layout_Append_Gong_Biz.Layout_In,
			self.__seq := left.seq,
			self.phone := left.phone,
			self.company_names := dataset([{left.company_name}],{string120 company_name})));

		append_gong_out := doxie.Append_Gong_Biz(append_gong_in);

		best_j := join(best_j_without_verified,append_gong_out,left.seq = right.__seq and left.phone = right.phone,TRANSFORM(Business_Header.layout_biz_search.result_with_input_and_dt_first_seen,
			self.verified := right.verified,
			self.phone := (unsigned6)left.phone,
			self := left),left outer);
			
		grpkb := Business_Header.Key_BH_SuperGroup_BDID;

		Business_Header.layout_biz_search.result_with_input_and_dt_first_seen AddGroup(Business_Header.layout_biz_search.result_with_input_and_dt_first_seen l, grpkb r) := TRANSFORM
			self.group_id := r.group_id;
			self := l;
		END;
		 
		best_group := join(best_j,
											 grpkb,
											 keyed (left.bdid = right.bdid),
											 AddGroup(left, right),
											 keep (1), limit (0));

		remove_blank_addresses := best_group(
			prim_range != '' or predir != '' or prim_name != '' or addr_suffix != '' or
				postdir != '' or unit_desig != '' or sec_range != '' or city != '' or
				state != '' or zip != 0 or zip4 != 0);
    // temporary record for supressions
    temp_f_suppress := RECORD
       business_header.Layout_Business_Contact_full;
       unsigned4 	global_sid := 0;
	     unsigned8 	record_sid := 0;
    end;

		by_contact_for_include_all_pre := dedup(sort(if (IncludeAllContacts,join(dedup(sort(remove_blank_addresses,bdid),bdid),business_header.Key_Business_Contacts_BDID,
			left.bdid = right.bdid and
			(~right.glb OR glb_ok),
			TRANSFORM(temp_f_suppress,
			self := right),limit(10000,skip))),ssn,lname,fname,mname,name_suffix,title,company_title),ssn,lname,fname,mname,name_suffix,title,company_title);
      
    by_contact_for_include_all := project(Suppress.MAC_SuppressSource(by_contact_for_include_all_pre, mod_access),
                                          business_header.Layout_Business_Contact_full);    
    
		join_to_contacts := join(remove_blank_addresses(~exact_only or ut.CleanCompany(company_name) = ut.CleanCompany(company_name_value) or (bdv != '' and bdid = (integer)bdv)), if(lname_value != '' or ssn_value != '',bycontact,by_contact_for_include_all),
			left.bdid = right.bdid,
			TRANSFORM(Business_Header.layout_biz_search.result_with_input_and_dt_first_seen,
			self.ssn := right.ssn,
			self.fname := right.fname,
			self.mname := right.mname,
			self.lname := right.lname,
			self.name_suffix := right.name_suffix,
			self.title := right.title,
			self.company_title := right.company_title,
			self := left),left outer);

		best_sorted := sort(join_to_contacts, -score, ut.StringSimilar100(company_name_value,company_name), -best_flags, company_name, bdid);

		// ESDL Layout
			recs_fmt := Business_header.fn_transformSearchServiceIntoEsdlLayout(best_sorted);
			Suppress.MAC_Mask(recs_fmt,recs_fmt1,ssn,'',true,false,maskVal:=ssn_mask_value);
			tempresults := choosen(project(recs_fmt1, iesp.business.t_BusinessRecord),iesp.constants.MAX_COUNT_SEARCH_RESPONSE_RECORDS); 
			iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, results, iesp.business.t_BusinessSearchResponse);

		// MAP( bdid_only and (company_name_value != ''or phone_value != '' or fein_value != 0) => output(business_header.doxie_get_bdids()),
				 output(results,named('Results'))
			 // )
	 
ENDMACRO;