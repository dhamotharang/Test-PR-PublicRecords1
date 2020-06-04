import inql_v2, data_services;
export FN_Apply_AMEX_Remediation(dataset(INQL_v2.Layouts.Common_ThorAdditions) base_file) := module

r:=record
string Julian_Date;
string Transaction_ID;
end;

damex := dataset(data_services.foreign_fcra_logs + 'uspr::inql::fcra::amex_transactions', r,  csv( separator(','), terminator(['\n', '\r\n'])), opt)
         (trim(Julian_Date) <>'Date');

export base_amex_remediation := join(base_file,damex,
         left.search_info.transaction_id 	= right.transaction_id, 
				 transform(recordof(base_file),
				 self.permissions.fcra_purpose := if(right.transaction_id <> '', '166',left.permissions.fcra_purpose);
				 self:=left),
				 Left outer, lookup
				 );

end;
				 