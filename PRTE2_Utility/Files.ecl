import utilFile;

EXPORT Files := module

	
	export infile1		:= dataset(constants.in_prefix_name, layouts.incoming,CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  export inIns:=   dataset(constants.in_ins, layouts.incoming,CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	export infile    :=infile1 + inIns;
//base files
	export basefile	:= dataset(constants.base_prefix_name, layouts.base, thor);
	export misc2b		:= dataset([], layouts.misc);
	
	
//Files for Indexes
utilfile.mac_convert_util_type(basefile, full_did_out);

shared full_did_out2:=full_did_out;

export full_did_for_index := full_did_out2(did!='0');

export full_did_for_index_bdid := full_did_out2(did='0');

export full_did_for_index_address := full_did_out2;


layouts.did_out t(full_did_for_index le, unsigned6 i) :=
TRANSFORM
	SELF.fdid := (unsigned6)le.did + i;
	SELF := le;
END;
export util_daily := PROJECT(full_did_for_index, t(LEFT, COUNTER));

export SearchAutokey := project(util_daily, transform(layouts.autokey, self := left, self := []));

export header_utility := project(basefile, layouts.as_header);
end;