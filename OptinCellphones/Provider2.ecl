import ut;
File_optin := (optincellphones.files.file_in(field1<>''));

optincellphones.Layouts.layout_common t_make_common(file_optin le) := TRANSFORM
self.RecordNum:='';
self.FirstName:=stringlib.StringToUpperCase(stringlib.stringfilterout(le.fname,'1234567890'));
self.LastName:=stringlib.StringToUpperCase(le.lname);
self.Address:=stringlib.StringToUpperCase(le.address);
self.City:=stringlib.StringToUpperCase(le.city);
self.State:=stringlib.StringToUpperCase(le.state);
self.Zip5:=le.zip[1..5];
self.Zip4:=le.zip[7..10];
self.Phone:=stringlib.stringfilterout(le.phone,'-');
self.EMail:='';
self.Date:=le.date;
self.IPAddress:='';
self.Source:=le.field1;
self.Status:='';
self.Provider:='P2';
END;

proj_file_optin := project(file_optin,t_make_common(left));
with_file_optin := proj_file_optin(stringlib.stringfind(address,'+',1)>0);
wihtout_file_optin := proj_file_optin(stringlib.stringfind(address,'+',1)=0);

optincellphones.Layouts.layout_common t_remove(with_file_optin le) := transform
self.address := regexreplace('\\+',le.address,' ');
self := le;
end;

file_cln := project(with_file_optin,t_remove(left));

export Provider2 := wihtout_file_optin+file_cln;