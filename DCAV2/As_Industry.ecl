IMPORT TopBusiness_BIPV2, MDR;

ds_base := Files().base.Companies.qa;

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout xform(ds_base L, INTEGER C) := TRANSFORM

	      self.source        := MDR.sourceTools.src_DCA,
			  self.source_docid  := (string) l.rawfields.enterprise_num,
			  self.source_rec_id := l.src_rid,
				Boolean skip_rec:= CHOOSE(c,
				l.rawfields.bus_desc = '' and l.rawfields.sic1=''	 and l.rawfields.text1=''	 and l.rawfields.naics1='',
																			l.rawfields.sic2=''	 and l.rawfields.text2=''	 and l.rawfields.naics2='',
																			l.rawfields.sic3=''  and l.rawfields.text3=''	 and l.rawfields.naics3='',
																			l.rawfields.sic4=''  and l.rawfields.text4=''	 and l.rawfields.naics4='',
																			l.rawfields.sic5=''  and l.rawfields.text5=''	 and l.rawfields.naics5='',
																			l.rawfields.sic6=''  and l.rawfields.text6=''	 and l.rawfields.naics6='',
																			l.rawfields.sic7=''  and l.rawfields.text7=''	 and l.rawfields.naics7='',
																			l.rawfields.sic8=''  and l.rawfields.text8=''	 and l.rawfields.naics8='',
																			l.rawfields.sic9=''  and l.rawfields.text9=''	 and l.rawfields.naics9='',
																			l.rawfields.sic10='' and l.rawfields.text10='' and l.rawfields.naics10=''	);
																			 
				self.siccode       := if(skip_rec,SKIP,CHOOSE(c,l.rawfields.sic1,l.rawfields.sic2,
																			 l.rawfields.sic3,l.rawfields.sic4,
																			 l.rawfields.sic5,l.rawfields.sic6,
																			 l.rawfields.sic7,l.rawfields.sic8,
																			 l.rawfields.sic9,l.rawfields.sic10	)),
				self.industry_description := if(skip_rec,SKIP,CHOOSE(c,l.rawfields.text1,l.rawfields.text2,
																							l.rawfields.text3,l.rawfields.text4,
																							l.rawfields.text5,l.rawfields.text6,
																							l.rawfields.text7,l.rawfields.text8,
																							l.rawfields.text9,l.rawfields.text10 )),
				self.business_description := l.rawfields.bus_desc,
				self.naics := if (skip_rec,SKIP,CHOOSE(c,l.rawfields.naics1,l.rawfields.naics2,
															 l.rawfields.naics3,l.rawfields.naics4,
															 l.rawfields.naics5,l.rawfields.naics6,
															 l.rawfields.naics7,l.rawfields.naics8,
															 l.rawfields.naics9,l.rawfields.naics10)),
				self.bdid := (unsigned) l.bdid,
				self.dt_first_seen:= (unsigned)l.date_first_seen;
				self.dt_last_seen:= (unsigned)l.date_last_seen;
				self.dt_vendor_first_reported:=(unsigned)l.date_vendor_first_reported ;
				self.dt_vendor_last_reported:=(unsigned)l.date_vendor_last_reported ;
				self.record_type:= (string)l.record_type,
			  self := l, 
			  self := [],
END;				

DCA_slim :=normalize(ds_base,10,xform(left,COUNTER));
				
EXPORT As_Industry := DEDUP(SORT(DCA_slim(siccode<>'' or naics<>'' or industry_description<>'' or business_description<>''),record),record);
