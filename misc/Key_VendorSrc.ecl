IMPORT misc, Data_Services, Doxie, ut;

EXPORT Key_VendorSrc(STRING pVersion='')	:= MODULE

	SHARED		key_stem	:= Data_Services.Data_location.Prefix('Provider') + 'thor_data400::key::vendor_src_info';
	
	EXPORT Vendor_Source	:= FUNCTION	
		file_in			:= DEDUP(Misc.Files_VendorSrc(pVersion).Combined_Base, RECORD, ALL, LOCAL);	
		key_name		:= key_stem + '::vendor_source_' + doxie.version_superkey;
		return_key	:= INDEX(file_in(source_code <> ''), {source_code},{file_in},key_name);
		RETURN (return_key);
	END;
END;