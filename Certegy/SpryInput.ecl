import _control, Scrubs, Scrubs_Certegy, tools, std, ut;

export SpryInput(string filedate) := function

	versionnum							 :=filedate;
	sourceDIR								 :='/data/hds_4/certegy/data/';
	Target									 :='~thor_data400::in::certegy::dl';
	sourceIP								 :=_Control.IPAddress.bctlpedata11;
	filename								 :=versionnum[3..]+'_certextr.dat';
	sourcepath1							 :=sourceDIR + versionnum + '/' + filename;
	maxrecordsize						 :=371;
	destinationgroup				 :=_Control.ThisCluster.GroupName;
	destinationlogicalname1	 :=Target + versionnum + thorlib.wuid();
	Email_list               :=Certegy.Send_Email(filedate).scrubs_report;							

	clear_sf		:=fileservices.clearsuperfile(Target);

	spry_file		:=fileservices.sprayfixed(sourceIP
																				,sourcepath1
																				,maxrecordsize
																				,destinationgroup
																				,destinationlogicalname1
																				,-1,,,true,true,true
																				);

	add_to_sf  :=fileServices.AddSuperFile(Target,destinationlogicalname1);
	scrub_file :=Scrubs.ScrubsPlus('Certegy','Scrubs_Certegy','Scrubs_Certegy_Raw_File','raw_file' ,filedate,Email_list,false);
	retval 		 :=sequential( clear_sf
													,spry_file
													,add_to_sf
													,scrub_file);
	return retval;

end;