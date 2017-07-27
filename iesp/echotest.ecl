export echotest := MODULE
			
export t_EchoTestRequest := record
	string ValueIn {xpath('ValueIn')};
	string TestOption {xpath('TestOption')}; //values['Normal','Soap Fault','Complex Soap Fault','AuthenticationError','']
end;
		
export t_EchoTestResponse := record
	string ValueOut {xpath('ValueOut')};
end;
		

end;

