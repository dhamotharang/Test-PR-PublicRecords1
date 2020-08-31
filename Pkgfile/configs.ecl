EXPORT configs(string clustername = '') := module
	export integer generations := 10;
	export string storedcluster := 'fcra' : stored('cluster');
	export string cluster := if (clustername <> '', clustername, storedcluster);
	export string env := 'qa' : stored('env');
end;