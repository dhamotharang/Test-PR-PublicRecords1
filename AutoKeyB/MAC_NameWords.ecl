export MAC_NameWords(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,outkey) :=
MACRO
import ut, doxie,business_header;

#uniquename(indata)
%indata% := indataset;

/*
THIS IS LITTLE MORE THAN A PLACE HOLDER...NEED COMPANY NAME WORDS OR PHONETICS, AT LEAST
*/

#uniquename(proj)
#uniquename(p)
#uniquename(f)
#uniquename(recs)
Business_Header_SS.layout_MakeCNameWords %proj%(%indata% le) :=
TRANSFORM
	self.company_name := le.inbname;
	self.state := le.inst;
	self.bdid := le.inbdid;
	self.__filepos := 0;
END;
%p% := PROJECT(%indata%, %proj%(LEFT));

%f% := business_header_ss.Fn_MakeCNameWords(%p%);


%recs% := dedup( sort (project(%f%, autokeyb.Layout_NameWords)(word<>'') , record,except seq), record,except seq );
  
outkey := INDEX(%recs%,//{%recs%.word,%recs%.state,%recs%.seq,%recs%.bdid}), 
{%recs%}, 
inkeyname+'NameWords' + '_' + doxie.Version_SuperKey);

ENDMACRO;

