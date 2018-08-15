import Header,ut,Header_SlimSort,MDR,DID_Add,DidVille,Address,RoxieKeyBuild,header_services,jtrost_stuff,VersionControl,Orbit3;

export proc_build_quick_hdr(string filedate, string leMailTarget='jose.bello@lexisnexis.com;michael.gould@lexisnexis.com;Gabriel.Marcan@lexisnexis.com;Harry.Gist@lexisnexis.com;Debendra.Kumar@lexisnexisrisk.com',string leMailTargetScoring='jose.bello@lexisnexis.com;michael.gould@lexisnexis.com;Gabriel.Marcan@lexisnexis.com;Debendra.Kumar@lexisnexisrisk.com;Scoring_QA@risk.lexisnexis.com') := function

	
	versionCheck := if(filedate[1..6] = ut.GetDate[1..6] and (header.Sourcedata_month.v_version[1..6] = filedate[1..6] or header.Sourcedata_month.v_eq_as_of_date[1..6] = filedate[1..6]),
											output('The version dates are good'),
											fail('Either the filedate or the header.Sourcedata_month date or both are not good'));
											
  SuccessBody		:= if(VersionControl.IsValidVersion(filedate),
	                   'Quick Header ' + filedate + ' is ready for CERT deployment, please respond immediately if we can send to cert','');
										 
	            		
//	RoxieKeyBuild.Mac_Daily_Email_Local('QUICK HEADER','SUCC',filedate,send_succ_msg,leMailTarget);
	RoxieKeyBuild.Mac_Daily_Email_Local('QUICK HEADER','FAIL see workunit:'+workunit,filedate,send_fail_msg,leMailTarget);
	
	dops_FCRA_QH	:= roxiekeybuild.updateversion('FCRA_QuickHeaderKeys',filedate,'michael.gould@lexisnexis.com,jose.bello@lexisnexis.com',,'F');
	dops_QH       := roxiekeybuild.updateversion('QuickHeaderKeys',filedate,'michael.gould@lexisnexis.com,jose.bello@lexisnexis.com',,'N');
	dops_SS       := roxiekeybuild.updateversion('QHsourceKeys',filedate,'michael.gould@lexisnexis.com,jose.bello@lexisnexis.com',,'N');
	
// Update Orbit with the correct entries in build in progress mode.

  oQH_fcra      := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'FCRA_Quick_Header',filedate,'F', ,true,true);	
  oQH_nonfcra   := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'Quick Header',filedate,'N', ,true);	
  oQH_qhs       := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'QHsourceKeys',filedate,'N', ,true);	
	
	EQ_records_in0 := header.fn_preprocess(true);
	
  ut.MAC_Sequence_Records(EQ_records_in0, rid, seqd);

	// rid is an unsigned6 which may extend up to 281,474,976,710,655
	// therefore, if we start sequensing from 999,999,999,999
	// there is a capacity for 280,474,976,710,656 unique rids
	header.Layout_New_Records to_form(seqd l) := transform
		self.rid    := l.rid + Header.constants.QH_start_rid;
		self := l;
	end;

	// do not remove this persist.  it is used in Header.Key_Rid_SrcID_Prep
	// if we have to restart with eq_records as a dataset, also look at 
	// heaer_quick.fn_patch_dids lines 64-73 as this will probably need to be sandboxed as well
	// if the counts were completed.
	
	//eq_records_in := dataset('~thor_data400::persist::qh_seqd',header.Layout_New_Records,flat);
	eq_records_in := project(seqd,to_form(left)): persist('~thor_data400::persist::qh_seqd');

  dids0 := project(eq_records_in,header.layout_header);

	dids  := header_quick.fn_patch_dids(dids0);

	//Build roxie keys
	roxie_keys := header_quick.FN_keyBuild(dids,filedate)  :success(FileServices.SendEmail(leMailTargetScoring, 'Quick Header Completed',SuccessBody)), failure(send_fail_msg);

	a0 := dids(did>0);
	
	a := project(a0,header.Layout_Header);
	
	Suppression_Layout := header_services.Supplemental_Data.layout_in;
	header_services.Supplemental_Data.mac_verify('driverslicense_sup.txt',Suppression_Layout, dl_supp_ds_func); 
	DL_Suppression_In 	:= dl_supp_ds_func();
	DLSuppressedIn 			:= PROJECT(	DL_Suppression_In,header_services.Supplemental_Data.in_to_out(left));

	HashDLShort := header_services.Supplemental_Data.layout_out;

	shortHashrec := record
	 header.layout_header;
	 HashDLShort;
	end;

	shortHashrec HashDID_DLnumber(header.Layout_Header l) := transform                            
		self.hval := hashmd5(	intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right));
		self := l;
	end;

	hdr_withMD5 := project(a, HashDID_DLnumber(left));

	header.layout_header shortSuppress(hdr_withMD5 l, DLSuppressedIn r) := transform
	 self := l;
	end;

	full_ShortSuppress := join(hdr_withMD5,DLSuppressedIn,left.hval=right.hval,shortSuppress(left,right),left only,lookup);

	addr1 := header.File_Headers(header.isPreGLB(header.File_Headers));
	addr2 := addr1(not mdr.Source_is_DPPA(src));
	header.MAC_Best_Address(addr2, did, 4, b)

    //note RID sequencing is not necessary for moxie
	header.mac_despray(full_ShortSuppress, b, full_out)
	
	//***//***//***//*** INSERT SUPPRESSION TEXT CNG 20070417***//***//***//***//
