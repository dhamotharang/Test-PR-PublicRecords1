export ClickData_Relative_SoapCall_With_Retry(dataset(layout_soapcall_in) data_in) := function
	
data_dst := distribute(data_in, random());
	
init_ip := 'http://10.173.192.' + (STRING)(thorlib.node() % 38 + 1) + ':9876';
rtry_ip := 'http://10.173.192.' + (STRING)(thorlib.node() % 2 + 39) + ':9876';

xlayout := record
	clickdata.layout_slim_out;
	string100 errorcode;
end;

xlayout get_FailMsg1(data_dst  le) := transform
	self.errorcode := FAILCODE + FAILMESSAGE;
	self := le;
	self := [];
end;
									
rslt_raw := soapcall(data_dst,init_ip,
		 		 'ClickData.ClickData_Relative_Search', {data_dst}, 
			 	 dataset(xlayout),
			 	 parallel(1), onFail(get_FailMsg1(LEFT)));

rslt_suc := rslt_raw(errorcode='');

//try the failed data on last two nodes
rslt_fal := rslt_raw(errorcode<>'');
rtry_in := table(rslt_fal,{rslt_fal.rid,rslt_fal.did});
rtry_dis := distribute(rtry_in, random());

xlayout get_FailMsg2(rtry_dis  le) := transform
	self.errorcode := FAILCODE + FAILMESSAGE;
	self := le;
	self := [];
end;

rtry_out := soapcall(rtry_dis,rtry_ip,
		 		 'ClickData.ClickData_Relative_Search', {rtry_dis}, 
			 	 dataset(xlayout),
			 	 parallel(1), onFail(get_FailMsg2(LEFT)));

rslt_out := rslt_suc + rtry_out;
						
clickdata.layout_slim_out get_slim_out(rslt_out l) := transform
	self := l;
end;
			
rslt_slm := project(rslt_out(errorcode=''), get_slim_out(left));
rslt := sort(rslt_slm, rid);		
			
return rslt;

end;