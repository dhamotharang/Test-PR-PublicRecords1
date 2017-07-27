
// Please fill the version date.
version_date := '20070723';

#if (trim(version_date,left, right) = '') 
	output('BUIDLD FAILED!!! - Version_date not provided.');
#else
    #workunit('name','CALBUS Build -'+version_date);
    CALBUS.Proc_build_Calbus(version_date);  
#end

//export BWR_Calbus_Build := 'todo';