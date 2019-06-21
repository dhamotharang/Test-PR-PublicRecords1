lay:=RECORD
integer seq;
string src_field;
string desti_field;
END;

EXPORT RULES:=dataset([
                { 1, 'date_vendor_first_reported_', 'dt_vendor_first_reported'},
                { 1, 'date_vendor_last_reported_', 'dt_vendor_last_reported'}
							 ],lay);

