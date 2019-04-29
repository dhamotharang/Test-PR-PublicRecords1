export MAC_HHid_Append(infile,supply,outfile) := MACRO

IMPORT dx_header;

#uniquename(key_did_hhid);
key_did_hhid := dx_header.key_did_hhid();

#uniquename(add_flds)
typeof(infile) %add_flds%(infile le, key_did_hhid ri,string options) := transform
  self.hhid := MAP ( stringlib.stringfind(options,'HHID_RELATIVES',1)<>0 OR
										 stringlib.stringfind(options,'HHID_PLUS',1)<>0  => ri.hhid_relat,
                     stringlib.stringfind(options,'HHID_NAMES',1)<>0 => ri.hhid_indiv,
                     ri.hhid );

  self := le;
  end;

  outfile := join(infile,key_did_hhid,
	  left.did != 0 AND 
	  left.did=right.did AND
	  right.ver = 1,
	  %add_flds%(left,right,supply),left outer);
  
  ENDMACRO;