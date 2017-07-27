import dnb_feinv2;
import autokeyb2,bankruptcyv2,doxie_raw,doxie_cbrs,autokeyi,AutoStandardI,AutoHeaderI;
doxie_cbrs.mac_Selection_Declare();
export ids(
	dataset(doxie_cbrs.layout_references) in_bdids,
	dataset(dnb_feinv2_services.layout_tmsid_ext) in_tmsids,
	unsigned in_limit,
	boolean in_skip_autokey = false // Param to turn off autokey lookup
	) :=
		// FUNCTION TO RETRIEVE TMSIDS USING BDID
		function
			get_tmsids_from_bdids(
				dataset(dnb_feinv2_services.layout_bdid_ext) in_bdids,
				unsigned in_limit = 0) :=
					function
						// MAKE SURE WE DON'T RETRIEVE BDIDS OVER AND OVER AGAIN
						bdids_deduped :=
							sort(
								dedup(sort(in_bdids(bdid != 0),bdid,if(isdeepdive,1,0)),bdid),
								if(isdeepdive,1,0),bdid);
						// BOUNCE AGAINST THE BDID KEY
						res :=
							join(
								bdids_deduped,
								dnb_feinv2.key_DNB_Fein_BDID,
								keyed(left.bdid = right.p_bdid),
								transform(dnb_feinv2_services.layout_tmsid_ext,self := right,self := left),
								keep(1000));
						// DEDUP THE TMSID RESULTS
						ded :=
							sort(
								dedup(sort(res,tmsid,if(isdeepdive,1,0)),tmsid),
								if(isdeepdive,1,0),tmsid);
						return
							if(in_limit = 0,ded,choosen(ded,in_limit));
			end;
			
			outrec := layout_tmsid_ext;
			
			// RETRIEVE TMSIDS, BDIDS VIA AUTOKEY
			tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
				export string autokey_keyname_root := dnb_feinv2.cluster + 'key::Dnbfein::autokey::';
				export string typestr := 'AK';
				export set of string1 get_skip_set :=['C'];
				export boolean workHard := false;
				export boolean noFail := false;
				export boolean useAllLookups := true;
			end;
			ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

			// Autokey
			AutokeyB2.mac_get_payload_ids (ids, dnb_feinv2.cluster + 'key::Dnbfein::autokey::', DNB_FEINv2.file_SearchAutokey, outpl, zero, intbdid, 'BC', , newdids, newbdids, olddids, oldbdids, tmsid, blank)
			by_auto := IF(~in_skip_autokey,project(outpl, transform(outrec,self.isdeepdive := false,self := left)));

			// NEW vs OLD: probably old is not required anymore, which would make the code much easier to read,
			// for now I keep this portion untouched.
			abdids := if(not nodeepdive,
				project(oldbdids,transform(layout_bdid_ext,self.isdeepdive := false,self := left)) +
				project(newbdids,transform(layout_bdid_ext,self.isdeepdive := true,self := left)));

			// LOOK UP BDIDS IN THE BUSINESS HEADER
			bdids := AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt));

			// USE BUSINESS HEADER BDIDS TO GET TMSIDS
			by_bdid	:= if(not nodeepdive,
				get_tmsids_from_bdids(project(
					bdids,
					transform(dnb_feinv2_services.layout_bdid_ext,
						self.isdeepdive := true,
						self := left))));
						
			// SELECT WHICH TMSIDS TO USE
			// IF A SET OF BDIDS OR TMSIDS EXIST, USE THOSE
			// OTHERWISE, USE AUTOKEY AND BUSINESS HEADER IDS
			msids :=
				map(
					exists(in_bdids(bdid != 0)) =>
						get_tmsids_from_bdids(project(in_bdids,transform(layout_bdid_ext,self.isdeepdive:=false,self:=left)),in_limit),
					exists(in_tmsids(tmsid != '')) =>
					  // Revised/added 2 lines below for use by TopBusiness_Services.DNBFeinSource_Records
						if(in_limit=0,choosen(in_tmsids,ALL),
						              choosen(in_tmsids,in_limit)),
					bdid_value != 0 =>
						get_tmsids_from_bdids(dataset([{bdid_value,false}],layout_bdid_ext)),
					tmsid_value != '' =>
						dataset([{tmsid_value,false}],layout_tmsid_ext),
				project(by_auto,layout_tmsid_ext) +
				get_tmsids_from_bdids(project(abdids,layout_bdid_ext)) +
				by_bdid);
			// DEDUP THE TMSIDS
			tmsids_raw := dedup(sort(msids,tmsid,if(isDeepDive,1,0)),tmsid);

			return tmsids_raw;
		end;
