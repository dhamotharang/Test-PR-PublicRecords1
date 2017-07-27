export ThisCluster
 :=
  module
	shared	rClusterHelper
	 :=
	  record,maxlength(1024)
		string		GroupName;
		string		QueueName;
		string		FilePrefix;
	  end
	 ;
	shared	dClusterHelper	:=	dataset('_control.thiscluster.helper',rClusterHelper,csv(heading(0),separator('|'),terminator('\n'),maxlength(1024)));
	
	export	string	GroupName	:=	dClusterHelper[1].GroupName;
	export	string	QueueName	:=	dClusterHelper[1].QueueName;
	export	string	FilePrefix	:=	dClusterHelper[1].FilePrefix;
  end
 ;
