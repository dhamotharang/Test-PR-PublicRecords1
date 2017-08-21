export fn_blankout_junk
	(string p,boolean debug=false)
		:=
			function
				e01:='(.*?)('
						+'^le, *[a-z]{1,}'
						+'|^le [a-z]{1,}$'
						+'|trusty'
						+'|trsek'
						+')(.*)';

				s01:='(.*?)('
						+'[^a-z]*liv tr[^a-z]*'
						+'|[^a-z]*AMERITRUST[^a-z]*'
						+'|[^a-z]*FAMILY TRUST[^a-z]*'
						+'|[^a-z]*FAM TRSTEE[^a-z]*'
						+'|[^a-z]*land TRUST[^a-z]*'
						+'|[^a-z]*LVG SOLETRSTEE[^a-z]*'
						+'|[^a-z]*P NTRST[^a-z]*'
						+'|[^a-z]*LQUIDTRS[^a-z]*'
						+'|[^a-z]*LIVINGTRUST[^a-z]*'
						+'|[^a-z]*REVOCABLETRUST[^a-z]*'

						+'|^[^a-z]*tr[^a-z]{1,}'
						+'|[^a-z]*trstees[^a-z]*'
						+'|[^a-z]*trstee[^a-z]*'
						+'|[^a-z]*cotrustees[^a-z]*'
						+'|[^a-z]*cotrustee[^a-z]*'
						+'|[^a-z]*trustees[^a-z]*'
						+'|[^a-z]*trustee[^a-z]*'
						+'|[^a-z]*truste[^a-z]*'
						+'|[^a-z]*trusts[^a-z]*'
						+'|[^a-z]*trust[^a-z]{1,}'
						+'|[^a-z]{1,}trust[^a-z]*'
						+'|[^a-z]*trstes[^a-z]*'
						+'|[^a-z]*trste[^a-z]*'
						+'|[^a-z]*extrs[^a-z]*'
						+'|[^a-z]*strtrs[^a-z]*'
						+'|[^a-z]*trst[^a-z]*'
						+'|[^a-z]{1,}trs[^a-z]*'

						+'|[^a-z ]{1,}EST[^a-z ]{1,}'
						+'|[^a-z ]{1,}life[^a-z ]{1,}'
						+'|[^a-z ]{1,}TRUSTS[^a-z ]{1,}'
						+'|[^a-z ]{1,}trtees[^a-z ]{1,}'
						+'|[^a-z ]{1,}AKA[^a-z ]{1,}'
						+'|[^a-z ]{1,}te[^a-z ]{1,}'
						+'|[^a-z ]{1,}pa-c[^a-z ]{1,}'
						+'|[^a-z ]{1,}pa[^a-z ]{1,}[-c]*'
						+'|[^a-z ]{1,}rpa-c[^a-z ]{1,}'
						+'|[^a-z ]{1,}arnp[^a-z ]{1,}'
						+'|[^a-z ]{1,}aprn[^a-z ]{1,}'
						+'|[^a-z ]{1,}mpas[^a-z ]{1,}'
						+'|[^a-z ]{1,}fnp[^a-z ]{1,}'
						+'|[^a-z ]{1,}surv[^a-z ]{1,}'
						+'|[^a-z ]{1,}od[^a-z ]{1,}'
						+'|[^a-z ]{1,}adms[^a-z ]{1,}'

						+'|[^a-z]*2nd'
						+'|[^a-z]*3rd'
						+'|[^a-z]*4th'

						+'|^[^a-z ]{1,}te$'
						+'|[^a-z ]{1,}pa-c$'

						+'|^le[^a-z0-9 -]{1,}'
						+'|^LESSEE[^a-z]*'
						+'|^UST[^a-z]{1,}'
						+'|^MAC%'
						+'|^trust$'
						+'|^trs$'
						+'|^error$'
						
						+'| frca[^a-z]{1,}$'
						+'|[^a-z]*trust[^a-z]{1,}$'

						+')(.*)';
				s02:='(.*)[,;-]{1,}$';
				s03:='^(.*?)([,;:%]{1,}.*)(.*?)$';

				return map(
					 regexfind(s01,trim(p,left,right),nocase) and not regexfind(e01,trim(p,left,right),nocase) => StringLib.StringCleanSpaces(trim(regexreplace(s01,trim(p,left,right),'$1'+' '+'$3'+if(debug,' rule 01',''),nocase)))
					,regexfind(s02,trim(p,left,right),nocase) and not regexfind(e01,trim(p,left,right),nocase) => StringLib.StringCleanSpaces(trim(regexreplace(s02,trim(p,left,right),'$1'         +if(debug,' rule 02',''),nocase)))
					,regexfind(s03,trim(p,left,right),nocase) and not regexfind(e01,trim(p,left,right),nocase) => StringLib.StringCleanSpaces(trim(regexreplace(s03,trim(p,left,right),'$1'+' '+'$3'+if(debug,' rule 03',''),nocase)))
					,p);

end;