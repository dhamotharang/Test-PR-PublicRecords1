export skipSetTools(
	set of STRING1 get_skip_set=[]):= 
MODULE

export boolean skipAll := 'C' in get_skip_set;
export boolean skipSSN := 'S' in get_skip_set;
export boolean skipPhn := 'P' in get_skip_set;
export boolean skipZip := 'Z' in get_skip_set;
export boolean addZipL := '-' in get_skip_set;

END;