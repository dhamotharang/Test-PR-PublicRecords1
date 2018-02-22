import header,ut, Drivers, header_services, std;

export DLs_as_Source(dataset(driversv2.Layout_Base_withAID) pDLs = dataset([],driversv2.Layout_Base_withAID), boolean pForHeaderBuild=false, boolean pFastHeader = false)
 :=
  function
	dSourceData_	:=	map(
							pForHeaderBuild => project(dataset('~thor_data400::BASE::dl2::DLHeader_Building',DriversV2.Layout_Base_withAID,flat,unsorted),driversv2.Layout_Base_withAID)
					   ,pFastHeader => project(dataset('~thor_data400::BASE::dl2::DLQuickHeader_Building',DriversV2.Layout_Base_withAID,flat,unsorted),driversv2.Layout_Base_withAID)
						 ,pDLs)
						 (trim(source_code,left,right)<>'CY' and  trim(orig_state,left,right)<>'NE')
					  ;
	dSourceData := if (pFastHeader, dSourceData_(ut.DaysApart((STRING8)Std.Date.Today(), ((STRING)dt_vendor_last_reported)[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep) , dSourceData_);

	rec := RECORD
		driversv2.Layout_Base_withAID;	
	END;

	Suppression_Layout := header_services.Supplemental_Data.layout_in;
	header_services.Supplemental_Data.mac_verify(	'driverslicense_sup.txt',Suppression_Layout, dl_supp_ds_func	);
	DL_Suppression_In := dl_supp_ds_func();
	DLSuppressedIn 	:= PROJECT(	DL_Suppression_In,header_services.Supplemental_Data.in_to_out(left));

	dlHashDIDDlseqFormat := header_services.Supplemental_Data.layout_out;

	DlOut_HashBDID := RECORD
		rec;
		dlHashDIDDlseqFormat;
	end;

	DlOut_HashBDID Hash_DID_and_dlSeq(rec l) := transform                            
		self.hval := HASHMD5(intformat((unsigned6)l.did,12,1),TRIM((string14)l.dl_number, left, right));
		self 			:= l;
	end;

	DLOnly_withMD5 := PROJECT(dSourceData, Hash_DID_and_dlSeq(left));

	DlOut_HashBDID dlONLYSuppress( DLOnly_withMD5 l ) := transform
	 self := l; 
	end;

	DL_Suppress			:= JOIN(DLOnly_withMD5,DLSuppressedIn,left.hval = right.hval,dlONLYSuppress(left),left only,lookup);
	
	dlFixed := PROJECT(DL_Suppress,rec);
	
	header_services.Supplemental_Data.mac_verify('driverslicenseall_sup.txt',Suppression_Layout,dl_supp_ALL_ds_func);																					
	 
	DL_Supp_All_In := dl_supp_ALL_ds_func();
	DLSuppressAllIn := PROJECT(	DL_Supp_All_In, header_services.Supplemental_Data.in_to_out(left));

	dlHashAllFormat := header_services.Supplemental_Data.layout_out;

	DlOut_HashAll := RECORD
		rec;
		dlHashAllFormat;
	end;

	DlOut_HashAll Hash_ALL( rec l) := transform                            
	 self.hval := HASHMD5(intformat((unsigned6)l.did,12,1),TRIM((string14)l.dl_number, left, right),intformat((unsigned4)l.dob,8,1),(string9)l.ssn);
	 self := l;
	end;

	DLALL_withMD5 := PROJECT(	dlFixed, Hash_ALL(left));
	DlOut_HashAll dlAllSuppress(DLALL_withMD5 l) := transform
	 self := l; 
	end;
	DL_SuppressAll	:= JOIN(DLALL_withMD5,DLSuppressAllIn,left.hval = right.hval,dlAllSuppress(left),left only,lookup);

	dlFixedAllSupp := PROJECT(DL_SuppressAll(did<999999000000),rec);

	src_rec := record
	 header.Layout_Source_ID;
	 driversv2.Layout_Base_withAID;
	end;

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(dlFixedAllSupp,driversv2.Layout_Base_withAID,src_rec, Drivers.header_src(l.source_code,l.orig_state),withUID,seed);

	dForHeader	:=	withUID	: persist('persist::dl2::headerbuild_dl_src');
	dForOther	:=	withUID;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;