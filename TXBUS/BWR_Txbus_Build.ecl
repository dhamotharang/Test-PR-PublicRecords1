import Tools;

// Please fill the version date.
version_date := '20070625';
pIsTesting   := Tools._Constants.IsDataland;

#if (trim(version_date,left, right) = '') 
	output('BUIDLD FAILED!!! - Version_date not provided.');
#else
    #workunit('name','Txbus Build -'+version_date);
    TXBUS.Proc_build_Txbus(version_date,pIsTesting);  
#end

//export BWR_Txbus_Build := 'todo';