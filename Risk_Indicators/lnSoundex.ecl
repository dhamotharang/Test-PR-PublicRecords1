export STRING4 lnSoundex(const STRING instring) := BEGINC++
 const static unsigned char
xlat[26]={0,'1','2','3',0,'1','2',0,0,'2','2','4','5','5',0,'1','2','6',
'2','3',0,'1',0,'2',0,'2'};
  char *r=__result;
  const char *s = instring;
  size32_t l = lenInstring;

  if (!l) 
	{
		memcpy(r, "    ", 4);
		return;
	}
  r[0] = '!';
  r[1] = '0';
  r[2] = '0';
  r[3] = '0';
  char c=toupper(*s);
  *r = c;
  r++; s++; l--;
  char dl = ((c>='A')&&(c<='Z'))?xlat[c-'A']:0;
  for (;;) {
    if (!l)
		  break;
    c = toupper(*s);
    s++; l--;
    if ((c>='A')&&(c<='Z')) {
      char d = xlat[c-'A'];
      if (d&&(d!=dl)) {
        *r = d;
        r++;
        if (r == __result+4) break;
      }
  	  if (c != 'H' && c != 'W')
 	      dl = d;
    }
  }
ENDC++;