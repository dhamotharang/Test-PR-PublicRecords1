EXPORT FN_DeleteQuery(STRING queryname, STRING roxieUrl, STRING roxiecluster,STRING composition_id):=FUNCTION
        publishendpoint :=roxieurl + 'WsWorkunits';
        layout_alias    := {QueryID {XPATH('QueryId')}:=queryname};
        layout_wupublish_in := {dataset(layout_alias)       Queries{XPATH('Queries/Query')}:=Dataset([{queryname}],layout_alias);STRING QuerySetName {XPATH('QuerySetName')} := roxiecluster,STRING Action {XPATH('Action')} := 'Delete'};
        layout_result:={STRING Name {XPATH('QueryId')},STRING Success {XPATH('Success')},STRING Suspended {XPATH('Suspended')},STRING Code {XPATH('Code')},STRING Message {XPATH('Message')}};
        layout_wupublish_out := {STRING Action {XPATH('Action')},STRING QuerySetName {XPATH('QuerySetName')},dataset(layout_result)     Results{XPATH('Results/Result')}};
        ds2:= SOAPCALL(publishendpoint,'WUQuerysetQueryAction',layout_wupublish_in, layout_wupublish_out,LITERAL,XPATH('WUQuerySetQueryActionResponse'));
 
        	  logging:=	map (ds2.results[1].Success=''=>
	  			$.Errors.CreateErr0('ECL_RUNTIMEERROR','Error deleting service ' + queryname , 
											'COMPOSITION',composition_id,0),
				$.Errors.CreateInfo('Successfully deleted service ' + queryname + ' on ' + $.Utils.stripuserurl(roxieUrl) + ' ' + roxiecluster ,
											'COMPOSITION',composition_id))   ;
											
				//RETURN OUTPUT(logging,NAMED('errors_' + $.HIPIEConfig.hipiehash + '_errors'),EXTEND);
				RETURN OUTPUT(logging,NAMED('_DeleteQuery'),EXTEND);
END;
 