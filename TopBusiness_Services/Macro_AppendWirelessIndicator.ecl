
export Macro_AppendWirelessIndicator(inds,outds,phone_field = 'phone',wireless_indicator_field = 'wirelessindicator',timezone_field = 'timezone') := macro

	import cellphone,Risk_Indicators, ut;

	#uniquename(wirelessrec)
	%wirelessrec% := record
		string1 wireless_indicator_field;
		string3 timezone_field;
	end;

	#uniquename(outrec)
	%outrec% := record
		recordof(inds) or %wirelessrec%;
	end;

	#uniquename(addneustar)
	%addneustar% := join(
		inds,
		cellphone.key_NeuStar_Phone,
		keyed(
			length(evaluate(left,phone_field)) = 10 and
			evaluate(left,phone_field) = right.cellphone),
		transform(%outrec%,
			self.wireless_indicator_field := if(right.cellphone != '','W',''),
			self.timezone_field := '';
			self := left),
		left outer, LIMIT(10000, SKIP));

	#uniquename(addtelcordia)
	%addtelcordia% := join(
		%addneustar%,
		risk_indicators.Key_Telcordia_tds,
		keyed(
			left.wireless_indicator_field = '' and
			length(evaluate(left,phone_field)) = 10 and
			evaluate(left,phone_field[1..3]) = right.npa and
			evaluate(left,phone_field[4..6]) = right.nxx)
		and
			evaluate(left,phone_field[7]) = right.tb,
		transform(%outrec%,
			self.wireless_indicator_field := if(right.npa != '',
			                                    if(right.wireless_ind = 'W' OR
			                                       right.wireless_ind = 'L' OR
																					   right.wireless_ind = 'S',  // per bug 122453
																					   right.wireless_ind,
																					   left.wireless_indicator_field),
																					left.wireless_indicator_field);
      self.timezone_field := '';
			self := left),
		left outer, LIMIT(10000, SKIP));

  #uniquename(addtimezone)
%addtimezone% := join(%addtelcordia%,Risk_Indicators.Key_Telcordia_tds,
        keyed(
				 evaluate(left,phone_field[1..3]) =right.npa and
         // keyed(left.phone_field[1..3]=right.npa) and
				//keyed(left.phone_field[4..6]=right.nxx),
				  evaluate(left,phone_field[4..6])=right.nxx),
				transform(%outrec%,
				self.timezone_field := if((right.npa='' and right.nxx = '') or length(trim(left.phone_field,all))<>10,
				left.timezone_field, ut.timeZone_Convert((unsigned1) right.timezone,right.state)),
				self := left
				)
				,left outer,keep(1));


	// #uniquename(outdsWOTimezone)
	// %outdsWOTimeZone := %addtelcordia%;
   // ut.getTimeZone(%addtelcordia%,phone_field,timeZone,tmpoutds);
	 // outds := tmpoutds;
	 //outds := %addtelcordia%;
	 outds := %addtimezone%;
endmacro;
