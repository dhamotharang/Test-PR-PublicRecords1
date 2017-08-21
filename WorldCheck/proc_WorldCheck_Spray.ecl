import WorldCheck,lib_FileServices,_Control;

export proc_WorldCheck_Spray (string filename
                             ,string filedate) := function

#uniquename(spray_main)
#uniquename(super_main)
#uniquename(sourceCsvSeparator)
#uniquename(sourceCsvTeminator)
#uniquename(groupname)
#uniquename(Layout_In_File)
#uniquename(outfile)
#uniquename(Layout_In_File2)
#uniquename(outfile2)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)

#workunit('name','World Check ' + filedate + ' Spray ');

%sourceCsvSeparator% := '\\t';
%sourceCsvTeminator% := '\\n,\\r\\n';
%groupname% := 'thor400_44';

//used to remove oversized records
%spray_main% := fileservices.SprayVariable(_Control.IPAddress.bctlpedata10
                                          //,'/data_999/world_check/data/'+filedate+'/'+filename
										  ,filename
										  ,100000
										  ,'\t'
										  ,'\\n,\\r\\n'
										  ,'"'
										  ,%groupname%
										  ,WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data'
										  ,
										  ,
										  ,
										  ,true
										  ,true
										  ,false);   										  

%Layout_In_File% := record, maxlength(70000)
	WorldCheck.Layout_WorldCheck_in2;
end;

%Layout_In_File% trfProject(%Layout_In_File% l) := transform
   self.UID 				:= l.UID[1..10];
    self.Last_Name			:= l.Last_Name[1..225];
    self.First_Name			:= l.First_Name[1..225];
    self.Aliases			:= l.Aliases[1..5000];               
    self.Alternate_Spelling	:= l.Alternate_Spelling[1..225];     
    self.Category			:= l.Category[1..225];
    self.Title				:= l.Title[1..225];
    self.Sub_Category		:= l.Sub_Category[1..32];
    self.Position			:= l.Position[1..225];
    self.Age				:= l.Age[1..3];
    self.Date_Of_Birth		:= l.Date_Of_Birth[1..10];
    self.Places_Of_Birth	:= l.Places_Of_Birth[1..225];        
    self.Date_Of_Death		:= l.Date_Of_Death[1..10];
    self.Passports			:= l.Passports[1..600];              
    self.Social_Security_Number	:= l.Social_Security_Number[1..255]; 
    self.Locations			:= l.Locations[1..3100];              
    self.Countries			:= l.Countries[1..25];
    self.Companies			:= l.Companies[1..4000];              
    self.E_I_Ind			:= l.E_I_Ind[1];
    self.Linked_Tos			:= l.Linked_Tos[1..2000];             
    self.Further_Information	:= l.Further_Information[1..5000];
    self.Keywords			:= l.Keywords[1..300];               
    self.External_Sources	:= l.External_Sources[1..5000];       
    self.Entered			:= l.Entered[1..10];
    self.Updated			:= l.Updated[1..10];
    self.Editor				:= l.Editor[1..20];
    self.Age_As_Of_Date		:= l.Age_As_Of_Date[1..10];
	self					:= l;
end;

%outfile% := distribute(project(dataset(WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data'
                                       ,%Layout_In_File%
							           ,csv(heading(1)
							               ,separator('\t')
							               ,terminator(['\r\n','\r','\n'])
										   ,quote('"')
								           ,maxlength(70000)
								           )
							           )//(uid<>'39165')
					           ,trfProject(left))
					   ,hash32(UID));


%Layout_In_File2% := record, maxlength(30900)
	WorldCheck.Layout_WorldCheck_in;
end;

%Layout_In_File2% trfProject2(%outfile% l) := transform
	self := l;
end;

%outfile2% := project(%outfile%,trfProject2(left));

%ds% := output(%outfile2%,,WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::Data',overwrite);

%temp_delete% := if (FileServices.FileExists(       WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data')
                    ,FileServices.DeleteLogicalFile(WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data'));

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Delete',
				                            WorldCheck.cluster_name + 'in::WorldCheck::Grandfather',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Grandfather'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Grandfather',
				                            WorldCheck.cluster_name + 'in::WorldCheck::Father',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Father'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Father', 
				                            WorldCheck.cluster_name + 'in::WorldCheck',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck', 
    				                        WorldCheck.cluster_name + 'in::WorldCheck::' + filedate + '::Data'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck.cluster_name   + 'in::WorldCheck::Delete',true));


#uniquename(do_super)
%do_super%  := sequential(%spray_main%
                           ,%ds%
						   ,%super_main%
						   ,%temp_delete%
				   
						   
						   );

return sequential(%do_super%);

end;
