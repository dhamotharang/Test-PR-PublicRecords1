import corp2;

//********************************************************************
//FileComfichex -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_WI.Layouts.FullLine_Layout ComfichexTransform(Corp2_Raw_WI.Layouts.TempComfichexFixedLayoutIn l) := transform,
skip(corp2.t2u(l.linevary)='')
			self.keyvalue													:= l.keyvalue; 							//integer value
			self.org_name 	        							:= corp2.t2u(l.linevary[1..68]);
			self.org_type 	        							:= corp2.t2u(l.linevary[69..71]);
			self.org_id			    									:= corp2.t2u(l.linevary[72..73])+corp2.t2u(l.linevary[74..80]);
			self.org_type_desc										:= corp2.t2u(l.linevary[81..103]);
			self.incorp_state		   	 							:= if(corp2.t2u(l.linevary[70..72]) = '02',corp2.t2u(l.linevary[90..91]),'');
			self.paid_capitol_rep   							:= if(corp2.t2u(l.linevary[70..72]) = '02',corp2.t2u(l.linevary[94..101]),'');
			self.paid_capitol_mills 							:= if(corp2.t2u(l.linevary[70..72]) = '02',corp2.t2u(l.linevary[102..102]),'');
			self.inc_date													:= if(l.linevary[104]='', 	//data not offset
																									corp2.t2u(l.linevary[111..114]+l.linevary[105..106]+l.linevary[108..109]),
																									corp2.t2u(l.linevary[110..113]+l.linevary[104..105]+l.linevary[107..108])
																								 );
			self.current_status										:= corp2.t2u(l.linevary[118..121]);
			self.current_status_date							:= if(l.linevary[122]='',		//data not offset
																									corp2.t2u(l.linevary[129..132]+l.linevary[123..124]+l.linevary[126..127]),
																									corp2.t2u(l.linevary[128..131]+l.linevary[122..123]+l.linevary[125..126])
																								 );			
			self.reg_agent_name										:= corp2.t2u(l.linevary[135..172]);
			self.reg_agent_addr1									:= corp2.t2u(l.linevary[173..205]);
			self.reg_agent_city										:= corp2.t2u(l.linevary[206..237]);
			self.reg_agent_state									:= corp2.t2u(l.linevary[238..239]);
			self.reg_agent_zip										:= corp2.t2u(l.linevary[241..250]);
			self.corporation_alpha_sort_name			:= '';
			self.reg_agent_addr2									:= corp2.t2u(l.linevary[306..337]);
			self.most_recent_locator_number				:= corp2.t2u(l.linevary[339..349]);
			self.most_recent_form20								:= corp2.t2u(l.linevary[351..361]);
		end; 

export FileComfichex(dataset(Corp2_Raw_WI.Layouts.TempComfichexFixedLayoutIn) pInComfichex) := project(pInComfichex,ComfichexTransform(LEFT));