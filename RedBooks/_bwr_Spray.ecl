import _control, RedBooks;
#workunit('name', 'Spray ' + RedBooks._Dataset.name + ' Files')


ISDA :=  RedBooks.fSprayFiles ( 'ISDA',,'/export/home/mlando/REDBOOKS','sda.txt','20080503'); 
ISDAA :=  RedBooks.fSprayFiles ( 'ISDAA',,'/export/home/mlando/REDBOOKS','sdaa.txt','20080503'); 
IAD :=  RedBooks.fSprayFiles ( 'IAD',,'/export/home/mlando/REDBOOKS','iad.txt','20080503'); 
IAG :=  RedBooks.fSprayFiles ( 'IAG',,'/export/home/mlando/REDBOOKS','iag.txt','20080503'); 
SEQUENTIAL(ISDA,ISDAA,IAD); 