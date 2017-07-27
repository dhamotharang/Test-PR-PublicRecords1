export ClickData_Relative_SoapCall(dataset(layout_soapcall_in) data_in) := function
	
data_dst := distribute(data_in, random());

r_ip := 'http://10.173.192.' + (STRING)(thorlib.node() % 40 + 1) + ':9876';
	
xlayout := record
	clickdata.layout_slim_out;
	string errorcode;
end;

xlayout get_FailMsg(data_dst  le) := transform
	self.errorcode := FAILCODE + FAILMESSAGE;
	self := le;
	self := [];
end;
									
rslt_raw := soapcall(data_dst,r_ip,
		 		 'ClickData.ClickData_Relative_Search', {data_dst}, 
			 	 dataset(xlayout),
			 	 parallel(1), onFail(get_FailMsg(LEFT)));
								
clickdata.layout_slim_out get_slim_out(rslt_raw l) := transform
	self := l;
end;
			
rslt_slm := project(rslt_raw(errorcode=''), get_slim_out(left));
rslt := sort(rslt_slm, rid);		
			
return rslt;

end;