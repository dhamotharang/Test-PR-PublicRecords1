//Build keys for Vendor_Src and move to QA.
import ut, RoxieKeyBuild, _control;

export Build_Keys(string pversion, boolean pUseProd = false) :=  
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											vendor_src.Key_DID,
											'~thor_data400::key::vendor_src_info::vendor_source_@version@',
											'~thor_data400::key::vendor_src_info::'+pversion+'::vendor_source',
											Vendor_Src_KeyOut
										   );
											 
										 
											 
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::vendor_src_info::vendor_source_@version@',
									  '~thor_data400::key::vendor_src_info::'+pversion+'::vendor_source',
									  Vendor_Src_key_built
									  );
								
											 
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::vendor_src_info::vendor_source_@version@', 'Q', Vendor_src_key_QA);


return sequential(
				parallel(
					Vendor_Src_KeyOut
		
					 ),
				// parallel(
					// Vendor_Src_key_built
	
					// ),
				// parallel(
					// Vendor_src_key_QA
		
					// )
				);
end;					