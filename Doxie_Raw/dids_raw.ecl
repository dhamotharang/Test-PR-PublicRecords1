import Doxie;

//For did: project to Layout_references.
dsInput := dataset([], Doxie_Raw.Layout_input) : stored('header_src_in',few);

Doxie.layout_references toDid(Doxie_Raw.Layout_input fileL) := Transform
    self.did := (unsigned6)fileL.id;
End;

export dids_raw := project(dsInput(idtype = 'DID'), toDid(left));


