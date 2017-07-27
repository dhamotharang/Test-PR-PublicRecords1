import AutoKeyI,AutoStandardI,AutoHeaderI, doxie, _Control, Data_Services;
import autokeyb2,bankruptcyv2,bankruptcyv3,doxie_raw,doxie_cbrs,BIPV2;
doxie_cbrs.mac_Selection_Declare();

// NB: parameter in_mod.skip_ids_search controls whether to fetch IDs by autokeys;
// "nodeepdive" controls whether execute person/business header deep-dive.
// At that point it seems sufficient, but we may want to overwrite "nodeepdive" if skip_ids_search=true in the future.
export bankruptcy_ids(
	dataset(doxie.layout_references) in_dids,
	dataset(doxie_cbrs.layout_references) in_bdids,
	dataset(bankruptcyv2_services.layout_tmsid_ext) in_tmsids,
  dataset(BIPV2.IDlayouts.l_xlink_ids) in_bids,
  string1 bid_fetch_level = BIPV2.IDconstants.Fetch_Level_SELEID,
	unsigned in_limit,
	string1 in_party_type = '',
	boolean isFCRA = false,
	input.params in_mod = module(project(AutoStandardI.GlobalModule(isFCRA),input.params,opt))end
	) :=
		function
      // tmsids from bdid
			get_tmsids_from_bdids(
				dataset(bankruptcyv2_services.layout_bdid_ext) in_bdids,
				unsigned in_limit = 0) :=
					function
						res := join(
							sort(dedup(sort(in_bdids(bdid != 0),bdid,if(isdeepdive,1,0)),bdid),if(isdeepdive,1,0),bdid),
							BankruptcyV3.key_bankruptcyV3_bdid(isFCRA),
							keyed(left.bdid = right.p_bdid) and
							(in_party_type = '' or exists(bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA)((unsigned)bdid=left.bdid	and 
									tmsid = right.tmsid and	name_type[1] = stringlib.stringtouppercase(in_party_type)[1]))),
							transform(bankruptcyv2_services.layout_tmsid_ext,
								self := right,
								self := left),
							limit(20000,skip),
							keep(1000));
						ded := sort(dedup(sort(res,tmsid,if(isdeepdive,1,0)),tmsid),if(isdeepdive,1,0),tmsid);
						return if(in_limit = 0,ded,choosen(ded,in_limit));
					end;
      
      // tmsid from did
			get_tmsids_from_dids(
				dataset(bankruptcyv2_services.layout_did_ext) in_dids,
				unsigned in_limit = 0) :=
					function
						res := join(
							sort(dedup(sort(in_dids(did != 0),did,if(isdeepdive,1,0)),did),if(isdeepdive,1,0),did),
							bankruptcyV3.key_bankruptcyV3_did(isFCRA),
							keyed(left.did = right.did) and
							(in_party_type = '' or exists(bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA)((unsigned)did = left.did and tmsid = right.tmsid and name_type[1] = stringlib.stringtouppercase(in_party_type)[1]))),
							transform(bankruptcyv2_services.layout_tmsid_ext,
								self := right,
								self := left),
							limit(20000,skip),
							keep(1000));
						ded := sort(dedup(sort(res,tmsid,if(isdeepdive,1,0)),tmsid),if(isdeepdive,1,0),tmsid);
						return if(in_limit = 0,ded,choosen(ded,in_limit));
					end;
      
      // tmsids from case number
			get_tmsids_from_casenumbers(
				dataset(bankruptcyv2_services.layout_casenumber_ext) in_casenumbers,
				unsigned in_limit = 0) :=
					function
						res := join(
							sort(dedup(sort(in_casenumbers(orig_case_number != ''),orig_case_number,filing_jurisdiction,if(isdeepdive,1,0)),orig_case_number),if(isdeepdive,1,0),orig_case_number,filing_jurisdiction),
							bankruptcyV3.key_bankruptcyV3_casenumber(isFCRA),
							keyed(left.orig_case_number = right.case_number) and
							keyed(left.filing_jurisdiction = '' or left.filing_jurisdiction = right.filing_state),
							transform(bankruptcyv2_services.layout_tmsid_ext,
								self := right,
								self := left),
							keep(1000));
						ded := sort(dedup(sort(res,tmsid,if(isdeepdive,1,0)),tmsid),if(isdeepdive,1,0),tmsid);
						return if(in_limit = 0,ded,choosen(ded,in_limit));
					end;
      
      // tmsids from business link ids
      get_tmsids_from_bids(dataset(BIPV2.IDlayouts.l_xlink_ids) in_bids,
                           string1 bid_fetch_level,
                           unsigned in_limit = 0) :=
      function        
        res_fetch := BankruptcyV3.key_bankruptcyV3_linkids.kFetch(in_bids,bid_fetch_level);
        
        res := project(res_fetch,transform(bankruptcyv2_services.layout_tmsid_ext,self.isDeepDive := false,self := left));
        
        ded := sort(dedup(sort(res,tmsid,if(isdeepdive,1,0)),tmsid),if(isdeepdive,1,0),tmsid);
        
        return if(in_limit = 0,ded,choosen(ded,in_limit));
      end;
      
			outrec := bankruptcyv2_services.layout_tmsid_ext;	
			ak		 := BankruptcyV2.Constants('', isFCRA);
			tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
				export string autokey_keyname_root := ak.ak_keyname;
				export string typestr := 'AK';
				export set of string1 get_skip_set := [];
				export boolean workHard := true;
				export boolean noFail := false;
				export boolean useAllLookups := true;
				export string1 partytype := in_party_type;
			end;
			
			ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

			// Autokey
			AutokeyB2.mac_get_payload_ids (ids, tempmod.autokey_keyname_root, BankruptcyV2.file_search_autokey(isFCRA), outpl, intDID, intbdid, 'AK', , newdids, newbdids, olddids, oldbdids, tmsid, zero)
			by_auto := if (~in_mod.skip_ids_search, project(outpl, transform(outrec,self.isdeepdive := false,self := left)));

			// NEW vs OLD: probably old is not required anymore, which would make the code much easier to read,
			// for now I keep this portion untouched.

			adids := if(not nodeepdive,
										project(olddids,transform(bankruptcyv2_services.layout_did_ext,self.isdeepdive := false,self := left))
										+	project(newdids,transform(bankruptcyv2_services.layout_did_ext,self.isdeepdive := true,self := left)));
			abdids := if(not nodeepdive,
										project(oldbdids,transform(bankruptcyv2_services.layout_bdid_ext,self.isdeepdive := false,self := left))
										+	project(newbdids,transform(bankruptcyv2_services.layout_bdid_ext,self.isdeepdive := true,self := left)));

			tempbhmod := module(project(AutoStandardI.GlobalModule(isFCRA),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
				export boolean noFail := true;
				export boolean use_exec_search := false;
			end;

			bdids := AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod);

			by_bdid	:= if(not nodeepdive,
										get_tmsids_from_bdids(project(bdids,
																									transform(bankruptcyv2_services.layout_bdid_ext,
																														self.isdeepdive := true,
																														self := left))));		
			noFail := true;
			forceLocal := true;
			tempmod2 := module(project(in_mod,AutoheaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
				export forceLocal := ^.forceLocal;
				export noFail := ^.noFail;
			end;

			dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tempmod2);

			by_did	:= if(not nodeepdive,
										get_tmsids_from_dids(project(dids,
																								 transform(bankruptcyv2_services.layout_did_ext,
																								 self.isdeepdive := true,
																								 self := left))));

			// case number
			ds_cnum := dataset([{CaseNumber_value,State_value,false}], bankruptcyv2_services.layout_casenumber_ext);
			by_cnum := get_tmsids_from_casenumbers(ds_cnum);

			//***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS
			isLRS := false : stored('isLocationReportService');//hacky workaround for bug 25247
			msids :=
				map(
					exists(in_bdids(bdid != 0)) or exists(in_dids(did != 0)) =>
						get_tmsids_from_bdids(project(in_bdids,transform(bankruptcyv2_services.layout_bdid_ext,self.isdeepdive:=false,self:=left)),in_limit) +
						get_tmsids_from_dids(project(in_dids,transform(bankruptcyv2_services.layout_did_ext,self.isdeepdive:=false,self:=left)),in_limit),
					exists(in_tmsids(tmsid != '')) =>
						in_tmsids,
          exists(in_bids) => get_tmsids_from_bids(in_bids,bid_fetch_level),
					bdid_value != 0 =>
						get_tmsids_from_bdids(dataset([{bdid_value,false}],bankruptcyv2_services.layout_bdid_ext)),
					(unsigned)did_value != 0 =>
						get_tmsids_from_dids(dataset([{(unsigned)did_value,false}],bankruptcyv2_services.layout_did_ext)),
					tmsid_value != '' =>
						dataset([{tmsid_value,false}],bankruptcyv2_services.layout_tmsid_ext),
					isCRS or isLRS => dataset([],bankruptcyv2_services.layout_tmsid_ext),
				project(by_auto,bankruptcyv2_services.layout_tmsid_ext) 
					+
					get_tmsids_from_bdids(project(abdids,bankruptcyv2_services.layout_bdid_ext)) +
					by_bdid +
					get_tmsids_from_dids(project(adids,bankruptcyv2_services.layout_did_ext)) +
					by_did +
					by_cnum
				);

			tmsids_raw := dedup(sort(msids,tmsid,if(isDeepDive,1,0)),tmsid);

			return tmsids_raw;
end;
