﻿import doxie, data_services, vault, _control;

f_optout := fcra_opt_out.file_infile_appended;

slim_optout := record
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

tbl_ssn := table(f_optout,slim_optout,ssn,did,source_flag,julian_date,inname_first,inname_last,address,
			city,state,zip5,did_score,ssn_append,permanent_flag,opt_back_in,date_YYYYMMDD,few);


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_ssn := vault.fcra_opt_out.key_ssn;
#ELSE
export key_ssn := index(tbl_ssn((unsigned)ssn<>0),
                {unsigned6 l_ssn := (unsigned)ssn},{did,source_flag,julian_date,inname_first,inname_last,address,
								city,state,zip5,did_score,ssn_append,permanent_flag,opt_back_in,date_YYYYMMDD},
                data_services.data_location.prefix() + 'thor_data400::key::fcra::optout::ssn_'+doxie.Version_SuperKey);

#END;							


