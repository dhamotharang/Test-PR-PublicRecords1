import OSHAIR, _control;

#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(sourceCsvSeparator)
#uniquename(sourceCsvTeminator)
#uniquename(sourceCsvQuote)
#uniquename(Layout_In_File)
#uniquename(Layout_In_File_V2)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)

%sourceCsvSeparator% := ',';
%sourceCsvTeminator% := '\\n,\\r\\n';
%sourceCsvQuote% := '\"';

%doCleanup% := FileServices.DeleteLogicalFile('~thor_data400::lookup::oshair::city_codes_temp');

%deleteIfExist% := if(FileServices.FileExists('~thor_data400::lookup::oshair::city_codes_temp')
                     ,%doCleanup%);
%spray_main% := FileServices.SprayVariable(_Control.IPAddress.edata12
                                          ,'/hds_4/oshair/data/lookup/OSHAIR_City_Code_Table.csv'
										  ,9999
										  ,%sourceCsvSeparator%
										  ,%sourceCsvTeminator%
										  ,%sourceCsvQuote%
										  ,'thor400_92'
										  ,'~thor_data400::lookup::oshair::city_codes_temp'
										  ,-1
										  ,
										  ,
										  ,true
										  ,true);

sequential(%deleteIfExist%,%spray_main%);

city_code_rec := record,maxlength(40)
	string City_Code_ID;  
	string City_Name;
end;

city_code_data := dataset('~thor_data400::lookup::oshair::city_codes_temp'
                    ,city_code_rec
					,csv(separator(',')
						,terminator(['\r\n','\n']))
				    );

count(city_code_data);

output(city_code_data,all);

deduped_city_code_data := dedup(city_code_data,all);

count(deduped_city_code_data);

output(deduped_city_code_data,,'~thor_data400::lookup::oshair::city_codes',overwrite);
