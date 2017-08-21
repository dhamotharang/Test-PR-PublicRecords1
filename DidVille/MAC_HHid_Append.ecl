//Add option to do a pull join if the code will be running on THOR
export MAC_HHid_Append(infile,supply,outfile,pulljoin=false) := MACRO

IMPORT doxie,PRTE2_Header;

#uniquename(add_flds)

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
Key_Did_HDid:= PRTE2_Header.Key_Did_HDid;
#ELSE
Key_Did_HDid:= doxie.Key_Did_HDid;
#END

typeof(infile) %add_flds%(infile le, Key_Did_HDid ri,string options) := transform
  self.hhid := MAP ( stringlib.stringfind(options,'HHID_RELATIVES',1)<>0 OR
										 stringlib.stringfind(options,'HHID_PLUS',1)<>0  => ri.hhid_relat,
                     stringlib.stringfind(options,'HHID_NAMES',1)<>0 => ri.hhid_indiv,
                     ri.hhid );

  self := le;
  end;

#IF(pulljoin = TRUE)
  outfile := join(DISTRIBUTE(infile, DID),DISTRIBUTE(PULL(key_did_hdid), DID),
                  left.did != 0 AND 
                  left.did=right.did AND
                  right.ver = 1,
                  %add_flds%(left,right,supply),left outer,local);
#else
  outfile := join(infile,key_did_hdid,
                  left.did != 0 AND 
                  left.did=right.did AND
                  right.ver = 1,
                  %add_flds%(left,right,supply),left outer);									
#end
ENDMACRO;