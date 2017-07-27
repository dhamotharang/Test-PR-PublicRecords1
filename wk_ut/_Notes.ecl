/*
-- making links in results
myTest1 := 'W20140710-132017';
output(myTest1, named('OtherWU1__html'));

this one works!
myTest2 := '<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20140710-132017">W20140710-132017</a>';
output(myTest2, named('OtherWU2__html'));

This also works!  I'm guessing any link here would work
output('<a href="http://prod_esp.br.seisint.com:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20140710-132017">W20140710-132017<\a>'
,named('OtherWU3__html'));


  ideas for gettign graphs:
    1. identify longest running subgraphs/flows, output them and also output code associated with it, in/out count and skew
    2. identify highest skewed graphs
    3. identify highest in/out count difference(percentage or raw count)
    4. allow to search for where specific code is executed in the workunit graphs
    5. allow to compare with another workunit, see diffs in graphs
    6. search for largest files output(whether persists or regular output files) by record count or size.
    7. longest running graphs as percentage of total thor time
    8. 
    
  write something to parse out workunit warnings to get the attributes that are sandboxed.


improve mac_chainworkunits to send email with extra fields, check status a few times in the watcher, and also output the summary dataset during operation, not at the end.  also when fails, send failmessage.
write macro/function to restore a workunit
use that in another macro that allows you to search for workunits, and restore them if necessary, and summarize their results in a dataset.
write macro/function to calculate precision.  
  could have a file for each iteration that gets put into a superfile.  
  After people respond to the review samples, I could pass into this function the Wuid for the iteration
, the number of samples that are good, # of bad, # of questionable, and it would grab the # of matches 
from the wuid, grab the dataset with the breakdown per conf level...then it could write out a file 
for that iteration and put it into the superfile. 



  WUQuery gets workunits, archived & not archived
       <Type>archived workunits</Type>
  WUAction will restore the workunit
    <Wuids>
        <Item>W20130603-104908</Item>
       </Wuids>
       <ActionType>Restore</ActionType>
  then u can get the scalar results or dataset results

  
*/