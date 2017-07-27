import atf;

// temp layout created to convert string12 did_out to unsigned6 type and added
// other fields zero/blank for passing into autokey build.

temp_layout_searchFileATF := RECORD
	 recordof (ATF.layout_firearms_explosives_out and not [did_out,persistent_record_id,lf]);
	 unsigned8 ATF_id := 0;
	 unsigned1 zero:=0;
	 string1 blank:= '';
	 unsigned6 did_out6 := 0;
	 unsigned6 bdid6;
	 
END; 
 
temp_layout_searchFileATF xform(searchFileATF_bid l) := transform

	self.did_out6 := l.did;
	self.ATF_id := l.ATF_id;
	self.bdid6 := (unsigned6) L.bdid;
	self := l;
END;
  
export file_atf_firearms_autokey_bid := project(searchFileATF_bid, xform(left));
