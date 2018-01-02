import doxie,Data_Services;
j := Telcordia_tpm_base;

slimrec := record	, MAXLENGTH(9999)
	j.npa;
	j.nxx;
	j.tb;
	j.dial_ind;
	j.point_id;
	j.nxx_type;
	dataset({string5 zip}) zipcodes;
end;

d := dataset('dummy',slimrec,flat);

export Key_tpm_slim := INDEX(d,{npa,nxx,tb},{d},Data_Services.Data_Location.Prefix('Telcordia')+'thor_data400::key::telcordia_tpm_slim_'+doxie.Version_SuperKey,OPT);