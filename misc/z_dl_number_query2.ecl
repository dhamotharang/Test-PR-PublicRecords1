
import misc, drivers;

my_ds := misc.dl_number_query1(orig_state='MI',contents<>'');

count(my_ds);

output(choosen(sort(my_ds,position,contents),10000));

