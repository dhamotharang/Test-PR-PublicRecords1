// Process to build Bank Routing.
IMPORT ut,dops,_control,roxiekeybuild,VersionControl,bank_routing,SALT38,Scrubs_bank_routing;

EXPORT proc_build_all(STRING filedate, STRING filename) := FUNCTION
 #workunit('name','bank_routing Build');
 GroupName := VersionControl.GroupName('44');

 bank_routing.Mac_spray_accuity_bank_routing(_control.IPAddress.bctlpedata12,
  '/data/hds_180/accuity/indata/',
  filedate,
  filename,
  GroupName,
  SprayRaw);

 e_mail_success := fileservices.sendemail(Email_Notification_Lists.BuildSuccess,
  'bank_routing Roxie Build Succeeded ' + filedate,
  'keys: 1) thor_data400::key::bank_routing::qa::rtn(thor_data400::key::bank_routing::'+filedate+'::rtn),\n' +
  '      have been built and ready to be deployed to QA.');
							
 e_mail_fail := fileservices.sendemail(Email_Notification_Lists.BuildFailure,'bank_routing Roxie Build FAILED',failmessage);

 Bank_Routing.Layouts.base tPrepRaw(recordof(bank_routing.In_Accuity_Bank_Routing) l):=transform
  SELF.institution_name_full:=stringlib.StringToUpperCase(l.institution_name_full);
  SELF:=l;
  SELF:=[];
 END;

 dsBase := bank_routing.Files.base(address_type='B');
 
 rsFileRaw := project(bank_routing.In_Accuity_Bank_Routing,tPrepRaw(left));

 Ingest_File := bank_routing.Ingest(,,dsBase,rsFileRaw);

 Build_Base := bank_routing.proc_build_base(Ingest_File.AllRecords);

 Build_Keys := bank_routing.Proc_build_keys(filedate);

 //Update Roxie Page with Key Version
 UpdateRoxiePage := SEQUENTIAL(dops.updateversion('BankRTNKeys', filedate, Email_Notification_Lists.Roxie));

 Build_Process := SEQUENTIAL(
  SprayRaw,
  Build_Base,
  PARALLEL(
   Build_Keys,
   bank_routing.Out_Base_Stats_Population(filedate),
   //bank_routing.Proc_Build_Autokeys(filedate)),
  
  Scrubs_bank_routing.PostBuildScrubs(filedate)
	
	),UpdateRoxiePage
	): 
  SUCCESS(e_mail_success), 
  FAILURE(e_mail_fail);

 RETURN Build_Process;

END;