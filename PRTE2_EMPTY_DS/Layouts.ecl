import zoom;

EXPORT Layouts := module

  export zomm_Layout_fixed_zoomid := record
        string15 zoomID := '';
        Zoom.layouts.keybuild;		 
	end;
  
 end; 