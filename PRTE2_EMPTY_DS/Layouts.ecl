import zoom;

EXPORT Layouts := module

  export zomm_Layout_fixed_zoomid := record
        string15 zoomID := '';
        Zoom.layouts.keybuild;		 
	end;
  
  export rel_supp := record
          unsigned8 did1;
          unsigned8 did2;
          string25 userid;
          unsigned4 dt_added;
   end;
   
 end; 