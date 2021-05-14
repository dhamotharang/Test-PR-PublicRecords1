EXPORT Orbit_GetReceivingInstanceDetails :=  module

import UPI_DataBuild__dev;

export layout := record
	// string	MemberId;
	// string	DWId;
	string	ReceivingStatus;
	// string	FileName;
	string	SourceName;
	string	DatasetName;
	// string	DataType;
	// boolean IsItemOnHold;
	// boolean IsTestItem;
	// string	ItemName;
	// string	ItemUpdateType;
	// string	ItemStatus;
	string	ReceiveDate;
	string	ReportingStartDate;
	string	ReportingEndDate;
end;


export action(string instance, string my_tok = UPI_DataBuild__dev.Orbit_Login()) := function

my_details := UPI_DataBuild__dev.Orbit_GetReceivingInstanceStatus(instance , my_tok);


myrow := row(transform(layout,
	// self.MemberId := my_details.MemberId;
	// self.DWId := my_details.DWId;
	self.ReceivingStatus := my_details.ReceivingStatus;
	// self.FileName := my_details.FileName;
	self.SourceName := my_details.SourceName;
	self.DatasetName := my_details.DatasetName;
	self.ReceiveDate := my_details.ReceiveDate;
	self.ReportingStartDate := my_details.ReportingStartDate;
	self.ReportingEndDate := my_details.ReportingEndDate));


return myrow;

end;

end;  // module

