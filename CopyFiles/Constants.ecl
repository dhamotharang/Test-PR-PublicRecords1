EXPORT Constants(string destespip, string destcluster, string srcdali) := module
	export dfuinfo := module
		
		export serv := 'server=http://'+destespip+':8010 ';
		export nsplit := ' nosplit=1 ';
		export dstcluster := 'dstcluster='+destcluster+' ';
		export over := 'overwrite=1 ';
		export repl := 'replicate=1 ';
		export action := 'action=copy ';
		export wrap := 'wrap=1 ';
		export transferbuffersize := 'transferbuffersize=100000 ';
		export connect := 'connect=200 ';
		export srcdali := 'srcdali='+srcdali+' ';
		
		
	end;
end;