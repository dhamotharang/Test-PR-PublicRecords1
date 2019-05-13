import versioncontrol, _control, ut, tools,promotesupers,std,Vendor_Src,dops,Orbit3;

EXPORT Build_all(STRING pversion,STRING LogicalName, STRING SourceIP, STRING Directory, BOOLEAN pUseProd = TRUE ) := FUNCTION

spray:=Vendor_Src.fSpray(pversion,LogicalName, SourceIP, Directory);

ORBITdump:=Vendor_Src.StandardizeInputFile(pversion, pUseProd).ORBIT;
PromoteSupers.MAC_SF_BuildProcess(orbitdump,'~thor_data400::in::vendor_src::orbit', ExtractOrbit,2,,true,pversion);

built := sequential(
          
		      //Create_Super_Files, // Need un comment and run once in case if superfiles doesnt exist on thor
					
					spray,
					ExtractORBIT,
					Vendor_Src.Build_Base(pversion,pUseProd).all,
					Build_Keys(pversion,pUseProd).all,
					Vendor_Src.Promote.Promote_vendorsrc(pversion,pUseProd).buildfiles.Built2QA,
			    Build_Strata(pversion,pUseProd).all, 
					// dops.updateversion('VendorSourceKeys',pversion,Vendor_Src.Email_Notification_Lists.developer,,'N');
				  // Orbit3.proc_Orbit3_CreateBuild_AddItem('VendorSourceKeys',pversion,'N',false, false,false,true,false,Vendor_Src.Email_Notification_Lists.developer),
				  ): success(Send_Email(pversion,pUseProd).BuildSuccess),
				  failure(send_email(pversion,pUseProd).BuildFailure) ;


return built;
end;