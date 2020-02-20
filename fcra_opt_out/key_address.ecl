import doxie, data_services, vault, _control;

f_optout := fcra_opt_out.file_infile_appended;

slim_optout := record
f_optout.z5;
f_optout.prim_range;
f_optout.prim_name;
f_optout.sec_range;
f_optout.ssn;
f_optout.did;
f_optout.source_flag;
f_optout.julian_date;
f_optout.inname_first;
f_optout.inname_last;
f_optout.address;
f_optout.city;
f_optout.state;
f_optout.zip5;
f_optout.did_score;
f_optout.ssn_append;
f_optout.permanent_flag;
f_optout.Opt_Back_in;
f_optout.date_YYYYMMDD;
end;

tbl_address := table(f_optout,
		slim_optout,
		z5,prim_range,prim_name,sec_range,ssn,did,source_flag,julian_date,inname_first,inname_last,address,
			city,state,zip5,did_score,ssn_append,permanent_flag,opt_back_in,date_YYYYMMDD,few);

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_address := vault.fcra_opt_out.key_address;
#ELSE
export key_address := index(tbl_address(z5<>'' and prim_range <> '' and prim_name <> ''),
                            {z5,prim_range,prim_name,sec_range},
                            {tbl_address},
                            data_services.data_location.prefix() + 'thor_data400::key::fcra::optout::address_'+doxie.Version_SuperKey);

#END;							

