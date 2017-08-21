import strata;
export Strata (string version):= function
ptucs_base := transunion_ptrak.File_Transunion_DID_Out;
rPopulationStats_tucs
 :=
  record
	  string3  grouping                                   := 'ALL';
    CountGroup:= count(group);
		dt_first_seen_CountNonBlank:= sum(group,if(ptucs_base.dt_first_seen<>0,1,0));
		dt_last_seen_CountNonBlank:= sum(group,if(ptucs_base.dt_last_seen<>0,1,0));
		filetype_CountNonBlank:= sum(group,if(ptucs_base.filetype<>'',1,0));
		filedate_CountNonBlank:= sum(group,if(ptucs_base.filedate<>'',1,0));
		vendordocumentidentifier_CountNonBlank:= sum(group,if(ptucs_base.vendordocumentidentifier<>'',1,0));
		transferdate_CountNonBlank:= sum(group,if(ptucs_base.transferdate<>'',1,0));
		currentname_firstname_CountNonBlank:= sum(group,if(ptucs_base.currentname.firstname<>'',1,0));
		currentname_middlename_CountNonBlank:= sum(group,if(ptucs_base.currentname.middlename<>'',1,0));
		currentname_middleinitial_CountNonBlank:= sum(group,if(ptucs_base.currentname.middleinitial<>'',1,0));
		currentname_lastname_CountNonBlank:= sum(group,if(ptucs_base.currentname.lastname<>'',1,0));
		currentname_suffix_CountNonBlank:= sum(group,if(ptucs_base.currentname.suffix<>'',1,0));
		currentname_gender_CountNonBlank:= sum(group,if(ptucs_base.currentname.gender<>'',1,0));
		currentname_dob_mm_CountNonBlank:= sum(group,if(ptucs_base.currentname.dob_mm<>'',1,0));
		currentname_dob_dd_CountNonBlank:= sum(group,if(ptucs_base.currentname.dob_dd<>'',1,0));
		currentname_dob_yyyy_CountNonBlank:= sum(group,if(ptucs_base.currentname.dob_yyyy<>'',1,0));
		currentname_deathindicator_CountNonBlank:= sum(group,if(ptucs_base.currentname.deathindicator<>'',1,0));
		ssnfull_CountNonBlank:= sum(group,if(ptucs_base.ssnfull<>'',1,0));
		ssnfirst5digit_CountNonBlank:= sum(group,if(ptucs_base.ssnfirst5digit<>'',1,0));
		ssnlast4digit_CountNonBlank:= sum(group,if(ptucs_base.ssnlast4digit<>'',1,0));
		consumerupdatedate_CountNonBlank:= sum(group,if(ptucs_base.consumerupdatedate<>'',1,0));
		dateofdeath_CountNonBlank:= sum(group,if(ptucs_base.DECEASEDDATE<>'',1,0));
		telephonenumber_CountNonBlank:= sum(group,if(ptucs_base.telephonenumber<>'',1,0));
		citedid_CountNonBlank:= sum(group,if(ptucs_base.citedid<>'',1,0));
		fileid_CountNonBlank:= sum(group,if(ptucs_base.fileid<>'',1,0));
		publication_CountNonBlank:= sum(group,if(ptucs_base.publication<>'',1,0));
		currentaddress_address1_CountNonBlank:= sum(group,if(ptucs_base.currentaddress.address1<>'',1,0));
		currentaddress_address2_CountNonBlank:= sum(group,if(ptucs_base.currentaddress.address2<>'',1,0));
		currentaddress_city_CountNonBlank:= sum(group,if(ptucs_base.currentaddress.city<>'',1,0));
		currentaddress_state_CountNonBlank:= sum(group,if(ptucs_base.currentaddress.state<>'',1,0));
		currentaddress_zipcode_CountNonBlank:= sum(group,if(ptucs_base.currentaddress.zipcode<>'',1,0));
		currentaddress_updateddate_CountNonBlank:= sum(group,if(ptucs_base.currentaddress.updateddate<>'',1,0));
		housenumber_CountNonBlank:= sum(group,if(ptucs_base.housenumber<>'',1,0));
		streettype_CountNonBlank:= sum(group,if(ptucs_base.streettype<>'',1,0));
		streetdirection_CountNonBlank:= sum(group,if(ptucs_base.streetdirection<>'',1,0));
		streetname_CountNonBlank:= sum(group,if(ptucs_base.streetname<>'',1,0));
		apartmentnumber_CountNonBlank:= sum(group,if(ptucs_base.apartmentnumber<>'',1,0));
		city_CountNonBlank:= sum(group,if(ptucs_base.city<>'',1,0));
		state_CountNonBlank:= sum(group,if(ptucs_base.state<>'',1,0));
		zipcode_CountNonBlank:= sum(group,if(ptucs_base.zipcode<>'',1,0));
		zip4u_CountNonBlank:= sum(group,if(ptucs_base.zip4u<>'',1,0));
		formername_firstname_CountNonBlank:= sum(group,if(ptucs_base.formername.firstname<>'',1,0));
		formername_middlename_CountNonBlank:= sum(group,if(ptucs_base.formername.middlename<>'',1,0));
		formername_middleinitial_CountNonBlank:= sum(group,if(ptucs_base.formername.middleinitial<>'',1,0));
		formername_lastname_CountNonBlank:= sum(group,if(ptucs_base.formername.lastname<>'',1,0));
		formername_suffix_CountNonBlank:= sum(group,if(ptucs_base.formername.suffix<>'',1,0));
		aliasname_firstname_CountNonBlank:= sum(group,if(ptucs_base.aliasname.firstname<>'',1,0));
		aliasname_middlename_CountNonBlank:= sum(group,if(ptucs_base.aliasname.middlename<>'',1,0));
		aliasname_middleinitial_CountNonBlank:= sum(group,if(ptucs_base.aliasname.middleinitial<>'',1,0));
		aliasname_lastname_CountNonBlank:= sum(group,if(ptucs_base.aliasname.lastname<>'',1,0));
		aliasname_suffix_CountNonBlank:= sum(group,if(ptucs_base.aliasname.suffix<>'',1,0));
		additionalname_firstname_CountNonBlank:= sum(group,if(ptucs_base.additionalname.firstname<>'',1,0));
		additionalname_middlename_CountNonBlank:= sum(group,if(ptucs_base.additionalname.middlename<>'',1,0));
		additionalname_middleinitial_CountNonBlank:= sum(group,if(ptucs_base.additionalname.middleinitial<>'',1,0));
		additionalname_lastname_CountNonBlank:= sum(group,if(ptucs_base.additionalname.lastname<>'',1,0));
		additionalname_suffix_CountNonBlank:= sum(group,if(ptucs_base.additionalname.suffix<>'',1,0));
		aka1_CountNonBlank:= sum(group,if(ptucs_base.aka1<>'',1,0));
		aka2_CountNonBlank:= sum(group,if(ptucs_base.aka2<>'',1,0));
		aka3_CountNonBlank:= sum(group,if(ptucs_base.aka3<>'',1,0));
		recordtype_CountNonBlank:= sum(group,if(ptucs_base.recordtype<>'',1,0));
		addressstandardization_CountNonBlank:= sum(group,if(ptucs_base.addressstandardization<>'',1,0));
		filesincedate_CountNonBlank:= sum(group,if(ptucs_base.filesincedate<>'',1,0));
		compilationdate_CountNonBlank:= sum(group,if(ptucs_base.compilationdate<>'',1,0));
		birthdateind_CountNonBlank:= sum(group,if(ptucs_base.birthdateind<>'',1,0));
		orig_deceasedindicator_CountNonBlank:= sum(group,if(ptucs_base.orig_deceasedindicator<>'',1,0));
		addressseq_CountNonBlank:= sum(group,if(ptucs_base.addressseq<>0,1,0));
		normaddress_address1_CountNonBlank:= sum(group,if(ptucs_base.normaddress.address1<>'',1,0));
		normaddress_address2_CountNonBlank:= sum(group,if(ptucs_base.normaddress.address2<>'',1,0));
		normaddress_city_CountNonBlank:= sum(group,if(ptucs_base.normaddress.city<>'',1,0));
		normaddress_state_CountNonBlank:= sum(group,if(ptucs_base.normaddress.state<>'',1,0));
		normaddress_zipcode_CountNonBlank:= sum(group,if(ptucs_base.normaddress.zipcode<>'',1,0));
		normaddress_updateddate_CountNonBlank:= sum(group,if(ptucs_base.normaddress.updateddate<>'',1,0));
		name_CountNonBlank:= sum(group,if(ptucs_base.name<>'',1,0));
		nametype_CountNonBlank:= sum(group,if(ptucs_base.nametype<>'',1,0));
		title_CountNonBlank:= sum(group,if(ptucs_base.title<>'',1,0));
		fname_CountNonBlank:= sum(group,if(ptucs_base.fname<>'',1,0));
		mname_CountNonBlank:= sum(group,if(ptucs_base.mname<>'',1,0));
		lname_CountNonBlank:= sum(group,if(ptucs_base.lname<>'',1,0));
		name_suffix_CountNonBlank:= sum(group,if(ptucs_base.name_suffix<>'',1,0));
		name_score_CountNonBlank:= sum(group,if(ptucs_base.name_score<>'',1,0));
		prim_range_CountNonBlank:= sum(group,if(ptucs_base.prim_range<>'',1,0));
		predir_CountNonBlank:= sum(group,if(ptucs_base.predir<>'',1,0));
		prim_name_CountNonBlank:= sum(group,if(ptucs_base.prim_name<>'',1,0));
		addr_suffix_CountNonBlank:= sum(group,if(ptucs_base.addr_suffix<>'',1,0));
		postdir_CountNonBlank:= sum(group,if(ptucs_base.postdir<>'',1,0));
		unit_desig_CountNonBlank:= sum(group,if(ptucs_base.unit_desig<>'',1,0));
		sec_range_CountNonBlank:= sum(group,if(ptucs_base.sec_range<>'',1,0));
		p_city_name_CountNonBlank:= sum(group,if(ptucs_base.p_city_name<>'',1,0));
		v_city_name_CountNonBlank:= sum(group,if(ptucs_base.v_city_name<>'',1,0));
		st_CountNonBlank:= sum(group,if(ptucs_base.st<>'',1,0));
		zip_CountNonBlank:= sum(group,if(ptucs_base.zip<>'',1,0));
		zip4_CountNonBlank:= sum(group,if(ptucs_base.zip4<>'',1,0));
		cart_CountNonBlank:= sum(group,if(ptucs_base.cart<>'',1,0));
		cr_sort_sz_CountNonBlank:= sum(group,if(ptucs_base.cr_sort_sz<>'',1,0));
		lot_CountNonBlank:= sum(group,if(ptucs_base.lot<>'',1,0));
		lot_order_CountNonBlank:= sum(group,if(ptucs_base.lot_order<>'',1,0));
		dbpc_CountNonBlank:= sum(group,if(ptucs_base.dbpc<>'',1,0));
		chk_digit_CountNonBlank:= sum(group,if(ptucs_base.chk_digit<>'',1,0));
		rec_type_CountNonBlank:= sum(group,if(ptucs_base.rec_type<>'',1,0));
		county_CountNonBlank:= sum(group,if(ptucs_base.county<>'',1,0));
		geo_lat_CountNonBlank:= sum(group,if(ptucs_base.geo_lat<>'',1,0));
		geo_long_CountNonBlank:= sum(group,if(ptucs_base.geo_long<>'',1,0));
		msa_CountNonBlank:= sum(group,if(ptucs_base.msa<>'',1,0));
		geo_blk_CountNonBlank:= sum(group,if(ptucs_base.geo_blk<>'',1,0));
		geo_match_CountNonBlank:= sum(group,if(ptucs_base.geo_match<>'',1,0));
		err_stat_CountNonBlank:= sum(group,if(ptucs_base.err_stat<>'',1,0));
		transferdate_unformatted_CountNonBlank:= sum(group,if(ptucs_base.transferdate_unformatted<>'',1,0));
		birthdate_unformatted_CountNonBlank:= sum(group,if(ptucs_base.birthdate_unformatted<>'',1,0));
		dob_no_conflict_CountNonBlank:= sum(group,if(ptucs_base.dob_no_conflict<>'',1,0));
		updatedate_unformatted_CountNonBlank:= sum(group,if(ptucs_base.updatedate_unformatted<>'',1,0));
		consumerupdatedate_unformatted_CountNonBlank:= sum(group,if(ptucs_base.consumerupdatedate_unformatted<>'',1,0));
		filesincedate_unformatted_CountNonBlank:= sum(group,if(ptucs_base.filesincedate_unformatted<>'',1,0));
		compilationdate_unformatted_CountNonBlank:= sum(group,if(ptucs_base.compilationdate_unformatted<>'',1,0));
		ssn_unformatted_CountNonBlank:= sum(group,if(ptucs_base.ssn_unformatted<>'',1,0));
		telephone_unformatted_CountNonBlank:= sum(group,if(ptucs_base.telephone_unformatted<>'',1,0));
		deceasedindicator_CountNonBlank:= sum(group,if(ptucs_base.deceasedindicator<>'',1,0));
		did_CountNonBlank:= sum(group,if(ptucs_base.did<>0,1,0));
		did_score_field_CountNonBlank:= sum(group,if(ptucs_base.did_score_field<>0,1,0));
  end;


dPopulationStats_tucs := table(ptucs_base
      ,rPopulationStats_tucs
,few);

STRATA.createXMLStats(dPopulationStats_tucs 
 ,'TSv3'
 ,'TransunionTUCS'
 ,version
 ,'angela.herzberg@lexisnexis.com; Gavin.Witz@lexisnexis.com'
 ,resultsOut);



return resultsOut;
end;
