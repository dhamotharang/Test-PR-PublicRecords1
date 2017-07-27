Import DEATH_MI,BatchServices,Autokey_batch,AutokeyB2,Codes;
EXPORT Customer_Death_Search_Records := module
	Shared myLayouts := Healthcare_Services.Customer_Death_Search_Layouts;
	Shared myConst := Healthcare_Services.Customer_Death_Search_Constants;

	//Verify Company #
	Export verify_Company (string companyid):= function
		doLookup := Codes.Key_Codes_V3(file_name = Customer_Death_Search_Constants.CUST_DEATH_CODESV3_FILENAME and field_name = Customer_Death_Search_Constants.CUST_DEATH_CODESV3_FIELDNAME);
		filterLookup := doLookup(code = companyid);
		validCompany := exists(filterLookup);//Verify only valid State requesting information
		return validcompany;
	end;
	//Search By License or License+State
	Export get_recs_by_SSN (dataset(myLayouts.autokeyInput) input):= function
		return dedup(sort(join(input, DEATH_MI.Keys().SSNCustID.qa,
																	 Keyed(left.ssn=right.ssn) and 
																	 (integer)left.CustomerID=right.customer_id,
																	 transform(myLayouts.LayoutOutput,self.acctno:=left.acctno; self:=right),
																	 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record);
	end;
	//Search by standard autokeys
	Export get_recs_by_ak (dataset(myLayouts.autokeyInput) input):= function
		ak_config := MODULE(BatchServices.Interfaces.i_AK_Config)
				export UseAllLookUps := TRUE;
				export skip_set := DEATH_MI._Constants().AUTOKEY_SKIP_SET;
		END;
			
		//**** GET FAKEIDS - FLAPD SEARCH
		ak_key := DEATH_MI._Constants().ak_qa_keyname;
		ak_in := PROJECT(input,transform(Autokey_batch.Layouts.rec_inBatchMaster,self.ssn:=left.ssn[1..4];self:=left));
		ak_out := Autokey_batch.get_fids(ak_in, ak_key, ak_config);
		out_rec := dataset([],myLayouts.akLayoutOutput);
		typ_str := DEATH_MI._Constants().TYPE_STR;
		AutokeyB2.mac_get_payload(ak_out,ak_key,out_rec,autokeysResults,did,did,typ_str);

		results:=dedup(sort(autokeysResults,record),record);
		//Very important that we do not show one customer another customers data...
		results_remove_restricted:=join(results,input,
																		left.acctno=right.acctno and left.customer_id=(integer)right.CustomerID,
																		transform(myLayouts.LayoutOutput,self:=left),
																		keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		//Very important that we do not show one customer another customers data...
		return results_remove_restricted;
	end;
	
	myLayouts.LayoutOutput setMatchFlags(myLayouts.autokeyInput inRecs, myLayouts.LayoutOutput rawRecs) := Transform
		//Clean name and dob string before compare.
		isSSN4Match	:= inRecs.SSN = rawRecs.SSN and inRecs.SSN <> '';
		isFirstMatch := inRecs.name_first = rawRecs.FName;
		isFirstCharacterMatch := inRecs.name_first[1] = rawRecs.FName[1];
		isLastMatch := inRecs.name_last = rawRecs.LName;
		isDOBMatch := inRecs.DOB = rawRecs.DOB;//
		matchPercent := map(isSSN4Match and isFirstMatch and isLastMatch and isDOBMatch => '100',
												isSSN4Match and isFirstCharacterMatch and isLastMatch and isDOBMatch => '95',
												isSSN4Match and isLastMatch and isDOBMatch => '90',
												isSSN4Match and isFirstMatch => '80',
												// isFirstMatch and isLastMatch and isDOBMatch => '75',
												// isFirstMatch and isLastMatch => '70',
												// isLastMatch => '50',
												'0');
		self.MatchPercent := matchPercent;
		self.isFirstNameMatch := isFirstMatch;
		self.isLastNameMatch := isLastMatch;
		self.isDOBMatch := isDOBMatch;
		self := rawRecs;
	end;

	Export SetFlags(dataset(myLayouts.autokeyInput) inRecs, dataset(myLayouts.LayoutOutput) rawRecs) := function
		ds_join := join(inRecs,rawRecs,left.acctno=right.acctno,setMatchFlags(left,right),
										keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		return ds_join;
	end;

	Export Records(dataset(myLayouts.autokeyInput) inRecsRaw) := function
		inRecs := project(inRecsRaw,transform(myLayouts.autokeyInput,
																				self.name_first:=stringlib.StringToUpperCase(left.name_first);
																				self.name_middle:=stringlib.StringToUpperCase(left.name_middle);
																				self.name_last:=stringlib.StringToUpperCase(left.name_last);
																				self.ssn := map(length(trim(left.ssn,all))=4 => left.ssn,
																												length(trim(left.ssn,all))=9 => left.ssn[6..9],
																												left.ssn[1..4]);
																				self:=left));
		//Query the data and get back the results.
		bySSN := get_recs_by_SSN(inRecs(ssn<>'' and ssn<>'0000'));
		fmtSSNResults := SetFlags(inRecs,bySSN)((integer)matchPercent>0);
		//Blank the ssn as it was not found by it any way
		// getRestByAK := join(inRecs,fmtSSNResults,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self.ssn := '';self := left),left only);
		// byAk := get_recs_by_ak(getRestByAK(name_last<>''));
		// fmtAKResults := SetFlags(inRecs,byAk)((integer)matchPercent>0);
		//Blank the dob in case it is bad as Autokieys will use it and filter out good results.
		// getLastResortByAK := join(inRecs,fmtSSNResults+fmtAKResults,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self.ssn := '';self.dob := '';self := left),left only);
		// byLastResortAk := get_recs_by_ak(getLastResortByAK(name_last<>''));
		// fmtLastResortAKResults := SetFlags(inRecs,byLastResortAk)((integer)matchPercent>0);
		// fmtSearchResults := fmtSSNResults+fmtAKResults+fmtLastResortAKResults;
		fmtSearchResults := fmtSSNResults;//+fmtAKResults+fmtLastResortAKResults;
		final := sort(dedup(sort(fmtSearchResults,acctno,-(integer)MatchPercent),all),acctno,-(integer)MatchPercent);
		// output(inRecs,named('inRecs'));
		// output(bySSN,named('bySSN'));
		// output(fmtSSNResults,named('fmtSSNResults'));
		// output(getRestByAK,named('getRestByAK'));
		// output(byAk,named('byAk'));
		// output(fmtAKResults,named('fmtAKResults'));
		// output(getLastResortByAK,named('getLastResortByAK'));
		// output(byLastResortAk,named('byLastResortAk'));
		// output(fmtLastResortAKResults,named('fmtLastResortAKResults'));
		// output(fmtSearchResults,named('fmtSearchResults'));
		// output(final,named('final'));
		return final;
	End;
	Export RecordsBatch(dataset(myLayouts.autokeyInput) inRecsRaw) := function
		recs:=Records(inRecsRaw);
		final:=project(recs,transform(myLayouts.LayoutOutputBatch,
													self.customer_id := (string)left.customer_id;
													self.dt_vendor_first_reported:= (string)left.dt_vendor_first_reported;
													self.dt_vendor_last_reported:= (string)left.dt_vendor_last_reported;
													self.raw_aid:= (string)left.raw_aid;
													self.ace_aid:= (string)left.ace_aid;
													self.did:= (string)left.did;
													self.bdid:= (string)left.bdid;
													self.clean_prim_range:=left.clean_address.prim_range;
													self.clean_predir:=left.clean_address.predir;
													self.clean_prim_name:=left.clean_address.prim_name;
													self.clean_addr_suffix:=left.clean_address.addr_suffix;
													self.clean_postdir:=left.clean_address.postdir;
													self.clean_unit_desig:=left.clean_address.unit_desig;
													self.clean_sec_range:=left.clean_address.sec_range;
													self.clean_p_city_name:=left.clean_address.p_city_name;
													self.clean_v_city_name:=left.clean_address.v_city_name;
													self.clean_st:=left.clean_address.st;
													self.clean_zip:=left.clean_address.zip;
													self.clean_zip4:=left.clean_address.zip4;
													self.clean_cart:=left.clean_address.cart;
													self.clean_cr_sort_sz:=left.clean_address.cr_sort_sz;
													self.clean_lot:=left.clean_address.lot;
													self.clean_lot_order:=left.clean_address.lot_order;
													self.clean_dbpc:=left.clean_address.dbpc;
													self.clean_chk_digit:=left.clean_address.chk_digit;
													self.clean_rec_type:=left.clean_address.rec_type;
													self.clean_fips_state:=left.clean_address.fips_state;
													self.clean_fips_county:=left.clean_address.fips_county;
													self.clean_geo_lat:=left.clean_address.geo_lat;
													self.clean_geo_long:=left.clean_address.geo_long;
													self.clean_msa:=left.clean_address.msa;
													self.clean_geo_blk:=left.clean_address.geo_blk;
													self.clean_geo_match:=left.clean_address.geo_match;
													self.clean_err_stat:=left.clean_address.err_stat;
													self.clean_title:=left.clean_name.title;
													self.clean_fname:=left.clean_name.fname;
													self.clean_mname:=left.clean_name.mname;
													self.clean_lname:=left.clean_name.lname;
													self.clean_name_suffix:=left.clean_name.name_suffix;
													self.clean_name_score:=left.clean_name.name_score;
													self.MatchPercent := (string)left.MatchPercent;
													self.isFirstNameMatch := if(left.isFirstNameMatch,'TRUE','FALSE');
													self.isLastNameMatch := if(left.isLastNameMatch,'TRUE','FALSE');
													self.isDOBMatch := if(left.isDOBMatch,'TRUE','FALSE');
													self := left;));
		return final;
	End;

end;
