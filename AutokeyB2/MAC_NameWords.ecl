export MAC_NameWords(indataset,inbname,
            infein,
            phone,
            inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
            inlookups,
            inbdid,
            inkeyname,outkey,by_lookup=TRUE, favor_lookup=0) :=
MACRO
import ut, doxie, Business_Header_SS;

#uniquename(indata)
%indata% := indataset;

/*
THIS IS LITTLE MORE THAN A PLACE HOLDER...NEED COMPANY NAME WORDS OR PHONETICS, AT LEAST
*/

#uniquename(proj)
#uniquename(p)
#uniquename(q)
#uniquename(f)
#uniquename(recs)
Business_Header_SS.layout_MakeCNameWords %proj%(%indata% le) :=
TRANSFORM
  self.company_name := le.inbname;
  self.state := le.inst;
  self.bdid := le.inbdid;
  self.__filepos := 0;
  self.lookups := le.inlookups | ut.bit_set(0,0);
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

// Remove duplicates before expanding out words because fn_MakCNameWords now takes into account
// the lookup field before rolling up/deduping

%q% := if(by_lookup,%p%,
      dedup(sort(%p%,company_name,state,bdid,if(ut.bit_test(lookups,favor_lookup),0,1),-lookups),
        company_name,state,bdid));
%f% := business_header_ss.Fn_MakeCNameWords(%q%);


%recs% := dedup( sort (project(%f%, AutokeyB2.Layout_NameWords)(word<>'') , record,except seq,local), record,except seq,local );


outkey := INDEX(%recs%,//{%recs%.word,%recs%.state,%recs%.seq,%recs%.bdid}),
{%recs%},
inkeyname+'NameWords2' + '_' + doxie.Version_SuperKey);

ENDMACRO;

