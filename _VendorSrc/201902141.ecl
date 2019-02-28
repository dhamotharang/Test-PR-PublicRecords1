x:='a	b	c	?';
regexreplace('[^0-9a-z.\\- ]',x,'',nocase);
// abc 
// abc

