import _control, versioncontrol, UPI_DataBuild;

EXPORT Build_asHeader_V2(
			 string				pVersion
			,boolean			pUseProd
			,string				gcid
			,string				pHistMode
			,string100		gcid_name
			,string10			batch_jobid) := module

			shared dBuildasHeader := UPI_DataBuild.Create_asHeader_V2(pVersion,pUseProd,gcid,pHistMode,gcid_name,batch_jobid).Build_it;
			VersionControl.macBuildNewLogicalFile(
																			 UPI_DataBuild.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).asHeader.new
																		 	,dBuildasHeader
																			,Build_asHeader_File
																			);
			shared full_build	:=  
				sequential(				
				 		 Build_asHeader_File
						,Promote_V2.promote_asHeader(pVersion, pUseProd, gcid, pHistMode).buildfiles.New2Built);
	
			export asHeader_all	:=
				if(VersionControl.IsValidVersion(pVersion[1..8])
						,full_build
						,output('No Valid version parameter passed, skipping asHeader build')
				);
	END;
