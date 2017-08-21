import ut,bbb2;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Spray all BBB Member and Non-Member Input files
// -- Please run on hthor for maximum speed
//////////////////////////////////////////////////////////////////////////////////////////////
export MAC_Spray_InputFiles(sourceIP,sourcedirectory,receiveddate,group_name='\'thor400_60\'') := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(member_directory_filter)
#uniquename(nonmember_directory_filter)
#uniquename(member_directory_listing)
#uniquename(nonmember_directory_listing)
#uniquename(member_files_count)
#uniquename(nonmember_files_count)

#uniquename(output_Server)
#uniquename(output_Directory)
#uniquename(output_member_directory_listing)
#uniquename(output_nonmember_directory_listing)
#uniquename(output_Member_Superfile_Name)
#uniquename(output_NonMember_Superfile_Name)
#uniquename(output_member_thor_filenames)
#uniquename(output_nonmember_thor_filenames)
#uniquename(output_value_types)

#uniquename(layout_thor_names)
#uniquename(AddThorName)
#uniquename(member_thor_filenames)
#uniquename(nonmember_thor_filenames)

#uniquename(SprayBBB)
#uniquename(AddSuper)
#uniquename(Add_Super_member_files)
#uniquename(Add_Super_nonmember_files)
#uniquename(spray_member_files)
#uniquename(spray_nonmember_files)
#uniquename(spray_files)

#uniquename(Member_Superfile_Subfiles)
#uniquename(NonMember_Superfile_Subfiles)
#uniquename(output_Member_Superfile_Subfiles)
#uniquename(output_NonMember_Superfile_Subfiles)
#uniquename(output_Superfile_Subfiles)

#uniquename(send_completion_email)

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Set value types
//////////////////////////////////////////////////////////////////////////////////////////////
%member_directory_filter%		:= 'memberfile*out';
%nonmember_directory_filter% 	:= 'nonmember*out';

%member_directory_listing% 		:= FileServices.remotedirectory(sourceIP,sourcedirectory,%member_directory_filter%);
%nonmember_directory_listing% 	:= FileServices.remotedirectory(sourceIP,sourcedirectory,%nonmember_directory_filter%);

%member_files_count%			:= count(%member_directory_listing%);
%nonmember_files_count%			:= count(%nonmember_directory_listing%);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Create unique thor names for each file to be sprayed
//////////////////////////////////////////////////////////////////////////////////////////////
%layout_thor_names% := 
record
	string 	unix_name;
	string 	logical_filename;
	string 	super_filename;
	string 	sprayed_filename;
end;

%layout_thor_names% %AddThorName%(lib_Fileservices.FsFilenameRecord l, unsigned4 cnt, string bbbtype) := 
transform
	self.logical_filename	:= if(bbbtype = 'M',bbb2.Filenames.MemberNewInput(receiveddate, cnt), 
								bbb2.Filenames.NonMemberNewInput(receiveddate, cnt));
	self.super_filename		:= if(bbbtype = 'M',bbb2.Filenames.MemberInput, 
								bbb2.Filenames.NonMemberInput);
	self.sprayed_filename	:= if(bbbtype = 'M',bbb2.Filenames.MemberSprayedInput, 
								bbb2.Filenames.NonMemberSprayedInput);
	self.unix_name 			:= l.name;
end;

%member_thor_filenames% 	:= project(%member_directory_listing%,		%AddThorName%(left, counter, 'M'));
%nonmember_thor_filenames%	:= project(%nonmember_directory_listing%,	%AddThorName%(left, counter, 'N'));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Output value types
//////////////////////////////////////////////////////////////////////////////////////////////
%output_Server% 						:= output(sourceip, named('Server'));
%output_Directory% 						:= output(sourcedirectory, named('Directory'));
%output_member_directory_listing%		:= output(%member_directory_listing%, named('MemberDirectoryListing'),all);
%output_nonmember_directory_listing%	:= output(%nonmember_directory_listing%, named('NonMemberDirectoryListing'),all);

%output_Member_Superfile_Name% 			:= output(bbb2.Filenames.MemberInput, named('MemberInputSuperfileName'));
%output_NonMember_Superfile_Name% 		:= output(bbb2.Filenames.NonMemberInput, named('NonMemberInputSuperfileName'));

%output_member_thor_filenames%			:= output(%member_thor_filenames%, named('MemberThorFilenames'),all);
%output_nonmember_thor_filenames%		:= output(%nonmember_thor_filenames%, named('NonMemberThorFilenames'),all);

%output_value_types% := sequential(
	 %output_Server%
	,%output_Directory%
	,%output_member_directory_listing%
	,%output_nonmember_directory_listing%
	,%output_Member_Superfile_Name%
	,%output_NonMember_Superfile_Name%
	,%output_member_thor_filenames%
	,%output_nonmember_thor_filenames%
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Spray Files
//////////////////////////////////////////////////////////////////////////////////////////////
%SprayBBB%(string psourceIP, string sourcepath, string LogicalFilename,string pgroup_name) :=
	lib_fileservices.FileServices.SprayXml(psourceIP,sourcepath, 8192, 'listing',
				'utf8', pgroup_name,	LogicalFilename);

%AddSuper%(string LogicalFilename, string SuperFilename, string SprayedFilename) :=
	nothor(sequential(FileServices.AddSuperFile(SuperFilename,	LogicalFilename),
	FileServices.AddSuperFile(SprayedFilename,	LogicalFilename)));

%spray_member_files%		:= APPLY(%member_thor_filenames%, 
			%SprayBBB%(sourceip,sourcedirectory + unix_name, logical_filename, group_name));

%Add_Super_member_files%	:= APPLY(%member_thor_filenames%, 
			%AddSuper%(logical_filename, super_filename, sprayed_filename));

%spray_nonmember_files%		:= APPLY(%nonmember_thor_filenames%, 
			%SprayBBB%(sourceip,sourcedirectory + unix_name, logical_filename, group_name));

%Add_Super_nonmember_files%	:= APPLY(%nonmember_thor_filenames%, 
			%AddSuper%(logical_filename, super_filename, sprayed_filename));

%spray_files% := sequential(
	 %spray_member_files%
	,%Add_Super_member_files%
	,%spray_nonmember_files%
	,%Add_Super_nonmember_files%
);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- List the Superfile subfiles
//////////////////////////////////////////////////////////////////////////////////////////////
ut.MAC_ListSubFiles_seq(bbb2.Filenames.MemberInput,%Member_Superfile_Subfiles%)
ut.MAC_ListSubFiles_seq(bbb2.Filenames.NonMemberInput,%NonMember_Superfile_Subfiles%)

%output_Member_Superfile_Subfiles%		:= output(%Member_Superfile_Subfiles%,		named('CurrentListOfMemberInputSubfiles'),all);
%output_NonMember_Superfile_Subfiles%	:= output(%NonMember_Superfile_Subfiles%,	named('CurrentListOfNonMemberInputSubfiles'),all);

%output_Superfile_Subfiles% := sequential(
	 %output_Member_Superfile_Subfiles%
	,%output_NonMember_Superfile_Subfiles%
);
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Send email notification
//////////////////////////////////////////////////////////////////////////////////////////////
%send_completion_email% := bbb2.Send_Emails.SprayCompletion(%member_files_count%,%nonmember_files_count%);


sequential(
		 %output_value_types%
		,%spray_files%
		,%output_Superfile_Subfiles%
		,%send_completion_email%
);

endmacro;