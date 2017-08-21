EXPORT IndustryClass_Explosion_Table(STRING pIndClass) := FUNCTION

  trimUpper(STRING s) := FUNCTION
	  RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
  END;				

  IndClassFull := MAP(trimUpper(pIndClass) = 'A'  => 'AGRICULTURE & FORESTRY',
	  						      trimUpper(pIndClass) = 'B'  => 'MINING',
		  					      trimUpper(pIndClass) = 'C'  => 'CONSTRUCTION',
			  				      trimUpper(pIndClass) = 'D'  => 'MANUFACTURING',
				  			      trimUpper(pIndClass) = 'E'  => 'TRANSPORTATION & UTILITIES',
					  		      trimUpper(pIndClass) = 'F'  => 'WHOLESALE TRADE',
						  	      trimUpper(pIndClass) = 'G'  => 'RETAIL TRADE',
							        trimUpper(pIndClass) = 'H'  => 'FINANCIAL, INSURANCE, REAL ESTATE',
							        trimUpper(pIndClass) = 'I'  => 'SERVICES, NOT MEDICAL',
							        trimUpper(pIndClass) = 'J'  => 'HEALTH SERVICES',
							        trimUpper(pIndClass) = 'K'  => 'LEGAL SERVICES',
  							      trimUpper(pIndClass) = 'L'  => 'EDUCATION & SOCIAL',
	  						      trimUpper(pIndClass) = 'M'  => 'ART & MEMBERSHIP ORGS',
		  						    trimUpper(pIndClass) = 'N'  => 'ENGINEERING, ARCHITECTURE, & ACCOUNTING',
			  					    trimUpper(pIndClass) = 'O'  => 'HOUSEHOLD & MISC SERVICES',
				  					  trimUpper(pIndClass) = 'P'  => 'GOVERNMENT',
					  				  ''
						  			  );

 RETURN IndClassFull;

END;