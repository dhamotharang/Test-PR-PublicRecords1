export Read_Boolean(string dname) := function
	string_rec := RECORD
		string20 word;
		unsigned integer4 nominal;
		unsigned integer3 suffix;
		unsigned integer8 freq;
		unsigned integer8 docfreq;
		unsigned integer8 fpos;
	END;
 
	drec := dataset([],string_rec);
	
	dindx := index(drec,{word},{drec},'~thor_data400::key::'+dname+'::qa::dictindx');
	
	string_rec2 := RECORD
		unsigned integer2 part;
		unsigned integer1 typ;
		unsigned integer4 nominal;
		unsigned integer2 src;
		unsigned integer6 doc;
		unsigned integer2 seg;
		unsigned integer4 kwp;
		unsigned integer1 wip;
		unsigned integer3 suffix;
		unsigned integer8 fpos;
	END;
	
	drec1 := dataset([],string_rec2);
	
	nidx := index(drec1,{part},{drec1},'~thor_data400::key::'+dname+'::qa::nidx');

	string_rec3 := record
		unsigned integer8 maxdocfreq;
		unsigned integer8 maxfreq;
		integer8 meandocsize;
		integer8 uniquenominals;
	end;

	ds := dataset('~thor_data400::base::'+dname+'::qa::dstat',string_rec3,thor);
	
	retval := parallel(
					output(choosen(dindx,100)),
					output(choosen(nidx,100)),
					output(ds)
					);

return retval;

end;