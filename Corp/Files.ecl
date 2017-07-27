import corp2;
export Files :=
module

	export V2 :=
	module
	
		export Events_father	:= Filters.V2.Events(corp2.Files('').input.events.used);
		export Cont_father		:= Filters.V2.Cont(corp2.Files('').input.cont.used);
		export Corp_father		:= Filters.V2.Corp(corp2.Files('').input.corp.used);

		export Events := Filters.V2.Events(corp2.Files('').input.events.sprayed);
		export Cont		:= Filters.V2.Cont(corp2.Files('').input.cont.sprayed);
		export Corp		:= Filters.V2.Corp(corp2.Files('').input.corp.sprayed);

	end;

end;