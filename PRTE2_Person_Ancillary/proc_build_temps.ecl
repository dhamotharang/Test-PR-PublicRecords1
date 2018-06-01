Import prte2_header, PromoteSupers;

EXPORT Proc_Build_temps := FUNCTION
																 
DS:=   Project(prte2_header.files.header_pre_keybuild(ssn<>'' AND ssn[1..5] <>'00000'), layouts.Layout_Header);  
										 
DS2:=   Project(prte2_header.files.header_pre_keybuild(ssn<>'' AND ssn[1..5] <>'00000'), layouts.layout_header_v2_dl);    
        						
PromoteSupers.MAC_SF_BuildProcess(DS,constants.AncillaryTemp, writefile);
PromoteSupers.MAC_SF_BuildProcess(DS2,constants.AncillaryTempB, writefile2);

ReturnBase := sequential(writefile,writefile2);

return ReturnBase;
end;
