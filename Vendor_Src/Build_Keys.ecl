 //Build keys for Vendor_Src and move to QA.
import ut, RoxieKeyBuild, _control,vendor_src,dx_Vendor_Src;

export Build_Keys(string pversion, boolean pUseProd = false) := function

superFile  :='~thor_data400::key::vendor_src_info::vendor_source_@version@';
logicalFile:='~thor_data400::key::vendor_src_info::'+pversion+'::vendor_source';

vendorsrc_base :=PROJECT(Vendor_Src.Files().base.built(source_code<>''), TRANSFORM(Vendor_Src.layouts.Base-[county_text],SELF:=LEFT));

RoxieKeybuild.MAC_build_logical (dx_Vendor_Src.Key_Vendor_Src(FALSE), vendorsrc_base, dx_vendor_src.names(FALSE).name, logicalFile, Vendor_Src_KeyOut);
										 
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(superFile,logicalFile,Vendor_Src_key_built);
								 
RoxieKeyBuild.Mac_SK_Move_V2(superFile, 'Q', Vendor_src_key_QA);


return sequential(
				parallel(
					Vendor_Src_KeyOut
		
					 ),
				parallel(
					Vendor_Src_key_built
	
					), 
				parallel(
					Vendor_src_key_QA
		
					)
				);
end;					

