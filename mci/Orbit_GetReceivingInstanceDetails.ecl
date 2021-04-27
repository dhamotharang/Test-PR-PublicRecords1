EXPORT Orbit_GetReceivingInstanceDetails :=  module

import UPI_DataBuild;

export layout := record
	string	ReceivingStatus;
	string	SourceName;
	string	DatasetName;
	string	ReceiveDate;
	string	ReportingStartDate;
	string	ReportingEndDate;
end;


export action(string instance, string my_tok = UPI_DataBuild.Orbit_Login()) := function

my_details := UPI_DataBuild.Orbit_GetReceivingInstanceStatus(instance , my_tok);


myrow := row(transform(layout,
	self.ReceivingStatus := my_details.ReceivingStatus;
	self.SourceName := my_details.SourceName;
	self.DatasetName := my_details.DatasetName;
	self.ReceiveDate := my_details.ReceiveDate;
	self.ReportingStartDate := my_details.ReportingStartDate;
	self.ReportingEndDate := my_details.ReportingEndDate));


return myrow;

end;

end;  // module

