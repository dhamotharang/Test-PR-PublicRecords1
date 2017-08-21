IMPORT _control,PRTE_CSV,header;

EXPORT Proc_Build_Header_Dts_Keys(STRING pIndexVersion):=FUNCTION

	rKeyheader_dts__fname_small:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__fname_small;};
	rKeyheader_dts__pname_prange_st_city_sec_range_lname:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname;};
	rKeyheader_dts__pname_zip_name_range:={PRTE_CSV.Header_dts.rthor_data400__key__header__dts__pname_zip_name_range;};

	dKeyheader_dts__fname_small:=PROJECT(PRTE_CSV.Header_dts.dthor_data400__key__header__dts__fname_small,rKeyheader_dts__fname_small);
	dKeyheader_dts__pname_prange_st_city_sec_range_lname:=PROJECT(PRTE_CSV.Header_dts.dthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname,rKeyheader_dts__pname_prange_st_city_sec_range_lname);
	dKeyheader_dts__pname_zip_name_range:=PROJECT(PRTE_CSV.Header_dts.dthor_data400__key__header__dts__pname_zip_name_range,rKeyheader_dts__pname_zip_name_range);

	kKeyheader_dts__fname_small:=INDEX(dKeyheader_dts__fname_small,{dKeyheader_dts__fname_small},'~prte::key::header::dts::'+pIndexVersion+'::fname_small');
	kKeyheader_dts__pname_prange_st_city_sec_range_lname:=INDEX(dKeyheader_dts__pname_prange_st_city_sec_range_lname,{dKeyheader_dts__pname_prange_st_city_sec_range_lname},'~prte::key::header::dts::'+pIndexVersion+'::pname.prange.st.city.sec_range.lname');
	kKeyheader_dts__pname_zip_name_range:=INDEX(dKeyheader_dts__pname_zip_name_range,{dKeyheader_dts__pname_zip_name_range},'~prte::key::header::dts::'+pIndexVersion+'::pname.zip.name.range');

	RETURN
    SEQUENTIAL(
      PARALLEL(
				BUILDINDEX(kKeyheader_dts__fname_small,UPDATE),
				BUILDINDEX(kKeyheader_dts__pname_prange_st_city_sec_range_lname,UPDATE),
				BUILDINDEX(kKeyheader_dts__pname_zip_name_range,UPDATE)
			)/*,
			PRTE.UpdateVersion('PersonHeaderKeys',pIndexVersion,_control.MyInfo.EmailAddressNormal,'B','N','N')*/
		);

end;
