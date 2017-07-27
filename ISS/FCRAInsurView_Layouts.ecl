import riskview, iesp, Models;

EXPORT FCRAInsurView_Layouts := MODULE

	EXPORT 	Layout_Attributes_In := RECORD
		string name;
	END;

 EXPORT Layout_in_put:= RECORD
	riskview.layouts.layout_riskview_input;
 	STRING100 employer_name := '';
	STRING20 lname_prev := '';
	END;

EXPORT FCRAInsurViewAttributesResponseWAcct := RECORD
	iesp.fcrainsurviewattributes.t_FCRAInsurViewAttributesResponse;
	STRING AccountNumber;
	UNSIGNED6 UniqueId;
END;

EXPORT Layout_rvAttrSeqWithAddrAppendWFlags := RECORD
	Models.Layout_RVAttributes.Layout_rvAttrSeqWithAddrAppend;
	BOOLEAN ClearFields;
	BOOLEAN ExperianTransaction;
END;

end;