export string NameFromComponents(string fname, 
                                 string mname, 
						   string lname, 
		     			   string name_suffix)
       := IF(fname<>'',trim(fname)+' ','') +
          IF(mname<>'',trim(mname)+' ','') +
          IF(lname<>'',trim(lname)+' ','') +
          trim(name_suffix);