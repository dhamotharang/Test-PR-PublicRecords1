import doxie_cbrs;


boolean multiBDID := (business_header.stored_bdid_val[1] = '{');

boolean use_Supergroup := business_header.stored_useSupergroup;

bdid_value := business_header.stored_bdid_value;

supergroup_ds := doxie_cbrs.ds_SupergroupLevels();

 

pattern bdidlistval := pattern('[0-9]*');

pattern bdidpatt := ('{' or ',') bdidlistval before (',' or '}');

 

#uniquename(rec)

%rec% := {unsigned6 bdid := (unsigned6)matchtext(bdidlistval)};

%rec% slimit(supergroup_ds l) := transform

            self := l;

end;

 

//decide if you want the supergroup bdids or just the subject bdid

export bdiddataset := if(multiBDID,

                   parse(dataset([{business_header.stored_bdid_val}],{string bdidlist}),bdidlist,bdidpatt,%rec%,scan),

                                                                                                             if(use_Supergroup,

                                                                                                             project(supergroup_ds, slimit(left)),

                                                                                                             dataset([bdid_value], %rec%)));
