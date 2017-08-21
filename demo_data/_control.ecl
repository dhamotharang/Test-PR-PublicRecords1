export _control 
 :=
  module
    export  string  prod_thor_dali  :=  '10.173.84.201';
	export  string  prod_thor_esp 	:=  '10.173.84.202';
    export  string  dest_thor_dali  :=  '10.173.1.130';
    export  string  dest_thor_esp   :=  '10.173.1.131';
    export foreign_prod := '~foreign::'+dest_thor_dali+'::';
	
	export 	copy_prename := '~thor_200::base::demo_data_';
	export  dest_prename := '~thor::base::demo_data_';
	export dest_group	 := 'thor';
	export dest_esp	 	 := dest_thor_esp;
  end
 ;
