import business_header, Business_Header_SS, doxie, drivers, ut, Suppress, mdr;

export fn_RSS_getBestRecords(
	boolean USE_GID,
	boolean RETURN_BDLS,
	boolean INCLUDE_MVAWFA_HEADERS,
	boolean INCLUDE_BUS_DPPA,
	boolean match_ssn_as_fein = false,
	boolean phone_mandatory_match = true,
	boolean fein_mandatory_match = true,
	UNSIGNED6 bdid_limit = 7500,
	BOOLEAN nofail = TRUE,
	UNSIGNED1 fuzziness_dial = 3,
	boolean SIC_CODE_SEARCH = false
) := FUNCTION

business_header.doxie_MAC_Field_Declare();

integer mini(integer a, integer b) := if(a<b,a,b);

// *** If input contains SIC and either zip or city&state ONLY and no other input 
//     fields, get bdids from Business_Header.key_commercial_SIC_Zip using the new 
//     (as of 06/02/2010) Business_Header.fn_RSS_get_bdids_by_sic_zip function.
//     Otherwise get bdids as was currently done below by using 
//     Business_Header.doxie_get_bdids_plus.
temp_bdids0 := if(SIC_CODE_SEARCH, 
                  Business_Header.fn_RSS_get_bdids_by_sic_zip,
							    Business_Header.doxie_get_bdids_plus(,nofail,,,bdid_limit,match_ssn_as_fein,
																									     phone_mandatory_match,
																									     fein_mandatory_match,
																									     fuzziness_dial));
temp_bdids := temp_bdids0(score > 10 and bdid != 0);

app_type := IF (isPeopleWise, Suppress.Constants.ApplicationTypes.PeopleWise, application_type_value);

Suppress.MAC_Suppress(temp_bdids, temp_bdids_suppress, App_type, Suppress.Constants.LinkTypes.BDID, BDID);


// now rollup these up by address. and figure out a date range to output 
 
mac_temp_best(bh_key,out_best) := MACRO	
out_best :=
	join(
		temp_bdids_suppress,
		bh_key,
		keyed(left.bdid = right.bdid) AND
		((NOT (mdr.sourcetools.SourceIsEBR(RIGHT.source))) OR not doxie.DataRestriction.EBR) AND 
    (right.source <> MDR.sourceTools.src_Dunn_Bradstreet OR Doxie.DataPermission.use_DNB),
		transform(
			business_header.layout_biz_search.result,
			self.bdid := left.bdid,
			self.seq := left.seq,
			self.score := (left.score + 100 - mini(100,if(company_name_value = '',0,ut.companysimilar100(company_name_value,right.company_name)))) / 2,
			self := right,
			self := []),
		left outer,
		limit(2));

ENDMACRO;



mac_temp_best(Business_Header.Key_BH_Best_KnowX,out_best1)
mac_temp_best(Business_Header.Key_BH_Best,out_best2)
temp_best := IF(ut.IndustryClass.is_knowx,out_best1,out_best2);


															 

temp_best_phone_string := project(temp_best,transform({recordof(temp_best) - [phone];string10 phone},
	self.phone := if (left.phone = 0,'',intformat(left.phone,10,1)),
	self := left));
	
// add timezone
ut.getTimeZone(temp_best_phone_string,phone,timezone,temp_best_w_tz)

temp_best_plus_execs :=
	join(
		temp_best_w_tz,
		business_header.Fetch_BC_State_LFName(
			state_value,
			fname_value,
			lname_value,
			nicknames,
			phonetics and lname_value <> '')(
			from_hdr = 'N' AND ((NOT (mdr.sourcetools.SourceIsEBR(source))) OR not doxie.DataRestriction.EBR)) +
		business_header.Fetch_BC_SSN(
			(unsigned)ssn_value)(
			from_hdr = 'N' AND ((NOT (mdr.sourcetools.SourceIsEBR(source))) OR not doxie.DataRestriction.EBR)),
		left.bdid = right.bdid,
		transform(
			business_header.layout_biz_search.result,
			self.fname := right.fname,
			self.mname := right.mname,
			self.lname := right.lname,
			self.ssn := if(right.ssn != 0,intformat(right.ssn,9,1),''),
			self.name_suffix := right.name_suffix,
			self.company_title := right.company_title,
			self.contact_score :=
					if(right.lname = lname_value,100,0) +
					if(right.fname = fname_value,50,0) +
					if(right.mname = mname_value,25,0) +
					if(right.ssn = (unsigned)ssn_value,150,0) +
					right.contact_score / 2,
			self.phone := (integer)left.phone,
			self := left),
		left outer);

temp_best_plus_group_id :=
	join(
		temp_best_plus_execs,
		business_header.Key_BH_SuperGroup_BDID,
		keyed(left.bdid = right.bdid),
		transform(
			business_header.layout_biz_search.result,
			self.group_id := right.group_id,
			self := left),
		limit(2));

