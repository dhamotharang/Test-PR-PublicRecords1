import BO_Address;

export CleanFirmName(const string firmname1, const string firmname2 = '')
       := function  	
	
	clean := BO_Address.CleanFirmName(firmname1, firmname2,Address.Constants.CorrectServer,Address.Constants.CorrectPort);
  return clean; 

end;  // Function