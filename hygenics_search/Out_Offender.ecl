	/*2013-06-17T15:49:44Z (vchikte)
C:\Documents and Settings\ChikteVP\Application Data\HPCC Systems\eclide\vchikte\Dataland_EOSS_Proxy\hygenics_search\Out_Offender\2013-06-17T15_49_44Z.ecl
*/
import PromoteSupers, Lib_Date, hygenics_crim, CrimSrch, Crim_Common, Corrections, Life_EIR, doxie_build;

fcra_v1 			:= Offender_Joined;


///////////////////////////////////////////////////////////////
//Add 180 Day Rule Filter /////////////////////////////////////
///////////////////////////////////////////////////////////////

file_date_filter	:= StringLib.StringFilter(hygenics_search.Version.development, '0123456789');

fcra_filtered			:= fcra_v1(vendor in hygenics_search.sCourt_Vendors_To_Omit);

fcra_all					:= fcra_v1(vendor not in hygenics_search.sCourt_Vendors_To_Omit
												
                             ); 											

/////////////////////////////////////////////////////////////
//Remove FCRA related information from non-updating sources//
/////////////////////////////////////////////////////////////
	
	fcra_filtered removeInfo(fcra_filtered l):= transform
		self.fcra_conviction_flag						:= '';
		self.fcra_traffic_flag							:= '';
		self.fcra_date											:= '';
		self.fcra_date_type									:= '';
		self.conviction_override_date				:= '';
		self.conviction_override_date_type	:= '';
		self.offense_score									:= '';
		self 																:= l;
	end;
	
ds_fcra_filtered 	:= project(fcra_filtered, removeInfo(left));
ds_fcra_all			 	:= fcra_all;

////////////////////////////////////
//Add Offender_persistent_id Field//
////////////////////////////////////

all_f				 			:= ds_fcra_filtered + ds_fcra_all;

	all_f addOPID(all_f l):= transform
	
		filterField(String s) := FUNCTION
			return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		END;

    Vid_num 						:= filterField(l.id_num);		
		Vpty_nm 						:= filterField(l.pty_nm);
		Vorig_lname					:= filterField(l.orig_lname);
		Vorig_fname					:= filterField(l.orig_fname);
		Vpty_typ						:= filterField(l.pty_typ);
		Vcase_num 					:= filterField(l.case_num);
		Vcase_court 				:= filterField(l.case_court);
		Vcase_date 					:= filterField(l.case_date);
		Vcase_type 					:= filterField(l.case_type);
		Vcase_type_desc 		:= filterField(l.case_type_desc);
		//Vcounty_of_origin 	:= filterField(l.county_of_origin);
		Vdle_num 						:= filterField(l.dle_num);
		Vfbi_num 						:= filterField(l.fbi_num);
		Vdoc_num 						:= filterField(l.doc_num);
		Vins_num 						:= filterField(l.ins_num);
		Vdl_num 						:= filterField(l.dl_num);
		Vdl_state 					:= filterField(l.dl_state);
		Vdob 								:= filterField(l.dob);
			
		Vstreet_address			:= trim(trim(trim(trim(trim(trim(trim(trim(trim(trim(l.prim_range, left, right) + trim(l.predir, left, right), left, right) + trim(l.prim_name, left, right), left, right) + trim(l.addr_suffix, left, right), left, right) + trim(l.postdir, left, right), left, right) + trim(l.unit_desig, left, right), left, right) + trim(l.sec_range, left, right), left, right) + trim(l.p_city_name, left, right), left, right) + trim(l.st, left, right), left, right) + trim(l.zip5, left, right), left, right);

		Vstreet_address_1 	:= filterField(l.street_address_1);
		Vstreet_address_2 	:= filterField(l.street_address_2);
		Vstreet_address_3 	:= filterField(l.street_address_3);
		Vstreet_address_4 	:= filterField(l.street_address_4);
		Vstreet_address_5 	:= filterField(l.street_address_5);
		Vrace 							:= filterField(l.race);
		Vrace_desc 					:= filterField(l.race_desc);
		Vheight							:= filterField(l.height);
		Vsex 								:= filterField(l.sex);
		Vskin_color					:= filterField(l.skin_color);	
		Vskin_color_desc		:= filterField(l.skin_color_desc);

		
		self.offender_persistent_id 	:= hash64(l.offender_key + Vid_num + trim(l.pty_nm, left, right) + Vorig_lname + Vorig_fname + Vpty_typ + trim(l.case_num, left, right) + Vcase_court + Vcase_date + Vcase_type + Vcase_type_desc /*+ Vcounty_of_origin +*/+ Vdle_num + Vfbi_num + Vdoc_num + Vins_num + Vdl_num + Vdl_state + Vdob + 
																					Vstreet_address_1 + Vstreet_address_2 + Vstreet_address_3 + Vstreet_address_4 + Vstreet_address_5 + 
																					//trim(l.street_address_1, left, right) + trim(l.street_address_2, left, right) + trim(l.street_address_3, left, right) + trim(l.street_address_4, left, right) + trim(l.street_address_5, left, right) +
																					Vstreet_address +
																					Vrace + Vrace_desc + Vheight + Vsex + Vskin_color + Vskin_color_desc);
		self := l;
	end;

