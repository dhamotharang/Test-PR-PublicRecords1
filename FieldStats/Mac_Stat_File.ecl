/*
	at least one field, with type and flag.
	you will compare top 'topc' results
	'fldc' is a field count - refers to how many fields you are running stats on	
	'basename' names the saved stats output file in a '~thor_data400::stats::basename_' pattern
	fldlimit = a boolean, if true, stat is run on 1st 2 char of strings only
	ftypex = 'string' | 'number' | '' -- controls filter on field 
		    string means "field != ''" 
		    number means "field != 0"
		    blank means no filter
	
	flagx  = 'F' | 'M' | '' -- controls 'few' or 'many' (or neither) on crosstab

*/

export Mac_Stat_File(inf, seqname, basename, topc, fldc, fldlimit,
					field1, ftype1, flag1,
				     field2 = '', ftype2 = '', flag2 = '',
					field3 = '', ftype3 = '', flag3 = '',
					field4 = '', ftype4 = '', flag4 = '',
					field5 = '', ftype5 = '', flag5 = '',
					field6 = '', ftype6 = '', flag6 = '',
					field7 = '', ftype7 = '', flag7 = '') := macro

#uniquename(foo)
%foo% := true;

#uniquename(outf)
FieldStats.mac_stat_generic(inf,%outf%,topc,fldc, fldlimit,
				field1,ftype1,flag1,
				field2,ftype2,flag2,
				field3,ftype3,flag3,
				field4,ftype4,flag4,
				field5,ftype5,flag5,
				field6,ftype6,flag6,
				field7,ftype7,flag7)
				
#uniquename(do1)
ut.MAC_SF_BuildProcess(%outf%,'~thor_data400::stats::' + basename,%do1%,3)

#uniquename(rec)
%rec% := record, maxlength(150000)
	%outf%;
end;


#uniquename(oldf)
%oldf% := dataset('~thor_data400::stats::' + basename + '_FATHER',%rec%,flat, opt);

#uniquename(o1)
#uniquename(o1f)
#uniquename(o2)
#uniquename(o2f)
#uniquename(o3)
#uniquename(o3f)
#uniquename(o4)
#uniquename(o4f)
#uniquename(o5)
#uniquename(o5f)
#uniquename(o6)
#uniquename(o6f)
#uniquename(o7)
#uniquename(o7f)

FieldStats.mac_compare_topn(%outf%,%oldf%,field1,%o1%);
FieldStats.mac_compare_topn_by_fldval(%outf%,%oldf%,field1,%o1f%);

#if (fldc > 1)
FieldStats.mac_compare_topn(%outf%,%oldf%,field2,%o2%)
FieldStats.mac_compare_topn_by_fldval(%outf%,%oldf%,field2,%o2f%)
#else
%o2% := [];
%o2f% := [];
#end

#if (fldc > 2)
FieldStats.mac_compare_topn(%outf%,%oldf%,field3,%o3%)
FieldStats.mac_compare_topn_by_fldval(%outf%,%oldf%,field3,%o3f%)
#else
%o3% := [];
%o3f% := [];
#end

#if (fldc > 3)
FieldStats.mac_compare_topn(%outf%,%oldf%,field4,%o4%)
FieldStats.mac_compare_topn_by_fldval(%outf%,%oldf%,field4,%o4f%)
#else
%o4% := [];
%o4f% := [];
#end

#if (fldc > 4)
FieldStats.mac_compare_topn(%outf%,%oldf%,field5,%o5%)
FieldStats.mac_compare_topn_by_fldval(%outf%,%oldf%,field5,%o5f%)
#else
%o5% := [];
%o5f% := [];
#end

#if (fldc > 5)
FieldStats.mac_compare_topn(%outf%,%oldf%,field6,%o6%)
FieldStats.mac_compare_topn_by_fldval(%outf%,%oldf%,field6,%o6f%)
#else
%o6% := [];
%o6f% := [];
#end

#if (fldc > 6)
FieldStats.mac_compare_topn(%outf%,%oldf%,field7,%o7%)
FieldStats.mac_compare_topn_by_fldval(%outf%,%oldf%,field7,%o7f%)
#else
%o7% := [];
%o7f% := [];
#end

seqname := sequential(%do1%,output(%o1%), output(%o1f%), 
			output(%o2%), output(%o2f%), 
			output(%o3%), output(%o3f%), 
			output(%o4%), output(%o4f%), 
			output(%o5%), output(%o5f%), 
			output(%o6%), output(%o6f%), 
			output(%o7%), output(%o7f%));

endmacro;
