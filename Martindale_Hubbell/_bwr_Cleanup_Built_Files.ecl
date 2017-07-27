pversion := '20100426';
#workunit('name', 'Cleanup ' + Martindale_Hubbell._Dataset().name + ' Build ' + pversion);

Martindale_Hubbell.Cleanup_Built_Files(

	 pversion			// version
	,''						// Filename Filter
	,true					// Is Testing?

);