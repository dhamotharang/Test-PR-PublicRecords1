//verify orphans on payload and override keys

export mac_orphans_validate(keydatasetname,datasetname,in_base = '',dsout, LexidField='\'\'',RecID1='\'\'',RecID2='\'\'',RecID3='\'\'',RecID4='\'\''):= macro

#uniquename(orphans)
#uniquename(payload_keys)
#uniquename(load_payload)

%orphans% := in_base(datagroup = STD.Str.ToUpperCase(datasetname));

//payload keys 
%payload_keys% := pull(overrides.payload_Keys.keydatasetname);

%load_payload% := table(%payload_keys%, {string12 did := (string)LexidField,
string100 RecID			:=	trim((string)RecID1) + trim((string)RecID2) + trim((string)RecID3) + trim((string)RecID4)}, LexidField,RecID1, RecID2, RecID3, RecID4, merge);

dsout := join(%load_payload%, %orphans%,	
	   left.RecID = right.RecID
		and (unsigned)left.DID=(unsigned)right.did
		,transform({boolean isinvalid, string RecID, string DID},
		 self.isinvalid	:=(unsigned)right.DID > 0, self := left),lookup);
	
		
endmacro;

	