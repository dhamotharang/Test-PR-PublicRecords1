

//Use file date from directory name

file_date := '20181116';

//file_date := '20181018';

#workunit('name','Infutor_NARC3 ' + file_date);
#OPTION('multiplePersistInstances',FALSE);
Infutor_NARC3.proc_build_all(file_date);