header_services.Supplemental_Data.mac_verify('didaddress_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

	rFullOut := record // Referenced string_rec layout in header.MAC_Despray
		string15 did;
		string15 rid;
		string2  src;
		string6  dt_first_seen;
		string6  dt_last_seen;
		string6  dt_vendor_last_reported;
		string6  dt_vendor_first_reported;
		string6  dt_nonglb_last_seen;
		string1  rec_type;
		string18 vendor_id;
		string10 phone;
		string9  ssn;
		string8  dob;
		string5  title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5  name_suffix;
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  suffix;
		string2  postdir;
		string10 unit_desig;
		string8  sec_range;
		string25 city_name;
		string2  st;
		string5  zip;
		string4  zip4;
		string3  county;
		string4  msa;
		string1  tnt;  
		string1  valid_ssn;
	end;

	rFullOut_HashDIDAddress := record
		rFullOut;
		rHashDIDAddress;
	end;

	rFullOut_HashDIDAddress tHashDIDAddress(full_out l) := transform                            
		self.hval := hashmd5(l.did,l.st,l.zip,l.city_name,l.prim_name,l.prim_range,l.predir,l.suffix,l.postdir,l.sec_range);
		self := l;
	end;

	dHeader_withMD5 := project(full_out, tHashDIDAddress(left));

	rFullOut tSuppress(dHeader_withMD5 l, dSuppressedIn r) := transform
		self := l;
	end;

	full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
														left.hval=right.hval,
														tSuppress(left,right),
														left only,lookup);
														
								
	//***//***//***//*** END SUPPRESSION TEXT ***//***//***//***//

	fSendMail(string pSubject, string pBody) := fileservices.sendemail(leMailTarget,pSubject,pBody);
	
  weekly_handling := sequential(output(header.file_header_in_weekly.File,,'~thor400_84::in::'+header.sourcedata_month.v_eq_as_of_date+'::eq_weekly_with_as_of_date',__compressed__),
																fileservices.addsuperfile('~thor400_84::in::eq_weekly_with_as_of_date2','~thor400_84::in::'+header.sourcedata_month.v_eq_as_of_date+'::eq_weekly_with_as_of_date'),
																fileservices.addsuperfile('~thor400_84::in::eq_weekly_history','~thor400_84::in::eq_weekly',,true),
				    										fileservices.clearsuperfile('~thor400_84::in::eq_weekly')
						  									);
  
	return sequential(
										 weekly_handling
										,roxie_keys
										,Proc_Accept_SRC_toQA(filedate)
										,proc_build_ssn_suppression(filedate)
										,proc_build_current_wa_residents_file 
										,SEQUENTIAL(oQH_fcra,oQH_nonfcra,oQH_qhs,oQH_nonitems,oQHS_nonitems)
	  								//,SEQUENTIAL(/*dops_FCRA_QH,dops_QH,*/dops_SS)
										);										 
end;