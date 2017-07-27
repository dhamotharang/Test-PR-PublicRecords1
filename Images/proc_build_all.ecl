
email_success := FileServices.sendemail('jlezcano@seisint.com; cmaroney@seisint.com','images build successful','Images have been successfully built on prod200.');
email_fail := FileServices.sendemail('jlezcano@seisint.com; cmaroney@seisint.com','images build failed!','Image build has failed on prod200.');

export proc_build_all := sequential(proc_build_base,proc_build_keys, proc_accept_sk_to_qa, email_success) : failure(email_fail);
