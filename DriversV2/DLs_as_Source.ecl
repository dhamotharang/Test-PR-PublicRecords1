import header,ut, Drivers, header_services, STD, data_services;

export DLs_as_Source(dataset(driversv2.Layout_Base_withAID) pDLs = dataset([],driversv2.Layout_Base_withAID), boolean pForHeaderBuild=false, boolean pFastHeader = false)
 :=
  function
	dSourceData_	:=	map(
							pForHeaderBuild => project(dataset(data_services.data_location.prefix()+'thor_data400::BASE::dl2::DLHeader_Building',DriversV2.Layout_Base_withAID,flat,unsorted),driversv2.Layout_Base_withAID)
					   ,pFastHeader => project(dataset(data_services.data_location.prefix()+'thor_data400::BASE::dl2::DLQuickHeader_Building',DriversV2.Layout_Base_withAID,flat,unsorted),driversv2.Layout_Base_withAID)
						 ,pDLs)
						 (trim(source_code,left,right)<>'CY' and  trim(orig_state,left,right)<>'NE') //NE is being purposely excluded from the header for legal reasons
					  ;
	dSourceData := if (pFastHeader, dSourceData_(ut.DaysApart((STRING8)Std.Date.Today(), ((string)dt_vendor_last_reported)[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep) , dSourceData_);

	dlFixed := DriversV2.Regulatory.applyDriversLicenseSup_DIDDl(dSourceData);

	src_rec := header.layouts_SeqdSrc.DL_src_rec;

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(dlFixed,driversv2.Layout_Base_withAID,src_rec, Drivers.header_src(l.source_code,l.orig_state),withUID,seed);

	return withUID;
  end
 ;