import inql_v2, data_services;
export FN_Apply_FCRA_Remediation_Soft_Inquiry(dataset(INQL_v2.Layouts.Common_ThorAdditions) base_file) := module

rDiscover:= RECORD
    string LN_TRAN_ID;
    string LN_TRSFRM_TMS;
    string LN_BILL_GRP;
    string Transaction_ID;
    string Timestamp;
    string XML_ID;
END;
dDiscover := dataset(data_services.foreign_fcra_logs + 'thor10_231::in::inquiry::remediation::discover', rDiscover,  csv( separator(','), terminator(['\n', '\r\n'])), opt);
tDiscover := table(dDiscover,{dDiscover.Transaction_Id});

rAmex:=record
string Julian_Date;
string Transaction_ID;
end;
dAmex := dataset(data_services.foreign_fcra_logs + 'uspr::inql::fcra::amex_transactions', rAmex,  csv( separator(','), terminator(['\n', '\r\n'])), opt)
         (trim(Julian_Date) <>'Date');
tAmex := table(dAmex,{dAmex.transaction_id});

tRemediation := tDiscover + tAmex;

export base_remediation := join(base_file,tRemediation,
         left.search_info.transaction_id 	= right.Transaction_ID, 
				 transform(recordof(base_file),
				 self.permissions.fcra_purpose := if(right.transaction_id <> '', '166',left.permissions.fcra_purpose);
				 self:=left),
				 Left outer, 
                 lookup
				 );

end;