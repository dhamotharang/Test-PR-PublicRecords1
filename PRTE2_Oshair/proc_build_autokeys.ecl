IMPORT OSHAIR, standard, Address, AutoKeyB2, ut,
autokey,doxie,ut,business_header,Business_Header_SS,RoxieKeyBuild;

export proc_build_autokeys(string filedate) := function

dbase := files.file_out_inspection_cleaned (Continuation_Flag = ''
                                           OR Continuation_Flag = '1');

layout_autokey_app := RECORD (layouts.layout_autokeys)
  unsigned1 zero := 0;
  string1 blank  := '';
  unsigned6 fdid := 0; // false did
END;

// project to standard address
layout_autokey_app tra (dbase l) := TRANSFORM
	SELF.addr.prim_range    := l.prim_range;
	SELF.addr.predir        := l.predir;
	SELF.addr.prim_name     := l.prim_name;
	SELF.addr.addr_suffix   := l.addr_suffix;
	SELF.addr.postdir       := l.postdir;
	SELF.addr.unit_desig    := l.unit_desig;
	SELF.addr.sec_range     := l.sec_range;
	SELF.addr.p_city_name   := l.p_city_name;
	SELF.addr.v_city_name   := l.v_city_name;
	SELF.addr.st            := l.st;
	SELF.addr.zip5          := l.zip5;
	SELF.addr.zip4          := l.zip4;
	SELF.addr.fips_state    := l.fips_state;
	SELF.addr.fips_county   := l.fips_county;
	SELF.addr.addr_rec_type := l.addr_rec_type;
	SELF                    := l;
end;

DS_oshair := PROJECT (dbase, tra (Left));

AutoKeyB2.MAC_Build (DS_oshair, blank, blank, blank,
                     zero,
                     zero,
                     zero,
                     addr.prim_name, addr.prim_range, addr.st, addr.v_city_name, addr.zip5, addr.sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     fdid,
                     //personal above.  business below
                     cname,
                     FEIN_append,
                     zero,
                     addr.prim_name, addr.prim_range, addr.st, addr.v_city_name, addr.zip5, addr.sec_range,
                     bdid,
                     constants.ak_keyname, constants.ak_logical(filedate), outaction, false,  //diffing
                     constants.ak_skipset, true, constants.ak_typestr, // use fakes
                     true,,,zero);  //useOnlyRecordIDs

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, move2qa,,constants.ak_skipset);

retval := sequential(outaction
                     ,move2qa);
										 
return retval;

end;

