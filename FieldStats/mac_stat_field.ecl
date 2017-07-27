export mac_stat_field(inf, field, ftype, outf, fewormany = 'F', topcount = '50', flimit = 'false') := macro

#uniquename(statrec)
%statrec% := record
#if(flimit = true and ftype != 'number')
	string2 field := inf.field[1..2];
#else
	inf.field;
#end
	unsigned4	cnt := count(group);
end;

#uniquename(inf_filtered)
#if (ftype = 'string')
%inf_filtered% := inf(field != '');
#else 
	#if (ftype = 'number')
	%inf_filtered% := inf(field != 0);
	#else
	%inf_Filtered% := inf;
	#end
#end

#if (flimit = true and ftype != 'number')
	outf := topn(table(%inf_filtered%,%statrec%,field[1..2],few),topcount,-cnt);
#else
	#if(fewormany = 'F')
	outf := topn(table(%inf_filtered%,%statrec%,field,few),topcount,-cnt);
	#else 
		#if(fewormany = 'M')
			outf := topn(table(distribute(%inf_filtered%,hash(field)),%statrec%,field,local,many),topcount,-cnt);
		#else
			outf := topn(table(distribute(%inf_filtered%,hash(field)),%statrec%,field,local),topcount,-cnt);
		#end
	#end
#end

endmacro;
