IMPORT yellowpages,Cellphone,utilfile;

EXPORT fn_phonetype(string filedate) := function

infile := utilfile.file_util.full_did;
infile_supp := utilfile.file_supplemental.in_supp;
infile_has_phone := (infile + infile_supp)(phone <> ''); 
infile_has_work_phone := (infile + infile_supp)(work_phone <> ''); 

//append phonetype and blank out invalid phone numbers
yellowpages.NPA_PhoneType(infile_has_phone, phone, phonetype, infile_phonetype);
yellowpages.NPA_PhoneType(infile_has_work_phone, work_phone, phonetype, infile_workphonetype);

//create phonetype table

outfile_phonetype := project(infile_phonetype, 
transform(utilfile.layout_phonetype, self.phone := left.phone, self.phonetype := left.phonetype)) 
+ project(infile_workphonetype, 
transform(utilfile.layout_phonetype, self.phone := left.work_phone, self.phonetype := left.phonetype));

phone_dedup := dedup(distribute(outfile_phonetype,hash(phone)),all,local);
	
phone_out := output(phone_dedup,,'~thor_data400::out::util_phonetype_' + filedate, __compressed__, overwrite);

//add util invalid phone to superfile

add_super := sequential(FileServices.StartSuperFileTransaction(),
               FileServices.RemoveOwnedSubFiles('~thor_data400::base::utility_phonetype',true),
               Fileservices.addsuperfile('~thor_data400::base::utility_phonetype','~thor_data400::out::util_phonetype_' + filedate),
							 FileServices.FinishSuperFileTransaction());

build_phonetype := sequential(phone_out,add_super);

return build_phonetype;

end;
