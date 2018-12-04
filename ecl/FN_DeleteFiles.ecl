EXPORT FN_DeleteFiles(STRING espURL='', SET OF STRING logicalfiles):=FUNCTION
		publishendpoint :=espURL + 'WsDfu';
		layout_in := {STRING Type {XPATH('Type')} := 'Delete',
			STRING removeFromSuperfiles {XPATH('removeFromSuperfiles')}:='1',
			SET OF STRING LogicalFiles {XPATH('LogicalFiles/Item')}:=logicalfiles
		};
	 
		l_message:={STRING Value {XPATH('Value')}};
		l_dfuarrayactionresult:=RECORD
				DATASET(l_message) message {XPATH('Message')};
		END	;
		l_result:=RECORD
			l_dfuarrayactionresult DFUArrayActionResult{XPATH('DFUArrayActionResult')};
		END;
	 
		ds2:= SOAPCALL(publishendpoint,'DFUArrayAction',layout_in, l_result,LITERAL,XPATH('DFUArrayActionResponse'));
	 
		logs:=PROJECT(ds2.DFUArrayActionResult.Message,TRANSFORM($.Errors.Layout,
			SELF:=ecl.Errors.CreateInfo('Deleting unused subindexes : ' + LEFT.Value,'COMPOSITION','ecl.DeleteFileFunction')[1];
		 ));
		 
		 RETURN OUTPUT(logs,NAMED('_DeleteFiles'),EXTEND);
	 
	END;