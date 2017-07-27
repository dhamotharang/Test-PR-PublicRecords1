/*This code take the Census population files and appends a geolink to the first field for indexing.*/

//working layouts
layout_blockgroups := record
	string2 st;
	string3	county;
	string6	tract;
	string1	blk_grp;
	integer4	population;
	real4	lat;
	real4	long;
end;

layout_final := record
	string12	geolink;
	integer4	population;
	string10	lat;
	string11	long;
end;

st_fips := record
	string2 st;
	string2	code;
end;



//datasets
state_fips := dataset([{'AL','01'},{'AK','02'},{'AS','03'},{'AZ','04'},{'AR','05'},{'CA','06'},{'CZ','07'},{'CO','08'},{'CT','09'},{'DE','10'},{'DC','11'},{'FL','12'},{'GA','13'},{'GU','14'},{'HI','15'},{'ID','16'},{'IL','17'},{'IN','18'},{'IA','19'},{'KS','20'},{'KY','21'},{'LA','22'},{'ME','23'},{'MD','24'},{'MA','25'},{'MI','26'},{'MN','27'},{'MS','28'},{'MO','29'},{'MT','30'},{'NE','31'},{'NV','32'},{'NH','33'},{'NJ','34'},{'NM','35'},{'NY','36'},{'NC','37'},{'ND','38'},{'OH','39'},{'OK','40'},{'OR','41'},{'PA','42'},{'PR','43'},{'RI','44'},{'SC','45'},{'SD','46'},{'TN','47'},{'TX','48'},{'UT','49'},{'VT','50'},{'VA','51'},{'VI','52'},{'WA','53'},{'WV','54'},{'WI','55'},{'WY','56'},{'AS','60'},{'FM','64'},{'GU','66'},{'JA','67'},{'MH','68'},{'MP','69'},{'PW','70'},{'MI','71'},{'PR','72'},{'UM','74'},{'NI','76'},{'VI','78'},{'WK','79'},{'BI','81'},{'HW','84'},{'JI','86'},{'KR','89'},{'PL','95'}], st_fips);

//files
Census2000_geoblks := dataset('~thor_data400::Census2000_geoblks', layout_blockgroups, csv(heading(1)));
Census2010_geoblks := dataset('~thor_data400::Census2010_geoblks', layout_blockgroups, csv(heading(1)));

Census2000_geoblks_clean := Census2000_geoblks(lat > 0);
Census2010_geoblks_clean := Census2010_geoblks(lat > 0);

export file_blockgroup := MODULE

	export buildFile(DATASET(layout_blockgroups) CensusPopulation) := Function
				layout_final appendGeolink(CensusPopulation l, state_fips r) := transform
					self.geolink := r.st + l.county + l.tract + l.blk_grp;
					self.lat := (string)l.lat;
					self.long := (string)l.long;
					self := l;
				end;
				
				final_file := join(CensusPopulation, state_fips,
											left.st = right.code,
											appendGeolink(left, right), keep(1));
				
				Return final_file;
		End;

	export file_Census2000_geoblks := buildFile(Census2000_geoblks_clean);
	export file_Census2010_geoblks := buildFile(Census2010_geoblks_clean);

End;