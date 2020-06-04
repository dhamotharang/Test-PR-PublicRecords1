import did_add,FCRA_ExperianCred,PromoteSupers;

EXPORT Proc_re_did_FCRA_EN(string version) := function

d:=FCRA_ExperianCred.Files.Base;

matchset := ['A','Z','D','S','P'];

did_add.MAC_Match_Flex
	(d, matchset,					
	 ssn,dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone, 
	 DID, fcra_experiancred.Layouts.base, true, did_score,
	 75, d_did,true,src);

PromoteSupers.MAC_SF_BuildProcess(d_did,'~thor_data400::base::fcra::experiancred',re_did_It,numgenerations:='2',pCompress:=true,pVersion:=version);

input_clear:=sequential(
	fileservices.RemoveOwnedSubFiles('~thor_data400::base::FCRA::ExperianCredheader_building',true)
	,fileservices.clearsuperfile('~thor_data400::base::FCRA::ExperianCredheader_building')
	);

input_set	:= if(fileservices.getsuperfilesubcount('~thor_data400::base::FCRA::ExperianCredheader_building')>0,
				output('Nothing added to Base::FCRA::ExperianCredHeader_Building'),
				fileservices.addsuperfile('~thor_data400::base::FCRA::ExperianCredheader_building','~thor_data400::base::FCRA::experiancred',,true));

return sequential(
		re_did_It
		,input_clear
		,input_set
		);

END;																				