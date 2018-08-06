EXPORT MAC_GetPickListRecords(request_in, picklist_out, no_fail = false) := macro
import Gateway;

	gateways := Gateway.Configuration.Get();

	//soap call for remote DIDs
	//------------------------------------------------------------------------------------
	// 1. In case DID was provided through the #stored, create a request structure having just this DID
	//    (see also comment #2)
	#uniquename (did);
	unsigned6 %did% := 0 :stored('DID');

	#uniquename (SetLegacyRequest);
	recordof (request_in) %SetLegacyRequest% () := transform
		Self.SearchBy.UniqueId := (string12) %did%;
		Self := [];
	end;
	#uniquename (legacy_request);
	%legacy_request% := dataset ([%SetLegacyRequest% ()]);

	// convert an input into pick list input format
	#uniquename (picklist_request);
	#uniquename (SetPickListInput);
	iesp.person_picklist.t_PersonPickListRequest %SetPickListInput% (recordof(request_in) L) := transform
		self.options.ReturnUniqueIdsOnly := true;
		self := L;
		self := [];
		end;
	%picklist_request% := project (if(%did% !=0, %legacy_request%, request_in), %SetPickListInput% (Left));

	// 2. FCRA.PickListSoapcall contract guarantees that no soap call will be made if we have DID or UniqueID in the input
	picklist_out := FCRA.PickListSoapcall.esdl (gateways, %picklist_request%, , , no_fail);
	//------------------------------------------------------------------------------------

endmacro;
