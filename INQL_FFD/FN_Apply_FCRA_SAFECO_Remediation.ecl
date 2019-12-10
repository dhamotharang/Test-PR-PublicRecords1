import inql_ffd, data_services;

export FN_Apply_FCRA_SAFECO_Remediation(dataset(INQL_FFD.Layouts.Base) base_file) := function

r:=RECORD
    STRING lexid;
    STRING date_added;
    STRING function_name;
    STRING transaction_id;
END;

fsafeco := dataset(data_services.foreign_fcra_logs + 'thor10_231::in::inquiry::remediation::safeco', r,  csv( separator(','), terminator(['\n', '\r\n']), heading(1)), opt);

new_base_file := join(base_file, fsafeco, 
                        left.transaction_id = right.transaction_id,
												transform(INQL_FFD.Layouts.Base, self:=left;),
										     left only, lookup);

return new_base_file;

end;
