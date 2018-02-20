export NameMatch100(string20 lf, string20 lm, string20 ll, 
                    string20 rf, string20 rm, string20 rl) := 
       if((lf='' and lm='' and ll='') or (rf='' and rm='' and rl=''), 0,
		Max(100 - datalib.NameSimilar(trim(lf) + ' ' +  trim(lm) + ' ' + trim(ll), 
		                               trim(rf) + ' ' +  trim(rm) + ' ' + trim(rl), 1), 0));