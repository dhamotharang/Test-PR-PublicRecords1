export Mac_Spray_File(sourceIP,sourcefile,filedate,recordsize,ftype,jobname,gname,filename,fsep) := 
macro

#workunit('name',filename + ' spray ' + filedate)

#uniquename(spray_file)
#uniquename(spray_fixed)
#uniquename(spray_csv)
#uniquename(spray_xml)
#uniquename(fileprefix)
#uniquename(fieldsep)
#uniquename(fieldsepxml)
#uniquename(newsourceip)

// Pass hostname as first parameter instead of IP address

%newsourceip% := map(
									sourceIP = 'edata10' => _control.IPAddress.edata10,
									sourceIP = 'edata11' => _control.IPAddress.edata11,
									sourceIP = 'edata11b' => _control.IPAddress.edata11b,
									sourceIP = 'edata14' => _control.IPAddress.edata14,
									sourceIP = 'edata14a' => _control.IPAddress.edata14a,
									sourceIP = 'edata12' => _control.IPAddress.edata12,
									sourceIP
									);


%fieldsep% := if(fsep <> '\t','\\'+fsep,'\\t');
%fieldsepxml% := fsep;

%fileprefix% := if(gname = 'thor_dell400' or gname='thor_dataland_linux','thor_data400',gname);

%spray_fixed% := FileServices.SprayFixed(%newsourceip%,sourcefile, recordsize, gname,'~'+filename,-1,,,true,true);
%spray_csv% := Fileservices.SprayVariable(%newsourceip%,sourcefile,,%fieldsep%,,,gname,'~'+filename,-1,,,true,true);
%spray_xml% := Fileservices.SprayXML(%newsourceip%,sourcefile,,%fieldsepxml%,,gname,'~'+filename,-1,,,true,true);

//%spray_file% := if(ftype = 'fixed',%spray_fixed%,%spray_csv%);

%spray_file% := map(ftype = 'fixed' => %spray_fixed%,
					ftype = 'csv' => %spray_csv%,
					%spray_xml%);


sequential(%spray_file%);

endmacro;