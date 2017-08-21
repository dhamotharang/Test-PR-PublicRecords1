import FraudPoint3;

EXPORT proc_build_all(string filedate):= function


build_all := sequential(FraudPoint3.proc_build_base, FraudPoint3.proc_build_key(filedate));


return  build_all;


end;