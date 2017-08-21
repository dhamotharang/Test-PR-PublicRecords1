currentdate := Stringlib.GetDateYYYYMMDD();
Layout_Input := BuildFax_Services.Layout_BuildFax.input_rec_online;

export Interactive (Layout_Input input) := FUNCTION

// Soapcall to Service to pull BuildFax data from keys
Result := ServiceSoapcall(input);
// Result := ProcessBuildFax(input);
											
RETURN result;
end;