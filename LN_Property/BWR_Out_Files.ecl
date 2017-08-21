//get additional names.  no fares records
import LN_Mortgage, ln_property, census_data, ut;

#workunit ('name', 'Build LNProp MOXIE output files');

//Function for unformatted apns
stripFormat(string apn) := stringlib.stringfilter(apn,
						'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');

an1 := LN_Property.File_Deed_Addl_Names;

LN_Mortgage.Layout_Moxie_Addl_Names getnames(an1 L) := transform
 self.ln_fares_id := 'RD' + l.ln_fares_id;
 self             := l;
end;

an2 := project(an1, getnames(left));

//one := output(an2,,'~thor_data400::out::ln_property_add_names' + thorlib.wuid(),__compressed__);

//get assessors
a3 := LN_Property.File_Assessment;

LN_Property.Layout_Moxie_Property_Common_Model_BASE getAssess(a3 L) := transform
 self.ln_fares_id := 'RA' + l.ln_fares_id;
 self.fares_unformatted_apn := if(l.ln_fares_id[1]!='R',stripFormat(l.apna_or_pin_number),l.fares_unformatted_apn);
 self.prior_recording_date := if(length(l.prior_recording_date) = length(stringlib.stringfilter(l.prior_recording_date,'0123456789')),
							l.prior_recording_date,'');
 self.fares_land_use           := if(l.vendor_source_flag in ['OKCTY','DAYTN'],l.standardized_land_use_code,  l.fares_land_use);
 self.fares_living_square_feet := if(l.vendor_source_flag in ['OKCTY','DAYTN'],(string)(integer)l.building_area,      l.fares_living_square_feet);
 self.fares_no_of_full_baths   := if(l.vendor_source_flag in ['OKCTY','DAYTN'],(string)(integer)l.no_of_baths,        l.fares_no_of_full_baths);
 self.fares_no_of_half_baths   := if(l.vendor_source_flag in ['OKCTY','DAYTN'],(string)(integer)l.no_of_partial_baths,l.fares_no_of_half_baths);
 self             := l;
end;

assess := project(a3, getAssess(left));

//two := output(assess,,'~thor_data400::out::ln_property_assessor' + thorlib.wuid(),__compressed__);

//get deeds
d3 := LN_Property.File_Deed;

LN_Mortgage.Layout_Moxie_Deed_Mortgage_Common_Model_Base getdeeds(d3 L) := transform
 self.ln_fares_id := 'RD' + l.ln_fares_id;
 self.fares_unformatted_apn := if(l.ln_fares_id[1]!='R',stripFormat(l.apnt_or_pin_number),l.fares_unformatted_apn);
 self             := l;
// self := [];
end;

deeds := project(d3, getDeeds(left));

//three := output(deeds,,'~thor_data400::out::ln_property_deeds' + thorlib.wuid(),__compressed__);

//get search records
s1 := ln_property.File_Search_DID;

LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search getsearch(s1 L) := transform
 self.ln_fares_id := if(l.ln_fares_id[2] = 'A', 'RA', 'RD') + l.ln_fares_id;
 self.did         := intformat(l.did,12,1);
 self.bdid        := intformat(l.bdid,12,1);
 self             := l;
end;

s2   := project(s1, getsearch(left));
s2d  := distribute(s2, hash(ln_fares_id));
s2fa := s2d(ln_fares_id[2]  = 'A'); 
s2fd := s2d(ln_fares_id[2] != 'A');

assessD := distribute(assess, hash(ln_fares_id));
deedsD  := distribute(deeds,  hash(ln_fares_id));
anDist  := distribute(an2,    hash(ln_fares_id));

//  Only use search records that are present in assess and deeds
//  Add source state when needed
LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search keepFormat1(assessD l, s2 r) := transform
 self.st := if(r.st='' and r.source_code[2]='P',l.state_code,r.st);
 self := r;
end;

LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search keepFormat2(deedsD l, s2 r) := transform
 self.st := if(r.st='' and r.source_code[2]='P',l.state,r.st);
 self := r;
end;

LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search keepFormat3(s2 l) := transform
 self := l;
end;

s3 := join(assessD, s2fa, left.ln_fares_id = right.ln_fares_id, keepFormat1(left, right), local); 
s4 := join(deedsD,  s2fd, left.ln_fares_id = right.ln_fares_id, keepFormat2(left, right), local); 
s5 := join(anDist,  s2d,  left.ln_fares_id = right.ln_fares_id, keepFormat3(right), local); 

s6 := s3 + s4 + s5;

//Look up

//four := output(s6,,'~thor_data400::out::ln_property_search' + thorlib.wuid(),__compressed__);

//Move out files into superfiles

ut.MAC_SF_Build_standard(an2,    ln_property.filenames.versionedOutAddlNames, one,   ln_property.version_build)
ut.MAC_SF_Build_standard(assess, ln_property.filenames.versionedOutAssessor,  two,   ln_property.version_build)
ut.MAC_SF_Build_standard(deeds,  ln_property.filenames.versionedOutDeed,      three, ln_property.version_build)
ut.MAC_SF_Build_standard(s6,     ln_property.filenames.versionedOutSearch,    four,  ln_property.version_build)

export BWR_Out_Files := parallel(one, two, three, four);