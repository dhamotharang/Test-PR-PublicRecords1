import ut;
File_optin := (optincellphones.files.file_in2);

optincellphones.Layouts.layout_common t_make_common(file_optin le) := TRANSFORM
self.RecordNum:=le.recordnum;
self.FirstName:=stringlib.StringToUpperCase(stringlib.stringfilterout(le.firstname,'1234567890'));
self.LastName:=stringlib.StringToUpperCase(le.lastname);
self.Address:=stringlib.StringToUpperCase(le.address);
self.City:=stringlib.StringToUpperCase(le.city);
self.State:=stringlib.StringToUpperCase(le.state);
self.Zip5:=le.zip;
self.Zip4:=le.zip4;
self.Phone:=stringlib.stringfilterout(le.mobile,'-');;
self.EMail:=le.email;
self.Date:=le.lasttransactiondate;
self.IPAddress:=le.ipaddress;
self.Source:=le.source;
self.Status:=le.status;
self.Provider:='P1';
END;

proj_file_optin := project(file_optin,t_make_common(left));
with_file_optin := proj_file_optin(stringlib.stringfind(address,'+',1)>0);
wihtout_file_optin := proj_file_optin(stringlib.stringfind(address,'+',1)=0);

optincellphones.Layouts.layout_common t_remove(with_file_optin le) := transform
self.address := regexreplace('\\+',le.address,' ');
self := le;
end;

file_cln := project(with_file_optin,t_remove(left));

export Provider1 := wihtout_file_optin+file_cln;