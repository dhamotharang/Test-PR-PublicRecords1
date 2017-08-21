/*
-- INFO FOR THOSE ENTERING DODGY DIDS --
ManualLink_Services.Overlink_StartHere_Service is how a user would mark mark an ADL as dodgy.

-- INFO FOR HEADER BUILD --
ManualLink_Services.files.UnApplied is the dataset that contains the ADLs that should be split.
ManualLink_Services.functions.MarkAsApplied() is how the header build would mark the records that had been applied to the header file.

-- BLOCKING PLATFORM BUG --
bug 39122
fixed  currently on build_0651_14 , dev dataland, 	http://10.173.88.201:8002/
BROKEN currently on build_0651_11,  prod, 					http://10.173.84.202:8002/

-- POTENTIAL FUTURE ENHANCEMENTS --
ability to click on a DID from FileView and then show all of those RIDs as they currently stand and the DID as it currently stands

-- TEST DIDS --
some good test dids are 3,6,7,8,13,14,15

-- SUPERFILE INFO --
//create superfiles
sequential(
	FileServices.CreateSuperFile(ManualLink_Services.files.overlink_qa_name),
	FileServices.CreateSuperFile(ManualLink_Services.files.overlink_father_name),
	FileServices.CreateSuperFile(ManualLink_Services.files.overlink_grandfather_name),
	FileServices.CreateSuperFile(ManualLink_Services.files.overlink_delete_name)
);

//populate them
	sequential(
		output(dataset([{10000000000001,[],'test','20010101',1,'','','','',''}],ManualLink_Services.layouts.overlink),,ManualLink_Services.files.base_name+ '_empty1',overwrite),
		FileServices.AddSuperFile(ManualLink_Services.files.overlink_qa_name, ManualLink_Services.files.base_name+ '_empty1'),
		output(dataset([{10000000000002,[],'test','20010101',1,'','','','',''}],ManualLink_Services.layouts.overlink),,ManualLink_Services.files.base_name+ '_empty2',overwrite),
		FileServices.AddSuperFile(ManualLink_Services.files.overlink_father_name, ManualLink_Services.files.base_name+ '_empty2'),
		output(dataset([{10000000000003,[],'test','20010101',1,'','','','',''}],ManualLink_Services.layouts.overlink),,ManualLink_Services.files.base_name+ '_empty3',overwrite),
		FileServices.AddSuperFile(ManualLink_Services.files.overlink_grandfather_name, ManualLink_Services.files.base_name+ '_empty3')
	)

//CAREFUL - if you want to clear them all out and delete everything
	sequential(
		FileServices.ClearSuperFile(ManualLink_Services.files.overlink_qa_name, TRUE),
		FileServices.ClearSuperFile(ManualLink_Services.files.overlink_father_name, TRUE),
		FileServices.ClearSuperFile(ManualLink_Services.files.overlink_grandfather_name, TRUE)
	);



*/