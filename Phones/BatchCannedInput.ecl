EXPORT BatchCannedInput := MODULE
	EXPORT PhonesAttribute := dataset([
		{'101', '2012042665'}, //disconnected
		{'102', '2012047066'}, //disconnected
		{'103', '2012046538'}, //disconnected
		{'104', '2012000023'}, //ported phone
		{'105', '2012000065'}, //ported phone
		{'106', '2012000165'}, //ported phone
		{'107', '2012001516'}, //ported phone and line
		{'108', '2012040232'}, //ported phone and line
		{'109', '2012001590'}, //ported phone and line
		{'110', '2013547790'}, //ported phone
		{'111', '2018785503'}, //ported phone
		{'112', '2017761884'}, //swapped number
		{'113', '2012070971'}, //suspended
		{'114', '2012060184'}, //disconnected
		{'115', '2012069861'}, //suspended
		{'116', '2012061419'}, //suspended-reactivated
		{'117', '2012077757'}, //suspended-reactivated 
		{'118', '2012060963'}, //suspended-reactivated 
		{'119', '5407472291'}, //no specific event
		{'220', '4079820087'}, //no specific event
		{'221', '2012000404'}, //disconnected
		{'222', '2012070180'}, //swapped number
		{'223', '2039771550'},
		{'224', '2107235607'},
		{'225', '2606670832'},
		{'226', '7123551103'},
		{'227', '8146917031'},
		{'228', '8146917038'},
		{'229', '8179250089'},
		{'230', '8322857096'},
		{'231', '8595122317'},
		{'232', '9713195484'}],
		Phones.Layouts.PhoneAttributes.BatchIn);
END;