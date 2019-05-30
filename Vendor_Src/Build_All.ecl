import versioncontrol, _control, ut, tools,promotesupers,std,Vendor_Src,dops,Orbit3,Scrubs_Vendor_Src;

EXPORT Build_all(STRING pversion,STRING LogicalName, STRING SourceIP, STRING Directory, BOOLEAN pUseProd = TRUE ) := FUNCTION

spray:=Vendor_Src.fSpray(pversion,LogicalName, SourceIP, Directory);

ORBITdump:=Vendor_Src.StandardizeInputFile(pversion, pUseProd).ORBIT;
PromoteSupers.MAC_SF_BuildProcess(orbitdump,'~thor_data400::in::vendor_src::orbit', ExtractOrbit,2,,true,pversion);

built := sequential(
          
		      Create_Super_Files,
					
					spray,
					ExtractORBIT,
					Vendor_Src.Build_Base(pversion,pUseProd).all,
					Build_Keys(pversion,pUseProd),
					Vendor_Src.Promote.Promote_vendorsrc(pversion,pUseProd).buildfiles.Built2QA,
			    Build_Strata(pversion,pUseProd).all, 
					Scrubs_Vendor_Src.Vendor_Src_ScrubsPlus(pversion,Vendor_Src.Email_Notification_Lists.developer),
					DOPS.updateversion('VendorSourceKeys',pversion,Vendor_Src.Email_Notification_Lists.developer,,'N',,,,,,'F');
				  Orbit3.proc_Orbit3_CreateBuild_AddItem('Vendor Source Code Master List Lookup',pversion,'N',false, false,false,true,false,Vendor_Src.Email_Notification_Lists.developer),
				  ): success(Send_Email(pversion,pUseProd).BuildSuccess),
				  failure(send_email(pversion,pUseProd).BuildFailure) ;


return built;
end;