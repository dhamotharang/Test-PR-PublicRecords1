import UCC,Lib_KeyLib, lib_stringlib;
#workunit('name', 'CREATE UCC Filing Events Keys ' + ucc.UCC_Build_Date);

h := ucc.File_UCC_filing_events_Keybuild;

MyFields := record
h.orig_filing_num;            // Seisint Business Identifier
string2 file_state := lib_stringlib.stringlib.stringtouppercase(h.file_state);
h.filing_date;
h.filing_type;
h.document_num;
h.orig_filing_date;
h.__filepos;
end;
  
t := table(h, MyFields);

BUILDINDEX( t, {orig_filing_num,file_state,filing_date,filing_type,document_num,orig_filing_date,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Debtor + 'orig_filing_num.file_state.filing_date.filing_type.document_num.orig_filing_date.key', moxie,overwrite);
BUILDINDEX( t, {document_num,file_state,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Debtor + 'document_num.file_state.key', moxie,overwrite);