prof_suf := ['MD','CPA','DBA','DDS','TE'];
close_titles := ['TE','PT','CO','PA','PLC','INC','PC','PLLC','PL','OFC','ASSOC','LLC','OFFICE','FACS','LTD','LC','FACOG','SC','INC.','PHD','FACC','FAAP','PS','MSD','P.C.','MD','FACP','PSC'];
numeric(string s) := stringlib.stringfilter(s,'0123456789 -/') = s;
salutation := ['MISS', 'SIR','MR', 'MS', 'DR', 'MRS','SGT','MAJ','CAPT','HON','COL','REV','JDG','SEN','PROF','JUDGE'];
suffix := ['JR','SR','II','III','IV'];



export NaiveAnnotate(string s) := MAP ( s IN prof_suf => 'S',
											s IN close_titles => 'E',
											s IN Salutation => 'T',
											s in Suffix => 'X',
											numeric(s) => '#',
											s = '&' => 'i',
											length(trim(s)) = 1  => 'I',
										  '');