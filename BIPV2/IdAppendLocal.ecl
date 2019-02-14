import BIPV2;
import BIPV2_Best;
import BIPV2_Company_Names;

export IdAppendLocal := module

	export AppendBest(dataset(BIPV2.IdAppendLayouts.IdsOnly) withAppend, string fetchLevel,
	                  boolean allBest, boolean isMarketing = false) := function
		isSeleBest := fetchLevel = BIPV2.IdConstants.fetch_level_seleid;
		preBest :=
			project(withAppend(proxid != 0 or (isSeleBest and seleid != 0)),
				transform(BIPV2.IdLayouts.l_xlink_ids2,
					self.uniqueid := left.request_id,
					self := left));

		withBest0 := if(isMarketing, BIPV2_Best.Key_linkIds.kfetch2Marketing(preBest, fetchlevel),
		                BIPV2_Best.Key_LinkIds.kfetch2(preBest, fetchLevel));
		withBest := dedup(withBest0, seleid, proxid, uniqueid, all);

		postBest := 
			join(withAppend, withBest(allBest or (isSeleBest and proxid = 0) or (not isSeleBest and proxid != 0)),
				left.request_id = right.uniqueid
					and (right.proxid = 0 or left.proxid = right.proxid or allBest),
				transform(BIPV2.IDAppendLayouts.svcAppendOut,
					hasMatch := right.proxid != 0 or right.seleid != 0;
					sameProx := left.proxid = right.proxid or (not allBest and isSeleBest);
					self.proxid := if(sameProx or not hasMatch, left.proxid, right.proxid),
					self.proxscore := if(sameProx, left.proxscore, 0);
					self.proxweight := if(sameProx, left.proxweight, 0);
					self.company_name := right.company_name[1].company_name,
					self.prim_range := right.company_address[1].company_prim_range,
					self.predir := right.company_address[1].company_predir,
					self.prim_name := right.company_address[1].company_prim_name,
					self.addr_suffix := right.company_address[1].company_addr_suffix,
					self.postdir := right.company_address[1].company_postdir,
					self.unit_desig := right.company_address[1].company_unit_desig,
					self.sec_range := right.company_address[1].company_sec_range,
					self.p_city_name := right.company_address[1].company_p_city_name,
					self.v_city_name := right.company_address[1].address_v_city_name,
					self.st := right.company_address[1].company_st,
					self.zip := right.company_address[1].company_zip5,
					self.zip4 := right.company_address[1].company_zip4,
					self.company_phone := right.company_phone[1].company_phone,
					self.company_fein := right.company_fein[1].company_fein,
					self.company_url := right.company_url[1].company_url,
					self.company_incorporation_date := right.company_incorporation_date[1].company_incorporation_date,
					self.duns_number := right.duns_number[1].duns_number,
					self.company_sic_code1 := right.sic_code[1].company_sic_code1,
					self.company_naics_code1 := right.naics_code[1].company_naics_code1,
// get new best fields for dba_name, contact_fname, contact_mname, contact_lname, contact_job_title, contact_did
					self.dba_name := '',
					self.company_btype := '',
					self.contact_fname := '',
					self.contact_mname := '',
					self.contact_lname := '',
					self.contact_job_title := '',
					self.contact_did := 0,
					self := left,
					self := right),
				left outer);

		BIPV2_Company_Names.functions.mac_go(postBest, outBtype, request_id, company_name);
		withBType :=
			join(postBest, outBtype,
				left.request_id = right.request_id,
				transform(recordof(left),
					self.company_btype := right.cnp_btype,
					self := left),
				keep(1), left outer);

		return withBType;

	end;

	export FetchRecords(dataset(BIPV2.IdAppendLayouts.IdsOnly) withAppend,
	                    string fetchLevel = BIPV2.IdConstants.fetch_level_proxid,
	                    boolean dnbFullRemove = false) := function

		isProxLevel := fetchlevel = BIPV2.IdConstants.fetch_level_proxid;

		preHeaderFetch := 
			project(withAppend(proxid != 0 or (seleid != 0 and not isProxLevel)),
				transform(BIPV2.IdLayouts.l_xlink_ids2,
					self.uniqueid := left.request_id,
					self := left));
		headerFetch := BIPV2.Key_BH_Linking_Ids.kfetch2(preHeaderFetch, level := fetchLevel, dnbFullRemove := dnbFullRemove);
			
		postHeader := 
			join(withAppend, headerFetch,
				left.request_id = right.uniqueid,
				transform(BIPV2.IdAppendLayouts.svcAppendRecsOut,
					self.proxid := if(right.proxid != 0, right.proxid, left.proxid);
					self.proxScore := if(isProxLevel or left.proxid = right.proxid, left.proxScore, 0),
					self.proxWeight := if(isProxLevel or left.proxid = right.proxid, left.proxWeight, 0),
					self.powid := if(right.powid != 0, right.powid, left.powid);
					self.powScore := if(isProxLevel or left.powid = right.powid, left.powScore, 0),
					self.powWeight := if(isProxLevel or left.powid = right.powid, left.powWeight, 0),
					self := left,
					self := right),
				left outer);

		return postHeader;

	end;

end;