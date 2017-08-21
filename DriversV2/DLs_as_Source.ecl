import header,ut, Drivers, header_services, STD;

export DLs_as_Source(dataset(driversv2.Layout_Base_withAID) pDLs = dataset([],driversv2.Layout_Base_withAID), boolean pForHeaderBuild=false, boolean pFastHeader = false)
 :=
  function
	dSourceData_	:=	map(
							pForHeaderBuild => project(dataset('~thor_data400::BASE::dl2::DLHeader_Building',DriversV2.Layout_Base_withAID,flat,unsorted),driversv2.Layout_Base_withAID)
					   ,pFastHeader => project(dataset('~thor_data400::BASE::dl2::DLQuickHeader_Building',DriversV2.Layout_Base_withAID,flat,unsorted),driversv2.Layout_Base_withAID)
						 ,pDLs)
						 (trim(source_code,left,right)<>'CY' and  trim(orig_state,left,right)<>'NE') //NE is being purposely excluded from the header for legal reasons
					  ;
	dSourceData := if (pFastHeader, dSourceData_(ut.DaysApart((STRING8)Std.Date.Today(), ((string)dt_vendor_last_reported)[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep) , dSourceData_);

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
		self.hval := HASHMD5(intformat((unsigned6)l.did,15,1),TRIM((string14)l.dl_number, left, right));
		self 			:= l;
	end;

	DLOnly_withMD5 := PROJECT(dSourceData, Hash_DID_and_dlSeq(left));

	DlOut_HashBDID dlONLYSuppress( DLOnly_withMD5 l ) := transform
	 self := l; 
	end;

	DL_Suppress			:= JOIN(DLOnly_withMD5,DLSuppressedIn,left.hval = right.hval,dlONLYSuppress(left),left only,lookup);
	
	dlFixed := PROJECT(DL_Suppress,rec);

	src_rec := header.layouts_SeqdSrc.DL_src_rec;

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(dlFixed,driversv2.Layout_Base_withAID,src_rec, Drivers.header_src(l.source_code,l.orig_state),withUID,seed);

	return withUID;
  end
 ;