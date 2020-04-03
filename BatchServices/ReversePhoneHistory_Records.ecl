import doxie,dx_Gong,Census_Data,ut,suppress;
export ReversePhoneHistory_Records(
  dataset(BatchServices.Layouts.ReversePhoneHistory.batch_in_cleaned) batch_in,
  BatchServices.Interfaces.reversephonehistory_config in_mod,
  Doxie.IDataAccess mod_access
) := FUNCTION
	Batchin			:= BatchServices.Layouts.ReversePhoneHistory.batch_in_cleaned;
	Batchout		:= BatchServices.Layouts.ReversePhoneHistory.batch_out;
	GongRecs		:= dx_Gong.key_history_phone();
	GongDIDRecs	:= dx_Gong.key_history_did();
	GongBDIDRecs:= dx_Gong.key_history_bdid();
	Census			:= Census_Data.Key_Fips2County;

  batchout_optout := RECORD
    batchout;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;

	doCommonProject() := macro
			self.acctno:=l.acctno;
			self.seq:=0;
			self.errormsg:='';
			self.timezone:= '';

			self.iscurrent:=r.current_record_flag;
			self.did:=r.did;
			self.bdid:=r.bdid;
			self.phone:=r.phone10;
			self.listed_name:=r.listed_name;
			self.title:=r.name_prefix;
			self.name_first:=r.name_first;
			self.name_middle:=r.name_middle;
			self.name_last:=r.name_last;
			self.name_suffix:=r.name_suffix;
			self.prim_range:=r.prim_range;
			self.predir:=r.predir;
			self.prim_name:=r.prim_name;
			self.addr_suffix:=r.suffix;
			self.postdir:=r.postdir;
			self.unit_desig:=r.unit_desig;
			self.sec_range:=r.sec_range;
			self.p_city_name:=r.p_city_name;
			self.st:=r.st;
			self.z5:=r.z5;
			self.zip4:=r.z4;
			self.county_name:=r.county_code;
			self.date_first_seen:=r.dt_first_seen;
			self.date_last_seen:=r.dt_last_seen;
			self.listing_type:=if(r.listing_type_bus <>'',r.listing_type_bus,if(r.listing_type_res <>'',r.listing_type_res,if(r.listing_type_gov <>'',r.listing_type_gov,'')));
			self.publish_code:=r.publish_code;
			self.omit_address:=r.omit_address;
			self.omit_phone:=r.omit_phone;
			self.omit_locality:=r.omit_locality;
			self.record_sid:=r.record_sid;
			self.global_sid:=r.global_sid;
	endmacro;

	batchout_optout doPhoneProject10 (Batchin l, GongRecs r) := TRANSFORM
		doCommonProject();
		self.search_type:='T';
	END;

	batchout_optout doPhoneProject7 (Batchin l, GongRecs r) := TRANSFORM
		doCommonProject();
		self.search_type:='S';
	END;

	batchout_optout doPhoneProjectDID (Batchin l, GongDIDRecs r) := TRANSFORM
		doCommonProject();
		self.search_type:='D';
	END;

	batchout_optout doPhoneProjectBDID (Batchin l, GongBDIDRecs r) := TRANSFORM
		doCommonProject();
		self.search_type:='B';
	END;

	//Break up records for processing
	fullPhones := batch_in(phone7<>'' and phone3<>'');
	unusedPhones := join(batch_in,fullPhones, left.acctno=right.acctno,left only);
	partialPhones := unusedPhones(phone7<>'' and st<>'');
	didPhones := batch_in(did <> 0);
	bdidPhones := batch_in(bdid <> 0);
	errorCriteria := join(batch_in,fullPhones+partialPhones+didPhones+bdidPhones, left.acctno=right.acctno,left only);

	//get records by 10 digit phone
	phones_by_10digit := join(fullPhones,GongRecs,
													keyed(left.phone7 = right.p7) and
												  keyed(left.phone3 = right.p3),
													doPhoneProject10(LEFT,right),
												  limit(count(fullPhones) * BatchServices.Constants.ReversePhoneHistory.MAX_SEARCH_RESULTS_PER_ACCT),
													left outer);

	//get records by 7 digit phone and state
	phones_by_7digit := join(partialPhones,GongRecs,
													keyed(left.phone7 = right.p7) and
												  left.st = right.st,
													doPhoneProject7(LEFT,right),
												  limit(count(partialPhones)*BatchServices.Constants.ReversePhoneHistory.MAX_SEARCH_RESULTS_PER_ACCT),
													left outer);

	//get records by DID
	phones_by_did := join(didPhones,GongDIDRecs,
													keyed(left.did = right.l_did),
													doPhoneProjectDID(LEFT,right),
												  limit(count(didPhones)*BatchServices.Constants.ReversePhoneHistory.MAX_SEARCH_RESULTS_PER_ACCT),
													left outer);
	//get records by BDID
	phones_by_bdid := join(bdidPhones,GongBDIDRecs,
													keyed(left.bdid = right.bdid),
													doPhoneProjectBDID(LEFT,right),
												  limit(count(bdidPhones)*BatchServices.Constants.ReversePhoneHistory.MAX_SEARCH_RESULTS_PER_ACCT),
													left outer);

  //Combine all records for a single Opt Out suppression call.
  combined_raw := phones_by_10digit + phones_by_7digit + phones_by_did + phones_by_bdid;
  combined_optout_flagged := Suppress.MAC_FlagSuppressedSource(combined_raw, mod_access);

  combined := PROJECT(combined_optout_flagged,
    TRANSFORM(batchout,
      self.acctno:= LEFT.acctno,
      self.seq:= LEFT.seq,
      self.errormsg:= LEFT.errormsg,
      self.timezone:= LEFT.timezone,
      self.search_type:= LEFT.search_type,
      self := if(not LEFT.is_suppressed, LEFT)));

  combined_final := group(sort(combined, acctno, phone, did, bdid, -date_last_seen, -iscurrent),
    acctno, phone, did, bdid);

	//Format bad criteria records
	badCriteriaRecords:=project(errorCriteria, transform(Batchout,self.acctno:=left.acctno,self.errormsg:='Bad Criteria',self:=[]));
	//Rollup Transform
	Batchout doRollup(Batchout l, DATASET(Batchout) allRows) := TRANSFORM
		self.acctno:=l.acctno;
		self.seq:=0;
		self.errormsg:='';
		self.iscurrent:=l.iscurrent;
		self.did:=l.did;
		self.bdid:=l.bdid;
		self.phone:=l.phone;
	  self.listed_name:=l.listed_name;
		self.title:=l.title;
	  self.name_first:=l.name_first;
		self.name_middle:=l.name_middle;
		self.name_last:=l.name_last;
		self.name_suffix:=l.name_suffix;
		self.prim_range:=l.prim_range;
		self.predir:=l.predir;
		self.prim_name:=l.prim_name;
		self.addr_suffix:=l.addr_suffix;
		self.postdir:=l.postdir;
		self.unit_desig:=l.unit_desig;
		self.sec_range:=l.sec_range;
		self.p_city_name:=l.p_city_name;
		self.st:=l.st;
		self.z5:=l.z5;
		self.zip4:=l.zip4;
		self.county_name:=l.county_name;
		self.date_first_seen:=sort(allRows(acctno=l.acctno and did=l.did),date_first_seen)[1].date_first_seen;
		self.date_last_seen:=sort(allRows(acctno=l.acctno and did=l.did),-date_last_seen)[1].date_last_seen;
		self.listing_type:=l.listing_type;
		self.publish_code:=l.publish_code;
		self.omit_address:=l.omit_address;
		self.omit_phone:=l.omit_phone;
		self.omit_locality:=l.omit_locality;
		self.search_type:=l.search_type;
	END;
	//Rollup the records and sequence them
	resultsRolled := ROLLUP(combined_final(phone <> ''), GROUP, doRollup(LEFT, ROWS(LEFT)));
	// pull any DIDed records as necessary
  Suppress.MAC_Suppress(resultsRolled,resultsCleanDID,in_mod.applicationType,Suppress.Constants.LinkTypes.DID,did);
	// pull any BDIDed records as necessary
  Suppress.MAC_Suppress(resultsCleanDID,resultsClean,in_mod.applicationType,Suppress.Constants.LinkTypes.BDID,bdid);
	//For Appending County
	Batchout doCountyName(Batchout l, Census r) := TRANSFORM
		SELF.county_name := if (l.county_name <> '', r.county_name, '');
		SELF := l;
	END;
	//Update county information and sequence
	results_county := JOIN(resultsClean,Census,
								KEYED(LEFT.st = RIGHT.state_code and
								LEFT.county_name[3..5] = RIGHT.county_fips),
								doCountyName(LEFT,RIGHT), LEFT OUTER, KEEP (1));
	//Update Timezone
	ut.getTimeZone(results_county,phone,timezone,results);
	//Join back in the bad records
	resultsSorted := sort(results+badCriteriaRecords,acctno,phone,-date_last_seen,-iscurrent);
	//Apply limits based on acct no and phone so if we have 7 digit + state we get a max per area code and phone
	Batchout doSeqLimit(Batchout l, integer c):=transform
		self.seq:=if(c > in_mod.MaxRecordsPerPhone,skip,c);
		self := l;
	end;

	resultsSeqLimit := Project(group(resultsSorted,acctno,phone),doSeqLimit(left,counter));

	Batchout -search_type doFinalSeq(Batchout l, integer c):=transform
		self.seq:=c;
		self := l;
	end;

	//Re sequence the records so that 7 digit + state records do not have sequences that restart
	resultsFinal := Project(group(resultsSeqLimit,acctno),doFinalSeq(left,counter));

	return resultsFinal;
end;
