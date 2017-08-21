import lib_stringlib;

Layouts_Flagler.document.fixed doc2fixed(Files_raw.Flagler.File_In_raw_document l) := transform
  self.InstrumentNumber        := trim(l.InstrumentNumber);
  self.UnmappedDocType         := lib_stringLib.StringLib.StringFilterOut(l.UnmappedDocType,'-');
  self                         := l;
  end;
  
dInFixed := project(Files_raw.Flagler.File_In_raw_document,doc2fixed(LEFT));
  

Layouts_Flagler.prior.fixed prior2fixed(Files_raw.Flagler.File_In_raw_prior l) := transform
self.InstrumentNumber       := l.InstrumentNumber;
  self.lf                   := '';
  self                      := l;
  end;
  
priorInFixed := project(Files_raw.Flagler.File_In_raw_prior,prior2fixed(LEFT));
  

Layouts_Flagler.party.fixed party2fixed(Files_raw.Flagler.File_In_raw_party l) := transform
	self.InstrumentNumber   := trim(l.InstrumentNumber);
  self.EntityNm           := trim(l.EntityNm)[1..74];
  self                    := l;
  end;
  
ptyInFixed := project(Files_raw.Flagler.File_In_raw_party,party2fixed(LEFT));
  
  
Layouts_Flagler.Layout_common dpcommon(dInFixed l,priorInFixed r) := transform
  self                := l;
	self                := r;
  self.EntitySequence := '';
  self.EntityTypeCode := '';
  self.EntityNm       := '';
end;

jdocprior      := join(distribute(dInFixed,hash(InstrumentNumber)),
                       distribute(priorInFixed,hash(InstrumentNumber)),
											 LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
											 dpcommon(LEFT,RIGHT),LEFT OUTER,local);

Layouts_Flagler.Layout_common dpptyall(jdocprior l,ptyInFixed r) := transform
self.EntitySequence := r.EntitySequence;
  self.EntityTypeCode := r.EntityTypeCode;
  self.EntityNm := r.EntityNm;
  self := l;
  end;
  
export File_In_FL_Flagler := join(jdocprior,
                                  distribute(ptyInFixed,hash(InstrumentNumber)),
																	LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
																	dpptyall(LEFT,RIGHT),LEFT OUTER,local);
  

