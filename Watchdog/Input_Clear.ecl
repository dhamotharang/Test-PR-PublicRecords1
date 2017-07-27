export Input_Clear := parallel(
fileservices.clearsuperfile('~thor_data400::BASE::PropDeedHeader_Building'),
fileservices.clearsuperfile('~thor_data400::BASE::PropAssesHeader_Building'),
fileservices.clearsuperfile('~thor_data400::BASE::PropSrchHeader_Building'),
fileservices.clearsuperfile('~thor_data400::BASE::UtilityHeader_Building'));