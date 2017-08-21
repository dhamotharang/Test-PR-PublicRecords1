export proc_incident_clean( dataset(layout_SANCTN_incident_clean) infile ) := function
integer current_yy := (integer)(stringlib.GetDateYYYYMMDD()[3..4]);

export	valid_date(string10 date) := map( length(trim(date)) = 8 and date[5..6] = '19' or date[5..6] = '20' => date,
                                          length(trim(date)) = 9 and date[6..7] = '19' or date[6..7] = '20' => date,
																				 length(trim(date)) = 10 and  (date[7..8] = '19' and date[1..2] != '00' and date[4..5] != '00' )or (length(trim(date)) = 10 and date[7..8] = '20' and date[1..2] != '00' and date[4..5] != '00'  ) => date,
																					'');
																					
export valid_date_in(string8 date) := if ( date[1..2] = '00' or date[4..5] = '00' or date = '02/02/02' or date = '10/10/10' or date = '12/12/12'
                                           or date = '09/09/09','',date);

													 
 SANCTN.layout_SANCTN_incident_clean clean_SANCTN_incident(infile input) := TRANSFORM
 
   string4 AdjustYear(string year) := map(length(year) <> 2 => year,
                                       (integer)year <= (current_yy + 30) => (string4)(2000 + (integer)year),
									   (string4)(1900 + (integer)year));
		string8     fSlashedMDYtoCCYYMMDD(string pDateIn) := ((integer2)AdjustYear(regexreplace('.*/.*/([0-9]+)',pDateIn,'$1')))//,4,1) 
                                                     + intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
									                 + intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
   
	 CL_FCR_DATE              := if( regexfind('-',input.FCR_DATE) = true,regexreplace('-',input.FCR_DATE,'/'),input.FCR_DATE);
	 CL_INCIDENT_DATE         := if( regexfind('-',input.INCIDENT_DATE) = true,regexreplace('-',input.INCIDENT_DATE,'/'),input.INCIDENT_DATE);
   FCR_DATE_NEW            := intformat((integer1)regexreplace('([0-9]+)/.*/.*',CL_FCR_DATE,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/([0-9]+)/.*',CL_FCR_DATE,'$1'),2,1) + '/' + (integer2)AdjustYear(regexreplace('.*/.*/([0-9]+)',CL_FCR_DATE,'$1'));
   INCIDENT_DATE_NEW       := intformat((integer1)regexreplace('([0-9]+)/.*/.*',CL_INCIDENT_DATE,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/([0-9]+)/.*',CL_INCIDENT_DATE,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/.*/([0-9]+)',CL_INCIDENT_DATE,'$1'),2,1) ;
	 self.FCR_DATE           := valid_date(FCR_DATE_NEW);
	 self.INCIDENT_DATE       := valid_date_in(INCIDENT_DATE_NEW);
	 self.incident_date_clean := fSlashedMDYtoCCYYMMDD(trim(CL_FCR_DATE,left,right));
   self.fcr_date_clean      := fSlashedMDYtoCCYYMMDD(trim(CL_INCIDENT_DATE,left,right));
	 self                     := input;
   END;
   
   incident_clean := project(infile(regexfind('[0-9]',incident_number) = true),clean_SANCTN_incident(LEFT));
   
   //incident_clean_file := output(incident_clean,,SANCTN.cluster + 'out::sanctn::incident_cleaned',overwrite);

return incident_clean;
end;