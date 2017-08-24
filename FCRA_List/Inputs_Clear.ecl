export Inputs_Clear := sequential(
fileservices.RemoveOwnedSubFiles('~thor_data400::Base::ProfLicFCRAHeader_Building',true)
,fileservices.Clearsuperfile('~thor_data400::Base::ProfLicFCRAHeader_Building'));