all_files := project(all_f, addOPID(left)):persist('~thor_400::persist::Crim_records_before_DID_filter');

corrections.layout_offender trecs(fcra_v1 L) := transform
	  self.did	:= if(trim(l.did_to_keep, left, right)='000000000000', '', l.did_to_keep);	
		self 			:= L;
	end;

NonFCRA_records 	:= project(all_files, trecs(left));

////////////////////////////////////////////////////////////////////////////////////
//Fix to accommodate current FCRA Offender file/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
	
	dslayout2 := record
		all_files; 
		string1 off_name_type;
	end;
	
	dslayout2 addONT(all_files l):= transform
		self.off_name_type := l.pty_typ;
		did      := MAP( trim(l.did_to_keep, left, right)<>'000000000000' and l.did = l.did_to_keep => l.did,'');
		//Added this filter as per Linking team. Added as part proj Juli
		self.did := MAP(~((unsigned)l.did>0 and l.xadl2_weight >=35 and (l.xadl2_distance>=9 or l.xadl2_distance=0))=>'',
		                did);
		self     := l;
	end;
	
add_ONT := project(all_files, addONT(left));
	
dCrimOffender2FixedDist 			:= distribute(add_ONT,hash(Offender_Key));
// Sort gives us filled DIDs first, and if no DIDs filled, name type "0" first
// by default.  Keep in mind that "2" record types would not have DID'd anyway.

dCrimOffender2FixedSorted			:= sort(dCrimOffender2FixedDist,Offender_Key,-DID,Off_Name_Type,local);
dCrimOffender2FixedGrouped		:= group(dCrimOffender2FixedSorted,Offender_Key);

	dslayout2 tFixNameType(dslayout2 pLeft, dslayout2 pRight):= transform
		self.Off_Name_Type	:= if(pLeft.Offender_Key='','0','2');
		self								:= pRight;
	end;

dCrimOffender2FixedTypeSet		:= iterate(dCrimOffender2FixedGrouped,tFixNameType(left,right));
dCrimOffender2FixedReady			:= ungroup(dCrimOffender2FixedTypeSet);
//dCrimOffender2FixedReadywithDIDFilter := dCrimOffender2FixedReady();
corrections.layout_offender RemF(dCrimOffender2FixedReady l):= transform
		self.did 						:= if(l.off_name_type= '2',
														'',
														l.did);	
		self.ssn						:= if(l.off_name_type= '2',
														  '',
														  l.ssn);
		self.ssn_appended		:= if(l.off_name_type= '2',
														  '',
														  l.ssn_appended);

		self := l;
	end;

  FCRA_records:= project(dCrimOffender2FixedReady, RemF(left));

////////////////////////////////////////////////////////////////////////////////////

  PromoteSupers.MAC_SF_BuildProcess(NonFCRA_records,'~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate, outOffnd, 2,,TRUE);
	PromoteSupers.MAC_SF_BuildProcess(FCRA_records,'~thor_data400::base::fcra_corrections_offenders_' + doxie_build.buildstate, outOffnd2, 2,,TRUE);			 
	PromoteSupers.MAC_SF_BuildProcess(hygenics_crim.File_AddressCacheInput,'~thor_data400::base::crim::address_cache_' + doxie_build.buildstate, outOffnd3, 2,,TRUE);
							 
export Out_Offender := sequential(
												outOffnd,
												//output(all_files,,'~thor_data400::base::fcra::life_eir::criminal_offenders_20130410'/* + Version.Development*/, overwrite, __compressed__),
												outOffnd2,
												outOffnd3);		 