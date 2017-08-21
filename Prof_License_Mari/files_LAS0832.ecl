// LAS0832 / Louisiana Real Estate Commission / Real Estate //

export files_LAS0832 := dataset('~thor_data400::in::prolic::LAS0832::active_agents',Prof_License_Mari.layout_LAS0832,csv(SEPARATOR('\t'),heading(1)))
                       +dataset('~thor_data400::in::prolic::LAS0832::inactive_agents',Prof_License_Mari.layout_LAS0832,csv(SEPARATOR('\t'),heading(1)))
                       +dataset('~thor_data400::in::prolic::LAS0832::companies',Prof_License_Mari.layout_LAS0832,csv(SEPARATOR('\t'),heading(1)));
	 
