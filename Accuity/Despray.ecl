export Despray(string logicalname, string destinationIP , string destinationpath) :=

fileservices.Despray(logicalname,
	destinationIP,
	destinationpath,
	allowoverwrite := true);
