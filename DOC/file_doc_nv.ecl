export file_doc_nv := module

import ut;

export alias := dataset('~thor_data400::in::doc::nv::alias.txt', DOC.layout_doc_nv.alias,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')) );
						

						
export booking := dataset('~thor_data400::in::doc::nv::booking.txt', DOC.layout_doc_nv.booking,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')) );
						

						
export demographic := dataset('~thor_data400::in::doc::nv::demographic.txt', DOC.layout_doc_nv.demographic,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')) );
						


export release := dataset('~thor_data400::in::doc::nv::release.txt', DOC.layout_doc_nv.release,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')) );
						
						
DOC.layout_doc_nv.cmbndFile tr1(demographic L, booking R) := transform
self := L;
self := R;
self :=[];
end;

jrecs1 := join(demographic,booking,
				left.offender_id = right.offender_id,
				tr1(left,right), left outer,lookup);
				
				
DOC.layout_doc_nv.cmbndFile tr2(jrecs1 L, alias R) := transform
self := L;
self := R;
self :=[];
end;

jrecs2 := join(jrecs1,alias,
				left.offender_id = right.offender_id,
				tr2(left,right), left outer,lookup);	
				
DOC.layout_doc_nv.cmbndFile tr3(jrecs2 L, release R) := transform
self.release_date := R.release_date;	
self.release_desc := R.release_desc;
self := L;
self :=[];
end;

jrecs3 := join(jrecs2,release,
				left.offender_id = right.offender_id,
				tr3(left,right), left outer,lookup) : persist('~thor_data400::persist::doc::nv::cmbndFiles.txt');

export cmbndFiles := jrecs3;				
end;