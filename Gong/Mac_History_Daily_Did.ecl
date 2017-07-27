import gong;

export Mac_History_Daily_Did(infile,did_field,outfile) := macro

#uniquename(did_history_key)
%did_history_key% := gong.key_history_did;

#uniquename(get_history_by_did)
%did_history_key% %get_history_by_did%(%did_history_key% r) := transform
	self := r;
end;

#uniquename(gong_did_history)
outfile := join(infile, %did_history_key%, keyed(left.did_field = right.l_did), 
                        %get_history_by_did%(right), LIMIT (ut.limits .GONG_HISTORY_MAX, SKIP));

endmacro;