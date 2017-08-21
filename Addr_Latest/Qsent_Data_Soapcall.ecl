export Qsent_Data_Soapcall(dataset(layout_qsent_soap_in) data_in) := function
	
data_dst := distribute(data_in, random());
	
xlayout := record
	addr_latest.layout_qsent_soap_out;
	string errorcode;
end;

xlayout get_FailMsg(data_dst  le) := transform
	self.errorcode := FAILCODE + FAILMESSAGE;
	self := le;
	self := [];
end;
	
rslt_raw := soapcall(data_dst,'http://10.173.4.' + (STRING)(random() % 10 + 3) + ':9876',
		 		 'doxie.HeaderFileSearchService', {data_dst}, 
			 	 dataset(xlayout),
				 parallel(1), onFail(get_FailMsg(LEFT)));
				
addr_latest.layout_qsent_soap_out get_slim_out(rslt_raw l) := transform
	self := l;
end;
			 
rslt := project(rslt_raw(errorcode='', rid<>''), get_slim_out(left));

return rslt;

end;