temp_best_plus_bdl :=
	join(
		temp_best_plus_group_id,
		business_header.Key_BDL2_BDID,
		keyed(left.bdid = right.bdid),
		transform(
			business_header.layout_biz_search.result,
			self.bdl := right.bdl,
			self := left),
		limit(2));

temp_best_grouped_by_group_id_and_sorted(
	boolean RETURN_BDLS
) :=
	global(
		sort(
			group(
				sort(
					if(RETURN_BDLS,temp_best_plus_bdl,temp_best_plus_group_id),
					group_id,bdl),
				group_id,bdl),
			-score,
			-contact_score,
			seq,
			company_name,
			bdid),
		few);
				   
temp_best_with_or_without_gid_replacement(
	boolean USE_GID,
	boolean RETURN_BDLS
) :=
	if(
		USE_GID,
		temp_best_grouped_by_group_id_and_sorted(RETURN_BDLS)(company_name <> ''),
		iterate(
			temp_best_grouped_by_group_id_and_sorted(RETURN_BDLS)(company_name <> ''),
			transform(
				business_header.layout_biz_search.result,
				self.group_id := if(counter = 1,right.bdid,left.group_id),
				self := right)));
				
blist :=  temp_best_with_or_without_gid_replacement(USE_GID,RETURN_BDLS);		

blist_BH  := sort(join(blist, Business_Header_SS.Key_BH_BDID_pl,
                     keyed(left.bdid = right.bdid) AND
										 left.prim_name = right.prim_name AND
										 left.prim_range = right.prim_range AND
										 left.zip = right.zip AND
                     ut.PermissionTools.glb.SrcOk(glb_purpose,right.source) AND 
                     (right.source <> MDR.sourceTools.src_Dunn_Bradstreet OR Doxie.DataPermission.use_DNB),
                  transform(business_header.layout_biz_search.result_dateRange,
									     // copy dates into separate fields in preparation for rollup
											 // ensure dates come from business header file. (right side).									     		
											 self.lastSeenDate := right.dt_last_seen,
											 self.firstSeenDate := right.dt_first_seen,
											 self := left;																					 
											 ), limit(10000, skip)), bdid, zip, state, city, prim_name, prim_range, addr_suffix, -dt_last_seen);
											 
business_header.layout_biz_search.result_dateRange

		doRoll(business_header.layout_biz_search.result_dateRange le,
					 business_header.layout_biz_search.result_dateRange r) := transform
								
        self.firstSeenDate := ut.min2(le.firstSeenDate, r.firstSeenDate);
				self.lastSeenDate := Max(le.lastSeenDate, r.lastSeenDate);
				self := r;
		end;														 


blist_BH_dateRange := rollup(blist_BH, 
                        left.bdid = right.bdid,
												doRoll(left, right));
                      											
temp_best_with_dppa_restrictions(
	boolean USE_GID,
	boolean RETURN_BDLS,
	boolean INCLUDE_MVAWFA_HEADERS,
	boolean INCLUDE_BUS_DPPA
) :=
	blist_BH_dateRange(
		(
			INCLUDE_MVAWFA_HEADERS or
		   NOT ( mdr.sourcetools.SourceIsVehicle(source) OR
			       mdr.sourcetools.SourceIsWC(source) OR  mdr.sourcetools.SourceIsFAA(source))) and
				( 		                                                                         
			   NOT (mdr.sourcetools.SourceIsVehicle(source) OR
			        mdr.sourcetools.SourceIsWC(source)) OR (
				INCLUDE_BUS_DPPA and
				ut.dppa_ok(dppa_purpose) and
				drivers.state_dppa_ok(dppa_state,dppa_purpose,,source))));
				
// output(temp_best, named('temp_best'));
// output(temp_bdids0, named('temp_bdids0'));
// output(temp_best_plus_execs, named('temp_best_plus_execs'));
// output(temp_best_plus_group_id, named('temp_best_plus_group_id'));
// output(temp_best_plus_bdl, named('temp_best_plus_bdl'));
 // output(temp_best_grouped_by_group_id_and_sorted, named('temp_best_grouped_by_group_id_and_sorted'));
// output(blist, named('temp_best_with_or_without_gid_replacement'));
// output(blist_BH, named('blist_BH'));
// output(blist_BH_rolled, named('blist_BH_rolled'));
// output(blist_BH_rolled_1, named('blist_BH_rolled_1'));
// output(blist_BH_dateRange, named('blist_BH_dateRange'));
// output(blist_BH_interate, named('blist_BH_interate'));
 //output(temp_best_with_dppa_restrictions, named('temp_best_with_dppa_restrictions'));
//output(temp_bdids_suppress_2, named('temp_bdids_suppress_2'));

return temp_best_with_dppa_restrictions(USE_GID,RETURN_BDLS,INCLUDE_MVAWFA_HEADERS,INCLUDE_BUS_DPPA);
END;
