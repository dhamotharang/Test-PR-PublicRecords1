import inql_v2, data_services;
export FN_Apply_FCRA_Remediation_Soft_Inquiry(dataset(INQL_FFD.Layouts.Base)  base_file) := module

rCapitalOne:=record
string uniqueid;
string transaction_id;
string transaction_timestamp;
end;
dCapitalOne := dataset(data_services.foreign_fcra_logs+'thor10_231::in::inquiry::remediation::capitalone', rCapitalOne,  csv( separator(','), terminator(['\n', '\r\n'])), opt);
tCapitalOne := table(dCapitalOne,{dCapitalOne.Transaction_Id});

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

tRemediation := tDiscover + tAmex + tCapitalOne;

export base_remediation := join(base_file,tRemediation,
         left.transaction_id 	= right.transaction_id, 
				 transform(recordof(base_file),
				 self.ppc := if(right.transaction_id <> '', '235',left.ppc);
				 self:=left),
				 Left outer, lookup
				 );

end;