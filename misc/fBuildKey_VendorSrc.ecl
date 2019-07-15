IMPORT misc, ut, roxiekeybuild,PromoteSupers;

EXPORT fBuildKey_VendorSrc(STRING version) := FUNCTION

	RoxieKeybuild.Mac_SK_BuildProcess_v2_local(Misc.Key_VendorSrc(version).Vendor_Source,
				'~thor_data400::key::vendor_src_info::vendor_source',
				'~thor_data400::key::vendor_src_info::'+ version + '::vendor_source',
				VendorSrcKeyOut);
		
	RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vendor_src_info::vendor_source', 
				'~thor_data400::key::vendor_src_info::' + version + '::vendor_source',
				VendorSrcKeyMove);
				
	PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::vendor_src_info::vendor_source','Q',VendorSrcMoveQA,2);
												
		built_and_moved := SEQUENTIAL(VendorSrcKeyOut, VendorSrcKeyMove, VendorSrcMoveQA);
	RETURN built_and_moved;
END;