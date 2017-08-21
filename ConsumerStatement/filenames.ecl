EXPORT filenames(string environment) := module
	export base := '~thor::';
	export datafile := base + 'base::consumerstatement::'+environment+'::qa::data';
	export rawfile := base + 'in::consumerstatement::'+environment+'::qa::data';
	export buildkeys := module
		export keyname(string suffix) := base + 'key::consumerstatement::'+environment+'::@version@::' + suffix;
		
	end;
	export readkeys := module
		export keyname(string suffix) := base + 'key::consumerstatement::'+environment+'::qa::' + suffix;
		
	end;
end;