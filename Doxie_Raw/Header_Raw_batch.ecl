import doxie_raw, ut, header, suppress, Doxie, Infutor;

inrec := doxie_raw.Layout_HeaderRawBatchInput;
outrec := inrec;

export Header_Raw_batch(
	grouped dataset(inrec) inputs
	) := 
FUNCTION

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

is_knowx := mod_access.isConsumer ();

kh := IF(is_knowx,Infutor.Key_Header_Infutor_Knowx,Doxie.Key_Header);


midrec := record
	outrec.input input;
	kh;
	doxie_raw.Layout_Filters;
	inputs.input.probation_override_Value;
	inputs.input.ssn_mask_value;
	boolean glb_ok;
	boolean dppa_ok;
	string9 ssn_unmasked := '';
end;



Fetch1_MACRO(key,fetch_out) := MACRO
#uniquename(getHeader)
midrec %getHeader%(inputs l, key fileR) := TRANSFORM
  self := fileR;
	self.glb_ok := doxie.compliance.glb_ok(l.input.glb_purpose);
	self.dppa_ok := doxie.compliance.dppa_ok(l.input.dppa_purpose);
	self.input := l.input;
	self := l.input;
	self := [];
END;

fetch_out := join(inputs, key, 
							 left.input.did > 0 and
							 keyed(left.input.did = right.s_did),
							 %getHeader%(left, right), atmost(ut.limits.HEADER_PER_DID), left outer);
ENDMACRO;
Fetch1_MACRO(Infutor.Key_Header_Infutor_Knowx,infr_out)
Fetch1_MACRO(doxie.Key_Header,hdr_out)
fetch1 := if(is_knowx,infr_out,hdr_out);

mod_access_local := MODULE (mod_access)
  EXPORT string5 industry_class := '';
  EXPORT boolean no_scrub := FALSE;
END;  

header.MAC_GlbClean_Header(Fetch1,Fetched10,true, , mod_access_local);

fetched := fetched10(dateVal = 0 OR dt_first_seen <= dateVal);

suppress.MAC_Mask(fetched,out_mskd,ssn,blank,true,false,true,true);
doxie.mac_HeaderDates(out_mskd,out_hd,true)

ut.MAC_Slim_Back(out_hd, outrec, outf);


m2 := dedup(sort(outf, whole record), whole record);

return m2;
END;