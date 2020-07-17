/*--LIBRARY--*/
// This library performs business fetches.
// All logic for performing the fetch should be based here.
import business_header_ss,AutoStandardI,ut,doxie,business_header,doxie_cbrs,mdr,_Control;
#if(not _Control.LibraryUse.ForceOff_AutoHeaderI__LIB_FetchI_Hdr_Biz)
	export LIB_FetchI_Hdr_Biz(LIBIN.FetchI_Hdr_Biz.full args) := MODULE,LIBRARY(LIBOUT.FetchI_Hdr_Biz)
#else
	export LIB_FetchI_Hdr_Biz(LIBIN.FetchI_Hdr_Biz.full args) := MODULE/*,LIBRARY*/(LIBOUT.FetchI_Hdr_Biz(args))
#end
	shared string30 temp_fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(args,AutoStandardI.InterfaceTranslator.fname_value.params));
	shared boolean temp_nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(args,AutoStandardI.InterfaceTranslator.nicknames.params));
	shared string30 temp_mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(project(args,AutoStandardI.InterfaceTranslator.mname_value.params));
	shared string30 temp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(args,AutoStandardI.InterfaceTranslator.lname_value.params));
	shared boolean temp_phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(args,AutoStandardI.InterfaceTranslator.phonetics.params));
	shared string120 temp_company_name_value := AutoStandardI.InterfaceTranslator.company_name_value.val(project(args,AutoStandardI.InterfaceTranslator.company_name_value.params));
	shared string temp_prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(args,AutoStandardI.InterfaceTranslator.prange_value.params));
	shared string2 temp_predir_value := AutoStandardI.InterfaceTranslator.predir_value.val(project(args,AutoStandardI.InterfaceTranslator.predir_value.params));
	shared string temp_pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(args,AutoStandardI.InterfaceTranslator.pname_value.params));
	shared string4 temp_addr_suffix_value := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(project(args,AutoStandardI.InterfaceTranslator.addr_suffix_value.params));
	shared string2 temp_postdir_value := AutoStandardI.InterfaceTranslator.postdir_value.val(project(args,AutoStandardI.InterfaceTranslator.postdir_value.params));
	shared string temp_sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(args,AutoStandardI.InterfaceTranslator.sec_range_value.params));
	shared string temp_city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(args,AutoStandardI.InterfaceTranslator.city_value.params));
	shared string temp_state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(args,AutoStandardI.InterfaceTranslator.state_value.params));
	shared string5 temp_zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(args,AutoStandardI.InterfaceTranslator.zip_val.params));
	shared string10 temp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(args,AutoStandardI.InterfaceTranslator.phone_value.params));
	shared unsigned4 temp_fein_value := AutoStandardI.InterfaceTranslator.fein_value.val(project(args,AutoStandardI.InterfaceTranslator.fein_value.params));
	shared temp_ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(args,AutoStandardI.InterfaceTranslator.ssn_value.params));
	shared temp_non_exclusion_value := AutoStandardI.InterfaceTranslator.non_exclusion_value.val(project(args,AutoStandardI.InterfaceTranslator.non_exclusion_value.params));

	// REPLACES Business_Header.doxie_get_bdids_plus... SHOULD BE ROLLED UP ASAP
	export DATASET({unsigned6 BDID;unsigned4 seq;unsigned1 score}) do_plus := function

		exec_matchable := args.use_exec_search and (trim(temp_lname_value) <> '' or (unsigned)temp_ssn_value <> 0);
		
		it := AutoStandardI.InterfaceTranslator;
		
		ds_input := dataset([transform(Layouts.Fetch_Hdr_Batch_Biz_Layout,
			self.acctno := '',
			self.nofail := args.nofail,
			self.SearchIgnoresAddressOnly_value := it.SearchIgnoresAddressOnly_value.val(project(args,it.SearchIgnoresAddressOnly_value.params)),
			self.pname_value                    := it.pname_value                   .val(project(args,it.pname_value                   .params)),
			self.prange_value                   := it.prange_value                  .val(project(args,it.prange_value                  .params)),
			self.sec_range_value                := it.sec_range_value               .val(project(args,it.sec_range_value               .params)),
			self.addr_loose                     := it.addr_loose                    .val(project(args,it.addr_loose                    .params)),
			self.city_value                     := it.city_value                    .val(project(args,it.city_value                    .params)),
			self.state_value                    := it.state_value                   .val(project(args,it.state_value                   .params)),
			self.zip_value                      := it.zip_value                     .val(project(args,it.zip_value                     .params)),
			self.company_name_value             := it.company_name_value            .val(project(args,it.company_name_value            .params)),
			self.fein_value                     := it.fein_value                    .val(project(args,it.fein_value                    .params)),
			self.bdid_value                     := it.bdid_value                    .val(project(args,it.bdid_value                    .params)),
			self.phone_value                    := it.phone_value                   .val(project(args,it.phone_value                   .params)),
			self.addr_error_value               := it.addr_error_value              .val(project(args,it.addr_error_value              .params)),
			self.any_addr_error_value           := it.any_addr_error_value          .val(project(args,it.any_addr_error_value          .params)),
			self.allow_wild_match_value         := args.fuzziness_dial > 2,
			self.allow_indic_match_value        := args.fuzziness_dial > 1,
			self.allow_close_match_value        := args.fuzziness_dial > 0,
			self.phone_mandatory_match          := args.phone_mandatory_match,
			self.fein_mandatory_match           := args.fein_mandatory_match
			)]);                                                                                      
		
		ds_output := FetchI_Hdr_Batch_Biz(ds_input);
		
		res_trad_only := if(
			exists(ds_output(errcode != Types.ErrCode.NONE)),
			FAIL(doxie_cbrs.layout_references,ds_output(errcode != Types.ErrCode.NONE)[1].errcode,doxie.ErrorCodes(ds_output(errcode != Types.ErrCode.NONE)[1].errcode)),
			project(ds_output(id != 0),transform(doxie_cbrs.layout_references,
				self.bdid := left.id)));

		res_exec_only :=
		business_header.Fetch_BC_State_LFName(temp_state_value, temp_fname_value, temp_lname_value, temp_nicknames, temp_phonetics and temp_lname_value<>'')(from_hdr = 'N' and (not mdr.sourcetools.SourceIsEBR(source) or not doxie.DataRestriction.EBR)) + 
		business_header.Fetch_BC_SSN((unsigned)temp_ssn_value)(from_hdr = 'N' and (not mdr.sourcetools.SourceIsEBR(source) or not doxie.DataRestriction.EBR));

		res_exec_filt_only := res_exec_only(temp_mname_value = '' or temp_non_exclusion_value or mname = temp_mname_value);

		recordof(res_trad_only) project_executives(res_exec_filt_only L) := transform
			self.bdid := L.bdid;
		end;

		res_executives := project(res_exec_filt_only,project_executives(left));

		temp_res :=
			res_trad_only +
			if(exec_matchable,res_executives);
					 
		res_ded_0 := dedup(sort(temp_res, bdid), bdid);

		res_ded := if(args.nofail,
		limit(res_ded_0(true),args.bdid_limit,skip),
		limit(res_ded_0(true),args.bdid_limit,fail(203,doxie.errorcodes(203))));

		layout_svc := RECORD
			Business_Header_SS.Layout_BDID_InBatch;
			UNSIGNED6 temp_id;
			UNSIGNED1 score := 0;
			UNSIGNED6 bdid;
		END;

		// Add the entered value back on so that we can filter on them
		layout_svc Format(res_ded l) := transform
			self.seq := 0;
			self.temp_id := 1;
			self.company_name := temp_company_name_value;
			self.prim_range := temp_prange_value;
			self.prim_name := temp_pname_value;
			self.predir := temp_predir_value;
			self.postdir := temp_postdir_value;
			self.addr_suffix := temp_addr_suffix_value;
			self.sec_range := temp_sec_range_value;
			self.p_city_name := temp_city_value;//moved that logic into mac_filter
			self.st := temp_state_value;
			self.z5 := temp_zip_val;//moved that logic into mac_filter
			self.phone10 := temp_phone_value;
			self.fein := if(temp_fein_value = 0,'',intformat(temp_fein_value,9,1));
			self := l; // BDID
		end;

		infile := project(res_ded, Format(left));
		
		mile_radius_value := it.mile_radius_value.val(project(args,it.mile_radius_value.params));
		bh_zip_value := it.bh_zip_value.val(project(args,it.bh_zip_value.params));
		
		Business_Header_SS.MAC_Filter_Matches(
			infile,
			filtered_res0
		);
			
		filtered_res1 := if(args.score_results,filtered_res0,infile(bdid>0));

		//slim down to the necessities
		outrec := record
			filtered_res1.BDID;
			filtered_res1.seq;
			filtered_res1.score;
		end;

		slim_res := table(filtered_res1, outrec);

		filtered_res := DEDUP(SORT(slim_res, bdid, -score), bdid);

		outres := project(filtered_res,{unsigned6 BDID;unsigned4 seq;unsigned1 score});	
		
		return outres;
	end;
	// REPLACES DOXIE_RAW.GET_BDIDS... USE THIS AS MAIN WHENEVER POSSIBLE.
	export DATASET(doxie.layout_ref_bdid) do := function
		return project(table(do_plus,{bdid}),doxie.layout_ref_bdid);
	end;
END;