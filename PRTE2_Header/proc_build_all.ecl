IMPORT PRTE2_Watchdog,PRTE2_Infutor;
EXPORT proc_build_all(string filedate) := function

 #workunit('name','PRTE[Header,Watchdog,Relatives,Infutor,Slimsort]'+filedate);
 do_all := sequential(
                         PRTE2_Header.proc_build_base(filedate)
                        ,PRTE2_Header.proc_build_keys(filedate).step1
                        ,PRTE2_Watchdog.proc_build_base(filedate)
                        ,PRTE2_Watchdog.proc_build_keys(filedate).step1
                        ,PRTE2_Infutor.proc_build_all(filedate)
												,PRTE2_Header.proc_build_slimsort(filedate)
                        
                     );
 return do_all;
end;